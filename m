Received: from eggs.gnu.org ([2001:4830:134:3::10]:34236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecAee-000411-Vp
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecAec-0004aZ-EU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:54:57 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecAec-0004Zu-7O
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:54:54 -0500
Received: by mail-wm0-f48.google.com with SMTP id t74so22266067wme.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:54:54 -0800 (PST)
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
	<20180118133643.GP19695@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
Date: Thu, 18 Jan 2018 14:54:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180118133643.GP19695@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18/01/2018 14:36, Daniel P. Berrange wrote:
>>> +/*
>>> + * Figure out how much pending data we should allow in the output
>>> + * buffer before we throttle incremental display updates, and/or
>>> + * drop audio samples.
>>> + *
>>> + * We allow for equiv of 1 full display's worth of FB updates,
>>> + * and 1 second of audio samples. If audio backlog was larger
>>> + * than that the client would already suffering awful audio
>>> + * glitches, so dropping samples is no worse really).
>>> + */
>>> +static void vnc_update_throttle_offset(VncState *vs)
>>> +{
>>> +    size_t offset =
>>> +        vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;
>> because the multiply is done with the "int" type, and then may
>> be sign-extended when converted to the probably-64-bit unsigned
>> size_t, resulting in the high bits all being set if the
>> multiply ended up with a 1 in bit 31.
> I guess we can usefully change client_width/client_height to be an unsigned
> int, since there's no valid scenario for them to be negative.

In addition to that, do we support a >= 2 GiB framebuffer at all? (Even
with unsigned ints, Coverity would rightly complain about a truncated
32-bit multiplication being assigned to a 64-bit value).

Paolo
