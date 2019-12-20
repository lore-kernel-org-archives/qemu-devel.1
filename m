Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD991C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9351D2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlL1fvrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKrD-000062-MN
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiKqY-0007qt-K9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiKqV-0003Qq-66
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:09:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiKqU-0003Q2-VV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576858181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOTvQ7u3nhQF/D9sVhCfi2MGv/2bL8ujCj6cC8eKtyE=;
 b=GlL1fvrsFNPPqqW9ciqoWPw0NyR0D7t4t/zEEB29WPIdEOZz4EG4cUeStOkTLiMbtNzBx7
 niRa/LnqZHbbjOY3EGANZqZnHzJd39/PauJSHWOpsn5qwe2KcZhiSJ5ISAF0O4NJmrm/gG
 3u6qOpYGkjK5+4GIz8l002S2bDmJEl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-6pFd88r0O4i47-b5FSjdBw-1; Fri, 20 Dec 2019 11:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221CEB163B;
 Fri, 20 Dec 2019 16:09:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61A6B5DA76;
 Fri, 20 Dec 2019 16:09:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8F3911386A7; Fri, 20 Dec 2019 17:09:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 0/2] Speed up QMP stream reading
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
Date: Fri, 20 Dec 2019 17:09:31 +0100
In-Reply-To: <20191219160756.22389-1-yury-kotov@yandex-team.ru> (Yury Kotov's
 message of "Thu, 19 Dec 2019 19:07:54 +0300")
Message-ID: <87a77ndlms.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6pFd88r0O4i47-b5FSjdBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, yc-core@yandex-team.ru, "Denis
 V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yury Kotov <yury-kotov@yandex-team.ru> writes:

> Hi,
>
> This series is continuation of another one:
> [PATCH] monitor: Fix slow reading
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.html
>
> Which also tried to read more than one byte from a stream at a time,
> but had some problems with OOB and HMP:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.html
>
> This series is an attempt to fix problems described.

Two problems: (1) breaks HMP migrate -d, and (2) need to think through
how this affects reading of QMP input, in particular OOB.

This series refrains from changing HMP, thus avoids (1).  Good.

What about (2)?  I'm feeling denser than usual today...  Can you explain
real slow how QMP input works?  PATCH 2 appears to splice in a ring
buffer.  Why is that needed?


