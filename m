Received: from eggs.gnu.org ([209.51.188.92]:58240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjU2u-0003M0-Ks
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjU2t-0004Ji-Hw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:06:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjU2t-0004FI-BM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:06:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so4211238wrs.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:06:34 -0800 (PST)
References: <1547573562-32754-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2a053f9-39d0-e59c-2250-ae89af242fab@redhat.com>
Date: Tue, 15 Jan 2019 20:06:32 +0100
MIME-Version: 1.0
In-Reply-To: <1547573562-32754-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] seccomp: Work-around GCC 4.x bug in gnu99
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 1/15/19 6:32 PM, Thomas Huth wrote:
> We'd like to compile QEMU with -std=gnu99, but GCC 4.8 currently
> fails to compile qemu-seccomp.c in this mode:
> 
> qemu-seccomp.c:45:1: error: initializer element is not constant
>  };
>  ^
> qemu-seccomp.c:45:1: error: (near initialization for ‘sched_setscheduler_arg[0]’)
> 
> This is due to a compiler bug which has just been fixed in GCC 5.0:
> 
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567
> 
> Since we still want to support GCC 4.8 for a while and also want to use
> gnu99 mode, work-around the issue by expanding the macro manually.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 5c73e6a..36d5829 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -41,7 +41,8 @@ struct QemuSeccompSyscall {
>  };
>  
>  const struct scmp_arg_cmp sched_setscheduler_arg[] = {
> -    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> +    /* was SCMP_A1(SCMP_CMP_NE, SCHED_IDLE), but expanded due to GCC 4.x bug */
> +    { .arg = 1, .op = SCMP_CMP_NE, .datum_a = SCHED_IDLE }
>  };
>  
>  static const struct QemuSeccompSyscall blacklist[] = {
> 
