Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA83A206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmeuYZc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA83A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5kD-0003Sq-36
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5ix-00027V-5V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5is-0002KS-UR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599202882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MEBuq0zfJBQ1/zxCRza1DPT/6+tMCyqccviMn0hSOs=;
 b=ZmeuYZc6XIO8HVwGOO3fRHLK7ShLtbGw7Tp/fzdQDG4yy1ErqF6fLiKmptW/L3quGyB2K1
 /29MOvjRUavTHiJpjwqSKUUuQVcScGz3DLJ45RMLcWE9vUIiyr9yDV6viTsDuYlB9nhCjN
 a24W9lFmg3LuKxJElJrDIKsFFo8P9PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-GNWjTNKJNLC-m3yhNf37iw-1; Fri, 04 Sep 2020 03:01:18 -0400
X-MC-Unique: GNWjTNKJNLC-m3yhNf37iw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A4F41019629;
 Fri,  4 Sep 2020 07:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBD967DA51;
 Fri,  4 Sep 2020 07:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0F0A1204AE; Fri,  4 Sep 2020 09:01:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string
Date: Fri,  4 Sep 2020 09:01:10 +0200
Message-Id: <20200904070112.7315-3-kraxel@redhat.com>
In-Reply-To: <20200904070112.7315-1-kraxel@redhat.com>
References: <20200904070112.7315-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 02:03:31
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
Cc: Li Qiang <liq3ea@gmail.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'addr' is forgot to free in vnc_socket_ip_addr_string error path. Fix that.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200831134315.1221-11-pannengyuan@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-auth-sasl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 7b2b09f24276..0517b2ead9ce 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -522,6 +522,7 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
 
     if (addr->type != SOCKET_ADDRESS_TYPE_INET) {
         error_setg(errp, "Not an inet socket type");
+        qapi_free_SocketAddress(addr);
         return NULL;
     }
     ret = g_strdup_printf("%s;%s", addr->u.inet.host, addr->u.inet.port);
-- 
2.27.0


