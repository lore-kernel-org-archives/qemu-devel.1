Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E562C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E209620B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E209620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJKt-0002e2-U5
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIHTU-0002vv-UI
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIHTS-0006qh-PD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iIHTS-0006qJ-Fi; Wed, 09 Oct 2019 15:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9C723164683;
 Wed,  9 Oct 2019 19:18:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83ACA6092F;
 Wed,  9 Oct 2019 19:18:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05D2A1138619; Wed,  9 Oct 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: [PATCH] monitor/qmp: resume monitor when clearing its queue
References: <20191002083003.21556-1-w.bumiller@proxmox.com>
 <87ftk28g8f.fsf@dusky.pond.sub.org>
 <20191009101032.kxts5buz7sp3cyo5@olga.proxmox.com>
Date: Wed, 09 Oct 2019 21:18:04 +0200
In-Reply-To: <20191009101032.kxts5buz7sp3cyo5@olga.proxmox.com> (Wolfgang
 Bumiller's message of "Wed, 9 Oct 2019 12:10:32 +0200")
Message-ID: <8736g1zq1f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 09 Oct 2019 19:18:13 +0000 (UTC)
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wolfgang Bumiller <w.bumiller@proxmox.com> writes:

> On Wed, Oct 09, 2019 at 10:39:44AM +0200, Markus Armbruster wrote:
>> Cc: Marc-Andr=C3=A9 for additional monitor and chardev expertise.
>>=20
>> Wolfgang Bumiller <w.bumiller@proxmox.com> writes:
>>=20
>> > When a monitor's queue is filled up in handle_qmp_command()
>> > it gets suspended. It's the dispatcher bh's job currently to
>> > resume the monitor, which it does after processing an event
>> > from the queue. However, it is possible for a
>> > CHR_EVENT_CLOSED event to be processed before before the bh
>> > is scheduled, which will clear the queue without resuming
>> > the monitor, thereby preventing the dispatcher from reaching
>> > the resume() call.
>>=20
>> Because with the request queue cleared, there's nothing for
>> monitor_qmp_requests_pop_any_with_lock() to pop, so
>> monitor_qmp_bh_dispatcher() won't look at this monitor.  It stays
>> suspended forever.  Correct?
>>=20
>> Observable effect for the monitor's user?
>
> Yes.

I was too terse, let me try again: what exactly breaks for the monitor's
user?

>      More easily triggered now with oob. We ran into this a longer time
> ago, but our only reliable trigger was a customized version of
> -loadstate which loads the state from a separate file instead of the
> vmstate region of a qcow2. Turns out that doing this on a slow storage
> (~12s to load the data) caused our status daemon to try to poll the qmp
> socket during the load-state and give up after a 3s timeout. And since
> the BH runs in the main loop which is not even entered until after the
> loadstate has finished, but iothread handling the qmp socket does fill &
> clear the queue, the qmp socket always ended up unusable afterwards.
>
> Aside from that we have users reporting the same symptom (hanging qmp)
> appearing randomly on busy systems.
>
>> > Fix this by resuming the monitor when clearing a queue which
>> > was filled up.
>> >
>> > Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
>> > ---
>> > @Michael, we ran into this with qemu 4.0, so if the logic in this patch
>> > is correct it may make sense to include it in the 4.0.1 roundup.
>> > A backport is at [1] as 4.0 was before the monitor/ dir split.
>> >
>> > [1] https://gitlab.com/wbumiller/qemu/commit/9d8bbb5294ed084f282174b0c=
91e1a614e0a0714
>> >
>> >  monitor/qmp.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/monitor/qmp.c b/monitor/qmp.c
>> > index 9d9e5d8b27..c1db5bf940 100644
>> > --- a/monitor/qmp.c
>> > +++ b/monitor/qmp.c
>> > @@ -70,9 +70,19 @@ static void qmp_request_free(QMPRequest *req)
>> >  /* Caller must hold mon->qmp.qmp_queue_lock */
>> >  static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
>> >  {
>> > +    bool need_resume =3D (!qmp_oob_enabled(mon) && mon->qmp_requests-=
>length > 0)
>> > +        || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;
>>=20
>> Can you explain why this condition is correct?
>
> Sorry, I meant to add a comment pointing to monitor_qmp_bh_dispatcher(),
> which does the following *after* popping 1 element off the queue:
>
>     need_resume =3D !qmp_oob_enabled(mon) ||
>         mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
>     qemu_mutex_unlock(&mon->qmp_queue_lock);
>
> It's supposed to be the same condition, but _before_ popping off an
> element (hence no `- 1`), but the queue shouldn't be empty as well
> otherwise the `monitor_suspend()` in `handle_qmp_command()` hasn't
> happened, though on second though we could probably just return early in
> that case.).

I see.

Could we monitor_resume() unconditionally here?

>> >      while (!g_queue_is_empty(mon->qmp_requests)) {
>> >          qmp_request_free(g_queue_pop_head(mon->qmp_requests));
>> >      }
>> > +    if (need_resume) {
>> > +        /*
>> > +         * Pairs with the monitor_suspend() in handle_qmp_command() i=
n case the
>> > +         * queue gets cleared from a CH_EVENT_CLOSED event before the=
 dispatch
>> > +         * bh got scheduled.
>> > +         */
>> > +        monitor_resume(&mon->common);
>> > +    }
>> >  }
>> >=20=20
>> >  static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
>>=20
>> Is monitor_qmp_cleanup_req_queue_locked() the correct place?
>>=20
>> It's called from
>>=20
>> * monitor_qmp_event() case CHR_EVENT_CLOSED via
>>   monitor_qmp_cleanup_queues(), as part of destroying the monitor's
>>   session state.
>>=20
>>   This is the case you're trying to fix.  Correct?
>>=20
>>   I figure monitor_resume() is safe because we haven't really destroyed
>>   anything, yet, we merely flushed the request queue.  Correct?
>>=20
>> * monitor_data_destroy() via monitor_data_destroy_qmp() when destroying
>>   the monitor.
>>=20
>>   Can need_resume be true in this case?  If yes, is monitor_resume()
>>   still safe?  We're in the middle of destroying the monitor...
>
> I thought so when first reading through it, but on second though, we
> should probably avoid this for sanity's sake.
> Maybe with a flag, or an extra parameter.
> Or we could introduce a "bool queue_filled" we set in handle_qmp_command()
> instead of "calculating" `need_resume` in 2 places and unset it in
> `monitor_data_destroy()` before clearing the queue?

Could we simply call monitor_resume() in monitor_qmp_event() right after
monitor_qmp_cleanup_queues()?

