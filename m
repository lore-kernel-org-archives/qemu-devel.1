Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62750C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FE12133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FE12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFlP-0003UY-Kh
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iFFiu-0002T9-GI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iFFir-0006IJ-0c
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iFFiq-0006H0-Ne
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:49:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5FCE81F31;
 Tue,  1 Oct 2019 10:49:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3968C1001B08;
 Tue,  1 Oct 2019 10:49:34 +0000 (UTC)
Date: Tue, 1 Oct 2019 11:49:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: Thoughts on VM fence infrastructure
Message-ID: <20191001104931.GG26133@redhat.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 01 Oct 2019 10:49:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Aditya Ramesh <aramesh@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 07:23:47PM +0000, Felipe Franciosi wrote:
> 
> 
> > On Sep 30, 2019, at 6:59 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > 
> > * Felipe Franciosi (felipe@nutanix.com) wrote:
> >> 
> >> 
> >>> On Sep 30, 2019, at 6:11 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>> 
> >>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>> 
> >>>> 
> >>>>> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>>>> 
> >>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>>>> Hi David,
> >>>>>> 
> >>>>>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>>>>>> 
> >>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>>>>>> Heyall,
> >>>>>>>> 
> >>>>>>>> We have a use case where a host should self-fence (and all VMs should
> >>>>>>>> die) if it doesn't hear back from a heartbeat within a certain time
> >>>>>>>> period. Lots of ideas were floated around where libvirt could take
> >>>>>>>> care of killing VMs or a separate service could do it. The concern
> >>>>>>>> with those is that various failures could lead to _those_ services
> >>>>>>>> being unavailable and the fencing wouldn't be enforced as it should.
> >>>>>>>> 
> >>>>>>>> Ultimately, it feels like Qemu should be responsible for this
> >>>>>>>> heartbeat and exit (or execute a custom callback) on timeout.
> >>>>>>> 
> >>>>>>> It doesn't feel doing it inside qemu would be any safer;  something
> >>>>>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
> >>>>>> 
> >>>>>> The argument above is that we would have to rely on this external
> >>>>>> service being functional. Consider the case where the host is
> >>>>>> dysfunctional, with this service perhaps crashed and a corrupt
> >>>>>> filesystem preventing it from restarting. The VMs would never die.
> >>>>> 
> >>>>> Yeh that could fail.
> >>>>> 
> >>>>>> It feels like a Qemu timer-driven heartbeat check and calls abort() /
> >>>>>> exit() would be more reliable. Thoughts?
> >>>>> 
> >>>>> OK, yes; perhaps using a timer_create and telling it to send a fatal
> >>>>> signal is pretty solid; it would take the kernel to do that once it's
> >>>>> set.
> >>>> 
> >>>> I'm confused about why the kernel needs to be involved. If this is a
> >>>> timer off the Qemu main loop, it can just check on the heartbeat
> >>>> condition (which should be customisable) and call abort() if that's
> >>>> not satisfied. If you agree on that I'd like to talk about how that
> >>>> check could be made customisable.
> >>> 
> >>> There are times when the main loop can get blocked even though the CPU
> >>> threads can be running and can in some configurations perform IO
> >>> even without the main loop (I think!).
> >> 
> >> Ah, that's a very good point. Indeed, you can perform IO in those
> >> cases specially when using vhost devices.
> >> 
> >>> By setting a timer in the kernel that sends a signal to qemu, the kernel
> >>> will send that signal however broken qemu is.
> >> 
> >> Got you now. That's probably better. Do you reckon a signal is
> >> preferable over SIGEV_THREAD?
> > 
> > Not sure; probably the safest is getting the kernel to SIGKILL it - but
> > that's a complete nightmare to debug - your process just goes *pop*
> > with no apparent reason why.
> > I've not used SIGEV_THREAD - it looks promising though.
> 
> I'm worried that SIGEV_THREAD could be a bit heavyweight (if it fires
> up a new thread each time). On the other hand, as you said, SIGKILL
> makes it harder to debug.
> 
> Also, asking the kernel to defer the SIGKILL (ie. updating the timer)
> needs to come from Qemu itself (eg. a timer in the main loop,
> something we already ruled unsuitable, or a qmp command which
> constitutes an external dependency that we also ruled undesirable).
> 
> What if, when self-fencing is enabled, Qemu kicks off a new thread
> from the start which does nothing but periodically wake up, verify the
> heartbeat condition and log()+abort() if required? (Then we wouldn't
> need the kernel timer.)
> 
> > 
> >> I'm still wondering how to make this customisable so that different
> >> types of heartbeat could be implemented (preferably without creating
> >> external dependencies per discussion above). Thoughts welcome.
> > 
> > Yes, you need something to enable it, and some safe way to retrigger
> > the timer.  A qmp command marked as 'oob' might be the right way -
> > another qm command can't block it.
> 
> This qmp approach is slightly different than the external dependency
> that itself kills Qemu; if it doesn't run, then Qemu dies because the
> kernel timer is not updated. But this is also a heavyweight approach.
> We are talking about a service that needs to frequently connect to all
> running VMs on a host to reset the timer.
> 
> But it does allow for the customisable heartbeat: the logic behind
> what triggers the command is completely flexible.
> 
> Thinking about this idea of a separate Qemu thread, one thing that
> came to mind is this:
> 
> qemu -fence heartbeat=/path/to/file,deadline=60[,recheck=5]
> 
> Qemu could fire up a thread that stat()s <file> (every <recheck>
> seconds or on a default interval) and log()+abort() the whole process
> if the last modification time of the file is older than <deadline>. If
> <file> goes away (ie. stat() gives ENOENT), then it either fences
> immediately or ignores it, not sure which is more sensible.

The architectural direction of QEMU is taking us towards a world
where "QEMU" is actually many processes. Having a thread which
just a log()+abort() the process is only going to take out one of
the QEMU processes associated with a VM. The other ones, which
are likely servicing I/O for the guest are still going to be running.

Even with monolithic single process QEMU we arguably have two processes,
the other being the kernel that is doing work on behalf of QEMU userspace.

In the event of a network outage, there are can be I/O requests from QEMU
in the kernel which are stuck/stalled. If you kill QEMU I don't believe
there's a strong guarantee that those I/O requests will be cancelled. In
this case QEMU can be stuck in an uninterruptable sleep such that even
kill -9 won't make the process go away entirely, it can get into a zombie
state. If/when the network problem resolves itself, QEMU will finally get
cleaned up, but there's a good chance the I/O operations will get sent.

As mentioned earlier, off-host STONITH is the best, but IMHO the next
fallback should be self-fencing of the host, rather than trying to get
each QEMU to self-fence its own process.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

