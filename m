Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1386C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827DF22206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPPrCfP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827DF22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkvI-0004pf-GO
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkm9-0002u3-JV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkm2-0005Ma-Nu
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600790649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ofqtQ7nSUfnCDjaW70jU7eHXN4cl3Xka+Q/RIkJaNiE=;
 b=OPPrCfP+tALl0kllxpsvvocJueaoumRvCCPvxr4te5yYBncIEOABVLkA5J9E245tIPawXm
 AsLofhMbc86LwPrdRKY1sRPSyhu0dohh1tCYzQ9IUxaLk5GF7Qvf64JWSovZ5WxAhrDY3G
 ZzfuTBXqmDxfmMTdHr/0h1okG4OlYbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-g3UGQDhjPh6NV2G1Wkq9yQ-1; Tue, 22 Sep 2020 12:04:07 -0400
X-MC-Unique: g3UGQDhjPh6NV2G1Wkq9yQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA0257052;
 Tue, 22 Sep 2020 16:04:05 +0000 (UTC)
Received: from localhost (ovpn-115-55.ams2.redhat.com [10.36.115.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5663A40;
 Tue, 22 Sep 2020 16:04:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] block/export: convert vhost-user-blk-server to block
 exports API
Date: Tue, 22 Sep 2020 17:03:50 +0100
Message-Id: <20200922160401.294055-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgY29udmVydHMgQ29pYnkgWHUncyB2aG9zdC11c2VyLWJsay1zZXJ2
ZXIgZnJvbSBhIFFPTSBvYmplY3QNCnRvIHRoZSBibG9jayBleHBvcnRzIEFQSS4gVGhlIGJsb2Nr
IGV4cG9ydHMgQVBJIHByb3ZpZGVzIGEgc3RhbmRhcmQgUU1QIGFuZA0KY29tbWFuZC1saW5lIGlu
dGVyZmFjZSBmb3IgbWFuYWdpbmcgYmxvY2sgZXhwb3J0cyAoTkJELCBGVVNFLCB2aG9zdC11c2Vy
LWJsaywNCmV0YykuIEEgZmFpciBhbW91bnQgb2YgaW5pdC9zaHV0ZG93biBjb2RlIGlzIHJlbW92
ZWQgYmVjYXVzZSB0aGUgYmxvY2sgZXhwb3J0cw0KQVBJIGFscmVhZHkgdGFrZXMgY2FyZSBvZiB0
aGF0IGZ1bmN0aW9uYWxpdHkuDQoNCk1vc3Qgb2YgdGhlIHBhdGNoZXMgYXJlIHZob3N0LXVzZXIt
YmxrLXNlcnZlciBjbGVhbnVwcy4NCg0KVGhlIHN5bnRheCBmb3IgbGF1bmNoaW5nIHFlbXUtc3Rv
cmFnZS1kYWVtb24gaXM6DQoNCiAgJCBxZW11LXN0b3JhZ2UtZGFlbW9uIFwNCiAgICAgIC0tYmxv
Y2tkZXYgZmlsZSxub2RlLW5hbWU9ZHJpdmUwLGZpbGVuYW1lPXRlc3QuaW1nIFwNCiAgICAgIC0t
ZXhwb3J0IHZob3N0LXVzZXItYmxrLG5vZGUtbmFtZT1kcml2ZTAsaWQ9ZXhwb3J0MCx3cml0YWJs
ZT1vbix1bml4LXNvY2tldD0vdG1wL3Zob3N0LXVzZXItYmxrLnNvY2sNCg0KUUVNVSBjYW4gY29u
bmVjdCB0byB0aGUgdmhvc3QtdXNlci1ibGsgZXhwb3J0IGxpa2UgdGhpczoNCg0KICAkIHFlbXUt
c3lzdGVtLXg4Nl82NCBcDQogICAgICAtTSBhY2NlbD1rdm0sbWVtb3J5LWJhY2tlbmQ9bWVtIFwN
CiAgICAgIC1tIDFHIFwNCiAgICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtbWVtZmQsc2l6ZT0x
RyxpZD1tZW0gXA0KICAgICAgLWNwdSBob3N0IFwNCiAgICAgIC1jaGFyZGV2IHNvY2tldCxwYXRo
PS90bXAvdmhvc3QtdXNlci1ibGsuc29jayxpZD1jaGFyMCBcDQogICAgICAtZGV2aWNlIHZob3N0
LXVzZXItYmxrLXBjaSxjaGFyZGV2PWNoYXIwDQoNCkJhc2VkLW9uOiAyMDIwMDkxODA4MDkxMi4z
MjEyOTktMS1jb2lieS54dUBnbWFpbC5jb20gKCJbUEFUQ0ggdjEwIDAvN10gdmhvc3QtdXNlciBi
bG9jayBkZXZpY2UgYmFja2VuZCBpbXBsZW1lbnRhdGlvbiIpDQpCYXNlZC1vbjogMjAyMDA5MDcx
ODIwMTEuNTIxMDA3LTEta3dvbGZAcmVkaGF0LmNvbSAoIltQQVRDSCAwMC8yOV0gYmxvY2svZXhw
b3J0OiBBZGQgaW5mcmFzdHJ1Y3R1cmUgYW5kIFFBUEkgZm9yIGJsb2NrIGV4cG9ydHMiKQ0KDQpT
dGVmYW4gSGFqbm9jemkgKDExKToNCiAgYmxvY2svZXhwb3J0OiBzaG9ydGVuIHNlcmlhbCBzdHJp
bmcgdG8gZml0DQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IHMvZmlsZWRzL2ZpZWxkcy8gdHlw
byBmaXgNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogZHJvcCB1bm5lY2Vzc2FyeSBRT00gY2Fz
dA0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBkcm9wIHVubmVjZXNzYXJ5IHdhdGNoIGRlbGV0
aW9uDQogIGJsb2NrL2V4cG9ydDogY29uc29saWRhdGUgcmVxdWVzdCBzdHJ1Y3RzIGludG8gVnVC
bG9ja1JlcQ0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBkcm9wIHVudXNlZCBEZXZpY2VQYW5p
Y05vdGlmaWVyDQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IGZpeCBtZW1vcnkgbGVhayBpbiB2
dV9tZXNzYWdlX3JlYWQoKQ0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBjaGVjayBFT0Ygd2hl
biByZWFkaW5nIHBheWxvYWQNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogcmV3b3JrIHZ1X2Ns
aWVudF90cmlwKCkgY29yb3V0aW5lIGxpZmVjeWNsZQ0KICBibG9jay9leHBvcnQ6IHJlcG9ydCBm
bHVzaCBlcnJvcnMNCiAgYmxvY2svZXhwb3J0OiBjb252ZXJ0IHZob3N0LXVzZXItYmxrIHNlcnZl
ciB0byBibG9jayBleHBvcnQgQVBJDQoNCiBxYXBpL2Jsb2NrLWV4cG9ydC5qc29uICAgICAgICAg
ICAgICAgfCAgMTkgKy0NCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmggfCAg
MjMgKy0NCiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmggICAgICAgICAgICAgfCAgMzIgKy0NCiBi
bG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAgICAgICAgICAgfCAgIDggKy0NCiBibG9jay9leHBv
cnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgfCA1MzQgKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tDQogdXRpbC92aG9zdC11c2VyLXNlcnZlci5jICAgICAgICAgICAgIHwgMzIyICsrKysrKysr
LS0tLS0tLS0NCiBibG9jay9leHBvcnQvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAgIDEgKw0K
IGJsb2NrL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQogOCBmaWxlcyBj
aGFuZ2VkLCAzNjAgaW5zZXJ0aW9ucygrKSwgNTgwIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjYu
Mg0KDQo=


