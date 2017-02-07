Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbAvt-0006cg-Gs
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbAvs-0001w7-Fj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:56:05 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbAvs-0001vb-6l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:56:04 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so173828259wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 10:56:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 18:55:42 +0000
Message-ID: <CAFEAcA8nQL7z-dc0n2tKnakD_8NoKvqbj+KcssUqCFaVEJpi8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2017 at 18:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> A random mix of items here, nothing very major.
>
> thanks
> -- PMM
>
>
> The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170207
>
> for you to fetch changes up to 7727b832886fafbdec7299eb7773dc9071bf4cdd:
>
>   stellaris: Use the 'unimplemented' device for parts we don't implement (2017-02-07 18:30:00 +0000)
>
> ----------------------------------------------------------------
> target-arm:
>  * new "unimplemented" device for stubbing out devices in a
>    system model so accesses can be logged
>  * stellaris: document the SoC memory map
>  * arm: create instruction syndromes for AArch32 data aborts
>  * arm: Correctly handle watchpoints for BE32 CPUs
>  * Fix Thumb-1 BE32 execution and disassembly
>  * arm: Add cfgend parameter for ARM CPU selection
>  * sd: sdhci: check data length during dma_memory_read
>  * aspeed: add a watchdog controller
>  * integratorcp: adding vmstate for save/restore

Clang complains about unused functions; will squash in:

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a14f74c..4436d8f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -982,7 +982,7 @@ static inline void
gen_aa32_ld##SUFF##_iss(DisasContext *s,              \
                                            TCGv_i32 a32, int index,      \
                                            ISSInfo issinfo)              \
 {                                                                        \
-    gen_aa32_ld_i32(s, val, a32, index, OPC | s->be_data);               \
+    gen_aa32_ld##SUFF(s, val, a32, index);                               \
     disas_set_da_iss(s, OPC, issinfo);                                   \
 }

@@ -997,7 +997,7 @@ static inline void
gen_aa32_st##SUFF##_iss(DisasContext *s,              \
                                            TCGv_i32 a32, int index,      \
                                            ISSInfo issinfo)              \
 {                                                                        \
-    gen_aa32_st_i32(s, val, a32, index, OPC | s->be_data);               \
+    gen_aa32_st##SUFF(s, val, a32, index);                               \
     disas_set_da_iss(s, OPC, issinfo | ISSIsWrite);                      \
 }


(which avoids the problem by having the _iss() versions of the
function call the non-iss versions rather than duplicating
their function body; seems like better code anyway.)

thanks
-- PMM
