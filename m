Received: from eggs.gnu.org ([2001:4830:134:3::10]:54380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAGT-0002Vd-Kb
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAGS-00048R-US
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:29:57 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecAGS-00048J-OT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:29:56 -0500
Received: by mail-ot0-x234.google.com with SMTP id a24so20058692otd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:29:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180112125854.18261-11-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 13:29:35 +0000
Message-ID: <CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/14] ui: fix VNC client throttling when
 audio capture is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 January 2018 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> The VNC server must throttle data sent to the client to prevent the 'output'
> buffer size growing without bound, if the client stops reading data off the
> socket (either maliciously or due to stalled/slow network connection).

Hi. Coverity (CID 1385147) complains about a suspicious sign extension
in this patch:

> +/*
> + * Figure out how much pending data we should allow in the output
> + * buffer before we throttle incremental display updates, and/or
> + * drop audio samples.
> + *
> + * We allow for equiv of 1 full display's worth of FB updates,
> + * and 1 second of audio samples. If audio backlog was larger
> + * than that the client would already suffering awful audio
> + * glitches, so dropping samples is no worse really).
> + */
> +static void vnc_update_throttle_offset(VncState *vs)
> +{
> +    size_t offset =
> +        vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;

because the multiply is done with the "int" type, and then may
be sign-extended when converted to the probably-64-bit unsigned
size_t, resulting in the high bits all being set if the
multiply ended up with a 1 in bit 31.

thanks
-- PMM
