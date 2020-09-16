Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CC8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A821F21973
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5hMZsOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A821F21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUAr-0003i1-Ox
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6x-0006JE-6i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIU6v-0000eC-Fr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXsIGqRE07bfYc36CHCsPlQ1Vpqma7Ye5JadMeb6sv4=;
 b=f5hMZsOevlHDyIMCmCHNFqBXR8zypkKyMWrOwbrmnxajCadYP8ygkjW3NPAGYxTzOqgceh
 cXPxZ6spedp0KlkhvcZ6fE2jV2HqdAyn27ND/gFYWAWNHeNT6zaZKYxklWD+pAYhhgTPSi
 2VEQDl65MGninETmBSOq34XRoCPzwPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-0jd0sEcGP2iZFE3-TL3QBQ-1; Wed, 16 Sep 2020 05:52:16 -0400
X-MC-Unique: 0jd0sEcGP2iZFE3-TL3QBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F48107464B;
 Wed, 16 Sep 2020 09:52:15 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A66260BFA;
 Wed, 16 Sep 2020 09:52:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] nvdimm: honor -object memory-backend-file,
 readonly=on option
Date: Wed, 16 Sep 2020 10:51:50 +0100
Message-Id: <20200916095150.755714-4-stefanha@redhat.com>
In-Reply-To: <20200916095150.755714-1-stefanha@redhat.com>
References: <20200916095150.755714-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, eric.g.ernst@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBwcmVzZW50IHJlYWQtb25seSBmaWxlcyB0byB0aGUgZ3Vlc3Qg
YXMgInVuYXJtZWQiCk5WRElNTXMuIFRoZSBMaW51eCBOVkRJTU0gZGV2aWNlICgvZGV2L3BtZW1Y
KSBpcyByZWFkLW9ubHkuCgpBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0
LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29t
PgotLS0KIGRvY3MvbnZkaW1tLnR4dCB8IDggKysrKysrKy0KIGh3L21lbS9udmRpbW0uYyB8IDQg
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZG9jcy9udmRpbW0udHh0IGIvZG9jcy9udmRpbW0udHh0CmluZGV4IGMyYzZl
NDQxYjMuLjA2YzIwMDgxMDcgMTAwNjQ0Ci0tLSBhL2RvY3MvbnZkaW1tLnR4dAorKysgYi9kb2Nz
L252ZGltbS50eHQKQEAgLTE3LDcgKzE3LDcgQEAgZm9sbG93aW5nIGNvbW1hbmQgbGluZSBvcHRp
b25zOgogCiAgLW1hY2hpbmUgcGMsbnZkaW1tCiAgLW0gJFJBTV9TSVpFLHNsb3RzPSROLG1heG1l
bT0kTUFYX1NJWkUKLSAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUsaWQ9bWVtMSxzaGFyZT1v
bixtZW0tcGF0aD0kUEFUSCxzaXplPSROVkRJTU1fU0laRQorIC1vYmplY3QgbWVtb3J5LWJhY2tl
bmQtZmlsZSxpZD1tZW0xLHNoYXJlPW9uLG1lbS1wYXRoPSRQQVRILHNpemU9JE5WRElNTV9TSVpF
LHJlYWRvbmx5PW9mZgogIC1kZXZpY2UgbnZkaW1tLGlkPW52ZGltbTEsbWVtZGV2PW1lbTEKIAog
V2hlcmUsCkBAIC00Miw2ICs0MiwxMiBAQCBXaGVyZSwKICAgICJzaGFyZT1vZmYiLCB0aGVuIGd1
ZXN0IHdyaXRlcyB3b24ndCBiZSBhcHBsaWVkIHRvIHRoZSBiYWNrZW5kCiAgICBmaWxlIGFuZCB0
aHVzIHdpbGwgYmUgaW52aXNpYmxlIHRvIG90aGVyIGd1ZXN0cy4KIAorICAgInJlYWRvbmx5PW9u
L29mZiIgY29udHJvbHMgd2hldGhlciB0aGUgZmlsZSAkUEFUSCBpcyBvcGVuZWQgcmVhZC1vbmx5
IG9yCisgICByZWFkL3dyaXRlIChkZWZhdWx0KS4gInJlYWRvbmx5PW9uIiBzZXRzIHRoZSBBQ1BJ
IE5GSVQgTlZESU1NIFJlZ2lvbiBNYXBwaW5nCisgICBTdHJ1Y3R1cmUgIk5WRElNTSBTdGF0ZSBG
bGFncyIgQml0IDMgaW5kaWNhdGluZyB0aGF0IHRoZSBkZXZpY2UgaXMgInVuYXJtZWQiCisgICBh
bmQgY2Fubm90IGFjY2VwdCBwZXJzaXN0ZW50IHdyaXRlcy4gTGludXggZ3Vlc3QgZHJpdmVycyBz
ZXQgdGhlIGRldmljZSB0bworICAgcmVhZC1vbmx5IHdoZW4gdGhpcyBiaXQgaXMgcHJlc2VudC4K
KwogIC0gImRldmljZSBudmRpbW0saWQ9bnZkaW1tMSxtZW1kZXY9bWVtMSIgY3JlYXRlcyBhIHZp
cnR1YWwgTlZESU1NCiAgICBkZXZpY2Ugd2hvc2Ugc3RvcmFnZSBpcyBwcm92aWRlZCBieSBhYm92
ZSBtZW1vcnkgYmFja2VuZCBkZXZpY2UuCiAKZGlmZiAtLWdpdCBhL2h3L21lbS9udmRpbW0uYyBi
L2h3L21lbS9udmRpbW0uYwppbmRleCBlMTU3NGJjMDdjLi44NDhjZDY1OTE3IDEwMDY0NAotLS0g
YS9ody9tZW0vbnZkaW1tLmMKKysrIGIvaHcvbWVtL252ZGltbS5jCkBAIC0xNDYsNiArMTQ2LDEw
IEBAIHN0YXRpYyB2b2lkIG52ZGltbV9wcmVwYXJlX21lbW9yeV9yZWdpb24oTlZESU1NRGV2aWNl
ICpudmRpbW0sIEVycm9yICoqZXJycCkKICAgICAgICAgcmV0dXJuOwogICAgIH0KIAorICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JvbShtcikpIHsKKyAgICAgICAgbnZkaW1tLT51bmFybWVkID0g
dHJ1ZTsgLyogdGhpcyBkZXZpY2UgaXMgcmVhZC1vbmx5ICovCisgICAgfQorCiAgICAgbnZkaW1t
LT5udmRpbW1fbXIgPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwogICAgIG1lbW9yeV9yZWdpb25f
aW5pdF9hbGlhcyhudmRpbW0tPm52ZGltbV9tciwgT0JKRUNUKGRpbW0pLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAibnZkaW1tLW1lbW9yeSIsIG1yLCAwLCBwbWVtX3NpemUpOwotLSAK
Mi4yNi4yCgo=


