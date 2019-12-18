Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A296B2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSfdP8kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A296B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57379 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcga-0001P0-QY
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihcfH-0000N3-TL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihcfE-0000gP-Kt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:59:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihcfE-0000cw-AM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576688346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHtMvc8pOS9oMKqhas0qXN9biWVGDi66zLq6x11zwZA=;
 b=BSfdP8khver27r6rRIfSLrfOuOjjLTKZuLFnWEqG4gvlG17pcQFgPC6xINzyZ/HBTt/Nah
 DZRjbU8AlFor4uDiwYe/t2b2d9lIUIgwPPFViNljku4+0DGu0abicSgERwif2s9JzJo+KR
 KjaUNv4L/QQG6haZ4jMgbKiptNsAwlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-o3vWopENNKiE8WDlQOPG2w-1; Wed, 18 Dec 2019 11:59:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D66A802CBF;
 Wed, 18 Dec 2019 16:59:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6767B60BC7;
 Wed, 18 Dec 2019 16:59:01 +0000 (UTC)
Date: Wed, 18 Dec 2019 17:59:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] block/io: take bs->reqs_lock in
 bdrv_mark_request_serialising
Message-ID: <20191218165847.GF4632@linux.fritz.box>
References: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
 <1576675026-25046-4-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576675026-25046-4-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: o3vWopENNKiE8WDlQOPG2w-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 14:17 hat Paolo Bonzini geschrieben:
> bdrv_mark_request_serialising is writing the overlap_offset and
> overlap_bytes fields of BdrvTrackedRequest.  Take bs->reqs_lock
> for the whole direction of it, and not just when waiting for

Is "direction" really the word you meant?

> serialising requests, so that tracked_request_overlaps does not
> look at a half-updated request.
>=20
> The new code does not unlock/relock around retries.  This is unnecessary
> because a retry is always preceded by a CoQueue wait, which already
> releases and reacquired bs->reqs_lock.
>=20
> Reported-by: Peter Lieven <pl@kamp.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


