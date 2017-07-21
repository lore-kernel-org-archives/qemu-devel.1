Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYdHS-0001Cj-Ui
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYdHP-0007rG-Oc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYdHP-0007qs-FB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:08:03 -0400
Date: Fri, 21 Jul 2017 20:07:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170721190755.GA2981@work-vm>
References: <20170721172832.GI2133@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170721172832.GI2133@work-vm>
Subject: Re: [Qemu-devel] dirty page count problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: haozhong.zhang@intel.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peterx@redhat.com, lvivier@redhat.com, quintela@redhat.com

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> Hi,
>   Git bisect is pointing to your patch 084140bd49:
>   exec: fix access to ram_list.dirty_memory when sync dirty bitmap
>=20
> trying to diagnose a bug I'm seeing; it looks like the dirty page count
> is wrong for some reason.
>=20
> Alex Benn=E9e spotted a problem where the postcopy test would occasionally
> fail under very heavy load;    attaching a debugger and it looks like
> the problem is we have a migration_dirty_page count stuck at 2;
> in the normal migration tests we don't spot this, because 2 pages is
> smaller than the threshold to end migration and so an extra 2 pages
> doesn't block it finishing.   However, with a very
> small downtime setting (like we use in the postcopy test) and with
> very low bandwidth (as when Alex ran the test on a very heavily loaded
> machine) we end up never calling the bitmap sync again and never
> completing the iteration.
>=20
> I'm using the following addition to spot the problem:

I think I have the fix for this, or at least the reason; the alignment
check also needs fixing up, but the 08414 patch missed it.

  Alex: Please test the fix included at the bottom

>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index e75f1050e4..3ddf884952 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1350,6 +1350,13 @@ static int ram_find_and_save_block(RAMState *rs, b=
ool last_stage)
>          }
>      } while (!pages && again);
>=20
> +    if (!pages && !again && pss.complete_round && rs->migration_dirty_pa=
ges)
> +    {
> +        /* Should make this fail migration ? */
> +        fprintf(stderr, "%s: no page found, yet dirty_pages=3D%"PRIu64"\=
n",
> +                __func__, rs->migration_dirty_pages);
> +    }
> +
>      rs->last_seen_block =3D pss.block;
>      rs->last_page =3D pss.page;
>=20
> (which I might add as a test to fail a migration)
>=20
> That test fails easily even on an unloaded machine:
> tests/postcopy-test
> /x86_64/postcopy: ram_find_and_save_block: no page found, yet dirty_pages=
=3D2
> ram_find_and_save_block: no page found, yet dirty_pages=3D2
> ram_find_and_save_block: no page found, yet dirty_pages=3D2
> OK
>=20
>=20
> I'll try and debug where our extra two pages are coming from.

=46rom b2c86818eaaaf790246f21ae21fead903c1d64f0 Mon Sep 17 00:00:00 2001
=46rom: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Fri, 21 Jul 2017 19:59:01 +0100
Subject: [PATCH] cpu_physical_memory_sync_dirty_bitmap: Fix alignment check

This code has an optimised, word aligned version, and a boring
unaligned version.  Recently 084140bd498909 fixed a missing offset
addition from the core of both versions.  However, the offset isn't
necessarily aligned and thus the choice between the two versions
needs fixing up to also include the offset.

DANGER: Friday evening, post-dinner lightly tested patch.

Symptom:
  A few stuck unsent pages during migration; not normally noticed
unless under very low bandwidth.

Fixes: 084140bd498909
---
 include/exec/ram_addr.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index c04f4f6..c802f7f 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -378,15 +378,16 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlo=
ck *rb,
 {
     ram_addr_t addr;
     unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAGE_BI=
TS);
     uint64_t num_dirty =3D 0;
     unsigned long *dest =3D rb->bmap;
=20
     /* start address is aligned at the start of a word? */
-    if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) {
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
+         (start + rb->offset)) {
         int k;
         int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAG=
E_BITS);
         unsigned long idx =3D (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_=
SIZE;
         unsigned long offset =3D BIT_WORD((word * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
--=20
1.8.3.1

> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
