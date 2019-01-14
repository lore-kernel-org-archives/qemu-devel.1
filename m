Received: from eggs.gnu.org ([209.51.188.92]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizMh-0004Ap-5J
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizMf-0001uo-BA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:21:07 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gizMd-0001ri-G6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:21:05 -0500
Received: by mail-oi1-x22d.google.com with SMTP id x23so17423296oix.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:21:02 -0800 (PST)
MIME-Version: 1.0
References: <87lg3rui28.fsf@linaro.org>
In-Reply-To: <87lg3rui28.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 10:20:50 +0000
Message-ID: <CAFEAcA9gMVuwU0yEvbuWcj3Pik+Nd37YPEKn+e0s1=24p=py2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "cota@braap.org" <cota@braap.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Fri, 11 Jan 2019 at 19:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I did run the make under strace to see who is using O_NONBLOCK but even
> after filtering out a bunch of stuff it seems to be quite embedded:
>
>  ag "O_NONBLOCK" check.strace  | ag -v "/sys" | ag -v "/dev" | grep -v ".=
git" | wc -l
>  2449

The strace rune I used to track down the other O_NONBLOCK issue was
strace -o /tmp/strace.log -e fcntl,execve,clone -e signal=3Dnone -f make ..=
.

and then looking through the strace.log for uses of O_NONBLOCK
on fds 0, 1 or 2, and backtracking those to which binary had been
exec'd to give that PID. Then I did a full strace of just
that test, and looked to check whether the 0/1/2 was really
the top-level make's stdin/stdout/stderr or whether something else
had dup'd or opened an fd there.

thanks
-- PMM
