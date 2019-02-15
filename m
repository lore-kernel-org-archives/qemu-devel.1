Received: from eggs.gnu.org ([209.51.188.92]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guZ3Y-0000J2-Bn
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guYqh-0005jX-Fj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:27:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1guYqh-0005ea-6v
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A9BF7AEAE
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 08:27:49 +0000 (UTC)
References: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
	<1550165756-21617-9-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c37f9c8-8cc4-031d-491f-e029640683aa@redhat.com>
Date: Fri, 15 Feb 2019 09:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <1550165756-21617-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] vhost-user-test: small changes to
 init_hugepagefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 14/02/2019 18.35, Paolo Bonzini wrote:
> After the conversion to qgraph, the equivalent of "main" will be in
> a constructor and will run even if the tests are not being requested.
> Therefore, it should not assert that init_hugepagefs succeeds and will
> be called when creating the TestServer.  This patch changes the prototy=
pe
> of init_hugepagefs, this way the next patch looks nicer.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1543851204-41186-14-git-send-email-pbonzini@redhat.com>
> ---
>  tests/vhost-user-test.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 33030e0..516e31c 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -465,14 +465,20 @@ static void chr_read(void *opaque, const uint8_t =
*buf, int size)
>      g_mutex_unlock(&s->data_mutex);
>  }
> =20
> -#ifdef CONFIG_LINUX
> -static const char *init_hugepagefs(const char *path)
> +static const char *init_hugepagefs(void)
>  {
> +#ifdef CONFIG_LINUX
> +    const char *path =3D getenv("QTEST_HUGETLBFS_PATH");
>      struct statfs fs;
>      int ret;
> =20
> +    if (!path) {
> +        return NULL;
> +    }
> +
>      if (access(path, R_OK | W_OK | X_OK)) {
>          g_test_message("access on path (%s): %s\n", path, strerror(err=
no));
> +        abort();
>          return NULL;
>      }

I think I'd rather replace the whole if-statement with something like
this instead:

    g_assert_cmpint(access(path, R_OK | W_OK | X_OK), =3D=3D, 0);

> @@ -482,17 +488,21 @@ static const char *init_hugepagefs(const char *pa=
th)
> =20
>      if (ret !=3D 0) {
>          g_test_message("statfs on path (%s): %s\n", path, strerror(err=
no));
> +        abort();
>          return NULL;
>      }

Maybe simplify to:

    TFR(statfs_err =3D statfs(path, &fs));
    g_assert_cmpint(statfs_err, =3D=3D, 0);

>      if (fs.f_type !=3D HUGETLBFS_MAGIC) {
>          g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
> +        abort();
>          return NULL;
>      }

    g_assert_cmpint(fs.f_type, =3D=3D, HUGETLBFS_MAGIC);

?

>      return path;
> -}
> +#else
> +    return NULL;
>  #endif
> +}
> =20
>  static TestServer *test_server_new(const gchar *name)
>  {
> @@ -986,7 +996,6 @@ static void test_multiqueue(void)
> =20
>  int main(int argc, char **argv)
>  {
> -    const char *hugefs;
>      int ret;
>      char template[] =3D "/tmp/vhost-test-XXXXXX";
> =20
> @@ -1001,14 +1010,7 @@ int main(int argc, char **argv)
>      }
>      g_assert(tmpfs);
> =20
> -    root =3D tmpfs;
> -#ifdef CONFIG_LINUX
> -    hugefs =3D getenv("QTEST_HUGETLBFS_PATH");
> -    if (hugefs) {
> -        root =3D init_hugepagefs(hugefs);
> -        g_assert(root);
> -    }
> -#endif
> +    root =3D init_hugepagefs() ? : tmpfs;

I'd prefer the Elvis operator without space inbetween.

>      if (qemu_memfd_check(0)) {
>          qtest_add_data_func("/vhost-user/read-guest-mem/memfd",

Anyway, just nits, so still:

Reviewed-by: Thomas Huth <thuth@redhat.com>
