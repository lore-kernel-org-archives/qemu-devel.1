Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAAEC54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A560220722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX9cbGAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A560220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR6h-00013w-S0
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGR4j-0005m6-L6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGR4h-0004jQ-C8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:41:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGR4h-0004hl-0t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584985278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HphUaKrtUqOxdbT9Ia8tkqJHdcS2my5hGgZmindu1AE=;
 b=KX9cbGARIYmci2MK1NSQnQKe+blXqf+TuYojkF3fckVJZ4Q8OBv20Cx9OZoJRlLLEQ/aNw
 2tmVkj7ZEGnRmunDx+/ht6nUheApfd8TwUBiYwFABuEIJ/I4GVXrtDrGSsMoYLgFnp9hMM
 wutF90zvFd3NZpXSWKSJRs/I9MJGKR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-LsjM0ydUOX-PU_1e9IB41A-1; Mon, 23 Mar 2020 13:41:13 -0400
X-MC-Unique: LsjM0ydUOX-PU_1e9IB41A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E817496F01;
 Mon, 23 Mar 2020 17:41:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E235C1AD;
 Mon, 23 Mar 2020 17:41:09 +0000 (UTC)
Date: Mon, 23 Mar 2020 18:41:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200323174108.GD8049@linux.fritz.box>
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
 <87d09965g3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87d09965g3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.03.2020 um 16:36 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > handlers that declare 'coroutine': true in coroutine context so they
> > can avoid blocking the main loop while doing I/O or waiting for other
> > events.
> >
> > For commands that are not declared safe to run in a coroutine, the
> > dispatcher drops out of coroutine context by calling the QMP command
> > handler from a bottom half.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> Uh, what about @cur_mon?
>=20
> @cur_mon points to the current monitor while a command executes.
> Initial value is null.  It is set in three places (not counting unit
> tests), and all three save, set, do something that may use @cur_mon,
> restore:
>=20
> * monitor_qmp_dispatch(), for use within qmp_dispatch()
> * monitor_read(), for use within handle_hmp_command()
> * qmp_human_monitor_command(), also for use within handle_hmp_command()
>=20
> Therefore, @cur_mon is null unless we're running within qmp_dispatch()
> or handle_hmp_command().

Can we make it NULL for coroutine-enabled handlers?

> Example of use: error_report() & friends print "to current monitor if we
> have one, else to stderr."  Makes sharing code between HMP and CLI
> easier.  Uses @cur_mon under the hood.

error_report() eventually prints to stderr both for cur_mon =3D=3D NULL and
for QMP monitors. Is there an important difference between both cases?

There is error_vprintf_unless_qmp(), which behaves differently for both
cases. However, it is only used in VNC code, so that code would have to
keep coroutines disabled.

Is cur_mon used much in other functions called by QMP handlers?

> @cur_mon is thread-local.
>=20
> I'm afraid we have to save, clear and restore @cur_mon around a yield.

That sounds painful enough that I'd rather avoid it.

Kevin


