Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA3BC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E6420773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyxo6VO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E6420773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKNJ-0003fs-Cl
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKK5m-0008Q6-V8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKK5k-0001JF-Rd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600688083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTZ8mzkVrbwLph5v42RvSwqkctWB20tlLXNi2SU46d4=;
 b=Zyxo6VO7d2B84uWwKTyBWaOvimkS+VMmrv2A17QaZDQ0ZLkJ6+w703HbMwrG0H/MS1MlBv
 9nQHzEYJ9SXbTGNyrT+sfQhZ5GKemGCeHtsf19pity8nUOmJC8etwxaligNl/nQ5vrgSJX
 VzAo8wUvuoaMvCuEvI7apqbArGX+Mbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-cjvjHyuBMWin_TUWieMutg-1; Mon, 21 Sep 2020 07:34:41 -0400
X-MC-Unique: cjvjHyuBMWin_TUWieMutg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDF721084D6B
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 11:34:40 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F8285C1D0;
 Mon, 21 Sep 2020 11:34:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] libvhost-user: return early on virtqueue errors
Date: Mon, 21 Sep 2020 12:34:19 +0100
Message-Id: <20200921113420.154378-2-stefanha@redhat.com>
In-Reply-To: <20200921113420.154378-1-stefanha@redhat.com>
References: <20200921113420.154378-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dnVfcGFuaWMoKSBpcyBub3QgZ3VhcmFudGVlZCB0byBleGl0IHRoZSBwcm9ncmFtLiBSZXR1cm4g
ZWFybHkgd2hlbgplcnJvcnMgYXJlIGVuY291bnRlcmVkLgoKTm90ZSB0aGF0IGxpYnZob3N0LXVz
ZXIgZG9lcyBub3QgaGF2ZSBhbiAidW5tYXAiIG9wZXJhdGlvbiBmb3IgbWFwcGVkCmRlc2NyaXB0
b3JzLiBUaGVyZWZvcmUgaXQgaXMgY29ycmVjdCB0byByZXR1cm4gd2l0aG91dCBleHBsaWNpdCBj
bGVhbnVwLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgotLS0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMgfCAyNyArKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb250cmliL2xpYnZob3N0LXVzZXIvbGli
dmhvc3QtdXNlci5jIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYwppbmRl
eCA1M2YxNmJkZjA4Li4yNzYyNmU2MjlhIDEwMDY0NAotLS0gYS9jb250cmliL2xpYnZob3N0LXVz
ZXIvbGlidmhvc3QtdXNlci5jCisrKyBiL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11
c2VyLmMKQEAgLTI0MDcsNyArMjQwNyw3IEBAIHZ1X3F1ZXVlX3NldF9ub3RpZmljYXRpb24oVnVE
ZXYgKmRldiwgVnVWaXJ0cSAqdnEsIGludCBlbmFibGUpCiAgICAgfQogfQogCi1zdGF0aWMgdm9p
ZAorc3RhdGljIGJvb2wKIHZpcnRxdWV1ZV9tYXBfZGVzYyhWdURldiAqZGV2LAogICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCAqcF9udW1fc2csIHN0cnVjdCBpb3ZlYyAqaW92LAogICAg
ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBtYXhfbnVtX3NnLCBib29sIGlzX3dyaXRlLApA
QCAtMjQxOSw3ICsyNDE5LDcgQEAgdmlydHF1ZXVlX21hcF9kZXNjKFZ1RGV2ICpkZXYsCiAKICAg
ICBpZiAoIXN6KSB7CiAgICAgICAgIHZ1X3BhbmljKGRldiwgInZpcnRpbzogemVybyBzaXplZCBi
dWZmZXJzIGFyZSBub3QgYWxsb3dlZCIpOwotICAgICAgICByZXR1cm47CisgICAgICAgIHJldHVy
biBmYWxzZTsKICAgICB9CiAKICAgICB3aGlsZSAoc3opIHsKQEAgLTI0MjcsMTMgKzI0MjcsMTMg
QEAgdmlydHF1ZXVlX21hcF9kZXNjKFZ1RGV2ICpkZXYsCiAKICAgICAgICAgaWYgKG51bV9zZyA9
PSBtYXhfbnVtX3NnKSB7CiAgICAgICAgICAgICB2dV9wYW5pYyhkZXYsICJ2aXJ0aW86IHRvbyBt
YW55IGRlc2NyaXB0b3JzIGluIGluZGlyZWN0IHRhYmxlIik7Ci0gICAgICAgICAgICByZXR1cm47
CisgICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgICAgIH0KIAogICAgICAgICBpb3ZbbnVt
X3NnXS5pb3ZfYmFzZSA9IHZ1X2dwYV90b192YShkZXYsICZsZW4sIHBhKTsKICAgICAgICAgaWYg
KGlvdltudW1fc2ddLmlvdl9iYXNlID09IE5VTEwpIHsKICAgICAgICAgICAgIHZ1X3BhbmljKGRl
diwgInZpcnRpbzogaW52YWxpZCBhZGRyZXNzIGZvciBidWZmZXJzIik7Ci0gICAgICAgICAgICBy
ZXR1cm47CisgICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgICAgIH0KICAgICAgICAgaW92
W251bV9zZ10uaW92X2xlbiA9IGxlbjsKICAgICAgICAgbnVtX3NnKys7CkBAIC0yNDQyLDYgKzI0
NDIsNyBAQCB2aXJ0cXVldWVfbWFwX2Rlc2MoVnVEZXYgKmRldiwKICAgICB9CiAKICAgICAqcF9u
dW1fc2cgPSBudW1fc2c7CisgICAgcmV0dXJuIHRydWU7CiB9CiAKIHN0YXRpYyB2b2lkICoKQEAg
LTI0NzksNiArMjQ4MCw3IEBAIHZ1X3F1ZXVlX21hcF9kZXNjKFZ1RGV2ICpkZXYsIFZ1VmlydHEg
KnZxLCB1bnNpZ25lZCBpbnQgaWR4LCBzaXplX3Qgc3opCiAgICAgaWYgKGRlc2NbaV0uZmxhZ3Mg
JiBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpIHsKICAgICAgICAgaWYgKGRlc2NbaV0ubGVuICUgc2l6
ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSkgewogICAgICAgICAgICAgdnVfcGFuaWMoZGV2LCAiSW52
YWxpZCBzaXplIGZvciBpbmRpcmVjdCBidWZmZXIgdGFibGUiKTsKKyAgICAgICAgICAgIHJldHVy
biBOVUxMOwogICAgICAgICB9CiAKICAgICAgICAgLyogbG9vcCBvdmVyIHRoZSBpbmRpcmVjdCBk
ZXNjcmlwdG9yIHRhYmxlICovCkBAIC0yNTA2LDIyICsyNTA4LDI3IEBAIHZ1X3F1ZXVlX21hcF9k
ZXNjKFZ1RGV2ICpkZXYsIFZ1VmlydHEgKnZxLCB1bnNpZ25lZCBpbnQgaWR4LCBzaXplX3Qgc3op
CiAgICAgLyogQ29sbGVjdCBhbGwgdGhlIGRlc2NyaXB0b3JzICovCiAgICAgZG8gewogICAgICAg
ICBpZiAoZGVzY1tpXS5mbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkgewotICAgICAgICAgICAg
dmlydHF1ZXVlX21hcF9kZXNjKGRldiwgJmluX251bSwgaW92ICsgb3V0X251bSwKLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWSVJUUVVFVUVfTUFYX1NJWkUgLSBvdXRfbnVtLCB0cnVl
LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NbaV0uYWRkciwgZGVzY1tpXS5s
ZW4pOworICAgICAgICAgICAgaWYgKCF2aXJ0cXVldWVfbWFwX2Rlc2MoZGV2LCAmaW5fbnVtLCBp
b3YgKyBvdXRfbnVtLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVFFV
RVVFX01BWF9TSVpFIC0gb3V0X251bSwgdHJ1ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRlc2NbaV0uYWRkciwgZGVzY1tpXS5sZW4pKSB7CisgICAgICAgICAgICAgICAg
cmV0dXJuIE5VTEw7CisgICAgICAgICAgICB9CiAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAg
ICBpZiAoaW5fbnVtKSB7CiAgICAgICAgICAgICAgICAgdnVfcGFuaWMoZGV2LCAiSW5jb3JyZWN0
IG9yZGVyIGZvciBkZXNjcmlwdG9ycyIpOwogICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwog
ICAgICAgICAgICAgfQotICAgICAgICAgICAgdmlydHF1ZXVlX21hcF9kZXNjKGRldiwgJm91dF9u
dW0sIGlvdiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUUVVFVUVfTUFYX1NJ
WkUsIGZhbHNlLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NbaV0uYWRkciwg
ZGVzY1tpXS5sZW4pOworICAgICAgICAgICAgaWYgKCF2aXJ0cXVldWVfbWFwX2Rlc2MoZGV2LCAm
b3V0X251bSwgaW92LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVFFV
RVVFX01BWF9TSVpFLCBmYWxzZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRlc2NbaV0uYWRkciwgZGVzY1tpXS5sZW4pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7CisgICAgICAgICAgICB9CiAgICAgICAgIH0KIAogICAgICAgICAvKiBJZiB3ZSd2ZSBnb3Qg
dG9vIG1hbnksIHRoYXQgaW1wbGllcyBhIGRlc2NyaXB0b3IgbG9vcC4gKi8KICAgICAgICAgaWYg
KChpbl9udW0gKyBvdXRfbnVtKSA+IG1heCkgewogICAgICAgICAgICAgdnVfcGFuaWMoZGV2LCAi
TG9vcGVkIGRlc2NyaXB0b3IiKTsKKyAgICAgICAgICAgIHJldHVybiBOVUxMOwogICAgICAgICB9
CiAgICAgICAgIHJjID0gdmlydHF1ZXVlX3JlYWRfbmV4dF9kZXNjKGRldiwgZGVzYywgaSwgbWF4
LCAmaSk7CiAgICAgfSB3aGlsZSAocmMgPT0gVklSVFFVRVVFX1JFQURfREVTQ19NT1JFKTsKLS0g
CjIuMjYuMgoK


