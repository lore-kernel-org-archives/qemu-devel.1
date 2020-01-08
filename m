Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51216205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfMYl2UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51216205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB8m-0008GP-Gu
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipB5v-0004cM-04
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipB5s-0002Eo-53
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:09:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipB5s-0002E9-1d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578488991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViuSItCm4Gf8TH93ZqXZKxJHXGkSkcoRjYUYAhg6l/s=;
 b=WfMYl2UGjvXACehS5g5rOp4tnHCI2tCu5gMwtteg+wdwqS0GJy+aWG2shul34Jk/xaAbSg
 jvs56ktDnl425ZD/APMuIuTzqIV6oh5N2A/xROye8p99OmM5dCQvDvWciX1+/gpNnvo/+W
 SXu0XiIEqonsxbYu99AL1saNVPKiOZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-2-JmH3KlMem1piqOX4jAeg-1; Wed, 08 Jan 2020 08:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787051005514;
 Wed,  8 Jan 2020 13:09:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB2C19C58;
 Wed,  8 Jan 2020 13:09:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6] migration: Support QLIST migration
In-Reply-To: <20191122171621.1307-1-eric.auger@redhat.com> (Eric Auger's
 message of "Fri, 22 Nov 2019 18:16:21 +0100")
References: <20191122171621.1307-1-eric.auger@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 14:09:38 +0100
Message-ID: <87tv56gkml.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2-JmH3KlMem1piqOX4jAeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: peterx@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
>
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST RAW macros: QLIST_RAW_INSERT_HEAD
> and QLIST_RAW_REVERSE.
>
> Tests also are provided.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


