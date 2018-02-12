Received: from eggs.gnu.org ([2001:4830:134:3::10]:52899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elLzg-0007VR-C8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elLzd-0003cX-2n
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:50:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elLzc-0003bl-SC
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:50:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elLzb-0006Xq-3X
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 21:50:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1142B2E80C3
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 21:50:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2018 21:44:09 -0000
From: Michael Fruchtman <msfrucht@us.ibm.com>
Reply-To: Bug 1749016 <1749016@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151847184922.10299.8486156753106334227.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1749016] [NEW] VHDX BAT and Metadata Region
 Header Required Bit Not Set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When converting a VMDK to VHDX the resulting VHDX's Region table has a
small error. According to the VHDX specification the BAT and Metadata
entries for the region header required bit should be set to 1.  In a
VHDX created by qemu-img, this bit is not set.

See Table 4: Known Region Properties of the VHDX specification.

The structure format is as following from Structure 4: Region Table
Entry:

struct VHDX_REGION_TABLE_ENTRY {
GUID Guid;
UINT64 FileOffset;
UINT32 Length;
UINT32 Required:1;
UINT32 Reserved:31;
}

The Required bit for VHDX specified BAT and Metadata Regions Required
bit in the entry is not set as required in the current specification.

VHDX Region Table in a valid VHDX

Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 01 00 00 00  =

0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 01 00 00 00

VHDX Region Table in a VHDX converted by qemu-img from VMDK

Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 00 00 00 00  =

0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 00 00 00 00

The fist bit at 0x0003002A and 0x0003004A should be set to 1.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-img vhdx

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749016

Title:
  VHDX BAT and Metadata Region Header Required Bit Not Set

Status in QEMU:
  New

Bug description:
  When converting a VMDK to VHDX the resulting VHDX's Region table has a
  small error. According to the VHDX specification the BAT and Metadata
  entries for the region header required bit should be set to 1.  In a
  VHDX created by qemu-img, this bit is not set.

  See Table 4: Known Region Properties of the VHDX specification.

  The structure format is as following from Structure 4: Region Table
  Entry:

  struct VHDX_REGION_TABLE_ENTRY {
  GUID Guid;
  UINT64 FileOffset;
  UINT32 Length;
  UINT32 Required:1;
  UINT32 Reserved:31;
  }

  The Required bit for VHDX specified BAT and Metadata Regions Required
  bit in the entry is not set as required in the current specification.

  VHDX Region Table in a valid VHDX

  Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
  0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
  0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
  0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 01 00 00 00  =

  0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
  0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 01 00 00 00

  VHDX Region Table in a VHDX converted by qemu-img from VMDK

  Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
  0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
  0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
  0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 00 00 00 00  =

  0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
  0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 00 00 00 00

  The fist bit at 0x0003002A and 0x0003004A should be set to 1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1749016/+subscriptions
