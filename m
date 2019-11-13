Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B80C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E10206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P14Qtg5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E10206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvpJ-0006lA-Ud
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iUvmV-00047h-QI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iUvmT-0006xa-DK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iUvmT-0006xL-9Z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573663568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fW7GUyMMHX6QKjOzgsMfsicIBNd+G+GV+I1wj3KKLSA=;
 b=P14Qtg5A1tgxwrWG0QGDXpg9Qe+e7tNpVzPWCAPwab5r8FZ7njohTpvo+ku8009Fs481DH
 tciRtXmAilkSDuMrhhi/r7AOkp62iGfyIZUKlIXiNdOzFA89P40z1TNaZiQiR0zXomgV4T
 dQkHOXs76sFCXcc+BUmqlH48wDzU/3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-a0WAMMGaOdSKtbqDVc2Hzw-1; Wed, 13 Nov 2019 11:46:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7229100EE09;
 Wed, 13 Nov 2019 16:46:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72AC360478;
 Wed, 13 Nov 2019 16:45:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD6A41138648; Wed, 13 Nov 2019 17:45:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: [PATCH v2] monitor/qmp: resume monitor when clearing its queue
References: <20191024081231.19087-1-w.bumiller@proxmox.com>
Date: Wed, 13 Nov 2019 17:45:57 +0100
In-Reply-To: <20191024081231.19087-1-w.bumiller@proxmox.com> (Wolfgang
 Bumiller's message of "Thu, 24 Oct 2019 10:12:31 +0200")
Message-ID: <871rubvi62.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: a0WAMMGaOdSKtbqDVc2Hzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wolfgang Bumiller <w.bumiller@proxmox.com> writes:

> When a monitor's queue is filled up in handle_qmp_command()
> it gets suspended. It's the dispatcher bh's job currently to
> resume the monitor, which it does after processing an event
> from the queue. However, it is possible for a
> CHR_EVENT_CLOSED event to be processed before before the bh
> is scheduled, which will clear the queue without resuming
> the monitor, thereby preventing the dispatcher from reaching
> the resume() call.
> Any new connections to the qmp socket will be accept()ed and
> show the greeting, but will not respond to any messages sent
> afterwards (as they will not be read from the
> still-suspended socket).
> Fix this by resuming the monitor when clearing a queue which
> was filled up.
>
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Changes to v1:
>   * Update commit message to include the resulting symptoms.
>   * Moved the resume code from `monitor_qmp_cleanup_req_queue_locked` to
>     `monitor_qmp_cleanup_queues` to avoid an unnecessary resume when
>     destroying the monitor (as the `_locked` version is also used by
>     `monitor_data_destroy()`.
>   * Renamed `monitor_qmp_cleanup_queues` to
>     `monitor_qmp_cleanup_queues_and_resume` to reflect the change and be
>     verbose about it for potential future users of the function.
>     Currently the only user is `monitor_qmp_event()` in the
>     `CHR_EVENT_CLOSED` case, which is exactly the problematic case curren=
tly.
>
> Sorry for the deleay :|

Same to you (my sorry excuse is KVM Forum).  Now we need to hurry to get
this fix into 4.2.  Let's try.

>  monitor/qmp.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 9d9e5d8b27..df689aa95e 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -75,10 +75,30 @@ static void monitor_qmp_cleanup_req_queue_locked(Moni=
torQMP *mon)
>      }
>  }
> =20
> -static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
> +static void monitor_qmp_cleanup_queues_and_resume(MonitorQMP *mon)

Let's rename to _cleanup_queue_and resume().  The plural is a remnant
from when we also had a response queue.  Gone since commit 27656018d86.

>  {
>      qemu_mutex_lock(&mon->qmp_queue_lock);
> +
> +    /*
> +     * Same condition as in monitor_qmp_bh_dispatcher(), but before remo=
ving an
> +     * element from the queue (hence no `- 1`), also, the queue should n=
ot be
> +     * empty either, otherwise the monitor hasn't been suspended yet (or=
 was
> +     * already resumed).
> +     */

Comment lines should be wrapped around colum 70.

> +    bool need_resume =3D (!qmp_oob_enabled(mon) && mon->qmp_requests->le=
ngth > 0)
> +        || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;

Now let me digest the comment.  Here's condition in
monitor_qmp_bh_dispatcher():

    need_resume =3D !qmp_oob_enabled(mon) ||
        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;

"Same but before removing" is

       bool need_resume =3D !qmp_oob_enabled(mon)
           || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;

That leaves the "also" part.  It's been too long since v1, I don't
remember a thing, and I'm too dense today to understand without more
help.  Can you help me some more?

> +
>      monitor_qmp_cleanup_req_queue_locked(mon);
> +
> +    if (need_resume) {
> +        /*
> +         * Pairs with the monitor_suspend() in handle_qmp_command() in c=
ase the
> +         * queue gets cleared from a CH_EVENT_CLOSED event before the di=
spatch
> +         * bh got scheduled.
> +         */

CHR_EVENT_CLOSED

Suggest:

           /*
            * handle_qmp_command() suspened the monitor because the
            * request queue filled up, to be resumed when the queue has
            * space again.  We just emptied it; resume the monitor.
            */

If we want to record the issue that made us fix the missing resume, we
can add:

            * Without this, the monitor would remain suspended forever
            * when we get here while the monitor is suspended.  An
            * unfortunately times CHR_EVENT_CLOSED can do the trick.

Also update handle_qmp_command()'s comment:

    /*
     * Suspend the monitor when we can't queue more requests after
     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() or
     * monitor_qmp_cleanup_queue_and_resume() will resume it.
     * Note that when OOB is disabled, we queue at most one command,
     * for backward compatibility.
     */

> +        monitor_resume(&mon->common);
> +    }
> +
>      qemu_mutex_unlock(&mon->qmp_queue_lock);
>  }
> =20
> @@ -332,7 +352,7 @@ static void monitor_qmp_event(void *opaque, int event=
)
>           * stdio, it's possible that stdout is still open when stdin
>           * is closed.
>           */
> -        monitor_qmp_cleanup_queues(mon);
> +        monitor_qmp_cleanup_queues_and_resume(mon);
>          json_message_parser_destroy(&mon->parser);
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);


