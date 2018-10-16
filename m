Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMn7-0000b3-9I
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMn1-00025O-K8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:41:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMmp-0001oP-U3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:41:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id 14so18013600oth.2
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:41:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008212205.17752-4-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
	<20181008212205.17752-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:40:52 +0100
Message-ID: <CAFEAcA_QxgmO+dhT=J4J5_jvVHE9zBE4nFL1+2Q-qL+jCLMZrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/arm: Convert v8 extensions
 from feature bits to isar tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 October 2018 at 22:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Most of the v8 extensions are self-contained within the ISAR
> registers and are not implied by other feature bits, which
> makes them the easiest to convert.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index c1b65f3efb..1d60569583 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -7,6 +7,7 @@
>  /* internal defines */
>  typedef struct DisasContext {
>      DisasContextBase base;
> +    ARMCPU *cpu;  /* for access to the id_* registers */

The translate code is not supposed to have access to either ARMCPU
or the ARMCPUState env pointer. Putting a pointer to cpu into the
DisasContext defeats this. This is why aarch64_tr_init_disas_context()
and the 32-bit equivalent extract all the info they need from
arm_cpu and env and put it into DisasContext fields.

thanks
-- PMM
