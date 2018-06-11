Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSQKb-0007TI-1B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSQKa-0000Tz-3s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:10:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fSQKZ-0000TG-SN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:10:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 18:10:04 +0100
Message-Id: <20180611171007.4165-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Add ldn_*_p() and stn_*_p() and use them
 in exec.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

There's a common pattern in QEMU where a function needs to perform
a data load or store of an N byte integer in a particular endianness.
At the moment this is handled by doing a switch() on the size and
calling the appropriate ld*_p or st*_p function for each size.
    
This patchset provides a new family of functions ldn_*_p() and stn_*_p()
which take the size as an argument and do the switch() themselves,
and uses them in 5 callsites in exec.c.

If people like the idea, naming convention, etc, we can look for
and convert other callsites, extend this to eg an address_space_ldn()
and address_space_stn() (sample use cases in watch_mem_read(),
watch_mem_write(), dino_chip_write_with_attrs(), tx_ppc_read(),
tx_ppc_write()...)

Patch 2 here fixes an apparently unintentional sign-extension in
subpage_read(), so that patch 3 is a no-behaviour-change patch.

thanks
-- PMM

Peter Maydell (3):
  bswap: Add new stn_*_p() and ldn_*_p() memory access functions
  exec.c: Don't accidentally sign-extend 4-byte loads in subpage_read()
  exec.c: Use stn_p() and ldn_p() instead of explicit switches

 include/exec/cpu-all.h      |   4 ++
 include/qemu/bswap.h        |  52 +++++++++++++++++
 exec.c                      | 112 +++---------------------------------
 docs/devel/loads-stores.rst |  15 +++++
 4 files changed, 79 insertions(+), 104 deletions(-)

-- 
2.17.1
