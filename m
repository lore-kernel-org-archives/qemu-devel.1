Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74FF20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzyBfHl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74FF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqKV-0005Dt-5a
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwqJi-0004ic-PL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwqJg-0007Za-OM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:35:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwqJg-0007YP-Kb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580315747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+QP2khDC/2yV3kvpd7zBl75t3RuI+zFEG2m77ScrsU=;
 b=MzyBfHl13kKiFs1G/pFjzyUnuZEigy5Lq099zqdmTcEiB9ghEWoSKocxcs/abNLGzzGavD
 OKW9IqmKqwkWB6rSFNN+2l/GrVsOlwJExqU4bsAJHaYNhhjTCopgCwuEytg22Uv/JNuu7p
 1srkLcvpEgCrV4+R2ryKQldoaABrkns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-5VQ-0R-vPr-gQ-9WYmf9EA-1; Wed, 29 Jan 2020 11:35:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876ED109AB38;
 Wed, 29 Jan 2020 16:35:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E460692D03;
 Wed, 29 Jan 2020 16:35:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FA851138404; Wed, 29 Jan 2020 17:35:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 2/4] qapi: Create module 'control'
References: <20200129102239.31435-1-kwolf@redhat.com>
 <20200129102239.31435-3-kwolf@redhat.com>
Date: Wed, 29 Jan 2020 17:35:41 +0100
In-Reply-To: <20200129102239.31435-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 29 Jan 2020 11:22:37 +0100")
Message-ID: <871rri2pb6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5VQ-0R-vPr-gQ-9WYmf9EA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

> misc.json contains definitions that are related to the system emulator,
> so it can't be used for other tools like the storage daemon. This patch
> moves basic functionality that is shared between all tools (and mostly
> related to the monitor itself) into a new control.json, which could be
> used in tools as well.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

I'd like to retitle this patch and the next one:

    qapi: Split control.json off misc.json
    monitor: Collect "control" command handlers in qmp-cmds.control.c

Okay?


