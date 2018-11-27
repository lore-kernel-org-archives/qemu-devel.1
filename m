Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRhKm-00075C-HG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRhKj-0004zH-Co
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:39:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRhKj-0004z2-44
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:39:37 -0500
Date: Tue, 27 Nov 2018 12:39:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127173934.GB12617@flamenco>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe de Dinechin <dinechin@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Nov 27, 2018 at 13:49:13 +0100, Christophe de Dinechin wrote:
> (I did not finish the review, but decided to send what I already had).
> 
> > On 22 Nov 2018, at 08:20, guangrong.xiao@gmail.com wrote:
> > 
> > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > This modules implements the lockless and efficient threaded workqueue.
> 
> I’m not entirely convinced that it’s either “lockless” or “efficient”
> in the current iteration. I believe that it’s relatively easy to fix, though.
(snip)
> > 
> >    All the requests are pre-allocated and carefully partitioned between
> >    threads so there is no contention on the request, that make threads
> >    be parallel as much as possible.
> 
> That sentence confused me (it’s also in a comment in the text).
> I think I’m mostly confused by “there is no contention”. Perhaps you
> meant “so as to avoid contention if possible”? If there is a reason
> why there would never be any contention even if requests arrive faster than
> completions, I did not figure it out.
> 
> I personally see serious contention on the fields in the Threads structure,
> for example, but also possibly on the targets of the “modulo” operation in
> thread_find_free_request. Specifically, if three CPUs are entering
> thread_find_free_request at the same time, they will all run the same
> loop and all, presumably, “attack” the same memory locations.
> 
> Sorry if I mis-read the code, but at the moment, it does not seem to
> avoid contention as intended. I don’t see how it could without having
> some way to discriminate between CPUs to start with, which I did not find.

You might have missed that only one thread can request jobs. So contention
should only happen between that thread and the worker threads, but
not among worker threads (they should only share cache lines with the
requester thread).

> > - User, i.e, the submitter
> >    It's the one fills the request and submits it to the workqueue,
> the one -> the one who
> >    the result will be collected after it is handled by the work queue.
> > 
> >    The user can consecutively submit requests without waiting the previous
> waiting -> waiting for
> >    requests been handled.
> >    It only supports one submitter, you should do serial submission by
> >    yourself if you want more, e.g, use lock on you side.
> 
> I’m also confused by this last statement. The proposal purports
> to be “lockless”, which I read as working correctly without a lock…
> Reading the code, I indeed see issues if different threads
> try to place requests at the same time. So I believe the word
> “lockless” is a bit misleading.

ditto, it is lockless as presented here, i.e. one requester thread.

> > +static void uninit_thread_requests(ThreadLocal *thread, int free_nr)
> > +{
> > +    Threads *threads = thread->threads;
> > +    ThreadRequest *request = thread->requests;
> > +    int i;
> > +
> > +    for (i = 0; i < free_nr; i++) {
> > +        threads->ops->thread_request_uninit(request + 1);
> > +        request = (void *)request + threads->request_size;
> 
> Despite GCC’s tolerance for it and rather lengthy debates,
> pointer arithmetic on void * is illegal in C [1].
> 
> Consider using char * arithmetic, and using macros such as:
> 
> #define request_to_payload(req) (((ThreadRequest *) req) + 1)
> #define payload_to_request(req) (((ThreadRequest *) req) - 1)
> #define request_to_next(req,threads) ((ThreadRequest *) ((char *) req) + threads->request_size))
> 
> where appropriate, that would clarify the intent.
> 
> [1] https://stackoverflow.com/questions/3523145/pointer-arithmetic-for-void-pointer-in-c

FWIW, we use void pointer arithmetic in other places in QEMU, so
I wouldn't worry about it being illegal.

I like those little macros though; even better as inlines.

Thanks,

		Emilio
