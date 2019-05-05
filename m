Received: from eggs.gnu.org ([209.51.188.92]:38666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIST-0001hV-Hw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNISS-00072V-Gd
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNISS-000721-7I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id l132so399772pfc.8
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:49:39 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
	<557b6776-45ab-0c00-7e1e-45fe33705d0b@linaro.org>
	<ea616832-33ca-eeed-03f9-708394e72ecb@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b249770-2b30-ef94-dc37-67cded8e6880@linaro.org>
Date: Sun, 5 May 2019 07:49:36 -0700
MIME-Version: 1.0
In-Reply-To: <ea616832-33ca-eeed-03f9-708394e72ecb@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] target/ppc: introduce
 GEN_VSX_HELPER_X3 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 2:52 AM, Mark Cave-Ayland wrote:
> Right, it looks like VSX_CMP is the culprit here. Am I right in thinking that it's
> best to remove the opc parameter from GEN_VSX_HELPER_X3 above, and then have a
> separate gen and helper function for just the VSX_CMP instructions? Presumably this
> reduces of the overhead at both translation and execution time for the instructions
> that don't require it.

Yep.

I think the best fix for VSX_CMP is to return the value that is to be assigned
to cr[6], and let it assign like so:

  gen_helper_foo(cpu_crf[6], other, arguments);

(Or if the opcode bit is unset,

  TCGv_i32 ignored = tcg_temp_new_i32();
  gen_helper_foo(ignored, other arguments);
  tcg_temp_free_i32(ignored);
)

at which point these functions do not modify tcg globals, so the decl
can be improved to

  DEF_HELPER_FLAGS_2(xvcmpeqdp, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr)

To keep the assignment vs exception order, you remove the direct call to
do_float_check_status and use gen_helper_float_check_status.


r~
