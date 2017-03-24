Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crSxk-0001Ec-RX
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crSxj-00040x-OX
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:20 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crSxj-00040c-Hq
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:19 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n11so7754489wma.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 10:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0036c9a7-717b-356a-e184-69270386431c@twiddle.net>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
	<CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
	<1a35985f-ad4b-c017-b355-51d47aaffa11@redhat.com>
	<CAFEAcA9oBDYqmRpwU5B2o2X-viYrccf1V3zASYGpuaQBL866ig@mail.gmail.com>
	<0036c9a7-717b-356a-e184-69270386431c@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 17:24:57 +0000
Message-ID: <CAFEAcA_E82Hn-7W=WDTSWoZPmEHifKUKDJgDpO0-vqeGBwBCsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2017 at 01:28, Richard Henderson <rth@twiddle.net> wrote:
> I also have access to a sparc box.
>
> (At the moment I'm trying to update it from 2013 era system libraries, and
> to enable the 64-bit userland, before I do any testing of current mainline.)

So far I have found that we seem to be mishandling 32-bit guest
load/stores, which I tentatively suggest

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index d1f4c0dead..c72b57dc58 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1119,7 +1119,7 @@ static void tcg_out_qemu_ld(TCGContext *s,
TCGReg data, TCGReg addr,
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;
     }
-    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
+    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);

     /* We use the helpers to extend SB and SW data, leaving the case
        of SL needing explicit extending below.  */
@@ -1199,7 +1199,7 @@ static void tcg_out_qemu_st(TCGContext *s,
TCGReg data, TCGReg addr,
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;
     }
-    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
+    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
     if (!SPARC64 && (memop & MO_SIZE) == MO_64) {
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;

(otherwise we pass a high-bits-set value to the slowpath functions,
which happens to work if QEMU was built with debug enabled but not
if it doesn't.)

That then at least makes i386 and x86_64 guests behave the same,
ie they don't work. I haven't figured out what's going wrong there yet.

thanks
-- PMM
