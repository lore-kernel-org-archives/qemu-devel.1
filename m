Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiL9w-0006Y4-Gv
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiL9t-00026b-J4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:53:00 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com
	([104.47.32.98]:63136
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiL9t-00026N-1R
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:52:57 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 14:52:53 +0000
Message-ID: <BN7PR08MB486877C9F3E7FAEA8D28EA4DC6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1532453527-22911-53-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-53-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 52/55] linux-user: Add signal.c for
 nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, July 24, 2018 7:32 PM
> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
>
> Add signal.c as a dredirection of regular mips' signal.c, but also
> amend regular mips' signal.c. this is done to avoid the duplication
> of large pieces of code.

dredirection of -> redirection to
mips' -> MIPS'
this -> This

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 6aa303e..3d7bcbc 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -21,7 +21,15 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"

-# if defined(TARGET_ABI_MIPSO32)
+#if defined(TARGET_ABI_MIPSP32)
+struct target_sigcontext {
+    uint64_t sc_regs[32];
+    uint64_t sc_pc;
+    uint32_t sc_used_math;
+    uint32_t sc_reserved;
+};
+#define TARGET_ALMASK  (~15)
+#elif defined(TARGET_ABI_MIPSO32)
 struct target_sigcontext {
     uint32_t   sc_regmask;     /* Unused */
     uint32_t   sc_status;
@@ -43,6 +51,7 @@ struct target_sigcontext {
     target_ulong   sc_hi3;
     target_ulong   sc_lo3;
 };
+#define TARGET_ALMASK  (~7)
 # else /* N32 || N64 */
 struct target_sigcontext {
     uint64_t sc_regs[32];
@@ -61,6 +70,7 @@ struct target_sigcontext {
     uint32_t sc_dsp;
     uint32_t sc_reserved;
 };
+#define TARGET_ALMASK  (~15)
 # endif /* O32 */

> struct sigframe {
> @@ -91,6 +101,17 @@ static inline int install_sigtramp(unsigned int *tram=
p,   unsigned int syscall)
> {
>     int err =3D 0;
>=20
> +#if defined(TARGET_ABI_MIPSP32)
> +    uint16_t *tramp16 =3D (uint16_t *)tramp;
> +    /*
> +     *         li $2, __NR__foo_sigreturn
> +     *         syscall 0
> +     */
> +     __put_user(0x6040 , tramp16 + 0);
> +     __put_user(syscall, tramp16 + 1);
> +     __put_user(0      , tramp16 + 2);
> +     __put_user(0x1008 , tramp16 + 3);
> +#else
>     /*
>      * Set up the return code ...
>      *

This code segment should be in a separate patch, called, let's say, "target=
/mips: Set up signal trampoline for nanoMIPS". Perhaps there should be one =
more patch "target/mips: Handle signal context for nanoMIPS", obtained in a=
 similar fashion.

Aleksandar M.=
