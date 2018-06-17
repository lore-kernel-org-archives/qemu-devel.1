Received: from eggs.gnu.org ([2001:4830:134:3::10]:33983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUcUV-0002oV-IB
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUcUQ-00074H-Lc
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:33:31 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <suratiamol@gmail.com>)
	id 1fUcUQ-00073y-GI
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:33:26 -0400
Received: by mail-pg0-x22a.google.com with SMTP id c10-v6so6505294pgu.9
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 11:33:26 -0700 (PDT)
From: Amol Surati <suratiamol@gmail.com>
Date: Mon, 18 Jun 2018 00:05:14 +0530
Message-Id: <20180617183515.3982-1-suratiamol@gmail.com>
Subject: [Qemu-devel] [RFC 0/1] ide: attempt at fixing the bug #1777315.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amol Surati <suratiamol@gmail.com>

This is an attempt at fixing the bug #1777315, through code review
alone (i.e. test and debugging are pending.)

The function bmdma_prepare_buf shows that s->io_buffer_size can be
controlled through the PRDs, and it is possible for it to not be a
perfect multiple of the sector size (the function ide_dma_cb assumes
that s->io_buffer_size is a perfect multiple of the sector size.)

For instance, consider a transfer of 630 bytes.
s->nsector should be (probably, I did not verify through test/debug) 2.

Let there be two PRDs, handed over to the bus-master:
prd[0]: len=512, eot=0
prd[1]: len=128, eot=1

The function bmdma_prepare_buf receives limit as 2*512 = 1024. During
the processing of the two PRDs, s->sg.size and s->io_buffer_size both
end up being set to 630.

Within the function ide_dma_cb, s->io_buffer_size >> 9 results in n
being set to 1, which is not greater than s->nsector (which must be
2.)

n * 512 is 512, while s->sg.size is 630; the difference results in
the firing of 'assert(n * 512 == s->sg.size);'.

Alternatively, a single change (discarding the current patch),

'assert(n * 512 == s->sg.size || s->io_buffer_size == s->sg.size);',

could work, provided these two are the only possibilities.




Amol Surati (1):
  ide: bug #1777315: io_buffer_size and sg.size can represent partial
    sector sizes

 hw/ide/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1
