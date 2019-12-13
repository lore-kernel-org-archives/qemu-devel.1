Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6974C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7078624125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1JTwMHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7078624125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnRL-0003yv-DG
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ifnPs-000356-FI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ifnPp-0007tV-3B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:03:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ifnPo-0007qn-FU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y67nNUw3kEABmusngWQxuPaBGm/fVHALxf3bTj2Zees=;
 b=V1JTwMHlIwVBQmZWZh1RSRKQLmwyJh0H6H9gXM6IfeK0hojg8YF8PapFaAWIrbaKu8F49U
 jqjbrX7F9+fC1sPgVbsK8s3AEzisfv1R0cBPmJ65xjru7SHs32VRPL4Tuy11BDcinJuZHc
 WpFa4Rt3XDbvBt8V3IWiFd9WgFTjymA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-eJeG1hRzMzawDPN9RfCJKA-1; Fri, 13 Dec 2019 11:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 667D6100A155
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-153.ams2.redhat.com
 [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E010810013D9;
 Fri, 13 Dec 2019 16:03:31 +0000 (UTC)
Date: Fri, 13 Dec 2019 17:03:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
Message-ID: <20191213160330.GD3428@localhost.localdomain>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eJeG1hRzMzawDPN9RfCJKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.11.2019 um 16:00 hat Marc-Andr=E9 Lureau geschrieben:
> The following series implements an internal async command solution
> instead. By introducing a session context and a command return
> handler, QMP handlers can:
> - defer the return, allowing the mainloop to reenter
> - return only to the caller (instead of the broadcast event reply)
> - optionnally allow cancellation when the client is gone
> - track on-going qapi command(s) per session

This requires major changes to existing QMP command handlers. Did you
consider at least optionally providing a way where instead of using the
new async_fn, QMP already creates a coroutine in which the handler is
executed?

At least for some of the block layer commands, we could simply enable
this without changing any of the code and would automatically get rid of
blocking the guest while the command is doing I/O. If we need to
implement .async_fn, in contrast, it would be quite a bit of boiler
plate code for each single handler to create a coroutine for the real
handler and to wrap all parameters in a struct.

I started playing a bit with this and it didn't look too bad, but we
can't move every command handler to a coroutine without auditing it, so
I would have had to add a new option to the QAPI schema - and at that
point I thought that I might end up duplicating a lot of your code if I
continued. So I'm now trying to get your opinion or advice before I
continue with anything in that direction.

> This does not introduce new QMP APIs or client visible changes, the
> command are handled in order, and the reply still come in order (even
> when handlers finish out of order).
>=20
> Existing qemu commands can be gradually replaced by async:true
> variants when needed, while carefully reviewing the concurrency
> aspects. The async:true commands marshaller helpers are splitted in
> half, the calling and return functions. The command is called with a
> QmpReturn context, that can return immediately or later, using the
> generated return helper.

This part would certainly become simpler with coroutines (the marshaller
could stay unchanged).

> The screendump command is converted to an async:true version to solve
> rhbz#1230527. The command shows basic cancellation (this could be
> extended if needed). It could be further improved to do asynchronous
> IO writes as well.

After converting it to QIOChannel like you already do, I/O would
automatically become asynchronous when run in a coroutine.

If you don't want this yet, but only fix the BZ, I guess you could delay
that patch until later and just have a single yield and reenter of the
command handler coroutine like this:

    co =3D qemu_coroutine_self();
    aio_co_schedule(qemu_coroutine_get_aio_context(co), co);
    qemu_coroutine_yield();

Kevin


