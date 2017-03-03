Received: from eggs.gnu.org ([2001:4830:134:3::10]:35529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjk8q-0003yx-TA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjk8p-0006Ox-T7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:08:52 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjk8p-0006Or-MT
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:08:51 -0500
Received: by mail-wm0-x229.google.com with SMTP id n11so11403695wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 02:08:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-5-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 10:08:29 +0000
Message-ID: <CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL
 asserts to tcg_debug_assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 2 March 2017 at 19:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> While on MTTCG hosts it is very important that updates to
> cpu->interrupt_request are protected by the BQL not all guests have
> been converted to the correct locking yet. As a result we are seeing
> breaking on non-MTTCG enabled guests in production builds.
>
> The locking in the guests needs to be fixed but while running single
> threaded they will continue to work. By moving the asserts to
> tcg_debug_asserts() they will still be useful during conversion
> work (much like the existing assert_memory_lock/assert_tb_lock
> asserts).
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  translate-all.c    | 2 +-
>  translate-common.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/translate-all.c b/translate-all.c
> index 9bac061c9b..7ee273410d 100644
> --- a/translate-all.c
> +++ b/translate-all.c
> @@ -1928,7 +1928,7 @@ void dump_opcount_info(FILE *f, fprintf_function cp=
u_fprintf)
>
>  void cpu_interrupt(CPUState *cpu, int mask)
>  {
> -    g_assert(qemu_mutex_iothread_locked());
> +    tcg_debug_assert(qemu_mutex_iothread_locked());

If CONFIG_DEBUG_TCG isn't enabled then tcg_debug_assert()
turns into "if (!(X)) { __builtin_unreachable(); }", which
means that instead of asserting we now run straight
into compiler undefined behaviour, don't we?
If what we want is "don't actually check this condition in
the non-tcg-debug config" then we should do something
that means we don't actually check the condition...

thanks
-- PMM
