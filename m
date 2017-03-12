Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cn9Hi-0005dw-M4
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cn9Hh-00085l-NB
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:36:06 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cn9Hh-00084R-8v
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:36:05 -0400
Received: by mail-wm0-x235.google.com with SMTP id v186so27096207wmd.0
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 12:36:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489345956-29167-1-git-send-email-mst@redhat.com>
References: <1489345956-29167-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Mar 2017 20:35:42 +0100
Message-ID: <CAFEAcA-FFPK_hFEydB7JWj=Zmgp3hs2e=n0vzuun97xnzc9JRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 12 March 2017 at 20:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> info mtree is doing 64 bit math to figure out
> addresses from offsets, this does not work ncorrectly
> incase of overflow.
>
> Overflow usually indicates a guest bug, so this is unusual
> but reporting correct addresses makes it easier to discover
> what is going on.
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/int128.h | 15 +++++++++++++++
>  memory.c              | 28 +++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
> index 5c9890d..8be5328 100644
> --- a/include/qemu/int128.h
> +++ b/include/qemu/int128.h
> @@ -302,4 +302,19 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
>  }
>
>  #endif /* CONFIG_INT128 */
> +
> +#define INT128_FMT1_plx "0x%" PRIx64
> +#define INT128_FMT2_plx "%015" PRIx64
> +
> +static inline uint64_t int128_printf1(Int128 a)
> +{
> +    /* We assume 4 highest bits are clear and safe to ignore */
> +    return (int128_gethi(a) << 4) | (int128_getlo(a) >> 60);
> +}
> +
> +static inline uint64_t int128_printf2(Int128 a)
> +{
> +    return (int128_getlo(a) << 4) >> 4;
> +}

I'm confused -- I was expecting these to just
be the two halves of the 128 bit integer to be
printed, but they seem to be doing something
more complicated...

thanks
-- PMM
