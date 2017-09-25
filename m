Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQCa-00064m-C9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQC3-0001ki-NW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:01:24 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwQC3-0001k3-6c
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:00:51 -0400
Received: by mail-wr0-x242.google.com with SMTP id g50so1676293wra.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:00:51 -0700 (PDT)
Date: Mon, 25 Sep 2017 11:00:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925100048.GH14140@stefanha-x1.localdomain>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506321449-24013-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] iothread: delay the context release
 to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 25, 2017 at 02:37:29PM +0800, Peter Xu wrote:
> When gcontext is used with iothread, the context will be destroyed
> during iothread_stop().  That's not good since sometimes we would like
> to keep the resources until iothread is destroyed, but we may want to
> stop the thread before that point.
> 
> Delay the destruction of gcontext to iothread finalize.  Then we can do:
> 
>   iothread_stop(thread);
>   some_cleanup_on_resources();
>   iothread_destroy(thread);
> 
> We may need this patch if we want to run chardev IOs in iothreads and
> hopefully clean them up correctly.  For more specific information,
> please see 2b316774f6 ("qemu-char: do not operate on sources from
> finalize callbacks").
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  iothread.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
