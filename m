Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB6DECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9486421848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9486421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFEq-0003mQ-7T
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iI7Vd-00085G-RK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iI7Vc-000158-Cn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:39:49 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:40120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>)
 id 1iI7Vc-00014h-3Q; Wed, 09 Oct 2019 04:39:48 -0400
Received: from blackfin.pond.sub.org (p5DCDBB4B.dip0.t-ipconnect.de
 [93.205.187.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 0BF20496C9;
 Wed,  9 Oct 2019 10:39:45 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F3761138619; Wed,  9 Oct 2019 10:39:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: [PATCH] monitor/qmp: resume monitor when clearing its queue
References: <20191002083003.21556-1-w.bumiller@proxmox.com>
Date: Wed, 09 Oct 2019 10:39:44 +0200
Message-ID: <87ftk28g8f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Marc-Andr=C3=A9 for additional monitor and chardev expertise.

Wolfgang Bumiller <w.bumiller@proxmox.com> writes:

> When a monitor's queue is filled up in handle_qmp_command()
> it gets suspended. It's the dispatcher bh's job currently to
> resume the monitor, which it does after processing an event
> from the queue. However, it is possible for a
> CHR_EVENT_CLOSED event to be processed before before the bh
> is scheduled, which will clear the queue without resuming
> the monitor, thereby preventing the dispatcher from reaching
> the resume() call.

Because with the request queue cleared, there's nothing for
monitor_qmp_requests_pop_any_with_lock() to pop, so
monitor_qmp_bh_dispatcher() won't look at this monitor.  It stays
suspended forever.  Correct?

Observable effect for the monitor's user?

> Fix this by resuming the monitor when clearing a queue which
> was filled up.
>
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> @Michael, we ran into this with qemu 4.0, so if the logic in this patch
> is correct it may make sense to include it in the 4.0.1 roundup.
> A backport is at [1] as 4.0 was before the monitor/ dir split.
>
> [1] https://gitlab.com/wbumiller/qemu/commit/9d8bbb5294ed084f282174b0c91e=
1a614e0a0714
>
>  monitor/qmp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 9d9e5d8b27..c1db5bf940 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -70,9 +70,19 @@ static void qmp_request_free(QMPRequest *req)
>  /* Caller must hold mon->qmp.qmp_queue_lock */
>  static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
>  {
> +    bool need_resume =3D (!qmp_oob_enabled(mon) && mon->qmp_requests->le=
ngth > 0)
> +        || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;

Can you explain why this condition is correct?

>      while (!g_queue_is_empty(mon->qmp_requests)) {
>          qmp_request_free(g_queue_pop_head(mon->qmp_requests));
>      }
> +    if (need_resume) {
> +        /*
> +         * Pairs with the monitor_suspend() in handle_qmp_command() in c=
ase the
> +         * queue gets cleared from a CH_EVENT_CLOSED event before the di=
spatch
> +         * bh got scheduled.
> +         */
> +        monitor_resume(&mon->common);
> +    }
>  }
>=20=20
>  static void monitor_qmp_cleanup_queues(MonitorQMP *mon)

Is monitor_qmp_cleanup_req_queue_locked() the correct place?

It's called from

* monitor_qmp_event() case CHR_EVENT_CLOSED via
  monitor_qmp_cleanup_queues(), as part of destroying the monitor's
  session state.

  This is the case you're trying to fix.  Correct?

  I figure monitor_resume() is safe because we haven't really destroyed
  anything, yet, we merely flushed the request queue.  Correct?

* monitor_data_destroy() via monitor_data_destroy_qmp() when destroying
  the monitor.

  Can need_resume be true in this case?  If yes, is monitor_resume()
  still safe?  We're in the middle of destroying the monitor...

