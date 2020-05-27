Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1058F20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbyCa3FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1058F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdp8X-0004ex-8H
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6Y-0002aA-Jm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6W-0004Dj-BL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMTB13MBlpQtZKdvSYzHk5QibalQ2G1E943+vWAs4eY=;
 b=VbyCa3FUK0YIY/llysuD4EgXTrpkIDegi01fL93kjfOBPrNG4zA1y9HzxW4F/N76esLYnF
 2URa7F3KvmqZB9UO2Jx26r1Od1LdVLU3fIvWYZ5jGW7HzKJUJKNK7k+Hh+9j7cf8OtqyQB
 Lu+h1ndVcnumq/Wen5AtGTSAj2l2Qpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-A3Rb5X4jMaCsjM_7wsDjfg-1; Wed, 27 May 2020 01:59:49 -0400
X-MC-Unique: A3Rb5X4jMaCsjM_7wsDjfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E51D800688;
 Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5926719D7E;
 Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1F8211386A0; Wed, 27 May 2020 07:59:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] nvdimm: Plug memory leak in uuid property setter
Date: Wed, 27 May 2020 07:59:36 +0200
Message-Id: <20200527055945.6774-2-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvdimm_set_uuid() leaks memory on qemu_uuid_parse() failure.  Fix
that.

Fixes: 6c5627bb24dcd68c997857a8b671617333b1289f
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505101908.6207-2-armbru@redhat.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/mem/nvdimm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index c5adedcc69..76f66e0b19 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -97,7 +97,6 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
     if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
         error_setg(errp, "Property '%s.%s' has invalid value",
                    object_get_typename(obj), name);
-        goto out;
     }
     g_free(value);
 
-- 
2.21.3


