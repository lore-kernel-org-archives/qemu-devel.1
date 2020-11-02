Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735BBC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D959120706
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+2RFwdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D959120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZg14-0008J1-N0
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfxL-0003Fe-LV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfxB-0002H0-Oh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604347039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2A7BmYSwoqgO+MxWARNx61HoQgC5UFmQDlge8zY+JuI=;
 b=A+2RFwdl1SM/oP46OKDmErk7b96T4g0YYKuhLECAdgODLPSkuwMk+ePxG3tILla+ALeEjs
 58N4JGyBEEunw+BP0lJnsVv7lNtztEf8F34lL1nSAVVVfalSr4x9HezvKgioYTRPIRKy/t
 8BwCSvLnc5KfmHpKvszWdZ2VdxuB+gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-vFOmU8hKPniJ8YUt0cp-hA-1; Mon, 02 Nov 2020 14:57:17 -0500
X-MC-Unique: vFOmU8hKPniJ8YUt0cp-hA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9F21006C99;
 Mon,  2 Nov 2020 19:57:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C58A1002C1F;
 Mon,  2 Nov 2020 19:57:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, peterx@redhat.com, philmd@redhat.com,
 zhangjiachen.jaycee@bytedance.com, mreitz@redhat.com
Subject: [PULL 05/12] virtiofsd: Fix the help message of posix lock
Date: Mon,  2 Nov 2020 19:56:50 +0000
Message-Id: <20201102195657.219501-6-dgilbert@redhat.com>
In-Reply-To: <20201102195657.219501-1-dgilbert@redhat.com>
References: <20201102195657.219501-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

The commit 88fc107956a5812649e5918e0c092d3f78bb28ad disabled remote
posix locks by default. But the --help message still says it is enabled
by default. So fix it to output no_posix_lock.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Message-Id: <20201027081558.29904-1-zhangjiachen.jaycee@bytedance.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 2e181a49b5..ae1b22e4a6 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -161,7 +161,7 @@ void fuse_cmdline_help(void)
            "                               allowed (default: 10)\n"
            "    -o posix_lock|no_posix_lock\n"
            "                               enable/disable remote posix lock\n"
-           "                               default: posix_lock\n"
+           "                               default: no_posix_lock\n"
            "    -o readdirplus|no_readdirplus\n"
            "                               enable/disable readirplus\n"
            "                               default: readdirplus except with "
-- 
2.28.0


