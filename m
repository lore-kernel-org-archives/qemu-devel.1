Received: from eggs.gnu.org ([209.51.188.92]:50225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1Q9w-0004HE-Av
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1Q9n-0002xa-P8
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1Q9g-0002me-0S
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:35:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67B113082A4C
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 06:35:37 +0000 (UTC)
References: <20190305225135.7060-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53bdf4ee-d791-9983-6f1c-72b2b96e7342@redhat.com>
Date: Wed, 6 Mar 2019 07:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190305225135.7060-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 05/03/2019 23.51, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vhost-user-test.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 4cd0a97f13..9364227ba4 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -588,6 +588,7 @@ static void test_server_free(TestServer *server)
>          g_test_message("unable to rmdir: path (%s): %s",
>                         server->tmpfs, strerror(errno));
>      }
> +    g_free(server->tmpfs);
> =20
>      qemu_chr_fe_deinit(&server->chr, true);
> =20
> @@ -605,6 +606,8 @@ static void test_server_free(TestServer *server)
> =20
>      g_main_loop_unref(server->loop);
>      g_main_context_unref(server->context);
> +    g_cond_clear(&server->data_cond);
> +    g_mutex_clear(&server->data_mutex);
>      g_free(server);
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and queued to my qtest-next branch (unless Michael wants to take it
through hist vhost tree instead).
