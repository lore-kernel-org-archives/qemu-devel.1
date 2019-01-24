Received: from eggs.gnu.org ([209.51.188.92]:57077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmdRx-0003iD-G0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmdRu-0001sR-1V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:45:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40326
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gmdRp-0001TB-Jy
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:45:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OBi5HW057339
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:45:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q7bh5c5ej-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:45:24 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 24 Jan 2019 11:45:23 -0000
Date: Thu, 24 Jan 2019 12:45:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190124111934.72e7f0f1.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
	<20190123112112.7822b237.cohuck@redhat.com>
	<42264dd9-86d7-8994-8c25-bc688067725d@linux.ibm.com>
	<20190124111934.72e7f0f1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190124124517.4023a3cc@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 24 Jan 2019 11:19:34 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 24 Jan 2019 11:08:02 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > On 23/01/2019 11:21, Cornelia Huck wrote:
> > > On Tue, 22 Jan 2019 19:33:46 +0100
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >   
> > >> On Mon, 21 Jan 2019 12:03:51 +0100
> > >> Cornelia Huck <cohuck@redhat.com> wrote:
> > >>  
> > >>> --- a/drivers/s390/cio/vfio_ccw_private.h
> > >>> +++ b/drivers/s390/cio/vfio_ccw_private.h
> > >>> @@ -28,6 +28,7 @@
> > >>>    * @mdev: pointer to the mediated device
> > >>>    * @nb: notifier for vfio events
> > >>>    * @io_region: MMIO region to input/output I/O arguments/results
> > >>> + * @io_mutex: protect against concurrent update of I/O structures  
> > >>
> > >> We could be a bit more specific about what does this mutex guard.
> > >> Is it only io_region, or cp, irb and the new regions a well? ->state does
> > >> not seem to be covered, but should need some sort of synchronisation
> > >> too, or?  
> > > 
> > > I'm not sure. IIRC Pierre had some ideas about locking in the fsm?
> > >   
> > 
> > Yes I postponed this work to not collide with your patch series.
> > 
> > Do you think I should provide a new version of the FSM reworking series 
> > based on the last comment I got?
> > 
> > I would take into account that the asynchronous commands will come with 
> > your patch series and only provide the framework changes.
> 
> This was more an answer to Halil's concerns around state
> synchronization. I would prefer to first get this series (or a
> variation) into decent shape, and then address state machine handling
> on top of that (when we know more about the transitions involved), just
> to avoid confusion.
> 
> Does that sound reasonable?
> 

I would like the two hitting the same kernel release. In that case I'm
fine with deferring some of the concurrency fixes after the csch/hsch
stuff. Otherwise I would have a bad feeling about increasing the
complexity without fixing known bugs.

Regards,
Halil
