Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26448C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E503F206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGJ1C0SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E503F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTR6q-000428-1t
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTR2X-0007Jd-B6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTR2W-00074T-Pz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:16:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTR2W-00073i-Ao
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588083407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvBFrqgktxRNcjCTkR4lx+at6nndUIQ1o6qNCIoSun0=;
 b=VGJ1C0SMgSntrHlyBKOE8XI/ugNP2DRqSoOacKIU+pCP3WnxHWgicSc2tmQNuLnPp1tRB8
 tLbPYDmlUQHXNrZLXk8oPE/DAce3RpTv4ezsdwd4IPR7a0+aysQB5chx6JYo7tdFns9CIa
 IIyZk/LZBynVM92U0zRjcA7J27Mh70g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-3KPZFJQyP4K2lqqwgYzYAw-1; Tue, 28 Apr 2020 10:16:44 -0400
X-MC-Unique: 3KPZFJQyP4K2lqqwgYzYAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE9B1005510;
 Tue, 28 Apr 2020 14:16:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C09505D9E2;
 Tue, 28 Apr 2020 14:16:42 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:16:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
Message-ID: <20200428141641.GH5789@linux.fritz.box>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
 <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
 <20200428140132.GF5789@linux.fritz.box>
 <f9b2b26a-eacd-93db-f5c1-2682ae597e24@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f9b2b26a-eacd-93db-f5c1-2682ae597e24@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Am 28.04.2020 um 16:07 hat Eric Blake geschrieben:
> On 4/28/20 9:01 AM, Kevin Wolf wrote:
>=20
> > > Can we please fix this to take a flags parameter?  I want to make it =
easier
> > > for callers to request BDRV_REQ_NO_FALLBACK for distinguishing betwee=
n
> > > callers where the image must be made empty (read as all zeroes) regar=
dless
> > > of time spent, vs. made empty quickly (including if it is already all=
 zero)
> > > but where the caller is prepared for the operation to fail and will w=
rite
> > > zeroes itself if fast bulk zeroing was not possible.
> >=20
> > bdrv_make_empty() is not for making an image read as all zeroes, but to
> > make it fully unallocated so that the backing file becomes visible.
> >=20
> > Are you confusing it with bdrv_make_zero(), which is just a wrapper
> > around bdrv_pwrite_zeroes() and does take flags?
>=20
> Yes.  Although now I'm wondering if the two should remain separate or sho=
uld
> just be a single driver callback where flags can include BDRV_REQ_ZERO_WR=
ITE
> to distinguish whether exposing the backing file vs. reading as all zeroe=
s
> is intended, or if that is merging too much.

I don't think the implementations for both things are too similar, so
you might just end up having two if branches and then two separate
implementations in the block drivers.

If anything, bdrv_make_empty() is more related to discard than
write_zeroes. But we use the discard code for it in qcow2 only as a
fallback because in the most common cases, making an image completely
empty means effectively just creating an entirely new L1 and refcount
table, which is much faster than individually discarding all clusters.

For bdrv_make_zero() I don't see an opportunity for such optimisations,
so I don't really see a reason to have a separate callback. Unless you
do know one?

Kevin


