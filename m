Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8665C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E860214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4Ryr1/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E860214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDdj-0004aH-Oh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlDa0-0001e9-Fj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:32:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlDZx-00060G-2o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592321568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgqodBgPCpfM8/0FpwIzpWCD6Hgmukz/7nJnfys5gjg=;
 b=B4Ryr1/m4f7yiEuHhWN9ZZzjDOr+bP7eRyYrBh7SC6pUHdd3SuR0nU97lVlsOMCQs6xGB5
 V/t4hJD1XFHHX31k8Zskab5DglNYqSTQjmF6pQeyvVSAniZkbQhSHk7emWsIx5ZPtCiJ9M
 dIig6i5q4oaVgjtEsZyZdY5Nc0M5+qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-oKQKLNzZNOi3CbYB4PYA9A-1; Tue, 16 Jun 2020 11:32:46 -0400
X-MC-Unique: oKQKLNzZNOi3CbYB4PYA9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29F680332B;
 Tue, 16 Jun 2020 15:32:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5839979304;
 Tue, 16 Jun 2020 15:32:43 +0000 (UTC)
Date: Tue, 16 Jun 2020 17:32:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] block: file-posix: Fail unmap with NO_FALLBACK on block
 device
Message-ID: <20200616153241.GF4305@linux.fritz.box>
References: <20200613170826.354270-1-nsoffer@redhat.com>
 <CAMRbyyswkaedF0dN2nPb3H8fj5+pmhLWh9GHGor4wUk_Su=b8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyyswkaedF0dN2nPb3H8fj5+pmhLWh9GHGor4wUk_Su=b8A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: nirsof <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>, pl@kamp.de,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.06.2020 um 21:32 hat Nir Soffer geschrieben:
> We can zero 2.3 g/s:
> 
> # time blkdiscard -z test-lv
> 
> real 0m43.902s
> user 0m0.002s
> sys 0m0.130s

> We can write 445m/s:
> 
> # dd if=/dev/zero bs=2M count=51200 of=test-lv oflag=direct conv=fsync
> 107374182400 bytes (107 GB, 100 GiB) copied, 241.257 s, 445 MB/s

So using FALLOC_FL_PUNCH_HOLE _is_ faster after all. What might not be
faster is zeroing out the whole device and then overwriting a
considerable part of it again.

I think this means that we shouldn't fail write_zeroes at the file-posix
level even if BDRV_REQ_NO_FALLBACK is given. Instead, qemu-img convert
is where I see a fix.

Certainly qemu-img could be cleverer and zero out more selectively. The
idea of doing a blk_make_zero() first seems to have caused some
problems, though of course its introduction was also justified with
performance, so improving one case might hurt another if we're not
careful.

However, when Peter Lieven introduced this (commit 5a37b60a61c), we
didn't use write_zeroes yet during the regular copy loop (we do since
commit 690c7301600). So chances are that blk_make_zero() doesn't
actually help any more now.

Can you run another test with the patch below? I think it should perform
the same as yours. Eric, Peter, do you think this would have a negative
effect for NBD and/or iscsi?

The other option would be providing an option and making it Someone
Else's Problem.

Kevin


diff --git a/qemu-img.c b/qemu-img.c
index d7e846e607..bdb9f6aa46 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2084,15 +2084,6 @@ static int convert_do_copy(ImgConvertState *s)
         s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
     }

-    if (!s->has_zero_init && !s->target_has_backing &&
-        bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
-    {
-        ret = blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
-        if (ret == 0) {
-            s->has_zero_init = true;
-        }
-    }
-
     /* Allocate buffer for copied data. For compressed images, only one cluster
      * can be copied at a time. */
     if (s->compressed) {


