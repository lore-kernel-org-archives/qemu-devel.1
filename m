Received: from eggs.gnu.org ([209.51.188.92]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYtc-0005tq-MG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYtb-00083q-Nn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 29 Jan 2019 19:17:38 +0000
Message-Id: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v4 0/8] target/ppc: remove various endian hacks
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
are a large number of endian-based hacks in int_helper.c which can be removed by
making use of the various Vsr* macros.

Patch 1 is simple enough, and implements the complete set of Vsr* macros for
both big endian and little endian hosts.

Patches 2 and 3 rework the vector merge and multiply algorithms so that they
no longer require the endian-dependent HI_IDX and LO_IDX macros.

Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macros by
replacing the element accesses with their equivalent Vsr* macro instead.

Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shift bug
in the ROTRu32 and ROTRu64 macros pointed out by Richard during the review of
v1.

Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIGENDIAN
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


v4:
- Rebase onto master
- Add R-B tag from Richard for patch 4
- Use Richard's improved vmrg{l,h} algorithm in patch 2

v3:
- Rebase onto master
- Add R-B tags from Richard

v2:
- Add R-B tags from Richard
- Add patches 6 and 7 to simplify the VEXT_SIGNED macro and fix a potential
  shift bug in the ROTRu32 and ROTRu64 macros
- Don't require ordered access for VNEG and VGENERIC_DO macros as pointed out
  by Richard


Mark Cave-Ayland (8):
  target/ppc: implement complete set of Vsr* macros
  target/ppc: rework vmrg{l,h}{b,h,w} instructions to use Vsr* macros
  target/ppc: rework vmul{e,o}{s,u}{b,h,w} instructions to use Vsr*
    macros
  target/ppc: eliminate use of HI_IDX and LO_IDX macros from
    int_helper.c
  target/ppc: eliminate use of EL_IDX macros from int_helper.c
  target/ppc: simplify VEXT_SIGNED macro in int_helper.c
  target/ppc: remove ROTRu32 and ROTRu64 macros from int_helper.c
  target/ppc: remove various HOST_WORDS_BIGENDIAN hacks in int_helper.c

 target/ppc/int_helper.c | 507 +++++++++++++++++++-----------------------------
 target/ppc/internal.h   |   9 +-
 2 files changed, 209 insertions(+), 307 deletions(-)

-- 
2.11.0
