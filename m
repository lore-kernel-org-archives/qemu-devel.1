Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D2820826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo+CnunP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D2820826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI16-0003aL-1j
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtP-0002mE-HF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:21:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtN-0000xP-Vp
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgDhseqCFHPUzondXeQso6AXVU4ku95v/WJUYakn3eY=;
 b=Vo+CnunP/6OSa5VYk2wM8Q528/o8n54vIrTfk3zcOJHodArfRORypi+0IpIUzrTzIEiP0N
 lnPz5LFMTeesl2FUtfgqORSOCsNo5qsb0h1mPseO9Y3un5CCWPyrDqtWD0BaGakBBfbhVa
 cB3ZpNXQbXxCfZKuFcAj1M8RsuvArL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ddL8IaueMzKFyjIPeRg8eg-1; Fri, 03 Jul 2020 05:21:54 -0400
X-MC-Unique: ddL8IaueMzKFyjIPeRg8eg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E0E800C60;
 Fri,  3 Jul 2020 09:21:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE93F7AC63;
 Fri,  3 Jul 2020 09:21:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/7] qemu-storage-daemon: remember to add qemu_object_opts
Date: Fri,  3 Jul 2020 11:21:38 +0200
Message-Id: <20200703092143.165594-3-kwolf@redhat.com>
In-Reply-To: <20200703092143.165594-1-kwolf@redhat.com>
References: <20200703092143.165594-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The --object option is supported by qemu-storage-daemon but the
qemu_object_opts QemuOptsList wasn't being added. As a result calls to
qemu_find_opts("object") failed with "There is no option group
'object'".

This patch fixes the object-del QMP command.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200619101132.2401756-2-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 9e7adfe3a6..a01cbd6371 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -316,6 +316,7 @@ int main(int argc, char *argv[])
 
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_TRACE);
+    qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_trace_opts);
     qcrypto_init(&error_fatal);
     bdrv_init();
-- 
2.25.4


