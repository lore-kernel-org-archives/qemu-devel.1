Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE88C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8773821775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vro34TU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8773821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmZt-00072p-Oi
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmYL-0005m5-CJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmYK-0002dz-QC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:15:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56313
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTmYK-0002dg-DF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588166103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHJ5OrObd5lWEoAZ5X+WaObvzESGCY7VL90bFN2zKsw=;
 b=Vro34TU4SH0JxXk1pne5JxcBg0FCFK2BiJljCBZDY71djqniVgPSbpH5vTzx6PR6ffC5y9
 oPAl/dE2XDP+Tx6Alfk3tg9EQYvCTnwhvM9F4MQhbeyrNGBDmOsS1tlBdzzMDe5L+3hWJT
 qkAGF7uviC51ZwarQ+t1PYA5duVo8A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-qfokVEuvP5qUJqWg_Mtv3A-1; Wed, 29 Apr 2020 09:14:50 -0400
X-MC-Unique: qfokVEuvP5qUJqWg_Mtv3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA938014D5;
 Wed, 29 Apr 2020 13:14:49 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1955C1BE;
 Wed, 29 Apr 2020 13:14:48 +0000 (UTC)
Subject: Re: [PATCH 0/9] More truncate improvements
To: qemu-devel@nongnu.org
References: <158812705840.2837.3534564330691034557@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dba78fab-b7a7-1f33-e65d-52d6ab654c46@redhat.com>
Date: Wed, 29 Apr 2020 08:14:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158812705840.2837.3534564330691034557@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 9:24 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200428202905.770727-1-eblake@redhat.com/
> 

> /tmp/qemu-test/src/block/parallels.c: In function 'parallels_co_writev':
> /tmp/qemu-test/src/block/parallels.c:218:12: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>           if (ret < 0) {
>              ^
> /tmp/qemu-test/src/block/parallels.c:169:9: note: 'ret' was declared here
>       int ret;
>           ^

False positive: the code is roughly:

int ret;
if (cond1) {
   ret = ...;
}
if (cond2) {
   ret = ...;
}
if (ret < 0)

but the compiler can't prove that cond1 + cond2 covers all 
possibilities.  The obvious fix is to initialize ret; squash this into 7/9:

diff --git i/block/parallels.c w/block/parallels.c
index eb6c6c01b998..e7717c508e62 100644
--- i/block/parallels.c
+++ w/block/parallels.c
@@ -166,7 +166,7 @@ static int64_t block_status(BDRVParallelsState *s, 
int64_t sector_num,
  static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                   int nb_sectors, int *pnum)
  {
-    int ret;
+    int ret = 0;
      BDRVParallelsState *s = bs->opaque;
      int64_t pos, space, idx, to_allocate, i, len;





-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


