Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9Ziq-0001Gz-IX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9Zip-0005d9-BJ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:49:04 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:53486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e9Zip-0005cu-5c
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:49:03 -0400
Received: by mail-vk0-x241.google.com with SMTP id k195so10760748vke.10
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 09:49:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031160902.6874-1-ross.lagerwall@citrix.com>
References: <20171031160902.6874-1-ross.lagerwall@citrix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Oct 2017 17:49:01 +0100
Message-ID: <CAJ+F1C+Bd3d8TqnZtXjQKyeD-BNruKomkp51QWOQfC=QwwB1vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: Fix QIOChannelFile when creating and
 opening read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

(adding the maintainer in cc, scripts/get_maintainer.pl -f  io/channel-file=
.c)

On Tue, Oct 31, 2017 at 5:09 PM, Ross Lagerwall
<ross.lagerwall@citrix.com> wrote:
> The code wrongly passes the mode to open() only if O_WRONLY is set.
> Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
> Linux). Fix this by always passing the mode since open() will correctly
> ignore the mode if it is not needed. Add a testcase which exercises this
> bug.

ok

>
> While at it, add /dev/fdset/ support to QIOChannelFile by calling
> qemu_open() instead open(). There is a subtle semantic change since
> qemu_open() automatically sets O_CLOEXEC, but this doesn't affect any of
> the users of the function.
>

yes, I meant to send a similar patch. However, it should probably call
qemu_close() then.


> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  include/io/channel-file.h    |  2 +-
>  io/channel-file.c            |  6 +-----
>  tests/test-io-channel-file.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/include/io/channel-file.h b/include/io/channel-file.h
> index 79245f1..ebfe54e 100644
> --- a/include/io/channel-file.h
> +++ b/include/io/channel-file.h
> @@ -73,7 +73,7 @@ qio_channel_file_new_fd(int fd);
>   * qio_channel_file_new_path:
>   * @path: the file path
>   * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
> - * @mode: the file creation mode if O_WRONLY is set in @flags
> + * @mode: the file creation mode if O_CREAT is set in @flags
>   * @errp: pointer to initialized error object
>   *
>   * Create a new IO channel object for a file represented
> diff --git a/io/channel-file.c b/io/channel-file.c
> index b383273..ae8fb62 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -50,11 +50,7 @@ qio_channel_file_new_path(const char *path,
>
>      ioc =3D QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>
> -    if (flags & O_WRONLY) {
> -        ioc->fd =3D open(path, flags, mode);
> -    } else {
> -        ioc->fd =3D open(path, flags);
> -    }
> +    ioc->fd =3D qemu_open(path, flags, mode);
>      if (ioc->fd < 0) {
>          object_unref(OBJECT(ioc));
>          error_setg_errno(errp, errno,
> diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
> index 6bfede6..0c7303d 100644
> --- a/tests/test-io-channel-file.c
> +++ b/tests/test-io-channel-file.c
> @@ -50,6 +50,32 @@ static void test_io_channel_file(void)
>      object_unref(OBJECT(dst));
>  }
>
> +static void test_io_channel_file_rdwr(void)
> +{
> +    QIOChannel *src, *dst;
> +    QIOChannelTest *test;
> +
> +#define TEST_FILE "tests/test-io-channel-file.txt"
> +    unlink(TEST_FILE);
> +    src =3D QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0600,
> +                          &error_abort));
> +    dst =3D QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDONLY | O_BINARY, 0,
> +                          &error_abort));
> +
> +    test =3D qio_channel_test_new();
> +    qio_channel_test_run_writer(test, src);
> +    qio_channel_test_run_reader(test, dst);
> +    qio_channel_test_validate(test);
> +
> +    unlink(TEST_FILE);
> +    object_unref(OBJECT(src));
> +    object_unref(OBJECT(dst));
> +}
> +
>
>  static void test_io_channel_fd(void)
>  {
> @@ -114,6 +140,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>
>      g_test_add_func("/io/channel/file", test_io_channel_file);
> +    g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
>      g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
>  #ifndef _WIN32
>      g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
> --
> 2.9.5
>
>

Looks good to me otherwise.


--=20
Marc-Andr=C3=A9 Lureau
