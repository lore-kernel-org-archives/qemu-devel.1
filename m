Received: from eggs.gnu.org ([2001:4830:134:3::10]:42382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffPlv-0003RY-3O
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffPlp-0008Ui-4v
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffPlo-0008UK-VP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AC22400225D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:12:00 +0000 (UTC)
Date: Tue, 17 Jul 2018 15:11:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717151157.6fa51a65.cohuck@redhat.com>
In-Reply-To: <20180717101944.11691-1-stefanha@redhat.com>
References: <20180717101944.11691-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] trace/simple: fix hang in child after
 fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 17 Jul 2018 11:19:44 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The simple trace backend spawns a write-out thread which is used to
> asynchronously flush the in-memory ring buffer to disk.
> 
> fork(2) does not clone all threads, only the thread that invoked
> fork(2).  As a result there is no write-out thread in the child process!
> 
> This causes a hang during shutdown when atexit(3) handler installed by
> the simple trace backend waits for the non-existent write-out thread.
> 
> This patch uses pthread_atfork(3) to terminate the write-out thread
> before fork and restart it in both the parent and child after fork.
> This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Hold trace_lock across fork() to prevent possibility of another
>    thread holding it and disappearing [Paolo]
> 
>  trace/simple.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)

Tested-by: Cornelia Huck <cohuck@redhat.com>
