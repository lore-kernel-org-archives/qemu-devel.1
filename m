Received: from eggs.gnu.org ([209.51.188.92]:33841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjVGh-0007m0-3I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjVGg-0002a7-02
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:25:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjVGf-0002Yo-MT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:25:01 -0500
References: <9af4a3f8-3095-61dc-77fa-17a877e48a02@huawei.com>
	<20190108124650.GC11492@linux.fritz.box>
	<affb7700-a2bc-6778-99be-931bb5e65e59@huawei.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a9f0dfb3-e3ab-a538-a4ed-cb74c6a1aa02@redhat.com>
Date: Tue, 15 Jan 2019 15:15:45 -0500
MIME-Version: 1.0
In-Reply-To: <affb7700-a2bc-6778-99be-931bb5e65e59@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Questions on the I/O performance of emulated
 host cdrom device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ying Fang <fangying1@huawei.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jianjay.zhou@huawei.com, dengkai1@huawei.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mreitz@redhat.com



On 1/8/19 10:20 PM, Ying Fang wrote:
> 
> 
> On 2019/1/8 20:46, Kevin Wolf wrote:
>> Am 29.12.2018 um 07:33 hat Ying Fang geschrieben:
>>> Hi.
>>> Recently one of our customer complained about the I/O performance of QEMU emulated host cdrom device.
>>> I did some investigation on it and there was still some point I could not figure out. So I had to ask for your help.
>>>
>>> Here is the application scenario setup by our customer.
>>> filename.iso        /dev/sr0           /dev/cdrom
>>> remote client    -->  host(cdemu)      -->  Linux VM
>>> (1)A remote client maps an iso file to x86 host machine through network using tcp.
>>> (2)The cdemu daemon then load it as a local virtual cdrom disk drive.
>>> (3)A VM is launched with the virtual cdrom disk drive configured.
>>> The VM can make use of this virtual cdrom to install an OS in the iso file.
>>>
>>> The network bandwith btw the remote client and host is 100Mbps, we test I/O perf using: dd if=/dev/sr0 of=/dev/null bs=32K count=100000.
>>> And we have
>>> (1) I/O perf of host side /dev/sr0 is 11MB/s;
>>> (2) I/O perf of /dev/cdrom inside VM is 3.8MB/s.
>>>
>>> As we can see, I/O perf of cdrom inside the VM is about 34.5% compared with host side.
>>> FlameGraph is used to find out the bottleneck of this operation and we find out that too much time is occupied by calling *bdrv_is_inserted*.
>>> Then we dig into the code and figure out that the ioctl in *cdrom_is_inserted* takes too much time, because it triggers io_schdule_timeout in kernel.
>>> In the code path of emulated cdrom device, each DMA I/O request consists of several *bdrv_is_inserted*, which degrades the I/O performance by about 31% in our test.
>>> static bool cdrom_is_inserted(BlockDriverState *bs)
>>> {
>>>     BDRVRawState *s = bs->opaque;
>>>     int ret;
>>>
>>>     ret = ioctl(s->fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
>>>     return ret == CDS_DISC_OK;
>>> }
>>> A flamegraph svg file (cdrom.svg) is attachieved in this email to show the code timing profile we've tested.
>>>
>>> So here is my question.
>>> (1) Why do we regularly check the presence of a cdrom disk drive in the code path?  Can we do it asynchronously?

The ATAPI emulator needs to know if it has storage present to carry out
the request or to signal an error, so it checks. It might be the case
that the VM operator forcibly dismounted network storage without
awareness from the guest. (This is basically emulation of the case when
a user mechanically forces a CDROM tray open.)

I wasn't aware this check was so slow.

Maybe we can just cache blk_is_inserted -- I don't remember if it's
possible to eject media without awareness from the device model, but if
this check winds up being slow in some configurations we can cache it.

This won't help the bdrv_check_byte_request calls, though, just ones
from the device model, see below

>>> (2) Can we drop some check point in the code path to improve the performance?
>>> Thanks.
>>
>> I'm actually not sure why so many places check it. Just letting an I/O
>> request fail if the CD was removed would probably be easier.
>>
> You can see those check points as showed in the attached flamegraph file in this thread (rename it to cdrom.svg).
> It is called mainly in bdrv_check_byte_request and ide_atapi_cmd, and only the host_cdrom backend implements
> it using cdrom_is_inserted.
> 

in ide_atapi_cmd, try replacing:

`!s->tray_open && blk_is_inserted(s->blk) && s->cdrom_changed)`

with

`!s->tray_open && s->cdrom_changed && blk_is_inserted(s->blk))`

which should hopefully short-circuit calls to blk_is_inserted if
s->cdrom_changed is false, but it doesn't do much to fix the subsequent
call:

`    if ((cmd->flags & CHECK_READY) &&
        (!media_present(s) || !blk_is_inserted(s->blk)))`

which is unfortunately going to check blk_is_inserted quite a lot
because the read commands are tagged CHECK_READY...


As alluded to above, too, I'm not sure what I can do about
bdrv_check_byte_request -- what happens if the io.c helpers don't
actually check this? Will they fail gracefully?

I guess there's one way to find out.

>> To try out whether that would improve performance significantly, you
>> could try to use the host_device backend rather than the host_cdrom
>> backend. That one doesn't implement .bdrv_is_inserted, so the operation
>> will be cheap (just return true unconditionally).
>>
> The remote client maps filename.iso to host virtual cdrom drive.
> We use xml like
>     <disk type='block' device='cdrom'>
>       <driver name='qemu' type='raw' cache='none' io='native'/>
>       <source dev='/dev/sr0'/>
>       <target dev='hdb' bus='ide'/>
>       <readonly/>
>       <boot order='2'/>
>       <address type='drive' controller='0' bus='0' target='0' unit='1'/>
>     </disk>
> to attach the virtual cdrom drive into guest and backend bdrv is host_cdrom.
> Sorry I do not know how to use the host_device backend here.
> 
>> You will also lose eject/lock passthrough when doing so, so this is not
>> the final solution, but if it proves to be a lot faster, we can check
>> where bdrv_is_inserted() calls are actually important (if anywhere) and
>> hopefully remove some even for the host_cdrom case.
>>
> You mean if we do not check *cdrom_is_inserted*, we may lose eject/lock here ?
> I wonder we used to check the presence of the cdrom device each time it is touched
> though I am not familiar with this feature.
> 
>> Kevin
>>
>> .
>>
> 
> 
