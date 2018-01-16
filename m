Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebRgo-0007vf-E4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebRgj-0007Rh-9G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebRgj-0007RG-3Q
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:54:05 -0500
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
	<CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5edb00c6-382e-5a36-a61b-47d3fc5b8408@redhat.com>
Date: Tue, 16 Jan 2018 14:54:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16/01/2018 14:47, Peter Maydell wrote:
> On 16 January 2018 at 13:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 16/01/2018 13:06, Peter Maydell wrote:
>>>> ASAN is enabled by default if available when --enable-debug. We coul=
d
>>>> add more flags if that helps.
>>> Configure switches should work like this:
>>>  * default: use feature if present, but don't complain if not present
>>>    or not usable
>>>  * --enable-foo: use feature. if feature not present, complain and
>>>    fail configure
>>>  * --disable-foo: don't test for or use feature
>>>
>>
>> However, --enable-debug has never worked like this (the "default" part=
)...
>=20
> True, but -g, no optimization isn't really something we want to
> default to :-)

Same for ASAN. :-)

> I think the general principle that unless the user
> specifically said they cared about the address sanitizer we shouldn't
> complain if it happens not to work on this host is still a good one.

Yes, I agree.

So we need two options:

* --enable-asan defaults to not used, but also fails configure if ASAN
is not available/usable.

* if we want to have --enable-debug enable ASAN, it should however _not_
fail configure if ASAN is not available/usable.  (I am not sure anymore
it's a good idea).

The questions are:

* should fiber support be required for --enable-asan?  What is the
difference in the quality of the reports?

* if not, and assuming --enable-debug tries to enable ASAN, should
--enable-debug complain if fiber support is not required?  Should
--enable-debug enable ASAN if fiber support is not available?

* if --enable-debug does *not* try to enable ASAN, should test-debug add
--enable-asn?  (I think so).

Paolo
