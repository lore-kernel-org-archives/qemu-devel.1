Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3090BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB21207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC2XPo//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB21207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oBu-0007gD-5t
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0oBA-0006zg-UJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:39:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0oB8-0005h9-5o
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596037176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TMX7oK+YZgERLAfX7ZNg22dPrVyCnBORm9hMJctJTEc=;
 b=LC2XPo//ia8W9VgcvwXCYwrkGGALB7sXx6dSZc1pvGQwjUinszyklDsQZbODzhgr6Hd7s5
 pAy77rOj3XHzjuUd8gzLuq1mrfH1a6KmFinaJAKm1fNCe8OevQmPKYFqhCM1QaLZs0nuH6
 vIu2zEReU269Ts4MMvOQ1QQBl/ocZn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-cuSQi9dfNsC4pkKlsUooCg-1; Wed, 29 Jul 2020 11:39:34 -0400
X-MC-Unique: cuSQi9dfNsC4pkKlsUooCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85AC8017FB
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 15:39:33 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B65CA71906;
 Wed, 29 Jul 2020 15:39:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] tracetool: carefully define SDT_USE_VARIADIC
Date: Wed, 29 Jul 2020 16:39:26 +0100
Message-Id: <20200729153926.127083-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGR0cmFjZSBiYWNrZW5kIGRlZmluZXMgU0RUX1VTRV9WQVJJQURJQyBhcyBhIHdvcmthcm91
bmQgZm9yIGEKY29uZmxpY3Qgd2l0aCBhIExUVG5nIFVTVCBoZWFkZXIgZmlsZSwgd2hpY2ggcmVx
dWlyZXMgU0RUX1VTRV9WQVJJQURJQwp0byBiZSBkZWZpbmVkLgoKTFRUbmcgVVNUIDxsdHRuZy90
cmFjZXBvaW50Lmg+IGJyZWFrcyBpZiBpbmNsdWRlZCBhZnRlciBnZW5lcmF0ZWQgZHRyYWNlCmhl
YWRlcnMgYmVjYXVzZSBTRFRfVVNFX1ZBUklBRElDIHdpbGwgYWxyZWFkeSBiZSBkZWZpbmVkOgoK
ICAjaWZkZWYgTFRUTkdfVVNUX0hBVkVfU0RUX0lOVEVHUkFUSU9OCiAgI2RlZmluZSBTRFRfVVNF
X1ZBUklBRElDIDwtLSBlcnJvciwgaXQncyBhbHJlYWR5IGRlZmluZWQKICAjaW5jbHVkZSA8c3lz
L3NkdC5oPgoKQmUgbW9yZSBjYXJlZnVsIHdoZW4gZGVmaW5pbmcgU0RUX1VTRV9WQVJJQURJQy4g
VGhpcyBmaXhlcyB0aGUgYnVpbGQKd2hlbiBib3RoIHRoZSBkdHJhY2UgYW5kIHVzdCB0cmFjZXJz
IGFyZSBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUuCgpGaXhlczogMjdlMDhiYWI5NGY3YzZlYmUw
Yjc1OTM4Yzk4YzM5NGM5NjllM2ZkOCAoInRyYWNldG9vbDogd29yayBhcm91bmQgdXN0IDxzeXMv
c2R0Lmg+IGluY2x1ZGUgY29uZmxpY3QiKQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9kdHJh
Y2UucHkgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2R0cmFjZS5weSBiL3NjcmlwdHMvdHJhY2V0
b29sL2JhY2tlbmQvZHRyYWNlLnB5CmluZGV4IGI3ZmU0YzFiNTAuLmZjMGM4ZmM1MmYgMTAwNjQ0
Ci0tLSBhL3NjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvZHRyYWNlLnB5CisrKyBiL3NjcmlwdHMv
dHJhY2V0b29sL2JhY2tlbmQvZHRyYWNlLnB5CkBAIC00NCwxMSArNDQsMTUgQEAgZGVmIGdlbmVy
YXRlX2hfYmVnaW4oZXZlbnRzLCBncm91cCk6CiAgICAgIyByZXF1aXJlIFNEVF9VU0VfVkFSSUFE
SUMgdG8gYmUgZGVmaW5lZC4gSWYgZHRyYWNlIGluY2x1ZGVzIDxzeXMvc2R0Lmg+CiAgICAgIyBm
aXJzdCB3aXRob3V0IGRlZmluaW5nIFNEVF9VU0VfVkFSSUFESUMgdGhlbiB1c3QgYnJlYWtzIGJl
Y2F1c2UgdGhlCiAgICAgIyBTVEFQX1BST0JFVigpIG1hY3JvIGlzIG5vdCBkZWZpbmVkLgorICAg
IG91dCgnI2lmbmRlZiBTRFRfVVNFX1ZBUklBRElDJykKICAgICBvdXQoJyNkZWZpbmUgU0RUX1VT
RV9WQVJJQURJQyAxJykKKyAgICBvdXQoJyNlbmRpZicpCiAKICAgICBvdXQoJyNpbmNsdWRlICIl
cyInICUgaGVhZGVyLAogICAgICAgICAnJykKIAorICAgIG91dCgnI3VuZGVmIFNEVF9VU0VfVkFS
SUFESUMnKQorCiAgICAgIyBTeXN0ZW1UYXAgZGVmaW5lcyA8cHJvdmlkZXI+XzxuYW1lPl9FTkFC
TEVEKCkgYnV0IG90aGVyIERUcmFjZQogICAgICMgaW1wbGVtZW50YXRpb25zIG1pZ2h0IG5vdC4K
ICAgICBmb3IgZSBpbiBldmVudHM6Ci0tIAoyLjI2LjIKCg==


