Received: from eggs.gnu.org ([2001:4830:134:3::10]:41059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fICRq-0008Az-1M
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fICRp-0002eX-4x
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:19:26 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fICRp-0002eL-0X
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:19:25 -0400
Received: by mail-ot0-x243.google.com with SMTP id g7-v6so13979580otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 05:19:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514115557.13524-1-linzhecheng@huawei.com>
References: <20180514115557.13524-1-linzhecheng@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 13:19:04 +0100
Message-ID: <CAFEAcA8X_TG0EGLWzr=SuBqWizcRWw6ed-eqTgM9XihaTa8PPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpus: remove useless cond signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, wangxinxin.wang@huawei.com, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 14 May 2018 at 12:55, linzhecheng <linzhecheng@huawei.com> wrote:
> commit dbadee4 removed qemu_cond_wait in cpu_remove_sync, so it is
> useless to keep qemu_cond_signal here.
>
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
>
> diff --git a/cpus.c b/cpus.c
> index 5bcd3ecf38..c7262484f3 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1222,7 +1222,6 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>
>      qemu_kvm_destroy_vcpu(cpu);
>      cpu->created = false;
> -    qemu_cond_signal(&qemu_cpu_cond);
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
> --
> 2.12.2.windows.2

At the moment we seem to have an invariant "everywhere we
set cpu->created = false we also signal the qemu_cpu_cond".
If signalling the condition is no longer necessary in this
function, is it also no longer necessary in all the other
places where we do it after setting created = false ?

thanks
-- PMM
