Received: from eggs.gnu.org ([2001:4830:134:3::10]:44134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMwH-0004yA-Di
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMwG-0007KX-3m
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:59:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNMwF-0007K2-Um
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15A85C050904
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 17:59:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-6-marcandre.lureau@redhat.com>
Date: Fri, 08 Dec 2017 18:59:51 +0100
In-Reply-To: <20171208005825.14587-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 8 Dec 2017 01:58:18 +0100")
Message-ID: <87po7p9k2w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/12] tests: fix check-qobject leak:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> /public/qobject_is_equal_conversion: OK
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D14396=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 56 byte(s) in 1 object(s) allocated from:
>     #0 0x7f07682c5850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f0767d12f0c in g_malloc ../glib/gmem.c:94
>     #2 0x7f0767d131cf in g_malloc_n ../glib/gmem.c:331
>     #3 0x562bd767371f in do_test_equality /home/elmarco/src/qq/tests/chec=
k-qobject.c:49
>     #4 0x562bd7674a35 in qobject_is_equal_dict_test /home/elmarco/src/qq/=
tests/check-qobject.c:267
>     #5 0x7f0767d37b04 in test_case_run ../glib/gtestutils.c:2237
>     #6 0x7f0767d37ec4 in g_test_run_suite_internal ../glib/gtestutils.c:2=
321
>     #7 0x7f0767d37f6d in g_test_run_suite_internal ../glib/gtestutils.c:2=
333
>     #8 0x7f0767d38184 in g_test_run_suite ../glib/gtestutils.c:2408
>     #9 0x7f0767d36e0d in g_test_run ../glib/gtestutils.c:1674
>     #10 0x562bd7674e75 in main /home/elmarco/src/qq/tests/check-qobject.c=
:327
>     #11 0x7f0766009039 in __libc_start_main (/lib64/libc.so.6+0x21039)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qobject.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/check-qobject.c b/tests/check-qobject.c
> index 03e9175113..710f9e6b0a 100644
> --- a/tests/check-qobject.c
> +++ b/tests/check-qobject.c
> @@ -59,6 +59,8 @@ static void do_test_equality(bool expected, int _, ...)
>              g_assert(qobject_is_equal(args[i], args[j]) =3D=3D expected);
>          }
>      }
> +
> +    g_free(args);
>  }
>=20=20
>  #define check_equal(...) \

Reviewed-by: Markus Armbruster <armbru@redhat.com>
