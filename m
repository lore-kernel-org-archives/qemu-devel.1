Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C42C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D7420863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D7420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdPfO-0000MT-Kb
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 21:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hdPeF-0007Fm-7Q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hdPVx-0002TK-4f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hdPVw-0002On-RY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:35:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D297C4ECF;
 Wed, 19 Jun 2019 01:35:41 +0000 (UTC)
Received: from xz-x1 (ovpn-12-133.pek2.redhat.com [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B9115C2E4;
 Wed, 19 Jun 2019 01:35:37 +0000 (UTC)
Date: Wed, 19 Jun 2019 09:35:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Cosmin Marin <cosmin.marin@nutanix.com>
Message-ID: <20190619013534.GA8761@xz-x1>
References: <20190614161106.218854-1-cosmin@nutanix.com>
 <20190617034628.GA12456@xz-x1>
 <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
 <20190618145116.GA3793@xz-x1>
 <903D206C-0B8E-4113-A8B4-B8AC571F840A@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903D206C-0B8E-4113-A8B4-B8AC571F840A@nutanix.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 19 Jun 2019 01:35:46 +0000 (UTC)
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

On Tue, Jun 18, 2019 at 04:52:09PM +0000, Cosmin Marin wrote:
>=20
>=20
> =EF=BB=BFOn 18/06/2019, 15:51, "Peter Xu" <peterx@redhat.com> wrote:
>=20
>     On Tue, Jun 18, 2019 at 12:25:43PM +0000, Cosmin Marin wrote:
>     > 	Hi Peter,
>     >=20
>     > 	thanks for reviewing the patch. Indeed, I agree that it's almost=
 impossible to determine which solution it's better from the scalability =
perspective. However, I feel that using per-vCPU timers is the only way f=
or ensuring correctness of the throttling ratio.
>    =20
>     The thing is that your patch actually contains two changes:
>    =20
>     1. use N timers instead of one.
>    =20
>     2. remove throttle_thread_scheduled check, so we do the throttle
>        always
>    =20
>     Here what I'm worried is that _maybe_ the 2nd item is the one that
>     really helped.
>    =20
> 	C: The removal of *throttle_thread_scheduled* is a consequence of the =
per-vCPU model only. In this model, each of the vCPUs schedules work just=
 for itself (as part of the timer's firing callback) - there's no global =
point of control - therefore, the variable isn't helpful for scheduling a=
nymore.
>=20
>     Note that there is a side effect that we might queue more than one
>     work on one specific cpu if we queue it too fast, but it does not
>     block us from trying it out to identify which item (1 or 2 or both)
>     really helped here.  Then if we think that (queuing too much) is an
>     issue then we can discuss on how to fix it since current patch will
>     have this problem as well.
>    =20
> 	C: I believe that in the per-vCPU timer implementation we cannot queue=
 more than one piece of work because, here, the vCPU queues work for itse=
lf and that happens only when the timer fires - so, the two "states" - sc=
heduling and sleeping - are mutually exclusive running from the same thre=
ad context.=20

I think this is the place where I'm in question with - I don't think
they are using the same context.  IMO the timer will always be run in
the main thread no matter you use per-cpu timer or not, however the
sleeping part should be run on per-cpu.

A simple way to verify it would be: break at cpu_throttle_timer_tick()
to see which thread it is running in.

>     >=20
>     > 	It's a bit unclear to me how the throttling ratio inconsistency =
can be fixed by using a single timer even avoiding the conditional timer =
re-arming.  Could you provide more details about the use of a single time=
r ?
>=20
> 	C: I feel like in this case it will sleep too much running into a prob=
lem similar to the one solved by 90bb0c0; under heavy throttling more tha=
n one work item may be scheduled.

Right.  So I feel like we need a solution that will avoid this problem
but at the same time keep the proper accuracy of the throttling.

Thanks,

--=20
Peter Xu

