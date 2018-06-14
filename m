Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTHtK-0000zX-EM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTHtH-0003M0-8k
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTHtH-0003Ls-3W
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B674E401EF1D
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 02:21:34 +0000 (UTC)
Date: Thu, 14 Jun 2018 10:21:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180614022130.GQ15344@xz-mi>
References: <20180613102642.23995-1-dgilbert@redhat.com>
	<20180613102642.23995-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613102642.23995-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Wake rate limiting for
 urgent requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jdenemar@redhat.com

On Wed, Jun 13, 2018 at 11:26:41AM +0100, Dr. David Alan Gilbert (git) wrote:

[...]

> @@ -2932,10 +2943,24 @@ static void *migration_thread(void *opaque)
>  
>          migration_update_counters(s, current_time);
>  
> +        urgent = false;
>          if (qemu_file_rate_limit(s->to_dst_file)) {
> -            /* usleep expects microseconds */
> -            g_usleep((s->iteration_start_time + BUFFER_DELAY -
> -                      current_time) * 1000);
> +            /* Wait for a delay to do rate limiting OR
> +             * something urgent to post the semaphore.
> +             */
> +            int ms = s->iteration_start_time + BUFFER_DELAY - current_time;
> +            trace_migration_thread_ratelimit_pre(ms);
> +            if (qemu_sem_timedwait(&s->rate_limit_sem, ms) == 0) {
> +                /* We were worken by one or more urgent things but
> +                 * the timedwait will have consumed one of them.
> +                 * The service routine for the urgent wake will dec
> +                 * the semaphore itself for each item it consumes,
> +                 * so add this one we just eat back.
> +                 */
> +                qemu_sem_post(&s->rate_limit_sem);

Is it possible that we just avoid eating that in the next patch?  Then
we only provide a helper to "trigger an urgent request" but we only
consume the point here?

-- 
Peter Xu
