Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109E32467A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYq/0/H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109E32467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuCyc-0007zA-71
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuCy0-0007Wz-KH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuCxy-0007Un-GU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:10:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuCxy-0007UU-Cn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579687829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiqQYtlrZX930JyyV03yykakkR1Qx393BqKdxILk8X8=;
 b=hYq/0/H45c3LM8qD/x2N2yZzOllVI9+vz4Zu0J+USaDWh4cOKitxRHYkVizGPT1mJPjXSZ
 hj01XKYcmuq5Kt3BBAD/0kiG0AnXA6awyySHJJkOhVJSw657csde6KGBJt4X2GKiUmoa0J
 kpZ9+4cE6iC/OvRO8wAiXAXTD37LaCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-wn8ZbvLoPamCf9fUWqvlAQ-1; Wed, 22 Jan 2020 05:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CEC4107ACC5;
 Wed, 22 Jan 2020 10:10:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-57.ams2.redhat.com [10.36.117.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BF5C85738;
 Wed, 22 Jan 2020 10:10:22 +0000 (UTC)
Date: Wed, 22 Jan 2020 11:10:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200122101021.GB5268@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfq0yp9v.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wn8ZbvLoPamCf9fUWqvlAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This patch adds a new 'coroutine' flag to QMP command definitions that
> > tells the QMP dispatcher that the command handler is safe to be run in =
a
> > coroutine.
>=20
> I'm afraid I missed this question in my review of v3: when is a handler
> *not* safe to be run in a coroutine?

That's a hard one to answer fully.

Basically, I think the biggest problem is with calling functions that
change their behaviour if run in a coroutine compared to running them
outside of coroutine context. In most cases the differences like having
a nested event loop instead of yielding are just fine, but they are
still subtly different.

I know this is vague, but I can assure you that problematic cases exist.
I hit one of them with my initial hack that just moved everything into a
coroutine. It was related to graph modifications and bdrv_drain and
resulted in a hang. For the specifics, I would have to try and reproduce
the problem again.

Kevin


