Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSlVw-000792-G4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSlVt-0002qI-Pf
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:19:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSlVt-0002or-FH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:19:33 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1543513531-1151-3-git-send-email-pbonzini@redhat.com>
	<20181130155003.GG9162@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <100f07e5-8067-3d68-afab-9896032927c9@redhat.com>
Date: Fri, 30 Nov 2018 17:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181130155003.GG9162@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eblake@redhat.com

On 30/11/18 16:50, Daniel P. Berrang=C3=A9 wrote:
> IIUC, this output is only seen when you with 'make check' passing V=3D1=
,
> so most people won't see it.

V=3D1 should be enabled by default on Patchew, so it will be visible in
the CI logs.  But anyway that's minor, there are more reasons why a
custom beautifier is better than prove.

First, at the very least, failures should be included in the output even
if V=3D1 is not provided.  Therefore, for failing tests we'd have:

  $ scripts/tap-driver.pl < f.tap
  FAIL 2 bbb
  XPASS 3 ccc # TODO
  FAIL 6 fff # SKIP cannot find frobnicator

And the output of prove in that case would be inferior for developers,
unless you use "V=3D1":

  $ prove -e cat f.tap
  f.tap .. Failed 2/6 subtests
	(less 2 skipped subtests: 2 okay)
	(1 TODO test unexpectedly succeeded)

  Test Summary Report
  -------------------
  f.tap (Wstat: 0 Tests: 6 Failed: 2)
    Failed tests:  2, 6
    TODO passed:   3
  Files=3D1, Tests=3D6,  0 wallclock secs ( 0.02 usr +  0.00 sys =3D  0.0=
2 CPU)
  Result: FAIL

where you don't really know what tests 2 and 6 are without looking at
the TAP output.  The part before the summary provides a nice progress
report, as you point out, but it adds a bunch of noise with respect to
skipped subtests (skipped tests will be more common once patch 1 is
merged; qgraph also adds some) that I personally dislike.

You can hide it with -Q, but then you cannot invoke anymore more than
one test with a single invocation of prove, and the Makefile output
becomes much bigger:

   TEST    check-foo

vs.

   TEST    check-foo
  All tests successful.
  Files=3D1, Tests=3D3,  0 wallclock secs ( 0.01 usr +  0.00 sys =3D  0.0=
1 CPU)
  Result: PASS

There are two other smaller "philosophical" differences.  First, prove
treats XPASS as passes, while tap-driver.pl treats them as failures.
Second, skipped tests really stand out in the "prove -v" output, with
white-on-blue text.

I'd rather avoid getting into the business of beautifying the output of
prove.

Paolo
