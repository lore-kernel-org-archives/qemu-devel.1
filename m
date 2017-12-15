Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-000628-D6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw2-0006gG-4d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60812
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw1-0006OU-Sj
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:42 +0000
Message-Id: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 00/13] net: introduce common net_crc32() and
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

Patches 1 and 2 introduce the new net_crc32() and net_crc32_le() functions for
use by NIC multicast hash lookups.

Patches 3 to 5 switch the pcnet, eepro100 and sunhme drivers over to use the
new functions instead of having their own private implementations.

Patch 6 fixes the sungem multicast filter CRC calculation, since we can see from
the Linux sungem driver that the CRC is calculated using ether_crc32_le() and so
the direct use of the zlib crc32() function is incorrect. The solution here is to
simply use the corresponding net_crc32_le() function.

Patches 7 to 12 switch the remaining users of compute_mcast_idx() over to use
the new net_crc32() function as it becomes much easier to spot errors in the
multicast hash calculations (see below).

Finally patch 13 removes the now unused compute_mcast_idx() function.

One of the motivations for removing compute_mcast_idx() and using the CRC and
bitshift inline is because it makes it much easier to spot potential errors
when comparing with the corresponding driver source code. This led to the following
curiosities whilst developing the patchset:

1) The sungem multicast filter CRC calculation was incorrect (fixed by patch 6 as
   I was able to test locally)

2) After conversion we can see in eepro100.c line 1682 that there is one single
   remaining multicast hash calculation that doesn't apply a BITS(7, 2) mask to
   the filter index when compared with all the others. This looks incorrect, but
   I don't have an easy way to verify this.

3) In ftgmac100.c we see a comment next to the multicast hash filter calculation
   that states "TODO: this does not seem to work for ftgmac100". Upon consulting the
   Linux driver source we can see that ether_crc32_le() is used in the driver
   suggesting that changing net_crc32() to net_crc32_le() should fix the calculation.
   Again I've left this as I don't have an easy way to verify the fix.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Add R-B and S-o-B tags
- Fix sungem multicast hash filter
- Use ETH_ALEN to specift MAC address length as suggested by Phillipe
- Switch to using inline CRC + bitshift as suggested by Stefan (i.e. remove
  what's left of the remaining hash function)
- Convert all remaining users of compute_mcast_idx() to inline CRC + bitshift
  (and then remove it) to make it easier to validate the multicast hash index
  calculation with the corresponding driver source

v2:
- Add sumhme net_crc32_le() conversion

Mark Cave-Ayland (13):
  net: move CRC32 calculation from compute_mcast_idx() into its own
    net_crc32() function
  net: introduce net_crc32_le() function
  pcnet: switch pcnet over to use net_crc32_le()
  eepro100: switch eepro100 e100_compute_mcast_idx() over to use
    net_crc32()
  sunhme: switch sunhme over to use net_crc32_le()
  sungem: fix multicast filter CRC calculation
  eepro100: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  opencores_eth: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  lan9118: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  ftgmac100: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  ne2000: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  rtl8139: use inline net_crc32() and bitshift instead of
    compute_mcast_idx()
  net: remove unused compute_mcast_idx() function

 hw/net/eepro100.c      | 32 +++++---------------------------
 hw/net/ftgmac100.c     |  2 +-
 hw/net/lan9118.c       |  3 ++-
 hw/net/ne2000.c        |  3 ++-
 hw/net/opencores_eth.c |  3 ++-
 hw/net/pcnet.c         | 22 ++--------------------
 hw/net/rtl8139.c       |  2 +-
 hw/net/sungem.c        |  5 ++---
 hw/net/sunhme.c        | 25 +------------------------
 include/net/net.h      |  5 ++++-
 net/net.c              | 33 ++++++++++++++++++++++++++++-----
 11 files changed, 50 insertions(+), 85 deletions(-)

-- 
2.11.0
