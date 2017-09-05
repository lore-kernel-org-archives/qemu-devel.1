Received: from eggs.gnu.org ([2001:4830:134:3::10]:55042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8Wb-00035Y-L4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8WW-0001vg-V3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp8WW-0001uZ-OS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 714C067745
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 07:43:51 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-4-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d820097-32bd-6f74-8f19-c13c2a1ec083@redhat.com>
Date: Tue, 5 Sep 2017 09:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/29] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> Back when the test was introduced, in commit 62c39b307, the
> test was set up to run qemu-ga directly on the host performing
> the test, and defaults to limiting itself to safe commands.  At
> the time, it was envisioned that setting QGA_TEST_SIDE_EFFECTING
> in the environment could cover a few more commands, while noting
> the potential danger of those side effects running in the host.
>=20
> But this has NEVER been tested: if you enable the environment
> variable, the test WILL fail.  One obvious reason: if you are not
> running as root, you'll probably get a permission failure when
> trying to freeze the file systems, or when changing system time.
> Less obvious: if you run the test as root (wow, you're brave), you
> could end up hanging if the test tries to log things to a
> temporarily frozen filesystem.  But the cutest reason of all: if
> you get past the above hurdles, the test uses invalid JSON in
> test_qga_fstrim() (missing '' around the dictionary key 'minimum'),
> and will thus fail an assertion in qmp_fd().
>=20
> Rather than leave this untested time-bomb in place, rip it out.
> Hopefully, as originally envisioned, we can find an opportunity
> to test an actual sandboxed guest where the guest-agent has
> full permissions and will not unduly affect the host running
> the test - if so, 'git revert' can be used if desired, for
> salvaging any useful parts of this attempt.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qga.c | 90 ------------------------------------------------=
--------
>  1 file changed, 90 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
