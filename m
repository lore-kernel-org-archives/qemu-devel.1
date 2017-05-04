Received: from eggs.gnu.org ([2001:4830:134:3::10]:60436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FxV-0003R8-BP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FxP-0005oa-DV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:34:13 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37872)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FxP-0005nj-5Q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:34:07 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
	<b365904f-21ae-85a7-a3a6-bbe21c62e35a@redhat.com>
	<000401d2c4c7$6d5b6d50$481247f0$@ru>
	<b44f8aa8-e42f-4b94-ccfa-d80adb60de35@redhat.com>
	<000801d2c4cd$3d3af720$b7b0e560$@ru>
	<58398574-88b5-3382-65e2-7208beccc09a@redhat.com>
	<000f01d2c4cf$7479f630$5d6de290$@ru>
	<c6f5e430-fa98-124f-146b-6c3de79448cd@redhat.com>
In-Reply-To: <c6f5e430-fa98-124f-146b-6c3de79448cd@redhat.com>
Date: Thu, 4 May 2017 15:34:10 +0300
Message-ID: <001101d2c4d2$bb44a4e0$31cdeea0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 06/10] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 04/05/2017 14:10, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 04/05/2017 13:54, Pavel Dovgalyuk wrote:
> >>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >>>> On 04/05/2017 13:13, Pavel Dovgalyuk wrote:
> >>>>>>> This patch does not allows saving/loading vmstate when
> >>>>>>> replay events queue is not empty. There is no reliable
> >>>>>>> way to save events queue, because it describes internal
> >>>>>>> coroutine state. Therefore saving and loading operations
> >>>>>>> should be deferred to another record/replay step.
> >>>>>>
> >>>>>> Can it actually be non-empty after bdrv_drain_all?
> >>>>>
> >>>>> drain/flush cannot succeed, because started requests are
> >>>>> prisoned in the replay events queue.
> >>>>
> >>>> But that would apply to loading only.  Saving should still be always
> >>>> possible.
> >>>
> >>> We can save it. But it wouldn't load correctly - replay queue will be empty after loading.
> >>
> >> When saving you can drain, and then the events queue should be empty.
> >> Or I am misunderstanding how it works, which is possible too.
> >
> > Drain will wait until the queue becomes empty.
> > Queue is processed only at checkpoints.
> > Checkpoints are met in iothread (at timers processing and so on).
> > But iothread is waiting for finishing the drain.
> 
> What checkpoint can hang the drain during a save?

No one. There are no checkpoins during vmsave and during drain.
Therefore the queue will never become empty.

Pavel Dovgalyuk
