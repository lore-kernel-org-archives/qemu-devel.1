Received: from eggs.gnu.org ([209.51.188.92]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghyjo-0003va-BY
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghyjn-0006kT-AH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:48 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghyjm-0006jR-RJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:47 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so15678567wrw.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:28:46 -0800 (PST)
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
Date: Fri, 11 Jan 2019 15:28:44 +0000
Message-ID: <87sgxzusb7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, cota@braap.org, ehabkost@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/01/19 15:38, Alex Benn=C3=A9e wrote:
>> Relying on sleep to always return having slept isn't safe as a signal
>> may have occurred. If signals are constantly incoming the program will
>> never reach it's termination condition. This is believed to be the
>> mechanism causing time outs for qht-test in Travis.
>>
>> Instead we use a g_timer to determine if the duration of the test has
>> passed and sleep for a second at a time. This may bias benchmark
>> results for short runs.
>
> Why not g_usleep?  It already does a while loop around nanosleep (which
> returns the remaining time in the wait, like select but unlike sleep and
> poll).

Yeah I'm testing that now. However I have managed to trigger:

  ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D 0): (=
35584 =3D=3D 0)

but I'm not sure if this is some other side-effect of the
test-qht-par/qht-bench invocation dance.

--
Alex Benn=C3=A9e
