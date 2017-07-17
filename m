Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3V0-00072M-Eg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3Uz-0001aE-M3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:43:34 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX3Uz-0001Zt-Ee
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:43:33 -0400
Received: by mail-wm0-x236.google.com with SMTP id w126so71896583wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:43:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717101700.23552-1-kraxel@redhat.com>
References: <20170717101700.23552-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 11:43:11 +0100
Message-ID: <CAFEAcA_=_5Y_DBJnvhHsOwGfKX-TKB+OPR5g_EgpUSNvqoS60w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 11:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Script to reformat sources in qemu style.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/indent.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100755 scripts/indent.sh
>
> diff --git a/scripts/indent.sh b/scripts/indent.sh
> new file mode 100755
> index 0000000000..8f045ecb1d
> --- /dev/null
> +++ b/scripts/indent.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +#
> +# indent wrapper script, with args to format
> +# source code according to qemu coding style.
> +#
> +indent --ignore-profile        \
> +       --k-and-r-style         \
> +       --line-length 80        \
> +       --indent-level 4        \
> +       --no-tabs               \
> +       "$@"

A quick pass of this over target/arm suggests it's probably
missing some arguments. For instance, things it gets wrong:

(1) it's adding spaces after '*' in "SomeType *foo" parameters:

-static void aarch64_note_init(struct aarch64_note *note, DumpState *s,
+static void aarch64_note_init(struct aarch64_note *note, DumpState * s,

(2) weird extra space after cast:

-    ((TaskState *)cs->opaque)->swi_errno = err;
+    ((TaskState *) cs->opaque)->swi_errno = err;

(3) weird spacing around address-of operator:

-    cpu_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4, 0);
+    cpu_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *) & size, 4, 0);

(4) weird spacing addition to a negative number constant:

-            return (uint32_t)-1;
+            return (uint32_t) - 1;

(5) mis-indentation of second line of multi-line assignment:

 static Property arm_cpu_reset_cbar_property =
-            DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
+DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);

(6) incorrectly deletes spaces in a named-struct-field initializer:

-            .name = "IFAR", .cp = 15, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 1,
+            .name = "IFAR",.cp = 15,.crn = 6,.crm = 0,.opc1 = 0,.opc2 = 1,

(7) gets confused by HELPER() macro in function definition:

-int64_t HELPER(sdiv64)(int64_t num, int64_t den)
-{
+int64_t HELPER(sdiv64) (int64_t num, int64_t den) {

(8) It disagrees with our emacs indent config about level of
indent for expressions:

     return arm_feature(env, ARM_FEATURE_PMSA) &&
-           arm_feature(env, ARM_FEATURE_V7);
+        arm_feature(env, ARM_FEATURE_V7);

--no-space-after-casts ought to fix 2, but in practice doesn't
seem to...

thanks
-- PMM
