Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96060CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA24205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbLaRD4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA24205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNs2j-0001Cm-CB
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 01:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNs1y-0000KK-6S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNs1v-0000Ci-MA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:20:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNs1v-0000C5-IK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571980854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twasTqZtlvoCtbJPfw/imwISxbZdt6Q2XK12y6GmtTA=;
 b=ZbLaRD4yGfgc+pV4QajJ3Hc24M0Ikgl0sZ+T5Eq36Y9MWsaSYde7NS0nIB3zKBXJUr8MBU
 bunty4UO9/aCOcGLXID1Yjz1ch+dUT9HyvQR7AFkNSVOW1suDxw2FnYONZK+BmuJmdZ91f
 Rqdvyk+sx8TgG8/nUrmZsf5c1qAbzGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-hEtGl1C0MCiiX2fHyhlm3w-1; Fri, 25 Oct 2019 01:20:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB1E7476;
 Fri, 25 Oct 2019 05:20:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B2D7600C6;
 Fri, 25 Oct 2019 05:20:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84B601138619; Fri, 25 Oct 2019 07:20:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Kirillov <lekiravi@yandex-team.ru>
Subject: Re: QMP netdev_add multiple dnssearch values
References: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
Date: Fri, 25 Oct 2019 07:20:46 +0200
In-Reply-To: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net> (Alex
 Kirillov's message of "Thu, 17 Oct 2019 16:53:22 +0300")
Message-ID: <87d0elmmdt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hEtGl1C0MCiiX2fHyhlm3w-1
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Kirillov <lekiravi@yandex-team.ru> writes:

> Hi,
>
> I'm trying to create a user (slirp) interface with several `dnssearch` va=
lues using QMP.
> But every variant I pass can't do that.

What exactly goes wrong?  Does the QMP command fail?  Does it succeed
but the network backend incorrectly?

> According to the QAPI schema it should be like:
>
> {
> =C2=A0 =C2=A0 "execute": "netdev_add",
> =C2=A0 =C2=A0 "arguments": {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "id": "netdev0",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "type": "user",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "dnssearch": [
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "str": "8.8.8.8"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "str": "8.8.4.4"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> =C2=A0 =C2=A0 }
> }
>
> I looked through code and find out that `dnssearch` is passing to the `sl=
irp_dnssearch` (net/slirp.c),
> but the only way to execute this function correctly is to pass simply str=
ing (like "example.org") to `dnssearch` OR to use command line options.
>
>
> What is the correct form of QMP command that I should use?
>
>
> P.S. Looks like fields `hostfwd` and `guestfwd` has the same issue.
>
> --=C2=A0
> Alex Kirillov
> Yandex.Cloud


