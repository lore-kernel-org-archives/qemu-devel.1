Received: from eggs.gnu.org ([209.51.188.92]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gxokf-0003Bu-Ac
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gxokd-0008Uv-4v
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 03:03:08 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gxokb-0008Q6-6G
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 03:03:07 -0500
Received: by mail-qt1-x842.google.com with SMTP id a48so7266419qtb.4
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 00:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20190218102748.2242-1-xieyongji@baidu.com>
	<20190218102748.2242-2-xieyongji@baidu.com>
	<20190221120121-mutt-send-email-mst@kernel.org>
	<CAONzpcYHae1fCJLN56ofQ91tSQi_JCXAA6mBhf0NqN=QusV1zg@mail.gmail.com>
	<20190222011631-mutt-send-email-mst@kernel.org>
	<CAONzpcaxS3ct5bx62126SMiowcZ2mApnYomwXkHg0R67SvoQBg@mail.gmail.com>
	<20190222095009-mutt-send-email-mst@kernel.org>
	<CAONzpcZ_4e5xYonBhXinkQC8E5UCsko3iLY8_8ykaVwdU0Aa4Q@mail.gmail.com>
	<20190223191037-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190223191037-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Sun, 24 Feb 2019 16:02:42 +0800
Message-ID: <CAONzpcbBkiN6CePxDPjEK4rv_K04UeCWcm1QFQCw_PdamwUAxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Sun, 24 Feb 2019 at 08:14, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Feb 23, 2019 at 09:10:01PM +0800, Yongji Xie wrote:
> > On Fri, 22 Feb 2019 at 22:54, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Feb 22, 2019 at 03:05:23PM +0800, Yongji Xie wrote:
> > > > On Fri, 22 Feb 2019 at 14:21, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Fri, Feb 22, 2019 at 10:47:03AM +0800, Yongji Xie wrote:
> > > > > > > > +
> > > > > > > > +To track inflight I/O, the queue region should be processed as follows:
> > > > > > > > +
> > > > > > > > +When receiving available buffers from the driver:
> > > > > > > > +
> > > > > > > > +    1. Get the next available head-descriptor index from available ring, i
> > > > > > > > +
> > > > > > > > +    2. Set desc[i].inflight to 1
> > > > > > > > +
> > > > > > > > +When supplying used buffers to the driver:
> > > > > > > > +
> > > > > > > > +    1. Get corresponding used head-descriptor index, i
> > > > > > > > +
> > > > > > > > +    2. Set desc[i].next to process_head
> > > > > > > > +
> > > > > > > > +    3. Set process_head to i
> > > > > > > > +
> > > > > > > > +    4. Steps 1,2,3 may be performed repeatedly if batching is possible
> > > > > > > > +
> > > > > > > > +    5. Increase the idx value of used ring by the size of the batch
> > > > > > > > +
> > > > > > > > +    6. Set the inflight field of each DescStateSplit entry in the batch to 0
> > > > > > > > +
> > > > > > > > +    7. Set used_idx to the idx value of used ring
> > > > > > > > +
> > > > > > > > +When reconnecting:
> > > > > > > > +
> > > > > > > > +    1. If the value of used_idx does not match the idx value of used ring,
> > > > > > > > +
> > > > > > > > +        (a) Subtract the value of used_idx from the idx value of used ring to get
> > > > > > > > +        the number of in-progress DescStateSplit entries
> > > > > > > > +
> > > > > > > > +        (b) Set the inflight field of the in-progress DescStateSplit entries which
> > > > > > > > +        start from process_head to 0
> > > > > > > > +
> > > > > > > > +        (c) Set used_idx to the idx value of used ring
> > > > > > > > +
> > > > > > > > +    2. Resubmit each inflight DescStateSplit entry
> > > > > > >
> > > > > > > I re-read a couple of time and I still don't understand what it says.
> > > > > > >
> > > > > > > For simplicity consider split ring. So we want a list of heads that are
> > > > > > > outstanding. Fair enough. Now device finishes a head. What now? I needs
> > > > > > > to drop head from the list. But list is unidirectional (just next, no
> > > > > > > prev). So how can you drop an entry from the middle?
> > > > > > >
> > > > > >
> > > > > > The process_head is only used when slave crash between increasing the
> > > > > > idx value of used ring and updating used_idx. We use it to find the
> > > > > > in-progress DescStateSplit entries before the crash and complete them
> > > > > > when reconnecting. Make sure guest and slave have the same view for
> > > > > > inflight I/Os.
> > > > > >
> > > > >
> > > > > But I don't understand how does the described process help do it?
> > > > >
> > > >
> > > > For example, we need to submit descriptors A, B, C to driver in a batch.
> > > >
> > > > Firstly, we will link those descriptors like:
> > > >
> > > > process_head->A->B->C    (A)
> > > >
> > > > Then, we need to update idx value of used vring to mark those
> > > > descriptors as used:
> > > >
> > > > _vring.used->idx += 3    (B)
> > > >
> > > > At last, clear the inflight field of those descriptors and update
> > > > used_idx field:
> > > >
> > > > A.inflight = 0; B.inflight = 0; C.inflight = 0;    (C)
> > > >
> > > > used_idx = _vring.used->idx;    (D)
> > > >
> > > > After (B), guest can consume the descriptors A,B,C. So we must make
> > > > sure the inflight field of A,B,C is cleared when reconnecting to avoid
> > > > re-submitting used descriptor. If slave crash during (C), the inflight
> > > > field of A,B,C may be incorrect. To detect that case, we can see
> > > > whether used_idx matches _vring.used->idx. And through process_head,
> > > > we can get the in-progress descriptors A,B,C and clear their inflight
> > > > field again when reconnecting.
> > > >
> > > > >
> > > > > > In other case, the inflight field is enough to track inflight I/O.
> > > > > > When reconnecting, we go through all DescStateSplit entries and
> > > > > > re-submit the entry whose inflight field is equal to 1.
> > > > >
> > > > > What I don't understand is how do we know the order
> > > > > in which they have to be resubmitted. Reordering
> > > > > operations would be a big problem, won't it?
> > > > >
> > > >
> > > > In previous patch, I record avail_idx for each DescStateSplit entry to
> > > > preserve the order. Is it useful to fix this?
> > > >
> > > > >
> > > > > Let's say I fetch descriptors A, B, C and start
> > > > > processing. how does memory look?
> > > >
> > > > A.inflight = 1, C.inflight = 1, B.inflight = 1
> > > >
> > > > > Now I finished B and marked it used. How does
> > > > > memory look?
> > > > >
> > > >
> > > > A.inflight = 1, C.inflight = 1, B.inflight = 0, process_head = B
> > >
> > > OK. And we have
> > >
> > > process_head->B->process_head
> > >
> > > ?
> > >
> > > Now if there is a reconnect, I want to submit A and then C,
> > > correct? How do I know that from this picture? How do I
> > > know to start with A? It's not on the list anymore...
> > >
> >
> > We can go through all DescStateSplit entries (track all descriptors in
> > Descriptor Table), then we can find A and C are inflight entry by its
> > inflight field. And if we want to resubmit them in order (submit A and
> > then C), we need to introduce a timestamp for each DescStateSplit
> > entry to preserve the order when we fetch them from driver. Something
> > like:
> >
> > When receiving available buffers from the driver:
> >
> > 1. Get the next available head-descriptor index from available ring, i
> >
> > 2. desc[i].timestamp = avail_idx++;
> >
> > 3. Set desc[i].inflight to 1
> >
> > Thanks,
> > Yongji
>
> OK I guess a 64 bit counter would be fine for that.
>
> In order seems critical for storage right?
> Reordering write would seem to lead to data corruption.
>

Actually I'm not sure. If we care about the order, we should not do
access to one block until another access to the same block is
completed?

> But now I don't understand what does the next
> field do. So it so you can maintain a freelist
> within a statically allocated array?
>

Yes, we can use it to maintain a list. The head of the list is
process_head. This list is only used when we want to submit
descriptors in a batch. All descriptors in this batch are linked to
the list. Then if we crash between marking those descriptors used and
clearing their inflight field. We need to find those in-progress
descriptors. The list will be helpful to achieve that. If no batch for
submitting, the next field can be removed.

Thanks,
Yongji
