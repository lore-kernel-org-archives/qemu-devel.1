Received: from eggs.gnu.org ([2001:4830:134:3::10]:50946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpveP-0006dY-J3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpveO-0006dt-Oc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpveO-0006dn-Hu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:39:00 -0400
References: <20170320101549.150076-1-vpalatin@chromium.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73447500-37b9-0a60-9c8d-6def60dc088e@redhat.com>
Date: Mon, 20 Mar 2017 12:38:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170320101549.150076-1-vpalatin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: fix breakage in locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>



On 20/03/2017 11:15, Vincent Palatin wrote:
> use qemu_mutex_lock_iothread consistently in qemu_hax_cpu_thread_fn() as
> done in other _thread_fn functions, instead of grabbing directly the
> BQL. This way we ensure that iothread_locked is properly set.
> 
> On v2.9.0-rc0, QEMU was dying in an assertion in the mutex code when
> running with '--enable-hax' either on OSX or Windows. This bug was triggered
> since the code modification for multithreading added new usages of
> qemu_mutex_iothread_locked.
> This fixes the breakage on both platforms, I can now run again a full
> Chromium OS image with HAX kernel acceleration.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> ---
>  cpus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index b84a392dda..167d9615e1 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1344,8 +1344,9 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>  {
>      CPUState *cpu = arg;
>      int r;
> +
> +    qemu_mutex_lock_iothread();
>      qemu_thread_get_self(cpu->thread);
> -    qemu_mutex_lock(&qemu_global_mutex);
>  
>      cpu->thread_id = qemu_get_thread_id();
>      cpu->created = true;
> 

Queued, thanks.

Paolo
