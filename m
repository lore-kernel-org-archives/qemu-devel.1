Received: from eggs.gnu.org ([209.51.188.92]:50981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3HCk-0005oR-JC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3HCj-0007VR-HD
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:26:42 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1h3HCj-0007Ts-8g
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:26:41 -0400
Received: by mail-wr1-f48.google.com with SMTP id o9so4191630wrv.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 02:26:40 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Mon, 11 Mar 2019 10:26:37 +0100
Message-ID: <871s3dg3si.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi,

Thanks to Q35/PCIe, we can now assign a large number of PCI devices to a
single VM, but it seems that Flatview rendering scales poorly (worse
than linear) when it has to deal with a large number of Memory Regions.

I've measured to cost of the pci_default_write_config() call at
virtio_write_config() for 1 PCI device vs. 100 PCI devices:

 - 1 PCI device

write_config: 1879 us
write_config: 1037 us
write_config: 1 us
write_config: 3 us
write_config: 1783 us
write_config: 2652 us
write_config: 1 us
write_config: 2 us
write_config: 1551 us

 - 100 PCI devices

write_config: 503963 us
write_config: 1 us
write_config: 493344 us
write_config: 0 us
write_config: 472946 us
write_config: 1 us
write_config: 495175 us
write_config: 1 us
write_config: 519312 us
write_config: 1 us

I guess this is a consequence of having to reset/rebuild the Flatview
when altering the PCI BAR regions.

Is this a known issue we're already working on?

Thanks,
Sergio (slp).
