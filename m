Received: from eggs.gnu.org ([2001:4830:134:3::10]:52143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebS8O-00078j-Ip
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebS8N-0007Jv-7d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:22:40 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:41354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ebS8N-0007Jg-1a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:22:39 -0500
Received: by mail-wm0-x230.google.com with SMTP id f71so8733348wmf.0
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:22:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5edb00c6-382e-5a36-a61b-47d3fc5b8408@redhat.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
	<CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
	<5edb00c6-382e-5a36-a61b-47d3fc5b8408@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Jan 2018 15:22:36 +0100
Message-ID: <CAJ+F1CKKdHYBgWWf6zucKB25gD0zG9Lrvbh51FCir2MvTRkJbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Jan 16, 2018 at 2:54 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/01/2018 14:47, Peter Maydell wrote:
>> On 16 January 2018 at 13:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 16/01/2018 13:06, Peter Maydell wrote:
>>>>> ASAN is enabled by default if available when --enable-debug. We could
>>>>> add more flags if that helps.
>>>> Configure switches should work like this:
>>>>  * default: use feature if present, but don't complain if not present
>>>>    or not usable
>>>>  * --enable-foo: use feature. if feature not present, complain and
>>>>    fail configure
>>>>  * --disable-foo: don't test for or use feature
>>>>
>>>
>>> However, --enable-debug has never worked like this (the "default" part)=
...
>>
>> True, but -g, no optimization isn't really something we want to
>> default to :-)
>
> Same for ASAN. :-)
>
>> I think the general principle that unless the user
>> specifically said they cared about the address sanitizer we shouldn't
>> complain if it happens not to work on this host is still a good one.
>
> Yes, I agree.
>
> So we need two options:
>
> * --enable-asan defaults to not used, but also fails configure if ASAN
> is not available/usable.

and --enable-ubsan etc ...

I wish we would avoid the multiplication of configure options, and use
good default values instead for --enable-debug. But if it's not
possible, let's add more options. However, it would be great if ASAN
can be enabled by default, it seems too few developers care, even
though it should be strongly recommended.

>
> * if we want to have --enable-debug enable ASAN, it should however _not_
> fail configure if ASAN is not available/usable.  (I am not sure anymore
> it's a good idea).
>
> The questions are:
>
> * should fiber support be required for --enable-asan?  What is the
> difference in the quality of the reports?

It's not required, but helps to detect more leaks. It also removes
some warnings in some cases:

Before:

elmarco@boraha:~/src/qemu/build (asan *%)$ tests/test-coroutine -p
/basic/lifecycle
/basic/lifecycle: =3D=3D20781=3D=3DWARNING: ASan doesn't fully support
makecontext/swapcontext functions and may produce false positives in
some cases!
=3D=3D20781=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retur=
n:
stack top: 0x7ffcb184d000; bottom 0x7ff6c4cfd000; size: 0x0005ecb50000
(25446121472)
False positive error reports may follow
For details see https://github.com/google/sanitizers/issues/189
OK

After:

 tests/test-coroutine -p /basic/lifecycle
/basic/lifecycle: =3D=3D21110=3D=3DWARNING: ASan doesn't fully support
makecontext/swapcontext functions and may produce false positives in
some cases!
OK


> * if not, and assuming --enable-debug tries to enable ASAN, should
> --enable-debug complain if fiber support is not required?  Should
> --enable-debug enable ASAN if fiber support is not available?

I propose to simply print a warning during configure

>
> * if --enable-debug does *not* try to enable ASAN, should test-debug add
> --enable-asn?  (I think so).

The other way around?

(tbh, I am not fond of all the configure options - if you need
fine-grained configuration, you can overwrite the various *FLAGS..)

--=20
Marc-Andr=C3=A9 Lureau
