Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3172C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A0D20727
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRcIrTp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A0D20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5q1-0005Iz-5n
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5or-0004LY-1C
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5on-0007hF-OF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603969807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A47iyUrQOmrPhm7wOWiOvkmMu6xk8xxKAcxFi5chMu8=;
 b=VRcIrTp3saa79Enqe7D6xPJR5ReFXq9+K8f2MlFHfBUz+Jy5nBv9818lAC+rOhuHdsRDO+
 3Bnra6MWrx/9fI3P0U2rOMTb3GNI+Q8pktV/shYJocRNp6TrgOWvfhSnxJ21L76jtWkGXd
 16wcCBlrPopmjYr6VtT6zfQM7xKXU5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-KDVYDN1ZPzKhuthUY5-LXg-1; Thu, 29 Oct 2020 07:10:05 -0400
X-MC-Unique: KDVYDN1ZPzKhuthUY5-LXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC76A10E218D
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:10:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28EB82C31E;
 Thu, 29 Oct 2020 11:09:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6171F9D0F; Thu, 29 Oct 2020 12:09:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] modules: unbreak them on macos
Date: Thu, 29 Oct 2020 12:09:56 +0100
Message-Id: <20201029110957.11062-5-kraxel@redhat.com>
In-Reply-To: <20201029110957.11062-1-kraxel@redhat.com>
References: <20201029110957.11062-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the correct shared library suffix helps ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20201027120603.3625-1-kraxel@redhat.com
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 83610b0db8ea..6df4306c884f 100755
--- a/configure
+++ b/configure
@@ -618,6 +618,7 @@ Darwin)
   if test -z "$cpu" && test "$(sysctl -n hw.optional.x86_64)" = "1"; then
     cpu="x86_64"
   fi
+  HOST_DSOSUF=".dylib"
   ;;
 SunOS)
   # $(uname -m) returns i86pc even on an x86_64 box, so default based on isainfo
-- 
2.27.0


