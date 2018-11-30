Received: from eggs.gnu.org ([2001:4830:134:3::10]:44890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfZl-0000Zo-Td
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfZj-0000v9-5j
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSfZi-0000uN-Ny
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:59:07 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
	<69af56c7-413d-857f-829b-37d4747d0d96@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <852011bf-424c-4215-2cef-f7456e8ab9aa@redhat.com>
Date: Fri, 30 Nov 2018 10:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <69af56c7-413d-857f-829b-37d4747d0d96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 30/11/18 08:21, Thomas Huth wrote:
> On 2018-11-29 21:43, Eric Blake wrote:
>> On 11/29/18 11:45 AM, Paolo Bonzini wrote:
>>> gtester is deprecated by upstream glib and it does not support tests
>>> that call g_test_skip in some glib stable releases.
>>>
>>> glib suggests instead using Automake's TAP support.=C2=A0 We do not s=
upport
>>> Automake, but we can copy the code that beautifies the TAP output and
>>> use it.=C2=A0 I chose to use the Perl copy rather than the shell/awk =
one,
>>> in order to reuse Perl's TAP parsing package, but I'm open to suggest=
ions
>>> about which language to use.
>>
>> I'm less familiar with the TAP protocol than I'd like to admit, but I
>> did find:
>>
>> https://blog.gtk.org/2018/07/11/news-from-glib-2-58/
>>
>> which corroborates your claim that switching to Automake's TAP parser =
is
>> indeed a recommended approach to avoid the now-deprecated gtester.
>=20
> Hmm, do we really have to maintain our own version of a test runner now=
?

Well, that's what you get for using a custom build system but it's
"just" an output beautifier really.  I could just "grep -ve ^# -e ^ok"
but it wouldn't look very nice (plus things that start as 1-line shell
scripts end up being the same as the thing you're trying to replace).

I don't think it will be a big maintenance headache---just like most
other files in scripts/, some of which have had exactly zero commits
since they were added.  In fact, Automake has hardly changed its driver
since the first commit.

> There's already some effort going on to use avocado in "make
> check-acceptance" ... maybe we could use avocado as replacement for
> gtester, too?

Avocado does not have the required functionality, unfortunately.  It can
produce TAP, but not consume it.  Also, Python libraries for TAP do not
abound and are generally not shipped with the OS (apart from Perl, which
basically invented TAP, the language with the most TAP libraries seem to
be JavaScript!).

Paolo
