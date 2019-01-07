Received: from eggs.gnu.org ([209.51.188.92]:57132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1ggJfY-0003DL-Bc
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 20:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1ggJfT-0001pb-BS
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 20:25:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58148 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fangying1@huawei.com>)
	id 1ggJfL-0001h0-0R
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 20:25:22 -0500
From: Ying Fang <fangying1@huawei.com>
References: <9af4a3f8-3095-61dc-77fa-17a877e48a02@huawei.com>
Message-ID: <7bdf5dd6-392f-4046-7a43-b39376529d08@huawei.com>
Date: Mon, 7 Jan 2019 09:23:54 +0800
MIME-Version: 1.0
In-Reply-To: <9af4a3f8-3095-61dc-77fa-17a877e48a02@huawei.com>
Content-Type: text/plain; charset="utf-8"
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
To: mreitz@redhat.com, kwolf@redhat.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jianjay.zhou@huawei.com, dengkai1@huawei.com

ping

On 2018/12/29 14:33, Ying Fang wrote:
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
> 
