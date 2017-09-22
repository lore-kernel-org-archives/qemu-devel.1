Received: from eggs.gnu.org ([2001:4830:134:3::10]:50988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvL1i-0005LO-7S
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvL1e-0004xP-TP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dvL1e-0004wi-KU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDA67806D1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:17:37 +0000 (UTC)
Date: Fri, 22 Sep 2017 11:17:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170922101728.GJ12725@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922090433.GC12725@redhat.com>
	<20170922091430.GJ30661@pxdev.xzpeter.org>
	<20170922093631.GG12725@redhat.com>
	<4760b1a1-446d-fc2c-8794-8860bededc56@redhat.com>
	<20170922094325.GH12725@redhat.com>
	<d0992b81-d5d0-6957-d292-52be50a21ec7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0992b81-d5d0-6957-d292-52be50a21ec7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 22, 2017 at 12:14:04PM +0200, Paolo Bonzini wrote:
> On 22/09/2017 11:43, Daniel P. Berrange wrote:
> > On Fri, Sep 22, 2017 at 11:38:31AM +0200, Paolo Bonzini wrote:
> >> On 22/09/2017 11:36, Daniel P. Berrange wrote:
> >>> On Fri, Sep 22, 2017 at 05:14:30PM +0800, Peter Xu wrote:
> >>>> On Fri, Sep 22, 2017 at 10:04:33AM +0100, Daniel P. Berrange wrote:
> >>>>> On Fri, Sep 22, 2017 at 04:56:10PM +0800, Peter Xu wrote:
> >>>>>> IOThread is a general framework that contains IO loop environment and a
> >>>>>> real thread behind.  It's also good to be used internally inside qemu.
> >>>>>> Provide some helpers for it to create iothreads to be used internally.
> >>>>>>
> >>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>>>>> ---
> >>>>>>  include/sysemu/iothread.h |  8 ++++++++
> >>>>>>  iothread.c                | 21 +++++++++++++++++++++
> >>>>>>  2 files changed, 29 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> >>>>>> index d2985b3..b07663f 100644
> >>>>>> --- a/include/sysemu/iothread.h
> >>>>>> +++ b/include/sysemu/iothread.h
> >>>>>> @@ -46,4 +46,12 @@ AioContext *iothread_get_aio_context(IOThread *iothread);
> >>>>>>  void iothread_stop_all(void);
> >>>>>>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >>>>>>  
> >>>>>> +/*
> >>>>>> + * Helpers used to allocate iothreads for internal use.  These
> >>>>>> + * iothreads will not be seen by monitor clients when query using
> >>>>>> + * "query-iothreads".
> >>>>>> + */
> >>>>>> +IOThread *iothread_create(const char *id, Error **errp);
> >>>>>> +void iothread_destroy(IOThread *iothread);
> >>>>>> +
> >>>>>>  #endif /* IOTHREAD_H */
> >>>>>> diff --git a/iothread.c b/iothread.c
> >>>>>> index 44c8944..74e400c 100644
> >>>>>> --- a/iothread.c
> >>>>>> +++ b/iothread.c
> >>>>>> @@ -354,3 +354,24 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
> >>>>>>  
> >>>>>>      return iothread->worker_context;
> >>>>>>  }
> >>>>>> +
> >>>>>> +static Object *iothread_get_internal_parent(void)
> >>>>>> +{
> >>>>>> +    return container_get(object_get_root(), "/internal-iothreads");
> >>>>>> +}
> >>>>>
> >>>>> I tend to think we might benefit from having this generalized in the
> >>>>> QOM API instead. We have object_get_objects_root() for things that
> >>>>> are created by the mgmt app / user via CLI / QMP.  A parallel method
> >>>>> object_get_internal_root() could be useful for cases like this where
> >>>>> we want to create user-creatable objects, but not have them be
> >>>>> visible to the mgmt app / user, as that would confuse the mgmt app.
> >>>>>
> >>>>> Example for this scenario - libvirt calls query-iothreads to identify
> >>>>> IO thread PIDs, and would get very unhappy if the IOThread used by
> >>>>> the monitor would appear in that response, which is why Peter has
> >>>>> put it under /internal-iothreads. I think this scenario will apply
> >>>>> more broadly, so benefit from us having a general helper in QOM.
> >>>>
> >>>> Yeah, I can split the patch if we want it to be exposed to public.
> >>>>
> >>>> In that case, would the name "object_get_internal_root" be good?
> >>>
> >>> Yeah that's fine with me, but lets see if Paolo has any thoughts from
> >>> the QOM side.
> >>
> >> No, I don't.  However, I wonder if query-iothreads should have an
> >> argument to include internal iothreads.
> > 
> > I guess it depends whether we consider use of iothreads for migration
> > to be a private impl detail that may be ripped out & replaced at any
> > time, or a semi-public detail that apps may rely on.  Personally I
> > would suggest it should be a private impl detail of migration code
> > that is never exposed to anything outside QEMU, so we have flexibility
> > to change it at will later.
> 
> As far as I understood it's not migration, it's the whole monitor that
> moves to the iothread.  So it's a thing that lasts for the whole
> existence of the QEMU process.  But I may be wrong.

Sorry yes, my bad - its the iothread behind the monitor. I still think that
is a detail worth keeping private in case we want to refactor how the
monitor threading works later.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
