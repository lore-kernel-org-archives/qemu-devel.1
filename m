Received: from eggs.gnu.org ([209.51.188.92]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gi9Jg-0007Ml-6w
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 21:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gi9Jf-0000mk-1b
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 21:46:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2235 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1gi9Ja-0000jB-1R
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 21:46:29 -0500
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <648fabd1-b598-02a9-14f6-02ed2c767b2a@huawei.com>
Date: Sat, 12 Jan 2019 10:30:40 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Questions about VFIO enabling MSIX vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, wanghaibin 00208455 <wanghaibin.wang@huawei.com>

Hi folks,

I have some questions about vfio_msix_vector_do_use() in hw/vfio/pci.c, could you help to explain?

We can see that when guest tries to enable one specific MSIX vector by unmasking MSIX Vector Control, the access will be trapped and then into function vfio_msix_vector_do_use(). And we may go to the below branch in line 525:


520 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l520> /*
521 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l521> * We don't want to have the host allocate all possible MSI vectors
522 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l522> * for a device if they're not in use, so we shutdown and incrementally
523 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l523> * increase them as needed.
524 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l524> */
525 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l525> if (vdev->nr_vectors < nr + 1) {
526 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l526> vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
527 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l527> vdev->nr_vectors = nr + 1;
528 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l528> ret = vfio_enable_vectors(vdev, true);
529 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l529> if (ret) {
530 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l530> error_report("vfio: failed to enable vectors, %d", ret);
531 <https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/pci.c;h=c0cb1ec289084eb1593f24dc423e647f4b29eb74;hb=HEAD#l531> }

Here all MSIX vectors will be disabled first and then enabled, with one more MSIX. The comment is there but I still don't quite understand. It makes sense for not allocating all possible MSI vectors, but why shall we shutdown the whole MSI when being requested to enable one specific vector? Can't we just enable the user specified vector indexed by "nr"?

What's more, on ARM64 systems with GIC ITS, the kernel will issue an ITS discard command when disabling a MSI vector, which will drop currently pending MSI interrupt. If device driver in guest system enables some MSIs first and interrupts may come at any time, and then it tries to enable other MSIs, is it possible for the above code to cause interrupts missing?

I may misunderstand the whole thing... Any comment is appreciated.

Thanks,

Heyi
