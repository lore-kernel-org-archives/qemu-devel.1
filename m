Received: from eggs.gnu.org ([2001:4830:134:3::10]:57177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eomVN-0001LM-AR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eomVK-0002r2-75
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:45:29 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1eomVJ-0002q2-PT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:45:26 -0500
MIME-version: 1.0
Content-type: text/plain; charset="UTF-8"
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Thu, 22 Feb 2018 11:45:06 +0300
Message-id: <1519289107-20251-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20180222084519eucas1p19bfdda3c62fa37b881f8de2d3602f3f3@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] Fix build on ppc platform in
 migration/postcopy-ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

V4->V3
    - common helper was introduced and sanity check for
probable time jumps (comment from David)

V2->V3
    - use UINT32_MAX instead of 0xffffffff (comment from Philippe)
    - use lelative time to avoid milliseconds overflow in uint32
(comment from David)


V2->V1
This is a second version:
    - comment from David about casting
David was right, I tried to find it in standard, but it was implicitly
described for me, so part of standard:

   1. When a value with integer type is converted to another integer
type other than _Bool, if the value can be represented by the new
type, it is unchanged.
   2. Otherwise, if the new type is unsigned, the value is converted
by repeatedly adding or subtracting one more than the maximum value
that can be represented in the new type until the value is in the
range of the new type.



Initial message:

It was a problem with 64 atomics on ppc in migration/postcopy-ram.c repor=
ted by
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>.

Tested in Debian on qemu-system-ppc and in Ubuntu16.04 on i386.

This commit is based on commit afd3397a8149d8b645004e459bf2002d78f5e267
Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request'=
 into staging
but with all necessary commit reverted in
ee86981bda9ecd40c8daf81b7307b1d2aff68174

Alexey Perevalov (1):
  migration: change blocktime type to uint32_t

 hmp.c                    |  4 ++--
 migration/postcopy-ram.c | 52 ++++++++++++++++++++++++++++--------------=
------
 migration/trace-events   |  4 ++--
 qapi/migration.json      |  4 ++--
 4 files changed, 36 insertions(+), 28 deletions(-)

--=20
2.7.4
