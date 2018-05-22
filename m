Received: from eggs.gnu.org ([2001:4830:134:3::10]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL0MH-0004uu-JL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL0MB-00028t-I9
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:01:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fL0MB-00028M-DE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:01:11 -0400
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
	<CAFEAcA968HDBJiBRCBEu+hV=fUx5HzHbnn6GDGKYzusEtjHGUQ@mail.gmail.com>
	<dd2d19de-eba5-90be-5f01-ff9fd268685f@redhat.com>
	<CAFEAcA-9miwQ_JK4VFcFMgWc=XCb_Qf3W4ZFk59csXUGdnAMDA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd1a9321-e727-b7a3-b11c-b7eaed863792@redhat.com>
Date: Tue, 22 May 2018 08:01:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9miwQ_JK4VFcFMgWc=XCb_Qf3W4ZFk59csXUGdnAMDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 19.05.2018 13:36, Peter Maydell wrote:
> On 19 May 2018 at 07:10, Thomas Huth <thuth@redhat.com> wrote:
>> On 18.05.2018 20:31, Peter Maydell wrote:
>>> Another flaky test for the collection:
>>>
>>> TEST: tests/boot-serial-test... (pid=3D25144)
>>>   /sparc64/boot-serial/sun4u:                                        =
  **
>>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:=
140:check_guest_output:
>>> assertion failed: (output_ok)
>>> FAIL
>>>
>>> Probably another "overly optimistic timeout" setting. (Failed
>>> for me on x86-64 host just now.)
>>
>> That test normally finishes within 3 seconds on my machine. The test
>> timeout is 60 seconds. How much load did you have on that machine to g=
o
>> from 3s to 60s ?
>=20
> The machine is my desktop box; I didn't notice anything too
> terrible while I was using it interactively at the same time
> the test build was running. The test build will run at -j8;
> it might also have been during a different -j8 build/test
> on the same machine for a different source tree.

That does not sound like it could cause a test time increase from 3s
to more than 60s. Maybe from 3s to 10s or 20s, but to more than 60s?

> 60s is quite a long time, so maybe there's an intermittent
> deadlock in there instead...

I just had a look through my mails, and the last (and as far as I
remember only) time we've seen an unexplainable error with the boot
serial tester was here:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01057.html

That was also related to sparc, though it was 32-bit sparc, not 64-bit
sparc. Could it still be related?

Anyway, no clue how to properly debug this ... so far I was not able to
reproduce this on my laptop here. I could think of the following options:

1) Increase the test timeout from 60s to maybe 90s or 120s.

2) Add an option to run tests without timeout (i.e. infinite timeout)

3) What could really be helpful for debugging: Move the
"unlink(serialtmp);" in the test to the end of the function, so that the
output file should not be get deleted when the test aborts unexpectedly.

4) If it's really just the sparc tests that are failing, we could run
them in the SPEED=3Dslow mode only, so that they do not break the normal
integration tests. Not sure whether we are confident enough for that
yet, though.

What do you think?

 Thomas
