Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B376C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C936720708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQADsq7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C936720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjPS-0004m8-2M
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwjOG-0003vt-FX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwjOF-0004q8-JM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:12:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwjOF-0004oI-Fu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580289123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0FJLlKGo7jdKg/Qb5BWjQ/1i5Ik0DDg8TvrcIuaEFo=;
 b=QQADsq7wzJ7ypf77o2dFS8KnWM4/Ato+N82faThgEdDernMe4+3ZXY+56UXawDmuEcIFAB
 2iPd//c25rac/QI8SWM+bl9t7e3qo2HZOcxaCRY4zkYSspNBcvMRzf9TpIfaRhnzX8ICSV
 lSPRsfARgIiAK68d5oCnXzuw6tXwhNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Y8jZKETnPgyAbgp3Mps3HA-1; Wed, 29 Jan 2020 04:11:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BA61800D41;
 Wed, 29 Jan 2020 09:11:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3466648;
 Wed, 29 Jan 2020 09:11:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB4E31138404; Wed, 29 Jan 2020 10:11:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 4/4] monitor: Move qmp_query_qmp_schema to
 qmp-cmds-control.c
References: <20200128175211.30007-1-kwolf@redhat.com>
 <20200128175211.30007-5-kwolf@redhat.com>
Date: Wed, 29 Jan 2020 10:11:56 +0100
In-Reply-To: <20200128175211.30007-5-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 28 Jan 2020 18:52:11 +0100")
Message-ID: <87sgjy39ur.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Y8jZKETnPgyAbgp3Mps3HA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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

Kevin Wolf <kwolf@redhat.com> writes:

> monitor/misc.c contains code that works only in the system emulator, so
> it can't be linked to tools like a storage daemon. In order to make
> schema introspection available for tools, move the function to
> monitor/qmp-cmds-control.c, which can be linked into the storage daemon.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


