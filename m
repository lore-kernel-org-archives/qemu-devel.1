Received: from eggs.gnu.org ([2001:4830:134:3::10]:53483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebSCE-0002I6-Hr
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebSC8-0000cI-B0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebSC8-0000c0-2B
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:26:32 -0500
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
	<CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
	<5edb00c6-382e-5a36-a61b-47d3fc5b8408@redhat.com>
	<CAJ+F1CKKdHYBgWWf6zucKB25gD0zG9Lrvbh51FCir2MvTRkJbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0132595-a110-fa09-aa7c-378caf0f885c@redhat.com>
Date: Tue, 16 Jan 2018 15:26:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKKdHYBgWWf6zucKB25gD0zG9Lrvbh51FCir2MvTRkJbQ@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16/01/2018 15:22, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 16, 2018 at 2:54 PM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 16/01/2018 14:47, Peter Maydell wrote:
>>> On 16 January 2018 at 13:41, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>>>> On 16/01/2018 13:06, Peter Maydell wrote:
>>>>>> ASAN is enabled by default if available when --enable-debug. We co=
uld
>>>>>> add more flags if that helps.
>>>>> Configure switches should work like this:
>>>>>  * default: use feature if present, but don't complain if not prese=
nt
>>>>>    or not usable
>>>>>  * --enable-foo: use feature. if feature not present, complain and
>>>>>    fail configure
>>>>>  * --disable-foo: don't test for or use feature
>>>>>
>>>>
>>>> However, --enable-debug has never worked like this (the "default" pa=
rt)...
>>>
>>> True, but -g, no optimization isn't really something we want to
>>> default to :-)
>>
>> Same for ASAN. :-)
>>
>>> I think the general principle that unless the user
>>> specifically said they cared about the address sanitizer we shouldn't
>>> complain if it happens not to work on this host is still a good one.
>>
>> Yes, I agree.
>>
>> So we need two options:
>>
>> * --enable-asan defaults to not used, but also fails configure if ASAN
>> is not available/usable.
>=20
> and --enable-ubsan etc ...
>=20
> I wish we would avoid the multiplication of configure options, and use
> good default values instead for --enable-debug. But if it's not
> possible, let's add more options. However, it would be great if ASAN
> can be enabled by default, it seems too few developers care, even
> though it should be strongly recommended.

We can add --enable-sanitizer then instead of being specific to ASAN.
It could also support --enable-sanitizer=3Dasan,ubsan but that's for late=
r.

>>
>> * if we want to have --enable-debug enable ASAN, it should however _no=
t_
>> fail configure if ASAN is not available/usable.  (I am not sure anymor=
e
>> it's a good idea).
>>
>> The questions are:
>>
>> * should fiber support be required for --enable-asan?  What is the
>> difference in the quality of the reports?
>=20
> It's not required, but helps to detect more leaks. It also removes
> some warnings in some cases:

Ok, if it's not a flood of warnings it's okay.

>=20
>> * if not, and assuming --enable-debug tries to enable ASAN, should
>> --enable-debug complain if fiber support is not required?  Should
>> --enable-debug enable ASAN if fiber support is not available?
>=20
> I propose to simply print a warning during configure

Yes, it could do the same as --enable-asan.

>> * if --enable-debug does *not* try to enable ASAN, should test-debug a=
dd
>> --enable-asn?  (I think so).
>=20
> The other way around?

I mean - IMO, test-debug should enable sanitizers even if
--enable-sanitizer and --enable-debug are completely separate.

Paolo
