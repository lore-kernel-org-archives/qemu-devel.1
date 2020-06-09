Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D6BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07AE20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejgctZUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07AE20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii1U-0005oS-Vy
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihe2-0003cl-Mk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:02:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihe1-0007Qr-UL
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TQSHojBIaVgg/+GZ0cffpAbjmH3wpDxDSJumTYihl7g=;
 b=ejgctZUbIPxHDNnrtVvM+Cx7xQme/KlFncZa+HR0UcYtBlhcgL4xWxMf2Gkoq/pMuiPJ7B
 j/DTiwgF2SZ6GQZFrbzHeiFnHURbhZWslb2ogkdeXhQDwXJQ036MD6bAdJX1V+swF12hFk
 wP3Wgnuy3R/pfof2exBr3rd6OiugQ4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-fyB1ilJOMAqJETIHz3_Qwg-1; Tue, 09 Jun 2020 13:02:33 -0400
X-MC-Unique: fyB1ilJOMAqJETIHz3_Qwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 759BE1800D42;
 Tue,  9 Jun 2020 17:02:31 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6DB960C87;
 Tue,  9 Jun 2020 17:02:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] virtio: enable VIRTIO_F_RING_PACKED for all devices
Date: Tue,  9 Jun 2020 18:02:11 +0100
Message-Id: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBBZGQgbGlidmhvc3QtdXNlciBWSE9TVF9VU0VSX0dFVF9GRUFUVVJFUyBwYXRjaCB0
byBzdGFydCByZXBvcnRpbmcgZmVhdHVyZQ0KICAgYml0cyBjb3JyZWN0bHkgKGFscmVhZHkgcmV2
aWV3ZWQgYnkgTWFyYy1BbmRyw6kgTHVyZWF1KQ0KICogUmVwaHJhc2UgZG9jIGNvbW1lbnRzIGFu
ZCBkcm9wIHZob3N0X2dldF9kZWZhdWx0X2ZlYXR1cmVzKCkgW0phc29uXQ0KICogU2ltcGxpZnkg
aHcvY29yZS9tYWNoaW5lLmMgY29tcGF0IHByb3BzIGJ5IHNldHRpbmcgcGFja2VkPW9mZiBvbiB0
aGUNCiAgIHZpcnRpby1kZXYgYmFzZSBjbGFzcyBbSmFzb25dDQoNClRoZSBWSVJUSU8gMS4xIHBh
Y2tlZCB2aXJ0cXVldWUgbGF5b3V0IGltcHJvdmVzIHBlcmZvcm1hbmNlIGFuZCBndWVzdCBkcml2
ZXINCnN1cHBvcnQgaGFzIGJlZW4gYXZhaWxhYmxlIHNpbmNlIExpbnV4IHY1LjAuIHZpcnRpby1i
bGsgYmVuY2htYXJrcyBzaG93IGl0IGlzDQpiZW5lZmljaWFsIGZvciBub24tbmV0IGRldmljZXMg
dG9vIHNvIEkgd3JvdGUgcGF0Y2hlcyB0byBlbmFibGUgaXQgZm9yIGFsbA0KZGV2aWNlcy4NCg0K
SXQgdHVybmVkIG91dCB0byBiZSB0cmlja2llciB0aGFuIEkgZXhwZWN0ZWQgYmVjYXVzZSB2aG9z
dCBmZWF0dXJlIG5lZ290aWF0aW9uDQppcyBjdXJyZW50bHkgbm90IHJlYWR5IGZvciBuZXcgdmly
dHF1ZXVlIGZlYXR1cmUgYml0cyBsaWtlDQpWSVJUSU9fRl9SSU5HX1BBQ0tFRC4NCg0KUGF0Y2gg
MSBmaXhlcyBsaWJxb3MuIFBhdGNoIDIgZml4ZXMgbGlidmhvc3QtdXNlci4gUGF0Y2ggMyBhZGRz
IGNsYXJpZmljYXRpb25zDQp0byB0aGUgdmhvc3QtdXNlciBzcGVjaWZpY2F0aW9uLiBQYXRjaGVz
IDQtNiBzb2x2ZSB0aGUgdmhvc3QgZmVhdHVyZSBpc3N1ZXMgaW4NClFFTVUuIEZpbmFsbHksIFBh
dGNoIDYgZW5hYmxlcyBwYWNrZWQgdmlydHF1ZXVlcy4NCg0KU3RlZmFuIEhham5vY3ppICg3KToN
CiAgdGVzdHMvbGlicW9zOiBtYXNrIG91dCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCBmb3Igbm93DQog
IGxpYnZob3N0LXVzZXI6IGFkdmVydGlzZSB2cmluZyBmZWF0dXJlcw0KICBkb2NzOiBkb2N1bWVu
dCBub24tbmV0IFZIT1NUX1VTRVJfR0VUX0ZFQVRVUkVTIGJlaGF2aW9yDQogIHZob3N0OiBpbnZv
bHZlIGRldmljZSBiYWNrZW5kcyBpbiBmZWF0dXJlIG5lZ290aWF0aW9uDQogIHZob3N0LXVzZXIt
YmxrOiBhZGQgVklSVElPX0ZfUklOR19QQUNLRUQgZmVhdHVyZSBiaXQNCiAgdmhvc3Qtc2NzaTog
YWRkIFZJUlRJT19GX1ZFUlNJT05fMSBhbmQgVklSVElPX0ZfUklOR19QQUNLRUQNCiAgdmlydGlv
OiBlbmFibGUgVklSVElPX0ZfUklOR19QQUNLRUQgZm9yIGFsbCBkZXZpY2VzDQoNCiBpbmNsdWRl
L2h3L3ZpcnRpby92aG9zdC5oICAgICAgICAgICAgICAgfCAgMSArDQogaW5jbHVkZS9ody92aXJ0
aW8vdmlydGlvLWdwdS5oICAgICAgICAgIHwgIDIgKysNCiBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0
aW8uaCAgICAgICAgICAgICAgfCAgMiArLQ0KIGluY2x1ZGUvc3lzZW11L2NyeXB0b2Rldi12aG9z
dC5oICAgICAgICB8IDExICsrKysrKysrKysrDQogYmFja2VuZHMvY3J5cHRvZGV2LXZob3N0LmMg
ICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQogY29udHJpYi9saWJ2aG9z
dC11c2VyL2xpYnZob3N0LXVzZXIuYyAgIHwgMTAgKysrKysrKysrKw0KIGNvbnRyaWIvdmhvc3Qt
dXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYyB8ICA0ICstLS0NCiBody9ibG9jay92aG9zdC11c2Vy
LWJsay5jICAgICAgICAgICAgICAgfCAgMSArDQogaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDQgKysrLQ0KIGh3L2Rpc3BsYXkvdmhvc3QtdXNlci1ncHUuYyAgICAg
ICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KIGh3L2Rpc3BsYXkvdmlydGlvLWdwdS1i
YXNlLmMgICAgICAgICAgICB8ICAyICstDQogaHcvaW5wdXQvdmhvc3QtdXNlci1pbnB1dC5jICAg
ICAgICAgICAgIHwgMTEgKysrKysrKysrKysNCiBody9zY3NpL3Zob3N0LXNjc2kuYyAgICAgICAg
ICAgICAgICAgICAgfCAgMiArKw0KIGh3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMgICAgICAgICAg
ICAgICB8ICAyICsrDQogaHcvdmlydGlvL3Zob3N0LXVzZXItZnMuYyAgICAgICAgICAgICAgIHwg
IDYgKysrKy0tDQogaHcvdmlydGlvL3Zob3N0LXZzb2NrLmMgICAgICAgICAgICAgICAgIHwgIDcg
KysrKystLQ0KIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgICAgICAgICAgICAgICB8IDI0ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KIGh3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMgICAgICAg
ICAgICAgICB8ICAzICsrLQ0KIHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8uYyAgICAgICAgICAg
ICB8ICAzICsrLQ0KIGRvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdCAgICAgICAgICAgICB8IDIx
ICsrKysrKysrKysrKysrKysrKysrKw0KIDIwIGZpbGVzIGNoYW5nZWQsIDE0MyBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI2LjINCg0K


