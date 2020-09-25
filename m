Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D3C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18452086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtMe/hpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18452086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo1t-0005h1-N3
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzm-0004O9-W6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzk-0008G7-V1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a3z463fBf+suJcMYbOUJbTwXPI9R+sIHfxe1orkCLPA=;
 b=UtMe/hppnpvSraq3T/sdHyDjH3hAaK31M2a6zzNhPR2slXZZtHFi4xnX98GEZw6meeO1Kb
 g/8a4Fb7EbtkicFKEQdpGjjn2t85eJaxjWNu2BelPOvkPey+UYH9qlK4lkO1hDpHC2F/Pj
 08cMo4maQ4GfoW4sO815Zma2iMLs+GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-FQajxxwDO3OWSeYkqhWhQw-1; Fri, 25 Sep 2020 09:42:35 -0400
X-MC-Unique: FQajxxwDO3OWSeYkqhWhQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55AEE1882FB4;
 Fri, 25 Sep 2020 13:42:34 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9E5F7368F;
 Fri, 25 Sep 2020 13:42:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] block/export: add BlockExportOptions->iothread member
Date: Fri, 25 Sep 2020 14:42:25 +0100
Message-Id: <20200925134229.246169-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBzZXJpZXMgYWRqdXN0cyB0aGUgYnVpbGQgc3lzdGVtIGFuZCB0aGVuIGFkZHMgYQ0KQmxv
Y2tFeHBvcnRPcHRpb25zLT5pb3RocmVhZCBtZW1iZXIgc28gdGhhdCBpdCBpcyBwb3NzaWJsZSB0
byBzZXQgdGhlIGlvdGhyZWFkDQpmb3IgYW4gZXhwb3J0Lg0KDQpCYXNlZC1vbjogMjAyMDA5MjQx
NTE1NDkuOTEzNzM3LTEtc3RlZmFuaGFAcmVkaGF0LmNvbSAoIltQQVRDSCB2MiAwMC8xM10gYmxv
Y2svZXhwb3J0OiBjb252ZXJ0IHZob3N0LXVzZXItYmxrLXNlcnZlciB0byBibG9jayBleHBvcnRz
IEFQSSIpDQoNClN0ZWZhbiBIYWpub2N6aSAoNCk6DQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6
IHVzZSBzdGF0aWMgbGlicmFyeSBpbiBtZXNvbi5idWlsZA0KICBxZW11LXN0b3JhZ2UtZGFlbW9u
OiBhdm9pZCBjb21waWxpbmcgYmxvY2tkZXZfc3MgdHdpY2UNCiAgYmxvY2s6IG1vdmUgYmxvY2sg
ZXhwb3J0cyB0byBsaWJibG9ja2Rldg0KICBibG9jay9leHBvcnQ6IGFkZCBCbG9ja0V4cG9ydE9w
dGlvbnMtPmlvdGhyZWFkIG1lbWJlcg0KDQogcWFwaS9ibG9jay1leHBvcnQuanNvbiAgICAgICAg
ICAgIHwgIDQgKysrKw0KIGJsb2NrL2V4cG9ydC9leHBvcnQuYyAgICAgICAgICAgICB8IDM0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCiBzdHVicy9ibGstZXhwLWNsb3NlLWFsbC5j
ICAgICAgICAgfCAgNyArKysrKysrDQogc3R1YnMvcWVtdS1zeXN0ZW0ta2lsbGVkLmMgICAgICAg
IHwgMTAgKysrKysrKysrDQogYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkICAgICAgICAgIHwgIDQg
KystLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9tZXNvbi5idWlsZCB8ICAxICsNCiBtZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKystLS0tLQ0KIG5i
ZC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8ICAyICsrDQogc3RvcmFnZS1kYWVtb24v
bWVzb24uYnVpbGQgICAgICAgIHwgIDMgKy0tDQogc3R1YnMvbWVzb24uYnVpbGQgICAgICAgICAg
ICAgICAgIHwgIDIgKysNCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgICAgfCAgMiAr
LQ0KIHV0aWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICB8ICA0ICsrKy0NCiAxMiBmaWxl
cyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBz
dHVicy9xZW11LXN5c3RlbS1raWxsZWQuYw0KDQotLSANCjIuMjYuMg0KDQo=


