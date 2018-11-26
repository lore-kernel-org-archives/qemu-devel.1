Received: from eggs.gnu.org ([2001:4830:134:3::10]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRHab-0004Lf-ET
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRHaV-0004e6-RX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:10:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRHaV-0004d2-Lc
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:10:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so18667834wmh.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 06:10:11 -0800 (PST)
References: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9c8191b-176b-5285-e9ca-8d4267fc5a89@redhat.com>
Date: Mon, 26 Nov 2018 15:09:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Enable fork_exec support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: jan.kiszka@siemens.com, stefanha@redhat.com, marcandre.lureau@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

Hi Samuel,

On 20/11/18 1:57, Samuel Thibault wrote:
> g_spawn_async_with_fds is portable on Windows, so we can now enable
> fork_exec support there.
> 
> Thanks Daniel P. Berrangé for the notice!

On x86_64 you can build locally using Docker:

$ make docker-test-build@debian-win32-cross
  BUILD   debian-win32-cross
  COPY    RUNNER
    RUN test-build in qemu:debian-win32-cross
Configure options:
--enable-werror --target-list=x86_64-softmmu,aarch64-softmmu
--prefix=/tmp/qemu-test/install --cross-prefix=i686-w64-mingw32.shared-
  CC      qga/commands-win32.o
  CC      qga/channel-win32.o
  CC      qga/service-win32.o
  CC      qga/vss-win32.o
...

>From the qemu source repository, you can also run once:
$ docker run --rm -it \
  -v $PWD:$PWD -w $PWD -v /tmp:/tmp \
  -u $UID \
  qemu:debian-win32-cross \
    bash -c 'mkdir build_win32 && cd build_win32 && ../configure
$QEMU_CONFIGURE_OPTS && make -j4'

Then to avoid rebuilding the world everytime, when you applied/modified
win32 related patches:

$ docker run --rm -it \
  -v $PWD:$PWD -w $PWD -v /tmp:/tmp \
  -u $UID \
  qemu:debian-win32-cross \
    bash -c 'make -C build_win32 -j4'

You can not 'run' the binary, but at least you can verify
compilation/linking steps.

Regards,

Phil.

> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>   slirp/misc.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 7972b9b05b..59b4e8f31c 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -62,17 +62,6 @@ int add_exec(struct ex_list **ex_ptr, void *chardev, const char *cmdline,
>   }
>   
>   
> -#ifdef _WIN32
> -
> -int
> -fork_exec(struct socket *so, const char *ex)
> -{
> -    /* not implemented */
> -    return 0;
> -}
> -
> -#else
> -
>   static int
>   slirp_socketpair_with_oob(int sv[2])
>   {
> @@ -132,7 +121,9 @@ err:
>   static void
>   fork_exec_child_setup(gpointer data)
>   {
> +#ifndef _WIN32
>       setsid();
> +#endif
>   }
>   
>   int
> @@ -177,7 +168,6 @@ fork_exec(struct socket *so, const char *ex)
>       qemu_set_nonblock(so->s);
>       return 1;
>   }
> -#endif
>   
>   char *slirp_connection_info(Slirp *slirp)
>   {
> 
