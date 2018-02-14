Received: from eggs.gnu.org ([2001:4830:134:3::10]:56114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1em3ER-0002aa-0h
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1em3EM-0008AC-8F
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:00:43 -0500
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-R0aq7Sp6P2TYrMDE0p0ewwpuXPp6=RzF1bU11FQwJxA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d49363d-7569-e95d-1d06-17a572c922db@redhat.com>
Date: Wed, 14 Feb 2018 21:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R0aq7Sp6P2TYrMDE0p0ewwpuXPp6=RzF1bU11FQwJxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14.02.2018 19:33, Peter Maydell wrote:
> On 14 February 2018 at 17:31, Thomas Huth <thuth@redhat.com> wrote:
>> When running configure with --with-pkgversion=3Dfoo there is no
>> space anymore between the version number and the parentheses:
>>
>> $ m68k-softmmu/qemu-system-m68k -version
>> QEMU emulator version 2.11.50(foo)
>>
>> Fix it by moving the space from the configure script to the Makefile.
>>
>> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> I see that in the bug report I wrote
> "Also it looks like we return QEMU_PKGVERSION as part of the
> QMP qmp_query_version() code, so we should check to see what
> the expected behaviour there is regarding having the space
> or not."
>=20
> -- does this patch change the QMP reported string
> unexpectedly?

Without my patch and with --with-pkgversion=3Dfoo :

{ "execute": "query-version" }
{"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": "(=
foo)"}}

With my patch and with --with-pkgversion=3Dfoo :

{ "execute": "query-version" }
{"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": " =
(foo)"}}

Without my patch and without --with-pkgversion :

{ "execute": "query-version" }
{"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": " =
(v2.11.0-1512-g02f4fbe)"}}

Using the old QEMU version 67a1de0d19~1 with  --with-pkgversion=3Dfoo :

{ "execute": "query-version" }
{"return": {"qemu": {"micro": 50, "minor": 6, "major": 2}, "package": " (=
foo)"}}

So yes, this patch changes the behavior of query-version, but the new
behavior is now the same behavior that you get without --with-pkgversion
(i.e. a space is included) and it is the same as the behavior that we had
in the past, before commit 67a1de0d19 has been merged. So I think this
is the right way to go.
Alternatively, we could maybe change query-version to always skip the
initial space?

 Thomas
