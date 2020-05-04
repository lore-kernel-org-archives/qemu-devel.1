Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B043EC47259
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C1620721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXW1liT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C1620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcpW-0004Hu-Ge
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoD-0002LK-IJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVcoB-0007i8-QM
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588605300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LaVVrsnJBkF3Tedbzkq4G3Ci+0DXqaMkQDubHHgJRew=;
 b=eXW1liT/2AZAiF1r/WvDTUZQRBWXWnMk0MrCEaX7AdEEzNLYgV8Bs1Z3H6RNJ1nPV0ho4o
 JeWsLrSxHiz44DiWnt9ef6ADgAqP2sA151vcYuA93TJW6iChpQdN97rlp5IFksT33ymTXD
 4yvU4ZVunA4t9dg6P5EVlfkNDubkGQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-bhWaCEW8PVWduvuIUi_eGA-1; Mon, 04 May 2020 11:14:53 -0400
X-MC-Unique: bhWaCEW8PVWduvuIUi_eGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB55835B41;
 Mon,  4 May 2020 15:14:52 +0000 (UTC)
Received: from localhost (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2039B6247C;
 Mon,  4 May 2020 15:14:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/4] Block patches
Date: Mon,  4 May 2020 16:14:34 +0100
Message-Id: <20200504151438.362702-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5YWY2MzhjYzFmNjY1NzEyNTIyNjA4
YzVkNmI4YzAzZDhmYTY3NjY2Og0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvcG1heWRlbGwvdGFncy9wdWxsLXRhcmdldC1hcm0tMjAyMDA1MDQnIGludG8gc3RhZ2lu
ZyAoMjAyMC0wNS0wNCAxMzozNzoxNyArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0
IHRhZ3MvYmxvY2stcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byAwOGI2ODlhYTZiNTIxOTY0YjgyNzVkZDdhMjU2NGFlZmE1ZDY4MTI5Og0KDQogIGxvY2thYmxl
OiBSZXBsYWNlIGxvY2tzIHdpdGggbG9jayBndWFyZCBtYWNyb3MgKDIwMjAtMDUtMDQgMTY6MDc6
NDMgKzAxMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NClB1bGwgcmVxdWVzdA0KDQp2MjoNCiAqIEZpeGVkIHN0cmF5
IHNsaXJwIHN1Ym1vZHVsZSBjaGFuZ2UgW1BldGVyXQ0KDQpGaXhlcyBmb3IgdGhlIGxvY2sgZ3Vh
cmQgbWFjcm9zLCBjb2RlIGNvbnZlcnNpb25zIHRvIHRoZSBsb2NrIGd1YXJkIG1hY3JvcywgYW5k
DQpzdXBwb3J0IGZvciBzZWxlY3RpbmcgZnV6emVyIHRhcmdldHMgd2l0aCBhcmd2WzBdLg0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQoNCkFsZXhhbmRlciBCdWxla292ICgxKToNCiAgZnV6ejogc2VsZWN0IGZ1enogdGFy
Z2V0IHVzaW5nIGV4ZWN1dGFibGUgbmFtZQ0KDQpEYW5pZWwgQnJvZHNreSAoMik6DQogIGxvY2th
YmxlOiBmaXggX19DT1VOVEVSX18gbWFjcm8gdG8gYmUgcmVmZXJlbmNlZCBwcm9wZXJseQ0KICBs
b2NrYWJsZTogcmVwbGFjZWQgbG9ja3Mgd2l0aCBsb2NrIGd1YXJkIG1hY3JvcyB3aGVyZSBhcHBy
b3ByaWF0ZQ0KDQpTaW1yYW4gU2luZ2hhbCAoMSk6DQogIGxvY2thYmxlOiBSZXBsYWNlIGxvY2tz
IHdpdGggbG9jayBndWFyZCBtYWNyb3MNCg0KIGluY2x1ZGUvcWVtdS9sb2NrYWJsZS5oIHwgIDcg
KysrLS0tDQogaW5jbHVkZS9xZW11L3JjdS5oICAgICAgfCAgMiArLQ0KIGJsb2NrL2lzY3NpLmMg
ICAgICAgICAgIHwgIDcgKystLS0tDQogYmxvY2svbmZzLmMgICAgICAgICAgICAgfCA1MSArKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGNwdXMtY29tbW9uLmMgICAg
ICAgICAgIHwgMTQgKysrKy0tLS0tLS0NCiBody9kaXNwbGF5L3F4bC5jICAgICAgICB8IDQzICsr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiBody9oeXBlcnYvaHlwZXJ2LmMgICAg
ICB8IDE1ICsrKysrKy0tLS0tLQ0KIGh3L3JkbWEvcmRtYV9iYWNrZW5kLmMgIHwgNTAgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGh3L3JkbWEvcmRtYV9ybS5jICAg
ICAgIHwgIDMgKy0tDQogaHcvdmZpby9wbGF0Zm9ybS5jICAgICAgfCAgNSArKy0tDQogbWlncmF0
aW9uL21pZ3JhdGlvbi5jICAgfCAgMyArLS0NCiBtaWdyYXRpb24vbXVsdGlmZC5jICAgICB8ICA4
ICsrKy0tLS0NCiBtaWdyYXRpb24vcmFtLmMgICAgICAgICB8ICAzICstLQ0KIG1vbml0b3IvbWlz
Yy5jICAgICAgICAgIHwgIDQgKy0tLQ0KIHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5jIHwgMTkgKysr
KysrKystLS0tLS0tDQogdWkvc3BpY2UtZGlzcGxheS5jICAgICAgfCAxNCArKysrKy0tLS0tLQ0K
IHV0aWwvbG9nLmMgICAgICAgICAgICAgIHwgIDQgKystLQ0KIHV0aWwvcWVtdS10aW1lci5jICAg
ICAgIHwgMTcgKysrKysrKy0tLS0tLS0NCiB1dGlsL3JjdS5jICAgICAgICAgICAgICB8ICA4ICsr
Ky0tLS0NCiB1dGlsL3RocmVhZC1wb29sLmMgICAgICB8ICAzICstLQ0KIHV0aWwvdmZpby1oZWxw
ZXJzLmMgICAgIHwgIDUgKystLQ0KIDIxIGZpbGVzIGNoYW5nZWQsIDEzMiBpbnNlcnRpb25zKCsp
LCAxNTMgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4zDQoNCg==


