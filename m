Received: from eggs.gnu.org ([2001:4830:134:3::10]:52824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cku3z-0000hk-Tq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cku3w-0001qH-RZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:56:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cku3w-0001pa-H6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:56:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26ErrIP070969
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:56:34 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 290u3j4p21-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 09:56:34 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 6 Mar 2017 14:56:31 -0000
Date: Mon, 6 Mar 2017 15:56:25 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <d00802cc-150a-2263-604d-9c2eaa5c19d1@linux.vnet.ibm.com>
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
	<20170303132149.34e5906a.cornelia.huck@de.ibm.com>
	<aa9b9219-f3a6-165c-2d92-156a9295adbb@linux.vnet.ibm.com>
	<20170303135012.17edb640.cornelia.huck@de.ibm.com>
	<d00802cc-150a-2263-604d-9c2eaa5c19d1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170306155625.5c426793.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 3 Mar 2017 14:08:37 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 03/03/2017 01:50 PM, Cornelia Huck wrote:
> > On Fri, 3 Mar 2017 13:43:32 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> >> On 03/03/2017 01:21 PM, Cornelia Huck wrote:
> >>> On Thu,  2 Mar 2017 19:59:42 +0100
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>
> >>>> The function virtio_notify_irqfd used to ignore the return code of
> >>>> event_notifier_set. Let's fail the device should this occur.
> >>>
> >>> I'm wondering if there are reasons for event_notifier_set() to fail
> >>> beyond "we've hit an internal race and should make an effort to fix
> >>> that one, or else we have completely messed up in qemu". Marking the
> >>> device broken tells the guest that there's something wrong with the
> >>> device, but I think we want qemu bug reports when there's something
> >>> broken with the irqfd.
> >>>
> >>
> >> That's why the error is logged. I understand virtio_error like something
> >> suitable for indicating bugs.
> >>
> >> What do you suggest? Forcing a dump? I would rather leave it to the
> >> user to figure out how important is the state sitting in the machine
> >> and the device, and how much effort does (s)he want to put into recovering
> >> from the failure. 
> > 
> > How likely are those logged messages being brought to attention of the
> > admin? Does any management software flag machines with such error
> > messages? (that's more of a general question)
> > 
> 
> I admit, I did not investigate this thoroughly, also because the patch
> is flawed regarding multi-thread anyway. After a quick investigation
> it seems the linux guest won't auto-reset the device so the guest should
> end up with a not working device. I think it's pretty likely that the
> admin will check the logs if the device was important.

Thinking a bit more about this, it seems setting the device broken is
not the right solution for exactly that reason. Setting the virtio
device broken is a way to signal the guest to 'you did something
broken; please reset the device and start anew' (and that's how current
callers use it). In our case, this is not the guest's fault.

Maybe go back to the assert 'solution'? But I'm not sure that's enough
if production builds disable asserts...

> 
> I agree fully that it's a very general question, and I do not feel
> competent for answering it.
> 
> > I'd like to have some kind of trigger that rings an alarm bell so that
> > the admin might consider reporting this, but I don't have a good idea
> > on how to do that either...
> > 
> 
> There are tools for aggregating and processing logs, and triggering
> alarm bells too (for example ELK= logstash + Kibana + Elasticsearch).
> AFAIK logs are the most common way to deal with such stuff. But I'm far
> form being an expert. Of course logs are only as good as the messages
> landing in them...

Let's hope this works properly, then.
