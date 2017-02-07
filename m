Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb7HZ-0006EB-IK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb7HT-0002zt-TB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:02:13 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:51535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb7HT-0002yY-NO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:02:07 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 467BF21A5D
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 16:02:04 +0100 (CET)
Date: Tue, 7 Feb 2017 16:02:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207160201.0310ef7a@bahia.lan>
In-Reply-To: <20170207135211.15870-4-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
	<20170207135211.15870-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/28] tests: fix leaks in
 test-io-channel-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue,  7 Feb 2017 17:51:46 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> No need for strdup, fix leaks when socat is missing.
>=20
> Spotted by ASAN.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/test-io-channel-command.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-comm=
and.c
> index 1d1f461bed..46ce1ff01c 100644
> --- a/tests/test-io-channel-command.c
> +++ b/tests/test-io-channel-command.c
> @@ -29,8 +29,8 @@ static void test_io_channel_command_fifo(bool async)
>  #define TEST_FIFO "tests/test-io-channel-command.fifo"
>      QIOChannel *src, *dst;
>      QIOChannelTest *test;
> -    char *srcfifo =3D g_strdup_printf("PIPE:%s,wronly", TEST_FIFO);
> -    char *dstfifo =3D g_strdup_printf("PIPE:%s,rdonly", TEST_FIFO);
> +    const char *srcfifo =3D "PIPE:" TEST_FIFO ",wronly";
> +    const char *dstfifo =3D "PIPE:" TEST_FIFO ",rdonly";
>      const char *srcargv[] =3D {
>          "/bin/socat", "-", srcfifo, NULL,
>      };
> @@ -59,8 +59,6 @@ static void test_io_channel_command_fifo(bool async)
>      object_unref(OBJECT(src));
>      object_unref(OBJECT(dst));
> =20
> -    g_free(srcfifo);
> -    g_free(dstfifo);
>      unlink(TEST_FIFO);
>  }
> =20
