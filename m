Received: from eggs.gnu.org ([2001:4830:134:3::10]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCBd-0002vd-Ex
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCBc-0008G4-Oo
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:39:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQCBc-0008FG-Ji
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:39:44 -0400
Received: by mail-ot0-x241.google.com with SMTP id q17-v6so2834807otg.2
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:39:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605131944.14649-3-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-3-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 14:39:23 +0100
Message-ID: <CAFEAcA8sO93Vk43PNHJhsg7Jvaya498y7Q89dm=Xi=-WKXMRQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/3] memory: add MemTxAttrs to IOMMUTLBEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On 5 June 2018 at 14:19, Peter Xu <peterx@redhat.com> wrote:
> It should never be used for translate() calls since the caller should be
> the one who passes in the MemTxAttrs.  However it could be used when we
> want to generate an IOMMU translation notification with specific
> translation attributes.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/memory.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6b0ced554d..12865a4890 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -72,6 +72,13 @@ struct IOMMUTLBEntry {
>      hwaddr           translated_addr;
>      hwaddr           addr_mask;  /* 0xfff = 4k translation */
>      IOMMUAccessFlags perm;
> +    /*
> +     * Attributes that were bound to the DMA translation.  Note that
> +     * this field is meaningless when the IOMMUTLBENtry is generated
> +     * by a translate() call.  It can be used as a hint when we want
> +     * to send IOMMU notifications with specific permission flags.
> +     */
> +    MemTxAttrs       attrs;
>  };

How do we say "this applies for more than just this set of
tx attrs" ? eg, if my IOMMU cares only about the secure/nonsecure
attribute, how do I express "this IOMMU TLB entry is valid for
both attrs.user = 1 and attrs.user = 0" ?

thanks
-- PMM
