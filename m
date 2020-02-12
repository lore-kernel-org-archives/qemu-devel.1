Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA54020675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMm4THOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA54020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qOv-0005P4-05
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 06:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j1qOA-0004m4-1P
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j1qO8-0004Ge-7j
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:41:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j1qO8-0004CM-3W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581507660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIQY7lOKT6IQXpxiCFIfbF6TYBXBAgWx1FpfPM7V208=;
 b=jMm4THOZ/E6bfV6QpAaNrnRZjbtf7DPlBAndeb/gsxOtE+ik2kJHHpQXxHc1cnauywhIfa
 GJrj7wzQlyGmmUHE2vD41OjsojmTYf2tc++7yVvlff0ur185Xgt96sAyBP2PkxV2M+obEC
 cpSoZ25PaWMPzAwqsiGsGHldNWdWgFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-30PX0PAOOT63pmXgHHPj4g-1; Wed, 12 Feb 2020 06:40:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB3FDB67;
 Wed, 12 Feb 2020 11:40:55 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-205.ams2.redhat.com [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 217CD9006B;
 Wed, 12 Feb 2020 11:40:51 +0000 (UTC)
Date: Wed, 12 Feb 2020 12:40:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/4] qmp: Optionally run handlers in coroutines
Message-ID: <20200212114050.GA5867@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200205140034.GD5768@dhcp-200-226.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205140034.GD5768@dhcp-200-226.str.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 30PX0PAOOT63pmXgHHPj4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.02.2020 um 15:00 hat Kevin Wolf geschrieben:
> Am 21.01.2020 um 19:11 hat Kevin Wolf geschrieben:
> > Some QMP command handlers can block the main loop for a relatively long
> > time, for example because they perform some I/O. This is quite nasty.
> > Allowing such handlers to run in a coroutine where they can yield (and
> > therefore release the BQL) while waiting for an event such as I/O
> > completion solves the problem.
> >=20
> > This series adds the infrastructure to allow this and switches
> > block_resize to run in a coroutine as a first example.
> >=20
> > This is an alternative solution to Marc-Andr=E9's "monitor: add
> > asynchronous command type" series.
>=20
> Ping?

Ping.

Kevin


