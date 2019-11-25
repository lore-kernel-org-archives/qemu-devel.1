Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74668C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BF62068E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4/syFEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGsV-0008KF-CD
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZGrj-0007pQ-4O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZGrh-0003fY-JW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:05:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZGrh-0003fB-FJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574697928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdvOQiBsHjB+JZsdmflKPmOqbjPAjZHMpyFz5x4Dzh0=;
 b=L4/syFEylSQnalYs/edJY8MufTWH8+6dSpoknh1xuo8XDRW6UUjPJDFfjUGC8+QQXXiRBO
 lzFmKrSrHkGr8QrL9MpvnHiT91iD+OrE672x364hZ2luvWTRAK5neCDKB+wVN6X69FbuVU
 V8BTWF48km/MdXMI6lYrjmj8zIdWbY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-B0bveaEMMSSv_BB_5IQ0QA-1; Mon, 25 Nov 2019 11:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058DA1853014;
 Mon, 25 Nov 2019 16:05:24 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61BB55D9E2;
 Mon, 25 Nov 2019 16:05:15 +0000 (UTC)
Date: Mon, 25 Nov 2019 17:05:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v3 2/8] block: Add no_fallback parameter to
 bdrv_co_truncate()
Message-ID: <20191125160513.GE4638@linux.fritz.box>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-3-kwolf@redhat.com>
 <w515zj8hu6b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w515zj8hu6b.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: B0bveaEMMSSv_BB_5IQ0QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.11.2019 um 16:06 hat Alberto Garcia geschrieben:
> On Fri 22 Nov 2019 05:05:05 PM CET, Kevin Wolf wrote:
>=20
> > @@ -3405,6 +3412,7 @@ typedef struct TruncateCo {
> >      int64_t offset;
> >      bool exact;
> >      PreallocMode prealloc;
> > +    bool no_fallback;
> >      Error **errp;
> >      int ret;
> >  } TruncateCo;
>=20
> You add the 'no_fallback' field here...
>=20
> >  int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
> > -                  PreallocMode prealloc, Error **errp)
> > +                  PreallocMode prealloc, bool no_fallback, Error **err=
p)
> >  {
> >      Coroutine *co;
> >      TruncateCo tco =3D {
>=20
> ...but then you don't use it when the structure is initialized.

Oops. Another proof that a series like this is too much for -rc3.

Kevin


