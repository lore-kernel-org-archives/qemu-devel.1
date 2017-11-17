Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFd47-0007OA-0e
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFd43-0005Et-TR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFd43-0005DT-Mq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:35:59 -0500
Date: Fri, 17 Nov 2017 10:35:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171117093556.ntseydf7eiboeyww@sirius.home.kraxel.org>
References: <20171116075155.22378-1-ppandit@redhat.com>
	<658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] ps2: check PS2Queue pointers in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

> > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > index f388a23c8e..de171a28dd 100644
> > --- a/hw/input/ps2.c
> > +++ b/hw/input/ps2.c
> > @@ -1225,24 +1225,21 @@ static void ps2_common_reset(PS2State *s)
> >  static void ps2_common_post_load(PS2State *s)
> >  {
> >      PS2Queue *q = &s->queue;
> > -    int size;
> > -    int i;
> > -    int tmp_data[PS2_QUEUE_SIZE];
> > +    uint8_t i, size;
> > +    uint8_t tmp_data[PS2_QUEUE_SIZE];
> 
> Hi Prasad,
> 
> you don't need to change the invalid values to sane ones.  Instead, make
> ps2_common_post_load return an int (just like the .post_load member of
> VMStateDescription).  You can then detect out of range count/rptr/wptr
> and return -1 for bad indices.

Well, it's not that simple because older qemu versions had larger
queues.  So post_load accepts migrations with queues which are too big.
It just clears the queue in that case, so the input events are dropped
in that (highly unlikely) case.

Also note that the current post_load is broken.  tmp_data is int whereas
q->data is uint8_t.  So ...

> > -        memcpy(q->data, tmp_data, size);

... this memcpy doesn't work as intended.  Nobody noticed in years.

v1 fixes this bug, v2 doesn't.

So, I'm tempted to just rip out the whole backward compatibility buffer
shuffling logic.  Or take v1 of this patch.

cheers,
  Gerd
