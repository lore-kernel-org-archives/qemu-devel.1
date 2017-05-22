Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dCmyA-00037D-M9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dCmy5-0008JR-Hn
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55914
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1dCmy5-0008Hl-D4
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:01:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4MCwdbn054224
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 09:01:47 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aktkks7ff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 09:01:47 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Mon, 22 May 2017 07:01:46 -0600
Reply-To: jjherne@linux.vnet.ibm.com
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Mon, 22 May 2017 09:01:41 -0400
MIME-Version: 1.0
In-Reply-To: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d643e698-8093-3e46-91de-551db41f3ec3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 05/19/2017 05:29 PM, Felipe Franciosi wrote:
> Currently, the throttle_thread_scheduled flag is reset back to 0 before
> sleeping (as part of the throttling logic). Given that throttle_timer
> (well, any timer) may tick with a slight delay, it so happens that under
> heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
> schedule a further cpu_throttle_thread() work item after the flag reset,
> but before the previous sleep completed. This results on the vCPU thread
> sleeping continuously for potentially several seconds in a row.
>
> The chances of that happening can be drastically minimised by resetting
> the flag after the sleep.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 516e5cb..f42eebd 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -677,9 +677,9 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>      sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
>
>      qemu_mutex_unlock_iothread();
> -    atomic_set(&cpu->throttle_thread_scheduled, 0);
>      g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
>      qemu_mutex_lock_iothread();
> +    atomic_set(&cpu->throttle_thread_scheduled, 0);
>  }
>
>  static void cpu_throttle_timer_tick(void *opaque)
>

This seems to make sense to me.

Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

I'm CC'ing Juan, Amit and David as they are all active in the migration 
area and may have
opinions on this. Juan and David were also reviewers for the original 
series.

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
