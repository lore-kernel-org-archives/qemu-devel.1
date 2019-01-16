Received: from eggs.gnu.org ([209.51.188.92]:55042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gjlGW-00073V-Kt
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gjlGU-0000EF-MZ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:29:55 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:53456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gjlGU-0008Us-Eh
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:29:54 -0500
Received: from player799.ha.ovh.net (unknown [10.109.160.25])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id C6B92E7B2B
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:29:51 +0100 (CET)
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
	<7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
	<186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <35b8b6d4-953a-d5ef-ceb5-5fa4a93c6c0e@kaod.org>
Date: Wed, 16 Jan 2019 14:29:41 +0100
MIME-Version: 1.0
In-Reply-To: <186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ppc: Fix duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 1/16/19 12:47 PM, Thomas Huth wrote:
> On 2019-01-16 12:43, C=C3=A9dric Le Goater wrote:
>> On 1/11/19 9:17 AM, Thomas Huth wrote:
>>> When compiling the ppc code with clang and -std=3Dgnu99, there are a
>>> couple of warnings/errors like this one:
>>>
>>>   CC      ppc64-softmmu/hw/intc/xics.o
>>> In file included from hw/intc/xics.c:35:
>>> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState=
' is a C11 feature
>>>       [-Werror,-Wtypedef-redefinition]
>>> typedef struct ICPState ICPState;
>>>                         ^
>>> target/ppc/cpu.h:1181:25: note: previous definition is here
>>> typedef struct ICPState ICPState;
>>>                         ^
>>> Work around the problems by including the proper headers instead.
>>
>> Thomas,
>>
>>
>> After a closer look, I think we should use 'void *' under PowerPCCPU=20
>> as it was the case before I introduced the second interrupt presenter.
>=20
> If you don't like the #includes, why not simply do anonymous struct
> forward declarations here? I think that would be better than "void *".

yes.
=20
>> That's a bigger change reverting bits of already merged patches. I can
>> take care of it if you prefer.=20
>=20
> Could I keep the current patch in my series so that I can get the
> patches finally merged? You could then do any clean up that you like on
> top of it, ok?

OK.=20

See below the patch I would propose. Compiled tested with clang -std=3Dgn=
u99.

>> I use a f29 for dev. Which compiler should I install ?=20
>=20
> Any version of Clang with -std=3Dgnu99 should do the job here, I think.

It does.

Thanks,

C.

=20
>From 0119d5b2f6fa963f5951897bbadd638f94ecdf4b Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Wed, 16 Jan 2019 14:27:25 +0100
Subject: [PATCH] ppc: remove inclusion of hw/ppc header file
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

and use struct forward declarations instead.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bde4dff1ba80..ca5f7f16a820 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,11 +23,6 @@
 #include "qemu-common.h"
 #include "qemu/int128.h"
=20
-#ifndef CONFIG_USER_ONLY
-#include "hw/ppc/xive.h" /* for XiveTCTX */
-#include "hw/ppc/xics.h" /* for ICPState */
-#endif
-
 //#define PPC_EMULATE_32BITS_HYPV
=20
 #if defined (TARGET_PPC64)
@@ -1204,8 +1199,8 @@ struct PowerPCCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
 #ifndef CONFIG_USER_ONLY
-    ICPState *icp;
-    XiveTCTX *tctx;
+    struct ICPState *icp;
+    struct XiveTCTX *tctx;
 #endif
=20
     /* Fields related to migration compatibility hacks */
--=20
2.20.1
