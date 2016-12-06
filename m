Received: from eggs.gnu.org ([2001:4830:134:3::10]:37425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJOV-0001Gq-7G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJOS-0003ax-3N
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:19:07 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEJOR-0003ap-Ud
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:19:04 -0500
Received: by mail-io0-f179.google.com with SMTP id c21so612518126ioj.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 09:19:03 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Dec 2016 17:18:00 +0000
Message-ID: <CAJSP0QXgf6PAge69RMTv_cQQoPF9zWA9B9hvhWUa7D+NGiHJcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] virtio-rng async rng_backend_request_entropy() vs
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Dave Gilbert hit the following virtio migration error message today
and asked me if it was a known bug:
virtio-rng: VQ 0 size 0x8 < last_avail_idx 0x21 - used_idx 0x22

It looks like a legitimate new bug.  This error occurred with postcopy
live migration and no rng backend (just -device virtio-rng-pci).

The virtio-rng code uses rng_backend_request_entropy().  Is the async
callback safe with live migration?

It should not fire after vm_stop() on the source host.  Looking
briefly at the code suggests it may fire during/after migration
handover.  This could lead to inconsistent virtio state since the
vring (guest RAM) is modified by the source host and the postcopy
destination host may load those updated values.

Stefan
