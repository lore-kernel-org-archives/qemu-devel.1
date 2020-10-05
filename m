Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6CB20578
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDCIp79y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6CB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSfu-0006ZQ-Cl
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeJ-0004mk-HC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeH-000868-O3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xlkjTaJixPH6ot9lKISFh4fWKOAbo3dmVQRfRcKMTXk=;
 b=QDCIp79ynaoC5oX3bBlVM/FYKNg4gauUQP0bdKOWZfpca16cSA1Rnjr2+S0xhPIQQW86Rv
 PejdaVBY0wkAFmlRADrEFC46f8vQHzX6VdLYvGlEFhEifT6cPjQKb+MAfTqJ+ySUtd0S2G
 b+0rQpTFHf2dN52QWJy8w+glYY0x1LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-0uk_GjqKMN6siXo2PnX7wQ-1; Mon, 05 Oct 2020 11:43:29 -0400
X-MC-Unique: 0uk_GjqKMN6siXo2PnX7wQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D961427C2;
 Mon,  5 Oct 2020 15:43:28 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A224100164C;
 Mon,  5 Oct 2020 15:43:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/17] Block patches
Date: Mon,  5 Oct 2020 16:43:06 +0100
Message-Id: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0NjllNzJhYjdkYmJkN2ZmNGVlNjAx
ZTVlYTdjMjk1NDVkNDY1OTNiOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMva2V2aW4vdGFncy9mb3ItdXBzdHJlYW0nIGludG8gc3RhZ2luZyAoMjAyMC0xMC0wMiAx
NjoxOTo0MiArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
DQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IHRhZ3MvYmxvY2stcHVs
bC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA5YWI1NzQxMTY0YjE3
MjdkMjJmNjlmZTcwMDEzODJiYWYwZDU2OTc3Og0KDQogIHV0aWwvdmZpby1oZWxwZXJzOiBSZXdv
cmsgdGhlIElPVkEgYWxsb2NhdG9yIHRvIGF2b2lkIElPVkEgcmVzZXJ2ZWQgcmVnaW9ucyAoMjAy
MC0xMC0wNSAxMDo1OTo0MiArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCnYyOg0K
ICogUmVtb3ZlZCBjbGFuZy1mb3JtYXQgY2FsbCBmcm9tIHNjcmlwdHMvYmxvY2stY29yb3V0aW5l
LXdyYXBwZXIucHkuIFRoaXMNCiAgIGF2b2lkcyB0aGUgaXNzdWUgd2l0aCBjbGFuZyB2ZXJzaW9u
IGluY29tcGF0aWJpbGl0eS4gSXQgY291bGQgYmUgYWRkZWQgYmFjaw0KICAgaW4gdGhlIGZ1dHVy
ZSBidXQgdGhlIGNvZGUgaXMgcmVhZGFibGUgd2l0aG91dCByZWZvcm1hdHRpbmcgYW5kIGl0IGFs
c28NCiAgIG1ha2VzIHRoZSBidWlsZCBsZXNzIGRlcGVuZGVudCBvbiB0aGUgZW52aXJvbm1lbnQu
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCg0KRXJpYyBBdWdlciAoMik6DQogIHV0aWwvdmZpby1oZWxwZXJzOiBDb2xs
ZWN0IElPVkEgcmVzZXJ2ZWQgcmVnaW9ucw0KICB1dGlsL3ZmaW8taGVscGVyczogUmV3b3JrIHRo
ZSBJT1ZBIGFsbG9jYXRvciB0byBhdm9pZCBJT1ZBIHJlc2VydmVkDQogICAgcmVnaW9ucw0KDQpQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoNik6DQogIHV0aWwvdmZpby1oZWxwZXJzOiBQYXNzIHBh
Z2UgcHJvdGVjdGlvbnMgdG8gcWVtdV92ZmlvX3BjaV9tYXBfYmFyKCkNCiAgYmxvY2svbnZtZTog
TWFwIGRvb3JiZWxscyBwYWdlcyB3cml0ZS1vbmx5DQogIGJsb2NrL252bWU6IFJlZHVjZSBJL08g
cmVnaXN0ZXJzIHNjb3BlDQogIGJsb2NrL252bWU6IERyb3AgTlZNZVJlZ3Mgc3RydWN0dXJlLCBk
aXJlY3RseSB1c2UgTnZtZUJhcg0KICBibG9jay9udm1lOiBVc2UgcmVnaXN0ZXIgZGVmaW5pdGlv
bnMgZnJvbSAnYmxvY2svbnZtZS5oJw0KICBibG9jay9udm1lOiBSZXBsYWNlIG1hZ2ljIHZhbHVl
IGJ5IFNDQUxFX01TIGRlZmluaXRpb24NCg0KU3RlZmFubyBHYXJ6YXJlbGxhICgxKToNCiAgZG9j
czogYWRkICdpb191cmluZycgb3B0aW9uIHRvICdhaW8nIHBhcmFtIGluIHFlbXUtb3B0aW9ucy5o
eA0KDQpWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICg4KToNCiAgYmxvY2s6IHJldHVybiBl
cnJvci1jb2RlIGZyb20gYmRydl9pbnZhbGlkYXRlX2NhY2hlDQogIGJsb2NrL2lvOiByZWZhY3Rv
ciBjb3JvdXRpbmUgd3JhcHBlcnMNCiAgYmxvY2s6IGRlY2xhcmUgc29tZSBjb3JvdXRpbmUgZnVu
Y3Rpb25zIGluIGJsb2NrL2Nvcm91dGluZXMuaA0KICBzY3JpcHRzOiBhZGQgYmxvY2stY29yb3V0
aW5lLXdyYXBwZXIucHkNCiAgYmxvY2s6IGdlbmVyYXRlIGNvcm91dGluZS13cmFwcGVyIGNvZGUN
CiAgYmxvY2s6IGRyb3AgYmRydl9wcnd2DQogIGJsb2NrL2lvOiByZWZhY3RvciBzYXZlL2xvYWQg
dm1zdGF0ZQ0KICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmg6IGRyb3Agbm9uLWFzY2lpIHF1b3RhdGlv
biBtYXJrDQoNCiBibG9jay9ibG9jay1nZW4uaCAgICAgICAgICAgICAgICAgICAgICB8ICA0OSAr
KysrDQogYmxvY2svY29yb3V0aW5lcy5oICAgICAgICAgICAgICAgICAgICAgfCAgNjUgKysrKysN
CiBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggICAgICAgICAgICAgICAgICB8ICAzNiArKy0NCiBpbmNs
dWRlL3FlbXUvdmZpby1oZWxwZXJzLmggICAgICAgICAgICB8ICAgMiArLQ0KIGJsb2NrLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDk3ICstLS0tLS0NCiBibG9jay9pby5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDMzOSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQogYmxvY2svbnZtZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNzMgKysrLS0tDQog
dGVzdHMvdGVzdC1iZHJ2LWRyYWluLmMgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiB1dGlsL3Zm
aW8taGVscGVycy5jICAgICAgICAgICAgICAgICAgICB8IDEzMyArKysrKysrKystDQogYmxvY2sv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKw0KIGRvY3MvZGV2ZWwvYmxv
Y2stY29yb3V0aW5lLXdyYXBwZXIucnN0IHwgIDU0ICsrKysNCiBkb2NzL2RldmVsL2luZGV4LnJz
dCAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTAgKy0NCiBzY3JpcHRzL2Jsb2NrLWNvcm91dGluZS13cmFwcGVyLnB5
ICAgICB8IDE2NyArKysrKysrKysrKysNCiAxNCBmaWxlcyBjaGFuZ2VkLCA2MDggaW5zZXJ0aW9u
cygrKSwgNDI4IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9jay9ibG9jay1n
ZW4uaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9jay9jb3JvdXRpbmVzLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZG9jcy9kZXZlbC9ibG9jay1jb3JvdXRpbmUtd3JhcHBlci5yc3QNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgc2NyaXB0cy9ibG9jay1jb3JvdXRpbmUtd3JhcHBlci5weQ0KDQotLSANCjIu
MjYuMg0KDQo=


