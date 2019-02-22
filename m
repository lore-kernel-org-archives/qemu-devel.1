Received: from eggs.gnu.org ([209.51.188.92]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gx4DP-0004h3-Lr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gx4DO-0006PR-Nj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:21:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gx4DO-00061B-7s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:21:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so1396136qtz.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:21:19 -0800 (PST)
Date: Fri, 22 Feb 2019 01:21:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190222011631-mutt-send-email-mst@kernel.org>
References: <20190218102748.2242-1-xieyongji@baidu.com>
	<20190218102748.2242-2-xieyongji@baidu.com>
	<20190221120121-mutt-send-email-mst@kernel.org>
	<CAONzpcYHae1fCJLN56ofQ91tSQi_JCXAA6mBhf0NqN=QusV1zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcYHae1fCJLN56ofQ91tSQi_JCXAA6mBhf0NqN=QusV1zg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/7] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, Feb 22, 2019 at 10:47:03AM +0800, Yongji Xie wrote:
> > > +
> > > +To track inflight I/O, the queue region should be processed as follows:
> > > +
> > > +When receiving available buffers from the driver:
> > > +
> > > +    1. Get the next available head-descriptor index from available ring, i
> > > +
> > > +    2. Set desc[i].inflight to 1
> > > +
> > > +When supplying used buffers to the driver:
> > > +
> > > +    1. Get corresponding used head-descriptor index, i
> > > +
> > > +    2. Set desc[i].next to process_head
> > > +
> > > +    3. Set process_head to i
> > > +
> > > +    4. Steps 1,2,3 may be performed repeatedly if batching is possible
> > > +
> > > +    5. Increase the idx value of used ring by the size of the batch
> > > +
> > > +    6. Set the inflight field of each DescStateSplit entry in the batch to 0
> > > +
> > > +    7. Set used_idx to the idx value of used ring
> > > +
> > > +When reconnecting:
> > > +
> > > +    1. If the value of used_idx does not match the idx value of used ring,
> > > +
> > > +        (a) Subtract the value of used_idx from the idx value of used ring to get
> > > +        the number of in-progress DescStateSplit entries
> > > +
> > > +        (b) Set the inflight field of the in-progress DescStateSplit entries which
> > > +        start from process_head to 0
> > > +
> > > +        (c) Set used_idx to the idx value of used ring
> > > +
> > > +    2. Resubmit each inflight DescStateSplit entry
> >
> > I re-read a couple of time and I still don't understand what it says.
> >
> > For simplicity consider split ring. So we want a list of heads that are
> > outstanding. Fair enough. Now device finishes a head. What now? I needs
> > to drop head from the list. But list is unidirectional (just next, no
> > prev). So how can you drop an entry from the middle?
> >
> 
> The process_head is only used when slave crash between increasing the
> idx value of used ring and updating used_idx. We use it to find the
> in-progress DescStateSplit entries before the crash and complete them
> when reconnecting. Make sure guest and slave have the same view for
> inflight I/Os.
> 

But I don't understand how does the described process help do it?


> In other case, the inflight field is enough to track inflight I/O.
> When reconnecting, we go through all DescStateSplit entries and
> re-submit the entry whose inflight field is equal to 1.

What I don't understand is how do we know the order
in which they have to be resubmitted. Reordering
operations would be a big problem, won't it?


Let's say I fetch descriptors A, B, C and start
processing. how does memory look?
Now I finished B and marked it used. How does
memory look?

I also wonder how do you address a crash between
marking descriptor used and clearing inflight.
Will you redo the descriptor? Is it always safe?
What if it's a write?
