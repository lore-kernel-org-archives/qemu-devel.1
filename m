Received: from eggs.gnu.org ([209.51.188.92]:52414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZ7p-0007MB-AG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZ7k-0003NW-U1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggZ7k-0003NA-MP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
Date: Mon, 07 Jan 2019 18:55:37 +0100
In-Reply-To: <20181225140449.15786-17-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:49 +0800")
Message-ID: <874lakl5d2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 16/16] qemu_thread_join: fix
 segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Stefan Weil <sw@weilnetz.de>

Fei Li <fli@suse.com> writes:

> To avoid the segmentation fault in qemu_thread_join(), just directly
> return when the QemuThread *thread failed to be created in either
> qemu-thread-posix.c or qemu-thread-win32.c.
>
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  util/qemu-thread-posix.c | 3 +++
>  util/qemu-thread-win32.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 39834b0551..3548935dac 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>      int err;
>      void *ret;
>  
> +    if (!thread->thread) {
> +        return NULL;
> +    }

How can this happen?

>      err = pthread_join(thread->thread, &ret);
>      if (err) {
>          error_exit(err, __func__);
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 57b1143e97..ca4d5329e3 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -367,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
>      HANDLE handle;
>  
>      data = thread->data;
> -    if (data->mode == QEMU_THREAD_DETACHED) {
> +    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
>          return NULL;
>      }
