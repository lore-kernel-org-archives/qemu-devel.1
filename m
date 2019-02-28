Received: from eggs.gnu.org ([209.51.188.92]:46810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzFtX-0002SG-N8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzFtW-0006Kp-W8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:14:15 -0500
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
	<e1b83ea1-2ae3-e137-90d1-1d6adcc7a3f3@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <18326ade-4b6b-04f9-f34b-9bd7ff39bd2c@redhat.com>
Date: Thu, 28 Feb 2019 08:14:11 +0100
MIME-Version: 1.0
In-Reply-To: <e1b83ea1-2ae3-e137-90d1-1d6adcc7a3f3@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 28.02.19 01:17, Richard Henderson wrote:
> On 2/27/19 11:37 AM, David Hildenbrand wrote:
>> #define CHECK_SIGILL(STATEMENT)                  \
>> do {                                             \
>>     if (signal(SIGILL, sig_sigill) =3D=3D SIG_ERR) { \
>>         check("SIGILL not registered", false);   \
>>     }                                            \
>>     if (setjmp(jmp_env) =3D=3D 0) {                  \
>>         STATEMENT;                               \
>>         check("SIGILL not triggered", false);    \
>>     }                                            \
>>     if (signal(SIGILL, SIG_DFL) =3D=3D SIG_ERR) {    \
>>         check("SIGILL not registered", false);   \
>>     }                                            \
>> } while (0)
>>
>>
>> However it only works once. During the second signal, QEMU decides to
>> set the default handler.
>>
>> 1. In a signal handler that signal is blocked. We leave that handler v=
ia
>> a longjump. So after the first signal, the signal is blocked.
>=20
> And this is why we use sigaction not signal.
>=20
> You can set action.sa_flags |=3D SA_RESETHAND to avoid needing the expl=
icit reset
> (or leave it clear to avoid the reset action that you are seeing).
>=20
> You can set action.sa_flags |=3D SA_NODEFER to avoid having the signal =
added to
> the signal mask of the thread, to avoid neeing to use sigsetjmp/siglong=
jmp.  Or
> you can just use sigsetjmp/siglongjmp.  ;-)

You might tell at this point that it is my first time hacking on signals
and I already learned a lot, thanks ;)

I guess signal + sigsetjmp/siglongjmp is the one with the smalles LOC?
Will give it a try.

BTW: I got the idea of using setjml/longjmp from
tests/tcg/multiarch/linux-test.c - we're also not caring about blocked
signals there, but I guess it doesn't matter as we trigger SISEGV only on=
ce.

--=20

Thanks,

David / dhildenb
