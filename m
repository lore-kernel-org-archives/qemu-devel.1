Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD14C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F42132072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F42132072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVWvi-000374-5A
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 03:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w.bumiller@proxmox.com>) id 1iVWup-0002Sf-8x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <w.bumiller@proxmox.com>) id 1iVWun-0005f0-EV
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:25:14 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:35129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
 id 1iVWun-0005XX-2k; Fri, 15 Nov 2019 03:25:13 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 55CB64631A;
 Fri, 15 Nov 2019 09:25:03 +0100 (CET)
Date: Fri, 15 Nov 2019 09:25:01 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] monitor/qmp: resume monitor when clearing its queue
Message-ID: <20191115082501.n6d4bewqlkxuqthc@olga.proxmox.com>
References: <20191024081231.19087-1-w.bumiller@proxmox.com>
 <871rubvi62.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rubvi62.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 05:45:57PM +0100, Markus Armbruster wrote:
> Wolfgang Bumiller <w.bumiller@proxmox.com> writes:
> 
> > When a monitor's queue is filled up in handle_qmp_command()
> > it gets suspended. It's the dispatcher bh's job currently to
> > resume the monitor, which it does after processing an event
> > from the queue. However, it is possible for a
> > CHR_EVENT_CLOSED event to be processed before before the bh
> > is scheduled, which will clear the queue without resuming
> > the monitor, thereby preventing the dispatcher from reaching
> > the resume() call.
> > Any new connections to the qmp socket will be accept()ed and
> > show the greeting, but will not respond to any messages sent
> > afterwards (as they will not be read from the
> > still-suspended socket).
> > Fix this by resuming the monitor when clearing a queue which
> > was filled up.
> >
> > Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > ---
> > Changes to v1:
> >   * Update commit message to include the resulting symptoms.
> >   * Moved the resume code from `monitor_qmp_cleanup_req_queue_locked` to
> >     `monitor_qmp_cleanup_queues` to avoid an unnecessary resume when
> >     destroying the monitor (as the `_locked` version is also used by
> >     `monitor_data_destroy()`.
> >   * Renamed `monitor_qmp_cleanup_queues` to
> >     `monitor_qmp_cleanup_queues_and_resume` to reflect the change and be
> >     verbose about it for potential future users of the function.
> >     Currently the only user is `monitor_qmp_event()` in the
> >     `CHR_EVENT_CLOSED` case, which is exactly the problematic case currently.
> >
> > Sorry for the deleay :|
> 
> Same to you (my sorry excuse is KVM Forum).  Now we need to hurry to get
> this fix into 4.2.  Let's try.

Uh, that's already in Rcs. *hurries*

> >  monitor/qmp.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 9d9e5d8b27..df689aa95e 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -75,10 +75,30 @@ static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
> >      }
> >  }
> >  
> > -static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
> > +static void monitor_qmp_cleanup_queues_and_resume(MonitorQMP *mon)
> 
> Let's rename to _cleanup_queue_and resume().  The plural is a remnant
> from when we also had a response queue.  Gone since commit 27656018d86.
> 
> >  {
> >      qemu_mutex_lock(&mon->qmp_queue_lock);
> > +
> > +    /*
> > +     * Same condition as in monitor_qmp_bh_dispatcher(), but before removing an
> > +     * element from the queue (hence no `- 1`), also, the queue should not be
> > +     * empty either, otherwise the monitor hasn't been suspended yet (or was
> > +     * already resumed).
> > +     */
> 
> Comment lines should be wrapped around colum 70.
> 
> > +    bool need_resume = (!qmp_oob_enabled(mon) && mon->qmp_requests->length > 0)
> > +        || mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX;
> 
> Now let me digest the comment.  Here's condition in
> monitor_qmp_bh_dispatcher():
> 
>     need_resume = !qmp_oob_enabled(mon) ||
>         mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
> 
> "Same but before removing" is
> 
>        bool need_resume = !qmp_oob_enabled(mon)
>            || mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX;
> 
> That leaves the "also" part.  It's been too long since v1, I don't
> remember a thing, and I'm too dense today to understand without more
> help.  Can you help me some more?

Not empty: `&& length > 0`. The 2nd part of the disjunction already
implies it (as it is `length == max`) so I only added it to the first
part. A pointless optimization on my part given that it's supposed to be
more easily verified against the comment, so I'll change it to be
clearer: ($condition_without_'-1') && (!g_queue_is_empty()), so:

    bool need_resume = (!qmp_oob_enabled(mon) ||
        mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX)
        && !g_queue_is_empty(mon->qmp_requests);

> 
> > +
> >      monitor_qmp_cleanup_req_queue_locked(mon);
> > +
> > +    if (need_resume) {
> > +        /*
> > +         * Pairs with the monitor_suspend() in handle_qmp_command() in case the
> > +         * queue gets cleared from a CH_EVENT_CLOSED event before the dispatch
> > +         * bh got scheduled.
> > +         */
> 
> CHR_EVENT_CLOSED
> 
> Suggest:
> 
>            /*
>             * handle_qmp_command() suspened the monitor because the
>             * request queue filled up, to be resumed when the queue has
>             * space again.  We just emptied it; resume the monitor.
>             */
> 
> If we want to record the issue that made us fix the missing resume, we
> can add:
> 
>             * Without this, the monitor would remain suspended forever
>             * when we get here while the monitor is suspended.  An
>             * unfortunately times CHR_EVENT_CLOSED can do the trick.
> 
> Also update handle_qmp_command()'s comment:
> 
>     /*
>      * Suspend the monitor when we can't queue more requests after
>      * this one.  Dequeuing in monitor_qmp_bh_dispatcher() or
>      * monitor_qmp_cleanup_queue_and_resume() will resume it.
>      * Note that when OOB is disabled, we queue at most one command,
>      * for backward compatibility.
>      */

will do.


