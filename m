Received: from eggs.gnu.org ([2001:4830:134:3::10]:36093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8PQm-0001yZ-U2
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8PQm-0004tO-2Y
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:42:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8PQl-0004sm-KF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:42:07 -0400
Received: by mail-oi1-x242.google.com with SMTP id a203-v6so10289341oib.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 05:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a90da631-1b38-7cc3-8200-521128199264@redhat.com>
References: <1538734535-7483-1-git-send-email-thuth@redhat.com>
	<7381a5a1-07f5-f79a-177d-cd39bce5a52e@redhat.com>
	<a90da631-1b38-7cc3-8200-521128199264@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 13:41:45 +0100
Message-ID: <CAFEAcA_7usyn6Ysox4as_f=sxeh53XUCkYfXVd0kb7N4FCsf_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 5 October 2018 at 13:17, Laszlo Ersek <lersek@redhat.com> wrote:
> On 10/05/18 12:49, Philippe Mathieu-Daud=C3=A9 wrote:
>> Is the comment added in 8e4a424b305 still valid?
>>
>> /*
>>  * A helper function for the _utterly broken_ virtio device model to
>> find out if
>>  * it's running on a big endian machine. Don't do this at home kids!
>>  */
>> bool target_words_bigendian(void);
>
> Yeah, that comment irks me too.
>
> Not that it isn't valid, necessarily. "hw/virtio/virtio.c" still
> features an embedded declaration of this function. Just above
> virtio_default_endian(), which calls it. And the latter function is
> called in several places (mostly from commit 616a655219a92).
>
> So I can't really tell what's "utterly broken" here -- the device model
> (i.e., the virtio implementation in QEMU), or the legacy *spec* that
> required QEMU to jump through such hoops?

AIUI, the brokenness here is that the virtio specification
requires that a device knows the endianness of the CPU,
which is an awkward layering violation [*]. The point of the
comment is really to say "virtio needs this, but that is
a special weird case, think twice or three times before
using this function anywhere else" (which I suspect is also
why the declaration is not in a header file, to make it less
easily accessible).

[*] Actually it's not even the endianness of the CPU, because
bi-endian CPUs like Arm can be in big-endian mode even though
TARGET_WORDS_BIGENDIAN is false...

I entirely agree that we should clean up the comment to be
clearer about what it's trying to say.

> BTW, I don't think angry comments are useful in *code*. They look & feel
> great for about a week. In a year, they just look unprofessional. (NB,
> this is not about "political correctness"; it's just that, when someone
> reads such a comment, they receive the anger *before* they understand,
> or recall, the underlying problem.

Agreed 100%.

thanks
-- PMM
