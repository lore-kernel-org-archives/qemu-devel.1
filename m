Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E0C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C449B20679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjXCaq+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C449B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFBk-0008PF-A0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAW-0006lC-Bm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAI-0002yp-9v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3MGDqxPfpiFKyA+WUD1oORoW1JjGYcqOMqS3lo6k9kE=;
 b=SjXCaq+REzgiUOvz+kpvata7pkHltHmMUzn03bRIGRlFHED6wpM32ALqUbr6OqPDcOUUR3
 v0GQVST09FBuYQf51o9X9D3g5vqCsPrV5/SgYWrw/KVYdmXo54oi6oRYbq8MnrGRbZPN3T
 uoEYefFJ21ppTdwVYQXb32rAH4ZwMdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-obzvNJhaNb6dAmxEe8MMeg-1; Tue, 29 Sep 2020 08:55:25 -0400
X-MC-Unique: obzvNJhaNb6dAmxEe8MMeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE60D80EDA9;
 Tue, 29 Sep 2020 12:55:23 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083201002C04;
 Tue, 29 Sep 2020 12:55:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] block/export: add BlockExportOptions->iothread member
Date: Tue, 29 Sep 2020 13:55:12 +0100
Message-Id: <20200929125516.186715-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBBZGQgZml4ZWQtaW90aHJlYWQgb3B0aW9uIHRvIHNldCBBaW9Db250ZXh0IGNoYW5n
ZSBwb2xpY3kgW0tldmluXQ0KICogVXNlIG9zLXBvc2l4LmMgc2lnbmFsIGhhbmRsaW5nIHV0aWxp
dGllcyBpbiBxZW11LW5iZC5jIFtQYW9sb10NCg0KVGhpcyBzZXJpZXMgYWRqdXN0cyB0aGUgYnVp
bGQgc3lzdGVtIGFuZCB0aGVuIGFkZHMgYQ0KQmxvY2tFeHBvcnRPcHRpb25zLT5pb3RocmVhZCBt
ZW1iZXIgc28gdGhhdCBpdCBpcyBwb3NzaWJsZSB0byBzZXQgdGhlIGlvdGhyZWFkDQpmb3IgYW4g
ZXhwb3J0Lg0KDQpCYXNlZC1vbjogMjAyMDA5MjQxNTE1NDkuOTEzNzM3LTEtc3RlZmFuaGFAcmVk
aGF0LmNvbSAoIltQQVRDSCB2MiAwMC8xM10gYmxvY2svZXhwb3J0OiBjb252ZXJ0IHZob3N0LXVz
ZXItYmxrLXNlcnZlciB0byBibG9jayBleHBvcnRzIEFQSSIpDQoNClN0ZWZhbiBIYWpub2N6aSAo
NCk6DQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IHVzZSBzdGF0aWMgbGlicmFyeSBpbiBtZXNv
bi5idWlsZA0KICBxZW11LXN0b3JhZ2UtZGFlbW9uOiBhdm9pZCBjb21waWxpbmcgYmxvY2tkZXZf
c3MgdHdpY2UNCiAgYmxvY2s6IG1vdmUgYmxvY2sgZXhwb3J0cyB0byBsaWJibG9ja2Rldg0KICBi
bG9jay9leHBvcnQ6IGFkZCBpb3RocmVhZCBhbmQgZml4ZWQtaW90aHJlYWQgb3B0aW9ucw0KDQog
cWFwaS9ibG9jay1leHBvcnQuanNvbiAgICAgICAgICAgICAgIHwgMTEgKysrKysrKysNCiBibG9j
ay9leHBvcnQvZXhwb3J0LmMgICAgICAgICAgICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jIHwgIDUgKysr
LQ0KIG5iZC9zZXJ2ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQogcWVtdS1u
YmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKy0tLS0tLS0tDQogc3R1
YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyAgICAgICAgICAgIHwgIDcgKysrKysNCiBibG9jay9leHBv
cnQvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAgNCArLS0NCiBjb250cmliL2xpYnZob3N0LXVz
ZXIvbWVzb24uYnVpbGQgICAgfCAgMSArDQogbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMjIgKysrKysrKysrKysrLS0tLQ0KIG5iZC9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgICB8ICAyICsrDQogc3RvcmFnZS1kYWVtb24vbWVzb24uYnVpbGQgICAgICAgICAg
IHwgIDMgKy0tDQogc3R1YnMvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0K
IHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICB8ICAyICstDQogdXRpbC9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystDQogMTQgZmlsZXMgY2hhbmdlZCwg
OTMgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0
dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMNCg0KLS0gDQoyLjI2LjINCg0K


