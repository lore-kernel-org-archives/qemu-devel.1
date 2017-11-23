Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHpeG-0004ON-Bi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHpeF-0002k2-2Q
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:28 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHpeE-0002jL-Rp
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:26:26 -0500
Received: by mail-oi0-x243.google.com with SMTP id n16so12972453oig.3
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 03:26:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 11:26:05 +0000
Message-ID: <CAFEAcA8FDoLRx+OCMwjUzYd-X3HX7Z77SUTmNbSB9YWYT77AcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Switch AMD CFI flash to use new
 MMIO API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13 November 2017 at 16:14, Mike Nawrocki
<michael.nawrocki@gtri.gatech.edu> wrote:
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/block/pflash_cfi02.c | 97 +++++++++----------------------------------------
>  1 file changed, 18 insertions(+), 79 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index c81ddd3a99..a81df913f6 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -138,12 +138,12 @@ static void pflash_timer (void *opaque)
>      pfl->cmd = 0;
>  }
>
> -static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
> -                             int width, int be)
> +static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
> +                            int width, int be)
>  {
>      hwaddr boff;
> -    uint32_t ret;
>      uint8_t *p;
> +    uint64_t ret;

I suspect you'll find that the change of type for 'ret' here
and the 'value' argument to pflash_write() will break compilation
with PFLASH_DEBUG defined, because the type won't match the DPRINTF
format strings any more.

You could either fix up the format strings, or (since there's a
wrapper function here anyway) leave the types of pflash_read()
and pflash_write() alone and let the wrappers implicitly do
the conversion between uint64_t and uint32_t.

thanks
-- PMM
