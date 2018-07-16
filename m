Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ff1Nw-0008Db-Uq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ff1Nr-00044V-TC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:09:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ff1Nr-00044F-OD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F1B37B2B3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 11:09:39 +0000 (UTC)
Date: Mon, 16 Jul 2018 13:09:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180716130934.084b7bc8.cohuck@redhat.com>
In-Reply-To: <36833724-11e5-42b9-e2bc-8f52734bd640@redhat.com>
References: <20180713184213.25301-1-stefanha@redhat.com>
	<36833724-11e5-42b9-e2bc-8f52734bd640@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] trace/simple: fix hang in child after
 fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On Sun, 15 Jul 2018 14:42:23 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 13/07/2018 20:42, Stefan Hajnoczi wrote:
> > +#ifndef _WIN32
> > +static void stop_writeout_thread(void)
> > +{
> > +    g_mutex_lock(&trace_lock);
> > +    trace_writeout_running = false;
> > +    g_cond_signal(&trace_available_cond);
> > +    g_mutex_unlock(&trace_lock);
> > +
> > +    g_thread_join(trace_writeout_thread);
> > +    trace_writeout_thread = NULL;
> > +}  
> 
> After stop_writeout_thread returns, another could start a write to the
> shared data structure---and the write would never finish, because the
> thread disappears after fork(2) returns.  This would leave the mutex
> locked, causing a deadlock soon after the fork.  So you need to lock
> trace_lock again here, and unlock it in restart_writeout_thread.

So, I suppose there will be a v3, right?

> 
> Apart from this, it looks good!

Did a quick run and it fixed the problems for me.
