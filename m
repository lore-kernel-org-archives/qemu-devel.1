Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3628621D24
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOfR2kVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3628621D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLT7Y-0006dg-0j
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyl-000695-RC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyj-0003uQ-Ig
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmBrjvKqCUANWBkNsuYymq/QQChNylLEcnQneRjNiPg=;
 b=BOfR2kVRjEySwFMbdwLLA0Krl+VeOmNwGVSuVvE9tV4E1m5Dls222ZfoYIedoRY6mefU8X
 m//oQEbjtCh1k7S2cDT/ij8nlFWe5lTq5KVv3QeYWSkQcKB6k3RnHDITZgVPCjmPNB7x5b
 fA900rqH3AoBQ1ymkVLRpD5qLYcKU3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-ROaxeF3aNvGPTVmZTceqGA-1; Thu, 24 Sep 2020 11:16:09 -0400
X-MC-Unique: ROaxeF3aNvGPTVmZTceqGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0EE64143;
 Thu, 24 Sep 2020 15:16:07 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF09455788;
 Thu, 24 Sep 2020 15:16:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/13] util/vhost-user-server: drop unnecessary watch
 deletion
Date: Thu, 24 Sep 2020 16:15:40 +0100
Message-Id: <20200924151549.913737-5-stefanha@redhat.com>
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RXhwbGljaXRseSBkZWxldGluZyB3YXRjaGVzIGlzIG5vdCBuZWNlc3Nhcnkgc2luY2UgbGlidmhv
c3QtdXNlciBjYWxscwpyZW1vdmVfd2F0Y2goKSBkdXJpbmcgdnVfZGVpbml0KCkuIEFkZCBhbiBh
c3NlcnRpb24gdG8gY2hlY2sgdGhpcwp0aG91Z2guCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC92aG9zdC11c2VyLXNlcnZlci5j
IHwgMTkgKysrKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5j
IGIvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCmluZGV4IGViZTQ3ODg1ZjUuLmViYjg1MDczMWIg
MTAwNjQ0Ci0tLSBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYworKysgYi91dGlsL3Zob3N0LXVz
ZXItc2VydmVyLmMKQEAgLTQ4LDIxICs0OCw2IEBAIHN0YXRpYyB2b2lkIGNsb3NlX2NsaWVudChW
dVNlcnZlciAqc2VydmVyKQogICAgIC8qIFdoZW4gdGhpcyBpcyBzZXQgdnVfY2xpZW50X3RyaXAg
d2lsbCBzdG9wIG5ldyBwcm9jZXNzaW5nIHZob3N0LXVzZXIgbWVzc2FnZSAqLwogICAgIHNlcnZl
ci0+c2lvYyA9IE5VTEw7CiAKLSAgICBWdUZkV2F0Y2ggKnZ1X2ZkX3dhdGNoLCAqbmV4dDsKLSAg
ICBRVEFJTFFfRk9SRUFDSF9TQUZFKHZ1X2ZkX3dhdGNoLCAmc2VydmVyLT52dV9mZF93YXRjaGVz
LCBuZXh0LCBuZXh0KSB7Ci0gICAgICAgIGFpb19zZXRfZmRfaGFuZGxlcihzZXJ2ZXItPmlvYy0+
Y3R4LCB2dV9mZF93YXRjaC0+ZmQsIHRydWUsIE5VTEwsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICBOVUxMLCBOVUxMLCBOVUxMKTsKLSAgICB9Ci0KLSAgICB3aGlsZSAoIVFUQUlMUV9FTVBU
WSgmc2VydmVyLT52dV9mZF93YXRjaGVzKSkgewotICAgICAgICBRVEFJTFFfRk9SRUFDSF9TQUZF
KHZ1X2ZkX3dhdGNoLCAmc2VydmVyLT52dV9mZF93YXRjaGVzLCBuZXh0LCBuZXh0KSB7Ci0gICAg
ICAgICAgICBpZiAoIXZ1X2ZkX3dhdGNoLT5wcm9jZXNzaW5nKSB7Ci0gICAgICAgICAgICAgICAg
UVRBSUxRX1JFTU9WRSgmc2VydmVyLT52dV9mZF93YXRjaGVzLCB2dV9mZF93YXRjaCwgbmV4dCk7
Ci0gICAgICAgICAgICAgICAgZ19mcmVlKHZ1X2ZkX3dhdGNoKTsKLSAgICAgICAgICAgIH0KLSAg
ICAgICAgfQotICAgIH0KLQogICAgIHdoaWxlIChzZXJ2ZXItPnByb2Nlc3NpbmdfbXNnKSB7CiAg
ICAgICAgIGlmIChzZXJ2ZXItPmlvYy0+cmVhZF9jb3JvdXRpbmUpIHsKICAgICAgICAgICAgIHNl
cnZlci0+aW9jLT5yZWFkX2Nvcm91dGluZSA9IE5VTEw7CkBAIC03Myw2ICs1OCwxMCBAQCBzdGF0
aWMgdm9pZCBjbG9zZV9jbGllbnQoVnVTZXJ2ZXIgKnNlcnZlcikKICAgICB9CiAKICAgICB2dV9k
ZWluaXQoJnNlcnZlci0+dnVfZGV2KTsKKworICAgIC8qIHZ1X2RlaW5pdCgpIHNob3VsZCBoYXZl
IGNhbGxlZCByZW1vdmVfd2F0Y2goKSAqLworICAgIGFzc2VydChRVEFJTFFfRU1QVFkoJnNlcnZl
ci0+dnVfZmRfd2F0Y2hlcykpOworCiAgICAgb2JqZWN0X3VucmVmKE9CSkVDVChzaW9jKSk7CiAg
ICAgb2JqZWN0X3VucmVmKE9CSkVDVChzZXJ2ZXItPmlvYykpOwogfQotLSAKMi4yNi4yCgo=


