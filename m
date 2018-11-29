Received: from eggs.gnu.org ([2001:4830:134:3::10]:54778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSNMc-0007mi-RZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSNMX-0003Jz-4z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:32:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSNMW-0003JN-UX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:32:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2119493wrt.7
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:32:16 -0800 (PST)
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-3-fli@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a4a3753d-8986-85c4-f098-395bc4379506@redhat.com>
Date: Thu, 29 Nov 2018 15:32:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181128103308.26755-3-fli@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/5] qemu_thread_join: fix segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, qemu-devel@nongnu.org

Hi Fei,

On 28/11/18 11:33, Fei Li wrote:
> To avoid the segmentation fault in qemu_thread_join(), just directly
> return when the QemuThread *thread failed to be created in either
> qemu-thread-posix.c or qemu-thread-win32.c.
> 
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  util/qemu-thread-posix.c | 3 +++
>  util/qemu-thread-win32.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 865e476df5..b9ab5a4711 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -558,6 +558,9 @@ void *qemu_thread_join(QemuThread *thread)
>      int err;
>      void *ret;
>  
> +    if (!thread->thread) {
> +        return NULL;
> +    }
>      err = pthread_join(thread->thread, &ret);
>      if (err) {
>          error_exit(err, __func__);
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 4a363ca675..1a27e1cf6f 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -366,7 +366,7 @@ void *qemu_thread_join(QemuThread *thread)
>      HANDLE handle;
>  
>      data = thread->data;
> -    if (data->mode == QEMU_THREAD_DETACHED) {
> +    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {

Isn't it a way to hide a problem from the caller?

qemu_thread_create() always initializes thread->data.

If the thread doesn't exist you shouldn't try to join() it.

If you try to fix a bug, I'd use here:

       assert(thread->data);

Regards,

Phil.

>          return NULL;
>      }
>  
> 
