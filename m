Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2VNh-0002Dd-Px
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2VNe-0006qR-Ib
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2VNe-0006qJ-Bu
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:13:42 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc7ef530-72c1-8d81-bb56-8a15d6ae1b66@redhat.com>
Date: Mon, 24 Apr 2017 12:13:34 +0800
MIME-Version: 1.0
In-Reply-To: <1492674416-9408-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] colo-compare: Check main_loop value
 before call g_main_loop_quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com



On 2017=E5=B9=B404=E6=9C=8820=E6=97=A5 15:46, zhanghailiang wrote:
> If some errors happen before main_loop is initialized in colo
> compare thread, qemu will go into finalizing process where
> we call g_main_loop_quit(s->main_loop), if main_loop is NULL, there
> will be an error report:
> "(process:14861): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop !=
=3D NULL' failed".
>
> We need to check if main_loop is NULL or not before call g_main_loop_qu=
it().

Do we need check and fail early in colo_compare_thread() too?

Thanks

>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a6bf419..d6a5e4c 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -770,7 +770,9 @@ static void colo_compare_finalize(Object *obj)
>                                s->worker_context, true);
>       qemu_chr_fe_deinit(&s->chr_out);
>  =20
> -    g_main_loop_quit(s->compare_loop);
> +    if (s->compare_loop) {
> +        g_main_loop_quit(s->compare_loop);
> +    }
>       qemu_thread_join(&s->thread);
>  =20
>       /* Release all unhandled packets after compare thead exited */
