Received: from eggs.gnu.org ([2001:4830:134:3::10]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gP8xs-0005ED-4d
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gP8xm-0006li-6N
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:33:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gP8xk-0006h9-Ie
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:33:21 -0500
Date: Tue, 20 Nov 2018 11:33:15 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181120163315.GA32388@flamenco>
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
	<20181106122025.3487-3-xiaoguangrong@tencent.com>
	<20181113183821.GA11606@flamenco>
	<35f0eb1a-3ec9-344b-7dda-d766c1b79626@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f0eb1a-3ec9-344b-7dda-d766c1b79626@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Nov 20, 2018 at 18:25:25 +0800, Xiao Guangrong wrote:
> On 11/14/18 2:38 AM, Emilio G. Cota wrote:
> > On Tue, Nov 06, 2018 at 20:20:22 +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
(snip)
> > Batching achieves higher performance at high core counts (>8),
> > since worker threads go through fewer sleep+wake cycles while
> > waiting for jobs. Performance however diminishes as more threads
> > are used (>=24) due to cache line contention.
> > 
> > Contention can be avoided by partitioning the request array, bitmaps
> > and completion event to be entirely local to worker threads
> > ("+per-thread-state"). This avoids the performance decrease at >=24
> > threads that we observe with batching alone. Note that the overall
> > speedup does not go beyond ~8; this is explained by the fact that we
> > use a single requester thread. Thus, as we add more worker threads,
> > they become increasingly less busy, yet throughput remains roughly
> > constant. I say roughly because there's quite a bit of noise--this
> > is a 4-socket machine and I'm letting the scheduler move threads
> > around, although I'm limiting the cores that can be used with
> > taskset to maximize locality (this means that for 15 threads we're
> > using 16 host cores that are all in the same socket; note that
> > the additional thread is the requester one).
> 
> Hmm... I have carefully written the stuff step by step:
> 1. separate @requests from threads to each single thread
> 2. separate @completion from threads
> 3. use batch mode
> 4. separate bitmaps from threads
> 5. revert batch mode based on step 4
> 6. compare them with directly using Emilio's patches.
> 
> The big different between my modification and Emilio's patches is
> that i still make per-thread-data be attached in the end of
> @Threads.
>
> I got these performance data:
> 	https://ibb.co/kcLnLL
> 
> Indeed, i can almost reproduce your conclusion. The confused part
> is batch -  I used 16G memory to do the benchmark, the batch improved
> nothing, I guess all the threads keep busy under this case anyway.

I wouldn't worry too much about it, then. The machine I ran my tests
on is rather old, so it's possible that cross-core/socket communication
is much slower there than on your machine, which makes batching
more attractive. At the end of the day, the measurements you take on
the machines you care about are what matter =)

> > I have pushed the above changes, along with some minor fixes (e.g.
> > removing the Threads.name field) here:
> > 
> >    https://github.com/cota/qemu/tree/xiao
> > 
> > Note that the 0-len variable goes away, and that Threads become
> > read-only. I also use padding to make sure the events are in
> > separate cache lines.
> > 
> > Feel free to incorporate whatever you see fit from that branch into
> > a subsequent iteraiton.
> 
> Nice, I will add you to the author list if you do not object. :)

That's not necessary. You deserve the full credit -- I just reviewed
the code ;-)

Thanks,

		Emilio
