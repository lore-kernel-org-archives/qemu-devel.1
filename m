Received: from eggs.gnu.org ([209.51.188.92]:42082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4Aw-0004oD-Qx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4Aw-0000gt-1L
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:29:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4Av-0000fT-Qa
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:29:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id d15so9357050wmb.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:29:17 -0800 (PST)
References: <87lg3rui28.fsf@linaro.org> <20190114150206.GA11818@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190114150206.GA11818@flamenco>
Date: Mon, 14 Jan 2019 15:29:14 +0000
Message-ID: <875zurp8ad.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Remaining CI failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Da?= =?utf-8?Q?niel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> On Fri, Jan 11, 2019 at 19:10:07 +0000, Alex Benn=C3=A9e wrote:
>> So trying to narrow down the remaining failures in the CI system. There
>> is one with a patch in flight (use g_usleep instead of sleep) but there
>> remains two failure modes, both erratic.
>>
>> tests/qht-par:
>>
>> I can trigger this on my dev machine with a gprof enabled build:
>>
>>   # QEMU configure log Fri Jan 11 14:10:45 GMT 2019
>>   # Configured with: './configure' '--disable-tools' '--disable-docs' '-=
-enable-gprof' '--enable-gcov'
>>
>> I only seem to be able to trigger it when running via the wrapper in the
>> make system:
>>
>>   retry.py -n 30 --invert make check-tests/test-qht-par
>>
>> Eventually this crashes with:
>>
>>   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D 0)=
: (35584 =3D=3D 0)
>>
>> Leaving a core dump for the child:
>
> I can't replicate this on my machine :-(
>
> I suspect this is probably related to the fact that gprof
> is not even meant to support multi-threaded programs (like qht-bench).
>
> Given that we've fixed the sleep issue (thanks!) and that there is no use
> in running test-qht-par under gprof, I propose to permanently skip
> it under gprof, e.g.:
>
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
>  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
>  check-unit-y +=3D tests/test-qdist$(EXESUF)
>  check-unit-y +=3D tests/test-qht$(EXESUF)
> -# FIXME: {test-qht-par + gprof} often break on Travis CI
> +# test-qht-par invokes qht-bench, which is multi-threaded.
> +# gprof doesn't support multi-threaded programs, so skip this test under=
 gprof.
>  check-unit-$(call lnot,$(CONFIG_GPROF)) +=3D tests/test-qht-par$(EXESUF)
>  check-unit-y +=3D tests/test-bitops$(EXESUF)
>  check-unit-y +=3D tests/test-bitcnt$(EXESUF)
>
> If you agree, I can submit a proper patch with the above.

Heh, that fix is already in although I reverted the work-around in my PR
as it seemed a little too hacky given it seems to be fixed now.

--
Alex Benn=C3=A9e
