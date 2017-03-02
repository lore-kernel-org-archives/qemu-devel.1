Received: from eggs.gnu.org ([2001:4830:134:3::10]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1cjZ5G-0005dZ-Ky
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1cjZ5C-0001oo-Nf
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1cjZ5C-0001nz-GE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:20:22 -0500
From: Bandan Das <bsd@redhat.com>
References: <20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
	<20170215025243.GA3988@pxdev.xzpeter.org>
	<20170215033452.GB3988@pxdev.xzpeter.org>
	<20170215111552.5405418a@t450s.home>
	<20170216022839.GC15985@pxdev.xzpeter.org>
	<20170215194758.4622d73c@t450s.home>
	<CAHyh4xg6oRVoW81QgdQRoL0Oc7jHm7prgyd--ghYQ4d4_aSUpQ@mail.gmail.com>
	<CAHyh4xi0qOaL5X5E6yLpf2O=RYR=G8X=zjr7g+h8QtntYPnsFA@mail.gmail.com>
Date: Thu, 02 Mar 2017 17:20:19 -0500
Message-ID: <jpgefyfs4m4.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, " Michael S . Tsirkin \" <mst@redhat.com>"@redhat.com

Jintack Lim <jintack@cs.columbia.edu> writes:

> [cc Bandan]
>
> On Tue, Feb 21, 2017 at 5:33 AM, Jintack Lim <jintack@cs.columbia.edu>
> wrote:
>
>>
>>
>> On Wed, Feb 15, 2017 at 9:47 PM, Alex Williamson <
>> alex.williamson@redhat.com> wrote:
...
>>
>
> I've tried another network device on a different machine. It has "Intel
> Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection" ethernet
> controller. I got the same problem of getting the network device
> initialization failure in L2. I think I'm missing something since I heard
> from Bandan that he had no problem to assign a device to L2 with ixgbe.
>
> This is the error message from dmesg in L2.
>
> [    3.692871] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
> version 4.2.1-k
> [    3.697716] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
> [    3.964875] ixgbe 0000:00:02.0: HW Init failed: -12
> [    3.972362] ixgbe: probe of 0000:00:02.0 failed with error -12
>
> I checked that L2 indeed had that device.
> root@guest0:~# lspci
> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM
> Controller
> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> 00:02.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
> Network Connection (rev 01)

Jintack, any progress with this ?

I am testing on a X540-AT2 and I see a different behavior. It appears
config succeeds but the driver keeps resetting the device due to a Tx
hang:

[ 568.612391 ] ixgbe 0000:00:03.0 enp0s3: tx hang 38 detected on queue 0,
resetting adapter
[ 568.612393 ]  ixgbe 0000:00:03.0 enp0s3: initiating reset due to tx
timeout
[ 568.612397 ]  ixgbe 0000:00:03.0 enp0s3: Reset adapter

This may be device specific but I think the actual behavior you see is
also dependent on the ixgbe driver in the guest. Are you on a recent
kernel ? Also, can you point me to the hack (by Peter) that you have
mentioned above ?

Thanks,
Bandan

> I'm describing steps I took, so if you notice something wrong, PLEASE let
> me know.
>
> 1. [L0] Check the device with lspci. Result is [1]
> 2. [L0] Unbind from the original driver and bind to vfio-pci driver
> following [2][3]
> 3. [L0] Start L1 with this script. [4]
> 4. [L1] L1 is able to use the network device.
> 5. [L1] Unbind from the original driver and bind to vfio-pci driver same as
> the step 2.
> 6. [L1] Start L2 with this script. [5]
> 7. [L2] Got the init failure error message above.
>
> [1] https://paste.ubuntu.com/24055745/
> [2] http://www.linux-kvm.org/page/10G_NIC_performance:_VFIO_vs_virtio
> [3] http://www.linux-kvm.org/images/b/b4/2012-forum-VFIO.pdf
> [4] https://paste.ubuntu.com/24055715/
> [5] https://paste.ubuntu.com/24055720/
>
> Thanks,
> Jintack
>
>
>>
>>
>>> Alex
>>>
>>>
>>
