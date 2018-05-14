Received: from eggs.gnu.org ([2001:4830:134:3::10]:54312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGGP-0001AW-DX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGGO-0003hL-Hk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:53 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIGGO-0003h1-CF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:52 -0400
Received: by mail-ot0-x22a.google.com with SMTP id g7-v6so14966886otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504171540.25813-19-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
	<20180504171540.25813-19-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 17:23:31 +0100
Message-ID: <CAFEAcA_USWqJ2ODDYKw0NbLTcwBqUdi-OiBBVuNC3yxp0manoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 18/24] hw/arm/smmuv3: Event queue recording
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 4 May 2018 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> Let's introduce a helper function aiming at recording an
> event in the event queue.

> +void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
> +{
> +    Evt evt;
> +    MemTxResult r;
>
>      if (!smmuv3_eventq_enabled(s)) {
>          return;
>      }
>
> -    if (smmuv3_q_full(q)) {
> +    EVT_SET_TYPE(&evt, info->type);
> +    EVT_SET_SID(&evt, info->sid);

Hi Eric -- Coverity complains about use of uninitialized data
here (CID 1391004). Evt is a struct, and there's no initializer
where we declare it, so its fields are uninitialized. The
The EVT_SET_TYPE and similar setters use deposit32() on fields
in the struct, so they read the uninitialized existing values.
In cases where we don't set all the fields in the event struct
we'll end up leaking random uninitialized data from QEMU's
stack into the guest.

Initializing the struct with "Evt evt = {};" ought to satisfy
Coverity and fix the data leak.

thanks
-- PMM
