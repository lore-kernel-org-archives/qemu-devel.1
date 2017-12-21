Received: from eggs.gnu.org ([2001:4830:134:3::10]:55945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0PT-00024i-Dy
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0PQ-0001Sw-6E
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eS0PP-0001R4-W4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:12 -0500
Date: Thu, 21 Dec 2017 20:57:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221125702.GS10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-23-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 22/27] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/19 16:45, Peter Xu wrote:
> For those monitors who has enabled IO thread, we'll offload the

s/has/have/

> responding procedure into IO thread.  The main reason is that chardev is
> not thread safe, and we need to do all the read/write IOs in the same
> thread.  For use_io_thr=true monitors, that thread is the IO thread.
> 
> We do this isolation in similar pattern as what we have done to the
> request queue: we first create one response queue for each monitor, then
> instead of reply directly in main thread, we queue the responses and

s/reply/replying/

s/main thread/the main thread/

> kick the IO thread to do the rest of the job for us.
> 
> A funny thing after doing this is that, when the QMP clients send "quit"
> to QEMU, it's possible that we close the IOThread even earlier than
> replying to that "quit".  So another thing we need to do before cleaning
> up the monitors is that we need to flush the response queue (we don't
> need to do that for command queue; after all we are quitting) to make
> sure replies for handled commands are always flushed back to clients.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
