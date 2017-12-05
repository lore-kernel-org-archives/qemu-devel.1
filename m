Received: from eggs.gnu.org ([2001:4830:134:3::10]:47377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QR-0004SS-8l
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QO-0006rD-2K
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:17:59 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38184
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eM8QN-0006ps-PJ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:17:55 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  5 Dec 2017 08:17:39 +0000
Message-Id: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 0/5] net: introduce common net_crc32() and
 net_crc32_le() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Whilst trying to debug a CRC32 endian issue for NIC multicast hash lookups, it
struck me that it would make sense to have a common set of standard ethernet
CRC32 functions (both little and big endian variants) in net.c.

The first two patches introduce the relevant functions while the last 3 patches
switch the pcnet, eepro100 and sunhme drivers over to use them, allowing us to remove
their private implementations.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Add sumhme net_crc32_le() conversion


Mark Cave-Ayland (5):
  net: move CRC32 calculation from compute_mcast_idx() into its own
    net_crc32() function
  net: introduce net_crc32_le() function
  pcnet: switch lnc_mchash() over to use net_crc32_le()
  eepro100: switch e100_compute_mcast_idx() over to use net_crc32()
  sunhme: switch sunhme_receive() over to use net_crc32_le()

 hw/net/eepro100.c | 19 +------------------
 hw/net/pcnet.c    | 16 +---------------
 hw/net/sunhme.c   | 25 +------------------------
 include/net/net.h |  5 ++++-
 net/net.c         | 38 +++++++++++++++++++++++++++++++++-----
 5 files changed, 40 insertions(+), 63 deletions(-)

-- 
2.11.0
