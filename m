Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E621AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D7F206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUlUHH0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZrfK-0005HZ-Rp
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZreS-0004q2-CD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZreR-0004gB-9C
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:22:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZreR-0004fQ-62
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574839333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StWgB5bdSqdZj+am8qFLej0BrRtfIfG5qerMsr7lKPo=;
 b=ZUlUHH0evZdRSUYBqeuXNSb11U8tdmrcatKyjYSjkkolFaUc6Eivfn7vC+VhWv+PY7IsYV
 u3KoT8niGmrAf/J4yCpETHU/xnlm6Ww0J0qojX2Xr+hjNJPvlxwL8LwF/9oaPZoSFA3kS1
 kypVcY90MqrQJGLW/q6xb7kAXUuKfbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Yews5lDvM_yNIZ_yTENsJg-1; Wed, 27 Nov 2019 02:22:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C8F61803801;
 Wed, 27 Nov 2019 07:22:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25DC65D9D6;
 Wed, 27 Nov 2019 07:22:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C6F31138606; Wed, 27 Nov 2019 08:22:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 4/9] monitor: move hmp_drive_mirror and hmp_drive_backup
 to blockdev-hmp-cmds.c
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-5-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 08:22:08 +0100
In-Reply-To: <20191120185850.18986-5-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:45 +0200")
Message-ID: <87v9r5kcm7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Yews5lDvM_yNIZ_yTENsJg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  blockdev-hmp-cmds.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  monitor/hmp-cmds.c  | 58 ------------------------------------------
>  2 files changed, 61 insertions(+), 58 deletions(-)

Licensing issue: blockdev-hmp-cmds.c is BSD, the code you moved there is
GPLv2+.  The combined work must be GPLv2+.


