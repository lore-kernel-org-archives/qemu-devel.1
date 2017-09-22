Received: from eggs.gnu.org ([2001:4830:134:3::10]:49438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tomoki.sekiyama@gmail.com>) id 1dvVFI-0006Hi-DI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tomoki.sekiyama@gmail.com>) id 1dvVFH-0003Cp-7n
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:12:24 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:56703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tomoki.sekiyama@gmail.com>)
	id 1dvVFH-0003C4-23
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:12:23 -0400
Received: by mail-oi0-x235.google.com with SMTP id b184so239096oii.13
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
References: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
From: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
Date: Sat, 23 Sep 2017 06:12:20 +0900
Message-ID: <CAM1upfMHMYvkQNfqPFZqsz2rGC+X7UZECXAffMZ6Lnz4_Tn1AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qga-win: don't hang if vss hold writes
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

Thanks for your patch.
Which version of Windows have you found the hang?

Regards,
Tomoki

2017-09-22 11:46 GMT+09:00 Chen Hanxiao <chen_han_xiao@126.com>:

> From: Chen Hanxiao <chenhanxiao@gmail.com>
>
> When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
> is executed, VSS may timeout when trying to hold writes.
>
> Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
> is logged in the Event Viewer.
>
> At that time, if we call AbortBackup, qga may hang forever.
>
> This patch will solve this issues.
>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
>  qga/vss-win32/requester.cpp | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 301762d..3d9c971 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -419,6 +419,16 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
>              break;
>          }
>      }
> +
> +    if (wait_status == WAIT_TIMEOUT) {
> +        err_set(errset, E_FAIL,
> +                "timeout when try to receive Frozen event from VSS
> provider");
> +        /* If we are here, VSS had timeout.
> +         * Don't call AbortBackup, just return directly.
> +         */
> +        goto out1;
> +    }
> +
>      if (wait_status != WAIT_OBJECT_0) {
>          err_set(errset, E_FAIL,
>                  "couldn't receive Frozen event from VSS provider");
> @@ -432,6 +442,8 @@ out:
>      if (vss_ctx.pVssbc) {
>          vss_ctx.pVssbc->AbortBackup();
>      }
> +
> +out1:
>      requester_cleanup();
>      CoUninitialize();
>  }
> --
> 2.7.5
>
>
