Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121CC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A3121783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpKxs/W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrya-0003iI-92
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iUrxD-0002wA-Hw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iUrxA-0002X8-6P
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:40:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iUrx9-0002WJ-LI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573648854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELXg7QoT5oBrk3FKkyIVTgo8c/tH5vcoYlN/uY+GI3o=;
 b=ZpKxs/W5HQm5b0qWaEa/NYcVwFSSILXIptHuigJa9lkghiYyrb9mVfLs5ksI3LgiQxY28y
 JBd1CQXJdW5l2iqqUgi2FL0vBqyaxqpJU2I/10g9r0TeYr8S60GZJaOkZwNAz4ojYh9rjC
 7SFegEyJGWY9iLzs6XvrsLlatHjVP4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-rYc0JUi1P4q11zwUpXVX6w-1; Wed, 13 Nov 2019 07:40:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058CA1034B05;
 Wed, 13 Nov 2019 12:40:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F771C947;
 Wed, 13 Nov 2019 12:40:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D1071138648; Wed, 13 Nov 2019 13:40:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
References: <20191106130309.6737-1-jandryuk@gmail.com>
Date: Wed, 13 Nov 2019 13:40:45 +0100
In-Reply-To: <20191106130309.6737-1-jandryuk@gmail.com> (Jason Andryuk's
 message of "Wed, 6 Nov 2019 08:03:09 -0500")
Message-ID: <878sok2ble.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rYc0JUi1P4q11zwUpXVX6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Andryuk <jandryuk@gmail.com> writes:

> Currently, mon->commands is uninitialized until CHR_EVENT_OPENED where
> it is set to &qmp_cap_negotiation_commands.  After capability
> negotiation, it is set to &qmp_commands.  If the chardev is closed,
> CHR_EVENT_CLOSED, mon->commands remains as &qmp_commands.  Only once the
> chardev is re-opened with CHR_EVENT_OPENED, is it reset to
> &qmp_cap_negotiation_commands.
>
> monitor_qapi_event_emit compares mon->commands to
> &qmp_cap_negotiation_commands, and skips sending events when they are
> equal.

The check's purpose is to ensure we don't send events in capabilities
negotiation mode, i.e. between connect and a successful qmp_capabilities
command.

>         In the case of a closed chardev, QMP events are still sent down
> to the closed chardev which needs to drop them.

True, but I wonder how this can happen.  Can you explain?

> Set mon->commands to &qmp_cap_negotiation_commands for CHR_EVENT_CLOSED
> to stop sending events.  Setting for the CHR_EVENT_OPENED case remains
> since that is how mon->commands is set for a newly opened connections.
>
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
>  monitor/qmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 9d9e5d8b27..5e2073c5eb 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int event=
)
       case CHR_EVENT_CLOSED:
           /*
            * Note: this is only useful when the output of the chardev
            * backend is still open.  For example, when the backend is
            * stdio, it's possible that stdout is still open when stdin
>           * is closed.
>           */
>          monitor_qmp_cleanup_queues(mon);
> +        mon->commands =3D &qmp_cap_negotiation_commands;
>          json_message_parser_destroy(&mon->parser);
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);

Patchew reports this loses SHUTDOWN events.  Local testing confirms it
does.  Simplified reproducer:

    $ for ((i=3D0; i<100; i++)); do printf '{"execute": "qmp_capabilities"}=
\n{"execute": "quit"}' | upstream-qemu -S -display none -qmp stdio; done | =
grep -c SHUTDOWN
    84

In this test, the SHUTDOWN event was lost 16 out of 100 times.

Its emission obviously races with the assignment you add.

The comment preceding it provides a clue: after CHR_EVENT_CLOSED, we
know the input direction is gone, and we duly clean up that part of the
monitor.  But the output direction may or may not be gone, so we don't
touch it.  Your assignment touches it.  This is not the correct spot.
I can't tell you offhand where the correct spot is.  Perhaps Marc-Andr=C3=
=A9
can.


