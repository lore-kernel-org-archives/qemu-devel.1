Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB7AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E242098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQUwxpej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E242098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY27-0003ll-UP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1C-0002AE-9l
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32257
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1A-0002lB-Fb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hjcp3AXa2UsO21Kzl+n5b2UkO7cOKXs+Kfo7rr3Qohw=;
 b=EQUwxpejDOUEzAphwq8LydJjFNFCUlcSy7S/bToxMkNtPQAUa3WrFpejPKXjPaWu3z3POk
 i3FC9FO0YJOayVLlWZpP6jawPsIgvUrQQpeM4GugUup7/VYJyhoP8TNmyOPAOIJO3WDk5j
 7IhqH6CqqvPO2Tg3fgoyIIf5QkxysNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-K5mmeOaKO4mPG7ifiF6PjQ-1; Wed, 17 Jun 2020 09:22:09 -0400
X-MC-Unique: K5mmeOaKO4mPG7ifiF6PjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9468A835B77;
 Wed, 17 Jun 2020 13:22:08 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7825D9D3;
 Wed, 17 Jun 2020 13:22:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] block/nvme: support nested aio_poll()
Date: Wed, 17 Jun 2020 14:21:54 +0100
Message-Id: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBSZXdvcmQgY29tbWVudCBpbiBQYXRjaCAxIGV4cGxhaW5pbiB3aHkgaXRzIHNhZmUg
bm90IHRvIGhvbGQgcS0+bG9jayBbU2VyZ2lvXQ0KICogRml4IHMvdW53aWVkbHkvdW53aWVsZHkv
IHR5cG8gaW4gdGhlIFBhdGNoIDYgY29tbWl0IGRlc2NyaXB0aW9uIFtQaGlsaXBwZV0NCg0KVGhp
cyBzZXJpZXMgYWxsb3dzIGFpb19wb2xsKCkgdG8gd29yayBmcm9tIEkvTyByZXF1ZXN0IGNvbXBs
ZXRpb24gY2FsbGJhY2tzLg0KUUVNVSBibG9jayBkcml2ZXJzIGFyZSBzdXBwb3NlZCB0byBzdXBw
b3J0IHRoaXMgYmVjYXVzZSBzb21lIGNvZGUgcGF0aHMgcmVseSBvbg0KdGhpcyBiZWhhdmlvci4N
Cg0KVGhlcmUgd2FzIG5vIG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZSB3aXRoIG5l
c3RlZCBhaW9fcG9sbCgpIHN1cHBvcnQuDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGFsc28gY29udGFp
bnMgY2xlYW51cHMgdGhhdCBJIG1hZGUgd2hpbGUgZXhhbWluaW5nIGFuZA0KYmVuY2htYXJraW5n
IHRoZSBjb2RlLg0KDQpTdGVmYW4gSGFqbm9jemkgKDcpOg0KICBibG9jay9udm1lOiBwb2xsIHF1
ZXVlcyB3aXRob3V0IHEtPmxvY2sNCiAgYmxvY2svbnZtZTogZHJvcCB0YXV0b2xvZ291cyBhc3Nl
cnRpb24NCiAgYmxvY2svbnZtZTogZG9uJ3QgYWNjZXNzIENRRSBhZnRlciBtb3ZpbmcgY3EuaGVh
ZA0KICBibG9jay9udm1lOiBzd2l0Y2ggdG8gYSBOVk1lUmVxdWVzdCBmcmVlbGlzdA0KICBibG9j
ay9udm1lOiBjbGFyaWZ5IHRoYXQgZnJlZV9yZXFfcXVldWUgaXMgcHJvdGVjdGVkIGJ5IHEtPmxv
Y2sNCiAgYmxvY2svbnZtZToga2VlcCBCRFJWTlZNZVN0YXRlIHBvaW50ZXIgaW4gTlZNZVF1ZXVl
UGFpcg0KICBibG9jay9udm1lOiBzdXBwb3J0IG5lc3RlZCBhaW9fcG9sbCgpDQoNCiBibG9jay9u
dm1lLmMgICAgICAgfCAyMjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tDQogYmxvY2svdHJhY2UtZXZlbnRzIHwgICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAx
NjAgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNi4yDQoNCg==


