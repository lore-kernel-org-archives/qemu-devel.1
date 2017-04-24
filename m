Received: from eggs.gnu.org ([2001:4830:134:3::10]:52040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2VKk-0001U6-1A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2VKf-00060p-7u
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2VKe-00060X-Uj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:10:37 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
Date: Mon, 24 Apr 2017 12:10:29 +0800
MIME-Version: 1.0
In-Reply-To: <1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: serialize compare
 thread's initialization with main thread
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
> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is used
> to detach watched fd from default main context, so it has chance to
> handle the same watched fd with main thread concurrently, which will
> trigger an error report:
> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src =3D=3D ((=
void *)0)' failed."

Anyway to prevent fd from being handled by main thread before creating=20
colo thread? Using semaphore seems not elegant.

Thanks

>
> Fix it by serializing compare thread's initialization with main thread.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 54e6d40..a6bf419 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -83,6 +83,7 @@ typedef struct CompareState {
>       GHashTable *connection_track_table;
>       /* compare thread, a thread for each NIC */
>       QemuThread thread;
> +    QemuSemaphore thread_ready;
>  =20
>       GMainContext *worker_context;
>       GMainLoop *compare_loop;
> @@ -557,6 +558,8 @@ static void *colo_compare_thread(void *opaque)
>                             (GSourceFunc)check_old_packet_regular, s, N=
ULL);
>       g_source_attach(timeout_source, s->worker_context);
>  =20
> +    qemu_sem_post(&s->thread_ready);
> +
>       g_main_loop_run(s->compare_loop);
>  =20
>       g_source_unref(timeout_source);
> @@ -707,12 +710,15 @@ static void colo_compare_complete(UserCreatable *=
uc, Error **errp)
>                                                         connection_key_=
equal,
>                                                         g_free,
>                                                         connection_dest=
roy);
> +    qemu_sem_init(&s->thread_ready, 0);
>  =20
>       sprintf(thread_name, "colo-compare %d", compare_id);
>       qemu_thread_create(&s->thread, thread_name,
>                          colo_compare_thread, s,
>                          QEMU_THREAD_JOINABLE);
>       compare_id++;
> +    qemu_sem_wait(&s->thread_ready);
> +    qemu_sem_destroy(&s->thread_ready);
>  =20
>       return;
>   }
