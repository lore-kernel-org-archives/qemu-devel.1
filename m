Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44598C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1119F2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD/m2y1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1119F2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY2E-00041Z-7i
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1H-0002HM-3c
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26874
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1F-0002mA-Et
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2t20qZtGK3zu569dBP1PPwGug5fDq/mvy0CcfwJjl0E=;
 b=hD/m2y1FQGmy2lWUrKAbNCfDM008wGR+pGx+mL26BwvlNwKqLA/wO+zrQMK8D8IQclxU7Y
 kZNVLX5FgVccN1mDAA7WxjuEm17Zpm3CDVZEctaFYLi0HSqhefmHTuS77muKMjnLKua9CW
 Ju56Th7VasgfcBZ2wCLuGNz75BrpGrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-rQKpJq-QPE-8kY7Sd9nOOA-1; Wed, 17 Jun 2020 09:22:19 -0400
X-MC-Unique: rQKpJq-QPE-8kY7Sd9nOOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07E9918A2670;
 Wed, 17 Jun 2020 13:22:18 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD3187890A;
 Wed, 17 Jun 2020 13:22:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] block/nvme: drop tautologous assertion
Date: Wed, 17 Jun 2020 14:21:56 +0100
Message-Id: <20200617132201.1832152-3-stefanha@redhat.com>
In-Reply-To: <20200617132201.1832152-1-stefanha@redhat.com>
References: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bnZtZV9wcm9jZXNzX2NvbXBsZXRpb24oKSBleHBsaWNpdGx5IGNoZWNrcyBjaWQgc28gdGhlIGFz
c2VydGlvbiB0aGF0CmZvbGxvd3MgaXMgYWx3YXlzIHRydWU6CgogIGlmIChjaWQgPT0gMCB8fCBj
aWQgPiBOVk1FX1FVRVVFX1NJWkUpIHsKICAgICAgLi4uCiAgICAgIGNvbnRpbnVlOwogIH0KICBh
c3NlcnQoY2lkIDw9IE5WTUVfUVVFVUVfU0laRSk7CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTZXJnaW8gTG9wZXogPHNs
cEByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5k
ZXggZTQzNzVlYzI0NS4uZDU2N2VjZTNmNCAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBi
L2Jsb2NrL252bWUuYwpAQCAtMzM2LDcgKzMzNiw2IEBAIHN0YXRpYyBib29sIG52bWVfcHJvY2Vz
c19jb21wbGV0aW9uKEJEUlZOVk1lU3RhdGUgKnMsIE5WTWVRdWV1ZVBhaXIgKnEpCiAgICAgICAg
ICAgICAgICAgICAgIGNpZCk7CiAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgfQotICAg
ICAgICBhc3NlcnQoY2lkIDw9IE5WTUVfUVVFVUVfU0laRSk7CiAgICAgICAgIHRyYWNlX252bWVf
Y29tcGxldGVfY29tbWFuZChzLCBxLT5pbmRleCwgY2lkKTsKICAgICAgICAgcHJlcSA9ICZxLT5y
ZXFzW2NpZCAtIDFdOwogICAgICAgICByZXEgPSAqcHJlcTsKLS0gCjIuMjYuMgoK


