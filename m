Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C452AC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CBF20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LI6TCsfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CBF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMs7-0002Z9-Om
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jFMrO-0001aW-4c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jFMrM-0004QP-M9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:09 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jFMrM-0004FB-3b; Fri, 20 Mar 2020 14:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
 bh=OwwiqZDOZYNLx3OtSAldsjmlJl+LnyWbr+Dfv7H1bOg=; 
 b=LI6TCsfK6fZdLeUjqPPBzgPHLLyWNsfO6TSOjC+F3T4+TS4SgWUTSNxE9X2aDMjGnAR6mO6mtcowMSoJyNPZYOKXPUxm28H7tF5NesaM0r6vw09w+eWUPdmTJeRgeUmQb5wB9naPQqnQ0oo/xHoWE0TaJ8VEPLlVkQWd3qAJkzY1o5m2CbS8UZb2dAZowt2khPI9cxb2SMGQgsYWMyLz8NgTrIyB4TrbgnnKW5IHiKv3hrP5l7dvPX5Dm0cn2B/D1ZywXQTqzhr8Hvt3Mc2Jllpmnsrf91lQuvt490YeK0mG3VZ75z3qYjTaxwjt0nw2tU0unohr+XeBZzjLIxcpEA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jFMr2-0007Ck-SE; Fri, 20 Mar 2020 19:58:48 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jFMr2-0001al-Ia; Fri, 20 Mar 2020 19:58:48 +0100
Date: Fri, 20 Mar 2020 19:58:48 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: discard and v2 qcow2 images
Message-ID: <20200320185848.GA5720@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

when full_discard is false in discard_in_l2_slice() then the selected
cluster should be deallocated and it should read back as zeroes. This
is done by clearing the cluster offset field and setting OFLAG_ZERO in
the L2 entry.

This flag is however only supported when qcow_version >= 3. In older
images the cluster is simply deallocated, exposing any possible
previous data from the backing file.

This can be trivially reproduced like this:

   qemu-img create -f qcow2 backing.img 64k
   qemu-io -c 'write -P 0xff 0 64k' backing.img
   qemu-img create -f qcow2 -o compat=0.10 -b backing.img top.img
   qemu-io -c 'write -P 0x01 0 64k' top.img

After this, top.img is filled with 0x01. Now we issue a discard
command:

   qemu-io -c 'discard 0 64k' top.img

top.img should now read as zeroes, but instead you get the data from
the backing file (0xff). If top.img was created with compat=1.1
instead (the default) then it would read as zeroes after the discard.

This seems like a bug to me, and I would simply forbid using discard
in this case (see below). The other user of full_discard = false is
qcow2_snapshot_create() but I think that one is safe and should be
allowed?

--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3763,6 +3763,10 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
+    if (s->qcow_version < 3) {
+        return -ENOTSUP;
+    }
+
     if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
         assert(bytes < s->cluster_size);
         /* Ignore partial clusters, except for the special case of the

Berto

