Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B65C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 03:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994282084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 03:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994282084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdnXM-00008o-MD
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 23:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hdnVW-0007Vh-JI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 23:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hdnEm-0002cQ-CM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:55:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hdnEk-0002ZU-7k
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6B5F308A968;
 Thu, 20 Jun 2019 02:55:38 +0000 (UTC)
Received: from xz-x1 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 131DA5D9C6;
 Thu, 20 Jun 2019 02:55:35 +0000 (UTC)
Date: Thu, 20 Jun 2019 10:55:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Cosmin Marin <cosmin.marin@nutanix.com>
Message-ID: <20190620025532.GA9073@xz-x1>
References: <20190614161106.218854-1-cosmin@nutanix.com>
 <20190617034628.GA12456@xz-x1>
 <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
 <20190618145116.GA3793@xz-x1>
 <903D206C-0B8E-4113-A8B4-B8AC571F840A@nutanix.com>
 <20190619013534.GA8761@xz-x1>
 <2D8771C7-51F3-4C9A-9E89-2E2A75686BF9@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2D8771C7-51F3-4C9A-9E89-2E2A75686BF9@nutanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 02:55:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 03:23:28PM +0000, Cosmin Marin wrote:
>=20
>=20
> =EF=BB=BFOn 19/06/2019, 02:35, "Peter Xu" <peterx@redhat.com> wrote:
>=20
>     On Tue, Jun 18, 2019 at 04:52:09PM +0000, Cosmin Marin wrote:
>     >=20
>     >=20
>     > On 18/06/2019, 15:51, "Peter Xu" <peterx@redhat.com> wrote:
>     >=20
>     >     On Tue, Jun 18, 2019 at 12:25:43PM +0000, Cosmin Marin wrote:
>     >     > 	Hi Peter,
>     >     >=20
>     >     > 	thanks for reviewing the patch. Indeed, I agree that it's =
almost impossible to determine which solution it's better from the scalab=
ility perspective. However, I feel that using per-vCPU timers is the only=
 way for ensuring correctness of the throttling ratio.
>     >    =20
>     >     The thing is that your patch actually contains two changes:
>     >    =20
>     >     1. use N timers instead of one.
>     >    =20
>     >     2. remove throttle_thread_scheduled check, so we do the throt=
tle
>     >        always
>     >    =20
>     >     Here what I'm worried is that _maybe_ the 2nd item is the one=
 that
>     >     really helped.
>     >    =20
>     > 	C: The removal of *throttle_thread_scheduled* is a consequence o=
f the per-vCPU model only. In this model, each of the vCPUs schedules wor=
k just for itself (as part of the timer's firing callback) - there's no g=
lobal point of control - therefore, the variable isn't helpful for schedu=
ling anymore.
>     >=20
>     >     Note that there is a side effect that we might queue more tha=
n one
>     >     work on one specific cpu if we queue it too fast, but it does=
 not
>     >     block us from trying it out to identify which item (1 or 2 or=
 both)
>     >     really helped here.  Then if we think that (queuing too much)=
 is an
>     >     issue then we can discuss on how to fix it since current patc=
h will
>     >     have this problem as well.
>     >    =20
=E4=B8=AD=E5=A4=AE=E5=85=9A=E5=8F=B2>     > 	C: I believe that in the per=
-vCPU timer implementation we cannot queue more than one piece of work be=
cause, here, the vCPU queues work for itself and that happens only when t=
he timer fires - so, the two "states" - scheduling and sleeping - are mut=
ually exclusive running from the same thread context.=20
>    =20
>     I think this is the place where I'm in question with - I don't thin=
k
>     they are using the same context.  IMO the timer will always be run =
in
>     the main thread no matter you use per-cpu timer or not, however the
>     sleeping part should be run on per-cpu.
>    =20
>     A simple way to verify it would be: break at cpu_throttle_timer_tic=
k()
>     to see which thread it is running in.
>    =20
> 	You're absolutely right, it was indeed a confusion I made (I've run a =
test in which I printed the thread IDs to confirm as well). However, I be=
lieve that there are two contributing factors preventing the scheduling o=
f more than one piece of work:=20
> 		- the timer's firing period is always greater than the vCPU's sleepin=
g interval, therefore the timer won't fire while a vCPU is sleeping and a=
s a consequence no additional work is scheduled (as long as the start of =
the sleeping time does not "move to the right" towards the next firing of=
 the timer)

I suspect the timer could still fire during vcpu sleeping.  The old
code have had that problem from the very beginning and that's why we
have had the throttle_thread_scheduled, AFAICT.  Meanwhile I cannot
see why per-cpu timer could help to avoid this.

The problem is async_run_on_cpu() will only queue the work onto the
CPU, but it never guarantees that when the work will be scheduled on
the CPU.  The delay should be unpredictable.

> 		- the timer's callback schedules work for one vCPU only (simple & fas=
t) preventing additional delays between work executions on different vCPU=
s or potential overlapping of timer firing with vCPU sleeps=20

Splitting the single timer into per-cpu timers doesn't help at all IMO
because you'll need to call async_run_on_cpu() as many times as
before.  Although you'll be with different timer contexts, but you are
still with the _same_ main thread context for all these timers so you
should even need more time to schedule these timers in total.  With
that, it seems to me that it's even more overhead and it could bring
more delays comparing to the old code rather than helping anything.

If you can schedule these timers on separate threads, then I would
agree. But I don't see how it could happen easily.

>=20
>     >     >=20
>     >     > 	It's a bit unclear to me how the throttling ratio inconsis=
tency can be fixed by using a single timer even avoiding the conditional =
timer re-arming.  Could you provide more details about the use of a singl=
e timer ?
>     >=20
>     > 	C: I feel like in this case it will sleep too much running into =
a problem similar to the one solved by 90bb0c0; under heavy throttling mo=
re than one work item may be scheduled.
>    =20
>     Right.  So I feel like we need a solution that will avoid this prob=
lem
>     but at the same time keep the proper accuracy of the throttling.
>    =20
> 	IMO the patch achieves both goals without putting too much pressure on=
 the main thread when running the callbacks; we could see no problem rela=
ted to the main thread/callbacks in any of the tests we ran.

Yeah I would fully believe that it won't bring problem to main thread
if we're with tens of vcpus.  I'm just a bit worried that we might
move the code even a bit further towards scalable by using split
timers.

Regards,

--=20
Peter Xu

