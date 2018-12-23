Received: from eggs.gnu.org ([2001:4830:134:3::10]:50493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gb26M-0000jr-0F
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 06:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gb26F-0008Ro-R4
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 06:39:21 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 23 Dec 2018 11:38:53 +0000
Message-Id: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/6] target/ppc: remove various endian hacks
 from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

>From working on the TCG vector operations patchset, it is apparent that there
are a large number endian-based hacks in int_helper.c which can be removed by
making use of the various Vsr* macros.

Patch 1 is simple enough, and implements the complete set of Vsr* macros for
both big endian and little endian hosts.

Patches 2 and 3 rework the vector merge and multiply algorithms so that they
no longer require the endian-dependent HI_IDX and LO_IDX macros.

Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macros by
replacing the element accesses with their equivalent Vsr* macro instead.

Finally patch 6 is an inspection-based removal of other HOST_WORDS_BIGENDIAN
hacks in int_helper.c, again replacing accesses with the relevant Vsr* macro
instead.

Note that there are still some endian hacks left in int_helper.c after this
patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I macro still
remains in places where the index variable was used for purposes other than
accessing elements within the vector.

There were also some parts where additional conversion could be done, but I
wasn't confident enough to make the change without access to PPC64 test images
or real big-endian host hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk> "target/ppc: prepare for conversion to TCG vector operations"


Mark Cave-Ayland (6):
  target/ppc: implement complete set of Vsr* macros
  target/ppc: rework vmrg{l,h}{b,h,w} instructions to use Vsr* macros
  target/ppc: rework vmul{e,o}{s,u}{b,h,w} instructions to use Vsr*
    macros
  target/ppc: eliminate use of HI_IDX and LO_IDX macros from
    int_helper.c
  target/ppc: eliminate use of EL_IDX macros from int_helper.c
  target/ppc: remove various HOST_WORDS_BIGENDIAN hacks in int_helper.c

 target/ppc/int_helper.c | 551 ++++++++++++++++++++----------------------------
 target/ppc/internal.h   |   9 +-
 2 files changed, 242 insertions(+), 318 deletions(-)

-- 
2.11.0
