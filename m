Received: from eggs.gnu.org ([2001:4830:134:3::10]:46017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcmH-0007Fu-V2
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcmD-0007Lm-45
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:54:50 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcmC-0007Lg-Vj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:54:45 -0400
Received: by mail-qt0-x241.google.com with SMTP id x35so11580709qtc.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 15:54:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af7e2b04-4815-6e78-bba7-6b0a277797e1@amsat.org>
Date: Fri, 7 Apr 2017 19:54:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>jsnow@redhat.com

Hi Paolo,

On 03/23/2017 02:39 PM, Paolo Bonzini wrote:
> !job is always checked prior to the call, drop it from here.

I agree with you this is currently true, *but* block_job_user_paused() 
is exported in "block/blockjob.h" so any future access (external to 
blockdev.c) could eventually happen with job == NULL.
I'd  NACK this patch for for this reason, but I checked and there is no 
access to this function outside of blockdev.c, so I think the best is to 
make block_job_user_paused() static (removing the public declaration) 
and safely drop the !job check, what do you think?

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/blockjob.c b/blockjob.c
> index 9b619f385..a9fb624 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
>
>  bool block_job_user_paused(BlockJob *job)
>  {
> -    return job ? job->user_paused : 0;
> +    return job->user_paused;
>  }
>
>  void coroutine_fn block_job_pause_point(BlockJob *job)
>
