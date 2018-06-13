Received: from eggs.gnu.org ([2001:4830:134:3::10]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0eN-0001RY-Ku
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0eK-00085N-IM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:57:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fT0eK-00084n-D5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:57:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-2-peterx@redhat.com>
	<20180529113000.1ee70ef4.cohuck@redhat.com>
	<20180530033045.GC25245@xz-mi>
	<20180530153600.63f16405.cohuck@redhat.com>
Date: Wed, 13 Jun 2018 09:56:53 +0200
In-Reply-To: <20180530153600.63f16405.cohuck@redhat.com> (Cornelia Huck's
	message of "Wed, 30 May 2018 15:36:00 +0200")
Message-ID: <8736xrm856.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>

Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 30 May 2018 11:30:45 +0800
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Tue, May 29, 2018 at 11:30:00AM +0200, Cornelia Huck wrote:
>> > On Thu, 24 May 2018 12:44:53 +0800
>> > Peter Xu <peterx@redhat.com> wrote:
>> >   
>> > > There are many error_report()s that can be used in frequently called
>> > > functions, especially on IO paths.  That can be unideal in that
>> > > malicious guest can try to trigger the error tons of time which might
>> > > use up the log space on the host (e.g., libvirt can capture the stderr
>> > > of QEMU and put it persistently onto disk).  In VT-d emulation code, we
>> > > have trace_vtd_error() tracer.  AFAIU all those places can be replaced
>> > > by something like error_report() but trace points are mostly used to
>> > > avoid the DDOS attack that mentioned above.  However using trace points
>> > > mean that errors are not dumped if trace not enabled.
>> > > 
>> > > It's not a big deal in most modern server managements since we have
>> > > things like logrotate to maintain the logs and make sure the quota is
>> > > expected.  However it'll still be nice that we just provide another way
>> > > to restrict message generations.  In most cases, this kind of
>> > > error_report()s will only provide valid information on the first message
>> > > sent, and all the rest of similar messages will be mostly talking about
>> > > the same thing.  This patch introduces *_report_once() helpers to allow
>> > > a message to be dumped only once during one QEMU process's life cycle.
>> > > It will make sure: (1) it's on by deffault, so we can even get something
>> > > without turning the trace on and reproducing, and (2) it won't be
>> > > affected by DDOS attack.  
>> > 
>> > This is good for something (sub-)system wide, where it is enough to
>> > alert the user once; but we may want to print something e.g. once per
>> > the device where it happens (see v3 of "vfio-ccw: add force unlimited
>> > prefetch property" for an example).  
>> 
>> I'm glad that we start to have more users of it, no matter which
>> implementation we'll choose.  At least it means it makes some sense to
>> have such a thing.
>> 
>> For me this patch works nicely enough.  Of course there can be
>> per-device errors, but AFAICT mostly we don't have any error at
>> all... and my debugging experience is that when multiple error happens
>> on different devices simutaneously, they'll very possible that it's
>> caused by the same problem (again, errors are rare after all), or, the
>> rest of the problems are caused by the first error only (so the first
>> error might cause a collapse of the rest).  That's why I wanted to
>> always debug with the first error I encounter, because that's mostly
>> always the root cause. In that sense, current patch works nicely for
>> me (note that we can have device ID embeded in the error message with
>> this one).
>
> I think we have slightly different use cases here. In your case,
> something (an error) happened and you don't really care about any
> subsequent messages. In the vfio-ccw case, we want to log when a guest
> tries to do things on a certain device, so we can possibly throw a
> magic switch for that device. We still want messages after that so we
> can catch further devices for which we may want to throw the magic
> switch. (Similar for the other message, we want to give a hint why a
> certain device may not work as expected.)
>
>> 
>> At the same time, I think this patch should be easier to use of course
>> - no extra variables to define, and very self contained. So I would
>> slightly prefer current patch.
>> 
>> However I'm also fine with the approach proposed in the vfio-ccw patch
>> too.  Though if so I would possibly drop the 2nd patch too since if
>> with the vfio-ccw patch I'll need to introduce one bool for every
>> trace_vtd_err() place... then I'd not bother with it any more but
>> instead live with that trace_*(). ;) Or I can define one per-IOMMU
>> error boolean and pass it in for each of the error_report_once(), but
>> it seems a bit awkward too.
>
> I think we can have both the fine-grained control and convenience
> macros for those cases where we really just want to print a message
> once.

Yes.  Cornelia, feel free to post a followup patch that satisfies your
needs.

>> 
>> >   
>> > > 
>> > > To implement it, I stole the printk_once() macro from Linux.  
>> > 
>> > Would something akin to printk_ratelimited() also make sense to avoid
>> > log flooding?  
>> 
>> Yes it will.  IMHO we can have that too as follow up if we want, and
>> it does not conflict with this print_once().  I'd say currently this
>> error_report_once() is good enough for me, especially lightweighted.
>> I suspect we'll need more lines to implement a ratelimited version.
>
> Yes, and I agree that wants to be a separate patch should we find a use
> case for it.

Yes.
