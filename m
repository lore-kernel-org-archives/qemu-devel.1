Received: from eggs.gnu.org ([2001:4830:134:3::10]:35505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLYa4-0007ZE-1l
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLYa0-00033e-U3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLYa0-00033B-Q1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:33:44 -0400
References: <20180523115719.26679-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f524be8-4807-64f1-7761-1d163524f2ec@redhat.com>
Date: Wed, 23 May 2018 20:33:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180523115719.26679-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Allow GTESTER_OPTIONS variable
 expansion from command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On 23.05.2018 13:57, Philippe Mathieu-Daud=C3=A9 wrote:
> The gtester utility offers the "-p=3DTESTPATH" option to
> "only run test cases matching TESTPATH".  We already use
> a $GTESTER_OPTIONS variable.
> Use make variable expansion to allow qtest path matching
> from command line:
>=20
>   $ time make check-qtest-arm GTESTER_OPTIONS=3D"-p /arm/boot-serial"
>     GTESTER check-qtest-arm
>=20
>   user 0m1.548s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I am more interested in the "-s" option (exclude pattern) but
> can't have it working :(
>=20
> i.e. "run all but qom/hmp":
> make check-qtest-arm GTESTER_OPTIONS=3D"-s /arm/qom -s /arm/hmp"
>=20
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3b9a5e31a2..b0ff3d988c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -870,7 +870,7 @@ tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
>  tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
> =20
>  SPEED =3D quick
> -GTESTER_OPTIONS =3D -k $(if $(V),--verbose,-q)
> +GTESTER_OPTIONS +=3D -k $(if $(V),--verbose,-q)
>  GCOV_OPTIONS =3D -n $(if $(V),-f,)
> =20
>  # gtester tests, possibly with verbose output

"make check-help" says:

 Default options are -k and (for make V=3D1) --verbose; they can be
 changed with variable GTESTER_OPTIONS.

So if you change the behavior here to amend to the variable instead, I
think you should also adjust the help text. Not sure if it's a good
idea, though, there might be people who want to run without "-k" and
this can not be disabled anymore with your patch.

 Thomas
