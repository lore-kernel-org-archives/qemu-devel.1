Received: from eggs.gnu.org ([209.51.188.92]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqma-0005hr-PW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqmV-0007oS-5f
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:46:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ggqmU-0007jA-T4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:46:55 -0500
Date: Tue, 8 Jan 2019 13:46:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108124650.GC11492@linux.fritz.box>
References: <9af4a3f8-3095-61dc-77fa-17a877e48a02@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af4a3f8-3095-61dc-77fa-17a877e48a02@huawei.com>
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
To: Ying Fang <fangying1@huawei.com>
Cc: mreitz@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jianjay.zhou@huawei.com, dengkai1@huawei.com

Am 29.12.2018 um 07:33 hat Ying Fang geschrieben:
> Hi.
> Recently one of our customer complained about the I/O performance of QEMU emulated host cdrom device.
> I did some investigation on it and there was still some point I could not figure out. So I had to ask for your help.
> 
> Here is the application scenario setup by our customer.
> filename.iso        /dev/sr0           /dev/cdrom
> remote client    -->  host(cdemu)      -->  Linux VM
> (1)A remote client maps an iso file to x86 host machine through network using tcp.
> (2)The cdemu daemon then load it as a local virtual cdrom disk drive.
> (3)A VM is launched with the virtual cdrom disk drive configured.
> The VM can make use of this virtual cdrom to install an OS in the iso file.
> 
> The network bandwith btw the remote client and host is 100Mbps, we test I/O perf using: dd if=/dev/sr0 of=/dev/null bs=32K count=100000.
> And we have
> (1) I/O perf of host side /dev/sr0 is 11MB/s;
> (2) I/O perf of /dev/cdrom inside VM is 3.8MB/s.
> 
> As we can see, I/O perf of cdrom inside the VM is about 34.5% compared with host side.
> FlameGraph is used to find out the bottleneck of this operation and we find out that too much time is occupied by calling *bdrv_is_inserted*.
> Then we dig into the code and figure out that the ioctl in *cdrom_is_inserted* takes too much time, because it triggers io_schdule_timeout in kernel.
> In the code path of emulated cdrom device, each DMA I/O request consists of several *bdrv_is_inserted*, which degrades the I/O performance by about 31% in our test.
> static bool cdrom_is_inserted(BlockDriverState *bs)
> {
>     BDRVRawState *s = bs->opaque;
>     int ret;
> 
>     ret = ioctl(s->fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
>     return ret == CDS_DISC_OK;
> }
> A flamegraph svg file (cdrom.svg) is attachieved in this email to show the code timing profile we've tested.
> 
> So here is my question.
> (1) Why do we regularly check the presence of a cdrom disk drive in the code path?  Can we do it asynchronously?
> (2) Can we drop some check point in the code path to improve the performance?
> Thanks.

I'm actually not sure why so many places check it. Just letting an I/O
request fail if the CD was removed would probably be easier.

To try out whether that would improve performance significantly, you
could try to use the host_device backend rather than the host_cdrom
backend. That one doesn't implement .bdrv_is_inserted, so the operation
will be cheap (just return true unconditionally).

You will also lose eject/lock passthrough when doing so, so this is not
the final solution, but if it proves to be a lot faster, we can check
where bdrv_is_inserted() calls are actually important (if anywhere) and
hopefully remove some even for the host_cdrom case.

Kevin
