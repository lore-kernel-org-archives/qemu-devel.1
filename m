Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A4C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D93D20774
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB2HJWJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D93D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEal9-0006v9-KY
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 11:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEak2-0006LR-Of
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEak0-0001nx-I9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:36:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44865)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEak0-0001mF-EH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584545780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfzdIfatVjxfd+m3BQBqnSjyoqySMplOStBC3Rmyxyc=;
 b=jB2HJWJdi1ACPHfpFkbwUa11N8JOXdbS3GADDwqLjmnjgtrS7t028dc+10TQNNuPJm9ctM
 NEjiAKQhWr+C0ctXbnfJHOu1SIqDXckgIwPzee+eARJKyh11OwPhfcEgGL1xSUw2A822mv
 q5VVHiC9kQBpcc4iZiRkH4hzDXslnyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-rJ-yW9tiPTSZo6ts8K5JGA-1; Wed, 18 Mar 2020 11:36:16 -0400
X-MC-Unique: rJ-yW9tiPTSZo6ts8K5JGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51AEE18A5500;
 Wed, 18 Mar 2020 15:36:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E082860BEC;
 Wed, 18 Mar 2020 15:36:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD1AA1138404; Wed, 18 Mar 2020 16:36:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
Date: Wed, 18 Mar 2020 16:36:12 +0100
In-Reply-To: <20200218154036.28562-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 18 Feb 2020 16:40:35 +0100")
Message-ID: <87d09965g3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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

Kevin Wolf <kwolf@redhat.com> writes:

> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.
>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Uh, what about @cur_mon?

@cur_mon points to the current monitor while a command executes.
Initial value is null.  It is set in three places (not counting unit
tests), and all three save, set, do something that may use @cur_mon,
restore:

* monitor_qmp_dispatch(), for use within qmp_dispatch()
* monitor_read(), for use within handle_hmp_command()
* qmp_human_monitor_command(), also for use within handle_hmp_command()

Therefore, @cur_mon is null unless we're running within qmp_dispatch()
or handle_hmp_command().

Example of use: error_report() & friends print "to current monitor if we
have one, else to stderr."  Makes sharing code between HMP and CLI
easier.  Uses @cur_mon under the hood.

@cur_mon is thread-local.

I'm afraid we have to save, clear and restore @cur_mon around a yield.


