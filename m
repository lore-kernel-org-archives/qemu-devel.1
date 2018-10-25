Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFgh9-0002hL-Hg
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFgh8-0008M1-MG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:33:07 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFgh8-0008LX-A3
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:33:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id w18so6384180otk.0
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 07:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022181035.20104-1-ppandit@redhat.com>
References: <20181022181035.20104-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Oct 2018 15:32:45 +0100
Message-ID: <CAFEAcA-6djmjK_x_n5z7cnicdgu+eeJF3QJw4iaCOMDLPkEJ7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 22 October 2018 at 19:10, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While performing gpio write via strongarm_gpio_handler_update
> routine, the 'bit' index could access beyond s->handler[28] array.
> Add check to avoid OOB access.
>
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/strongarm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Update v1: use ARRAY_SIZE macro
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04826.html
>

Hi; thanks for this patch. Looking at the SA1110 manual,
it says that writes to the reserved bits [31:28] are
ignored. So I think that rather than doing this check
here, we should do what the strongarm_ppc_* code in the
same file does -- mask off the high bits for writes to
the direction and state registers. Then it will not
be possible for high bits to be set here that cause an
out-of-range array access.

Side note: this device is used only in the "collie"
machine model, which only works via TCG, so this is
not a security issue, just a bug (which will only be
visible if the guest is buggy.)

thanks
-- PMM
