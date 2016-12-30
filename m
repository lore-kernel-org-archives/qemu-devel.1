Received: from eggs.gnu.org ([2001:4830:134:3::10]:47120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fbl@redhat.com>) id 1cMwVA-0005vN-4K
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 07:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fbl@redhat.com>) id 1cMwV7-00058q-2c
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 07:41:40 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fbl@redhat.com>) id 1cMwV6-00058Z-VX
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 07:41:37 -0500
Received: by mail-qk0-f181.google.com with SMTP id u25so285479273qki.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 04:41:36 -0800 (PST)
Date: Fri, 30 Dec 2016 10:41:30 -0200
From: Flavio Leitner <fbl@redhat.com>
Message-ID: <20161230104130.29ff671b@x240.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] vhost-user breaks after 96a3d98.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


Hi,

While I was testing vhost-user using OVS 2.5 and DPDK 2.2.0 in the
host and testpmd dpdk 2.2.0 in the guest, I found that the commit
below breaks the environment and no packets gets into the guest.

dpdk port --> OVS --> vhost-user --> guest --> testpmd
                         ^--- drops here         ^--- no packets here.

commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665
Author: Jason Wang <jasowang@redhat.com>
Date:   Mon Aug 1 16:07:58 2016 +0800

    vhost: don't set vring call if no vector
    
    We used to set vring call fd unconditionally even if guest driver does
    not use MSIX for this vritqueue at all. This will cause lots of
    unnecessary userspace access and other checks for drivers does not use
    interrupt at all (e.g virtio-net pmd). So check and clean vring call
    fd if guest does not use any vector for this virtqueue at
    all.
[...]

Thanks,
-- 
Flavio
