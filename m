Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71752C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378F02075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J03PSTXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378F02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXAJ-0001Dc-EL
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipX9d-0000XY-Fb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipX9c-0006Ho-5k
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:43:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipX9b-0006Fk-QT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578573788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXQjUutXXW5rZMKaTG8JQXYRmQ7IehrSYkmOrqHuLgw=;
 b=J03PSTXBhQV8g4Zwwz6o25HVCbOM/Ot9bLQLzAeofN7JV+RwKdP96f/Khn10QjUnfGEUYT
 aYJ50tqYphv5qkeYoIUl43UzU2bvPdSVokWDvJZh9aUXoBXL2OMdyiH0jOV5kNIqqsPzHL
 nLMOYoqpOgS0lLgU+jWWegBDXv7ezxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-ouWyxtg7OvuvG7dgS7JnQw-1; Thu, 09 Jan 2020 07:43:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EC064A7E;
 Thu,  9 Jan 2020 12:43:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-193.ams2.redhat.com [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A60A80611;
 Thu,  9 Jan 2020 12:43:02 +0000 (UTC)
Date: Thu, 9 Jan 2020 13:43:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 3/3] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
Message-ID: <20200109124301.GG9504@linux.fritz.box>
References: <cover.1578505678.git.berto@igalia.com>
 <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
 <20200109121900.GF9504@linux.fritz.box>
 <w51a76wbymr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51a76wbymr.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ouWyxtg7OvuvG7dgS7JnQw-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.01.2020 um 13:30 hat Alberto Garcia geschrieben:
> On Thu 09 Jan 2020 01:19:00 PM CET, Kevin Wolf wrote:
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index e8ce966f7f..6427c75409 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -2175,7 +2175,7 @@ static coroutine_fn int qcow2_co_preadv_task(Blo=
ckDriverState *bs,
> >>                                            offset, bytes, qiov, qiov_o=
ffset);
> >> =20
> >>      case QCOW2_CLUSTER_NORMAL:
> >> -        if ((file_cluster_offset & 511) !=3D 0) {
> >> +        if ((file_cluster_offset % BDRV_SECTOR_SIZE) !=3D 0) {
> >>              return -EIO;
> >>          }
> >
> > Hm, unrelated to your change, but why do we test for 512 byte
> > alignment here? file_cluster_offset should certainly be cluster
> > aligned for normal clusters. And if the check fails, that's actually
> > an image corruption and not just an I/O error. Am I missing something?
>=20
> I actually suspect that this is just an old, obsolete check that we have
> kept during these years. file_cluster_offset should be not just sector
> aligned but also cluster aligned if I'm not wrong, and if not then
> qcow2_alloc_cluster_offset() and qcow2_get_cluster_offset() should
> return an error.

Right, they already check it, and don't only return an error, but also
call qcow2_signal_corruption() as they should.

> I can simply remove that check, or replace it with an assertion.

Sounds good to me (and with cluster size instead of 512).

Kevin


