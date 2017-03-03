Received: from eggs.gnu.org ([2001:4830:134:3::10]:55453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjpr7-0005JG-OA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjpr4-000579-HB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:57 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjpr4-00055l-D5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:54 -0500
Received: by mail-qk0-x244.google.com with SMTP id n141so4467042qke.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:14:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488555707-14669-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <14f2a848-1ec6-35f6-a240-9d8ac5e93234@amsat.org>
Date: Fri, 3 Mar 2017 13:14:48 -0300
MIME-Version: 1.0
In-Reply-To: <1488555707-14669-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iscsi: fix missing unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Paolo,

On 03/03/2017 12:41 PM, Paolo Bonzini wrote:
> Reported by Coverity.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/iscsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 76319a1..75d8905 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -637,6 +637,7 @@ retry:
>      }
>  #endif
>      if (iTask.task == NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>          return -ENOMEM;

what about:

         r = -ENOMEM;
         goto out_unlock;

to follow the file codestyle? (same following 3)

>      }
>  #if LIBISCSI_API_VERSION < (20160603)
> @@ -864,6 +865,7 @@ retry:
>      }
>  #endif
>      if (iTask.task == NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>          return -ENOMEM;
>      }
>  #if LIBISCSI_API_VERSION < (20160603)
> @@ -904,6 +906,7 @@ static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
>  retry:
>      if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0, 0, 0,
>                                        0, iscsi_co_generic_cb, &iTask) == NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>          return -ENOMEM;
>      }
>
> @@ -1237,6 +1240,7 @@ retry:
>                                              0, 0, iscsi_co_generic_cb, &iTask);
>      }
>      if (iTask.task == NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>          return -ENOMEM;
>      }
>
>
