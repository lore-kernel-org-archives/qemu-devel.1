Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25581CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B0020663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUNl3yQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B0020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwXW-0008Vk-Qk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNwNE-0006Wg-V5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNwND-0004hl-4O
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNwNC-0004as-VP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hlA0R1g5WXsAHk7gDWlmXOz/G3RhG48NKi6/mhZyIeI=;
 b=hUNl3yQNsT6DAB+OrIsw/GWyeVg+97Z+RSPEtPpud5mTSKMnzptqJ0j7VyMgzLfRj62Pin
 ieqX4BI+8sCZbiwk1WUTAVV/HZYrBkt4H/3l07HW7FuDj/5/GpG2jZoqrTfDNzsKm4HvGs
 nYV8wu6uEWSo/aZ49aTh8FR/d5Q+V2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-54bGxlm0M2OFKSfSwawPhQ-1; Fri, 25 Oct 2019 05:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC1080183D;
 Fri, 25 Oct 2019 09:58:56 +0000 (UTC)
Received: from localhost (ovpn-117-205.ams2.redhat.com [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7739960BEC;
 Fri, 25 Oct 2019 09:58:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC 0/3] block/file-posix: Work around XFS bug
Date: Fri, 25 Oct 2019 11:58:46 +0200
Message-Id: <20191025095849.25283-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 54bGxlm0M2OFKSfSwawPhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driver, as
I=E2=80=99ve explained here:

https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html

In combination with our commit c8bb23cbdbe32f, this may lead to guest
data corruption when using qcow2 images on XFS with aio=3Dnative.

We can=E2=80=99t wait until the XFS kernel driver is fixed, we should work
around the problem ourselves.

This is an RFC for two reasons:
(1) I don=E2=80=99t know whether this is the right way to address the issue=
,
(2) Ideally, we should detect whether the XFS kernel driver is fixed and
    if so stop applying the workaround.
    I don=E2=80=99t know how we would go about this, so this series doesn=
=E2=80=99t do
    it.  (Hence it=E2=80=99s an RFC.)
(3) Perhaps it=E2=80=99s a bit of a layering violation to let the file-posi=
x
    driver access and modify a BdrvTrackedRequest object.

As for how we can address the issue, I see three ways:
(1) The one presented in this series: On XFS with aio=3Dnative, we extend
    tracked requests for post-EOF fallocate() calls (i.e., write-zero
    operations) to reach until infinity (INT64_MAX in practice), mark
    them serializing and wait for other conflicting requests.

    Advantages:
    + Limits the impact to very specific cases
      (And that means it wouldn=E2=80=99t hurt too much to keep this workar=
ound
      even when the XFS driver has been fixed)
    + Works around the bug where it happens, namely in file-posix

    Disadvantages:
    - A bit complex
    - A bit of a layering violation (should file-posix have access to
      tracked requests?)

(2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.  The XFS bug o=
nly
    becomes visible due to that function: I don=E2=80=99t think qcow2 write=
s
    zeroes in any other I/O path, and raw images are fixed in size so
    post-EOF writes won=E2=80=99t happen.

    Advantages:
    + Maybe simpler, depending on how difficult it is to handle the
      layering violation
    + Also fixes the performance problem of handle_alloc_space() being
      slow on ppc64+XFS.

    Disadvantages:
    - Huge layering violation because qcow2 would need to know whether
      the image is stored on XFS or not.
    - We=E2=80=99d definitely want to skip this workaround when the XFS dri=
ver
      has been fixed, so we need some method to find out whether it has

(3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
    To my knowledge I=E2=80=99m the only one who has provided any benchmark=
s for
    this commit, and even then I was a bit skeptical because it performs
    well in some cases and bad in others.  I concluded that it=E2=80=99s
    probably worth it because the =E2=80=9Csome cases=E2=80=9D are more lik=
ely to occur.

    Now we have this problem of corruption here (granted due to a bug in
    the XFS driver), and another report of massively degraded
    performance on ppc64
    (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=80=93 sorry,=
 a
    private BZ; I hate that :-/  The report is about 40 % worse
    performance for an in-guest fio write benchmark.)

    So I have to ask the question about what the justification for
    keeping c8bb23cbdbe32f is.  How much does performance increase with
    it actually?  (On non-(ppc64+XFS) machines, obviously)

    Advantages:
    + Trivial
    + No layering violations
    + We wouldn=E2=80=99t need to keep track of whether the kernel bug has =
been
      fixed or not
    + Fixes the ppc64+XFS performance problem

    Disadvantages:
    - Reverts cluster allocation performance to pre-c8bb23cbdbe32f
      levels, whatever that means

So this is the main reason this is an RFC: What should we do?  Is (1)
really the best choice?


In any case, I=E2=80=99ve ran the test case I showed in
https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01282.html
more than ten times with this series applied and the installation
succeeded every time.  (Without this series, it fails like every other
time.)


Max Reitz (3):
  block: Make wait/mark serialising requests public
  block/file-posix: Detect XFS with CONFIG_FALLOCATE
  block/file-posix: Let post-EOF fallocate serialize

 include/block/block_int.h |  3 +++
 block/file-posix.c        | 46 +++++++++++++++++++++++++++++++++++++--
 block/io.c                | 24 ++++++++++----------
 3 files changed, 59 insertions(+), 14 deletions(-)

--=20
2.21.0


