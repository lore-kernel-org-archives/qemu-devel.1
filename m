Received: from eggs.gnu.org ([209.51.188.92]:32958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpAti-0002wj-Hu
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpAth-00012b-Em
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:52:46 -0500
Date: Thu, 31 Jan 2019 12:52:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190131125220.285a4bc8.cohuck@redhat.com>
In-Reply-To: <20190130195127.5ff3c849@oc2783563651>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 30 Jan 2019 19:51:27 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 30 Jan 2019 14:22:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.  
> 
> I read this like it is supposed to be safe regardless of
> parallelism and threads. However I don't see any explicit
> synchronization done for cp->initialized.
> 
> I've managed to figure out how is that supposed to be safe
> for the cp_free() (which is probably our main concern) in
> vfio_ccw_sch_io_todo(), but if fail when it comes to the one
> in vfio_ccw_mdev_notifier().
> 
> Can you explain us how does the synchronization work?

You read that wrong, I don't add synchronization, I just add a check.
