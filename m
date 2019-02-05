Received: from eggs.gnu.org ([209.51.188.92]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr2LS-0008E0-A7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr2LR-0001Gi-1y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:09:06 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:36263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr2LQ-0000w1-6D
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:09:04 -0500
Received: by mail-ot1-x333.google.com with SMTP id k98so6206518otk.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:08:20 -0800 (PST)
MIME-Version: 1.0
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
	<CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
	<CAFEAcA9sLhi__xgQz9xXyyjxyuRN1ayAUykFgTb_rHCfEtVipg@mail.gmail.com>
	<221f03c2-10ca-dc90-83f6-3781c356c8e0@redhat.com>
In-Reply-To: <221f03c2-10ca-dc90-83f6-3781c356c8e0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 15:08:08 +0000
Message-ID: <CAFEAcA8udaag9C6-_E0FN5skVjps1fTUGfa0w+j0yauvg3wUXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] 2x-3x tcg performance regression on
 ppc64 (maybe others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, qemu-ppc <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On Tue, 5 Feb 2019 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> I was going to send this patch and was looking for to fill the
> "Reported-by" tag to finalize the commit description before sending:
>
> -- >8 --
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index aa7b81aaf0..8dc2aab60e 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -418,7 +418,8 @@ static inline uint32_t tb_cflags(const
> TranslationBlock *tb)
>  static inline uint32_t curr_cflags(void)
>  {
>      return (parallel_cpus ? CF_PARALLEL : 0)
> -         | (use_icount ? CF_USE_ICOUNT : 0);
> +         | (use_icount ? CF_USE_ICOUNT : 0)
> +         | CF_CLUSTER_MASK;
>  }

That's not right, because it puts all-1s in the cluster field.
That will happen to hit for TBs generated for CPUs in the
"not in a cluster" default UNASSIGNED_CLUSTER_INDEX, but it's
wrong for CPUs that are in a specifically assigned cluster
and will result in those failing to hit cached TBs when they should.

thanks
-- PMM
