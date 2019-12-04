Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF1FC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A917920675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs2J41yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A917920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUcR-0005P1-Pg
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1icUbj-0004ti-Nd
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1icUbi-0002pv-M4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:22:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1icUbi-0002pZ-Ha
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575465738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0puoKytu4A5yF9hHCEL9v1UQ/FOid3QZhlIb+dMe7c=;
 b=Vs2J41yk0tNl45HuvaKzJHcBGxfHLygpL7a2MJGN72q7gxlkxbBHbGKsZrybP5D83fkOW2
 m/FRs8w67UJAgDywkpr1Y/JokTT6xvaMmGylQ3Qj/q2aToUv9MMZfUntvekYRAfqqma/sb
 3ZnUsYg/sPFpjFsfWAPfdb+4E2GJrC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-8O_Cn_6hPJ602YsWWuwdCQ-1; Wed, 04 Dec 2019 08:22:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69575801FA0;
 Wed,  4 Dec 2019 13:22:13 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 070621001938;
 Wed,  4 Dec 2019 13:22:06 +0000 (UTC)
Date: Wed, 4 Dec 2019 14:22:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: NBD reconnect on open
Message-ID: <20191204132205.GA20250@dhcp-200-226.str.redhat.com>
References: <f2f45e40-ae57-3366-c018-11579775031b@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f2f45e40-ae57-3366-c018-11579775031b@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8O_Cn_6hPJ602YsWWuwdCQ-1
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
Cc: Denis Lunev <den@virtuozzo.com>, qemu block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.12.2019 um 13:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> There is a question to discuss.
>=20
> We need to make an option to allow nbd-reconnect loop on nbd-open.
> For example, add optional nbd blockdev option open-reconnect-delay, to
> make it possible to start qemu with specified nbd connection, when nbd
> server is down, and make several tries to connect before starting the
> guest.
>=20
> So, we need it for nbd opened from commandline arguments, and this case
> seems OK.
>=20
> But adding option to QAPI, we also allow it for qmp blockdev-add, and
> reconnecting in context of qmp command execution is a wrong thing..
>=20
> I can add new option only to options in block/nbd.c, but this way
> -blockdev command line option will not work, it needs QAPI definition.
>=20
> What do you think about it?

I think there is a more general problem here actually. bdrv_open() is a
blocking operation and it shouldn't be. BlockDriver should probably have
a .bdrv_co_open instead, and I think this wouldn't be too hard to do.

However, that's only half of the solution: QMP still takes the BQL while
it's executing a command, so even if we used a coroutine, it would be of
no use if then the QMP command implementation would just call
BDRV_POLL_WHILE() to wait for the completion of the coroutine while
holding the BQL.

This is going in direction of async commands that Marc-Andr=E9 was working
on. I didn't follow this closely, so I'm not sure what the status there
is, but he and Markus should be able to tell more.

> I can detect somehow in nbd_open that we are in qmp monitor context, and
> return error if open-reconnect-delay specified.. Is it OK? Is there a
> way to do it?

The whole point of -blockdev is that it's a direct mapping of
blockdev-add to the command line, so making things behave differently
between them sounds like a bad idea.

Kevin


