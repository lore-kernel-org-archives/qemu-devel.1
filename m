Received: from eggs.gnu.org ([2001:4830:134:3::10]:36794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cb6M1-00006D-7Z
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cb6Ly-0005iA-5Y
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cb6Lx-0005hE-Vi
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:02:42 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 740B23A768B
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 14:02:41 +0000 (UTC)
Date: Tue, 7 Feb 2017 14:02:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170207140237.GK2635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
	<20170207135211.15870-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170207135211.15870-4-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Feb 07, 2017 at 05:51:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> No need for strdup, fix leaks when socat is missing.
>=20
> Spotted by ASAN.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-io-channel-command.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

ACK, I've added this to my queue, but if this merges via a
pull request for your entire series, that's fine too.

>=20
> diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-co=
mmand.c
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


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
