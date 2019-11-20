Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3459C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E4F2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcJ+eDt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E4F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTA1-0006nA-Ej
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXT7l-00051K-C7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXT7j-0002s5-FL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:46:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXT7j-0002ra-An
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfejx6nfSowJIW4fjCGCXCMko0P+rjvj56sDUEjmtF8=;
 b=YcJ+eDt13skg8bqOUaoPotQHD5MzGG9/H1wYK2U+OK+qGFQLnnFv23pxgDejWRlxS9EOy6
 Anykoj2RJfTWN/uCuRouz9a/d/G8aT110l/Mm3rF+w1seJZx6t5LxDhNI7/jlrUG9mcQ4G
 xrZ7Qid6vxoisprW1aSGCyGR4OLFDhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-eZVMOFkvP72gLcYMmhjtcg-1; Wed, 20 Nov 2019 11:46:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 075BE593A3;
 Wed, 20 Nov 2019 16:46:30 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D222A81F;
 Wed, 20 Nov 2019 16:46:28 +0000 (UTC)
Date: Wed, 20 Nov 2019 17:46:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: qcow2 preallocation and backing files
Message-ID: <20191120164626.GF5779@linux.fritz.box>
References: <20191120120625.GA25497@igalia.com>
 <a1575e90-3fe4-e843-518c-714db4b621bc@virtuozzo.com>
 <w517e3u8tks.fsf@maestria.local.igalia.com>
 <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eZVMOFkvP72gLcYMmhjtcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 16:58 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 20.11.2019 18:18, Alberto Garcia wrote:
> > On Wed 20 Nov 2019 01:27:53 PM CET, Vladimir Semeeausntsov-Ogievskiy wr=
ote:
> >=20
> >> 3. Also, the latter way is inconsistent with discard. Discarded
> >> regions returns zeroes, not clusters from backing. I think discard and
> >> truncate should behave in the same safe zero way.
> >=20
> > But then PREALLOC_MODE_OFF implies that the L2 metadata should be
> > preallocated (all clusters should be QCOW2_CLUSTER_ZERO_PLAIN), at leas=
t
> > when there is a backing file.
> >=20
> > Or maybe we just forbid PREALLOC_MODE_OFF during resize if there is a
> > backing file ?
> >=20
>=20
> Kevin proposed a fix that alters PREALLOC_MODE_OFF behavior if there is
> a backing file, to allocate L2 metadata with ZERO clusters..
>=20
> I don't think that it's the best thing to do, but it's already done,
> it works and seems appropriate for rc3..
>=20
> I see now, that change PREALLOC_MODE_OFF behavior may break things,
> first of all qemu-img create, which creating UNALLOCATED qcow2 by
> default for years.

And it still does, because the backing file is added only after giving
the qcow2 image the right size.

But you're right, this is more accidental than by design. I wonder if
there are other problematic cases (and whether merging something like
this in -rc3 isn't rather risky).

> Still, I think that it would be safer to always ZERO expanded part of
> qcow2, regardless of backing file..
>=20
> We may add PREALLOC_MODE_ZERO, and use it in mirror, commit, and some
> other calls to bdrv_truncate, except for qcow2 image creation of
> course.

What do we do with image formats that don't support zero clusters and
therefore can't provide PREALLOC_MODE_ZERO? Will commit just fail for
them?

> Then, to improve this mode handling in qcow2, to not allocate all L2
> tables, we may add "zero" bit to L1 table entry.

This would be an incompatible image format change that needs to be
explicitly enabled by the user. This might limit its usefulness a bit.

Kevin


