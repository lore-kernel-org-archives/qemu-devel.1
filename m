Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94564C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656DA20720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkIwr+2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656DA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqg7-0005YR-Go
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwqfS-0004t2-J0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwqfR-0007jU-M1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:58:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwqfR-0007hf-IQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580317097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcedKwbQKirhf2xNz6xKw9zd6IjAink5bmFF/iOtFAA=;
 b=CkIwr+2d53kATfgJbDXzP9mBCpmA3Ekl2Tytb2asCiu2LkYKS9ROtmBmO5iYrBqBVgG9wY
 tJFW5bZBVLugwI+2QxbRnC88uka5DEiRoIHfJ8pMrWxxhO0K0RFaeXyUR8ySfkAIxxOUT/
 xIWzFkW6ONHbb4yGXKCvurU2k6CVIcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4t8ogeOjN_-e_S4WbRl6oQ-1; Wed, 29 Jan 2020 11:58:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A142B1080D6C;
 Wed, 29 Jan 2020 16:58:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-205.ams2.redhat.com [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 938B25C28C;
 Wed, 29 Jan 2020 16:58:11 +0000 (UTC)
Date: Wed, 29 Jan 2020 17:58:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 2/4] qapi: Create module 'control'
Message-ID: <20200129165810.GD5690@linux.fritz.box>
References: <20200129102239.31435-1-kwolf@redhat.com>
 <20200129102239.31435-3-kwolf@redhat.com>
 <871rri2pb6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rri2pb6.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4t8ogeOjN_-e_S4WbRl6oQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.01.2020 um 17:35 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > misc.json contains definitions that are related to the system emulator,
> > so it can't be used for other tools like the storage daemon. This patch
> > moves basic functionality that is shared between all tools (and mostly
> > related to the monitor itself) into a new control.json, which could be
> > used in tools as well.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> I'd like to retitle this patch and the next one:
>=20
>     qapi: Split control.json off misc.json
>     monitor: Collect "control" command handlers in qmp-cmds.control.c
>=20
> Okay?

Sure, why not.

Kevin


