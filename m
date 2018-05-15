Received: from eggs.gnu.org ([2001:4830:134:3::10]:37556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIVNt-0007bU-Qs
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIVNp-0000Ns-6P
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:32:37 -0400
Date: Tue, 15 May 2018 10:32:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180515103229.6684fbe9.cohuck@redhat.com>
In-Reply-To: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio-ccw.c vs larger VIRTIO_QUEUE_MAX (coverity
 warning CID 1390619)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, qemu-s390x@nongnu.org

On Mon, 14 May 2018 19:12:27 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Hi; Coverity has I think enabled a new warning recently, which
> is triggering on virtio_ccw_notify() in hw/s390x/virtio-ccw.c
> (CID 1390619).
> 
> This function does
>     indicators |= 1ULL << vector;
> but the code is guarded only by
>     if (vector < VIRTIO_QUEUE_MAX) {
> 
> That used to be OK when VIRTIO_QUEUE_MAX was 64, but in
> commit b829c2a98f1 it was raised to 1024, and this is no longer
> a useful guard. The commit message for b829c2a98f1 suggests that
> this is a "can't happen" case -- is that so? 

That is outdated; we bumped max virtqueues for ccw in b1914b824ade.

> If so then the
> else {} part of the code and an earlier check on
> "if (vector >= VIRTIO_QUEUE_MAX + 64)" are dead code.
> However it looks like the device_plugged method is also
> checking VIRTIO_QUEUE_MAX, rather than 64.
> 
> If this is a false positive, then an assert() in
> virtio_ccw_notify() and cleaning up the dead code would
> help placate coverity.

It is a false positive as far as I can see; this is the notification
code for classical interrupts, and we fence off more than 64 virtqueues
already when the guest tries to set it up (introduced in 797b608638c5).
As that code flow is basically impossible to deduce by a static code
checker, adding an assert() seems like a good idea. Halil, what do you
think?

> 
> (Other odd code in that function:
>     vector = 0;
>     [...]
>     indicators |= 1ULL << vector;
> is that really supposed to ignore the input vector number?)

Yes; this as a configuration change notification done via secondary
indicators (different from either the classical indicators or the
adapter interrupt indicators). We always set the same bit, and it is
always triggered by doing a notification with a number one above the
maximum possible virtqueue number. (I agree that it does look odd, we
should maybe add a comment.)
