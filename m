Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68932C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F4A2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzXgXxxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F4A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKdT-0003Hc-Rd
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZ3-0004qk-2q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYz-0007sY-TR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8n5FGglofSWSuHLIHxXfbLQCLImF7XWLpkLxdv5S0c=;
 b=SzXgXxxvWyxqhHjGmcTJKJ6z1oAdwSiuiq5Xk089NqEirKnUiF3WXOiaYelNVoDWb74Aj0
 ROZ3St+eWNjCrudRfxSdvDd3b1hrtUmzW6G7fniIHf9wbfNcht0ix+ILO8ihR1s2PIMgl9
 NDrbZYbWrMLZB3T7IXy2o1IoSoqcFAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-VvnFW5qSNtGrsM6uWq_Zww-1; Wed, 04 Nov 2020 10:19:02 -0500
X-MC-Unique: VvnFW5qSNtGrsM6uWq_Zww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F7D8030B0;
 Wed,  4 Nov 2020 15:19:01 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DB485B4CE;
 Wed,  4 Nov 2020 15:18:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/33] block/nvme: Use hex format to display offset in trace
 events
Date: Wed,  4 Nov 2020 15:17:59 +0000
Message-Id: <20201104151828.405824-5-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVXNlIHRo
ZSBzYW1lIGZvcm1hdCB1c2VkIGZvciB0aGUgaHcvdmZpby8gdHJhY2UgZXZlbnRzLgoKU3VnZ2Vz
dGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMy1w
aGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
PgotLS0KIGJsb2NrL3RyYWNlLWV2ZW50cyB8IDEyICsrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay90
cmFjZS1ldmVudHMgYi9ibG9jay90cmFjZS1ldmVudHMKaW5kZXggMGUzNTFjM2ZhMy4uMDk1NWM4
NWM3OCAxMDA2NDQKLS0tIGEvYmxvY2svdHJhY2UtZXZlbnRzCisrKyBiL2Jsb2NrL3RyYWNlLWV2
ZW50cwpAQCAtMTQ0LDEzICsxNDQsMTMgQEAgbnZtZV9zdWJtaXRfY29tbWFuZCh2b2lkICpzLCBp
bnQgaW5kZXgsIGludCBjaWQpICJzICVwIHF1ZXVlICVkIGNpZCAlZCIKIG52bWVfc3VibWl0X2Nv
bW1hbmRfcmF3KGludCBjMCwgaW50IGMxLCBpbnQgYzIsIGludCBjMywgaW50IGM0LCBpbnQgYzUs
IGludCBjNiwgaW50IGM3KSAiJTAyeCAlMDJ4ICUwMnggJTAyeCAlMDJ4ICUwMnggJTAyeCAlMDJ4
IgogbnZtZV9oYW5kbGVfZXZlbnQodm9pZCAqcykgInMgJXAiCiBudm1lX3BvbGxfY2Iodm9pZCAq
cykgInMgJXAiCi1udm1lX3Byd19hbGlnbmVkKHZvaWQgKnMsIGludCBpc193cml0ZSwgdWludDY0
X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IGZsYWdzLCBpbnQgbmlvdikgInMgJXAgaXNf
d3JpdGUgJWQgb2Zmc2V0ICUiUFJJZDY0IiBieXRlcyAlIlBSSWQ2NCIgZmxhZ3MgJWQgbmlvdiAl
ZCIKLW52bWVfd3JpdGVfemVyb2VzKHZvaWQgKnMsIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3Qg
Ynl0ZXMsIGludCBmbGFncykgInMgJXAgb2Zmc2V0ICUiUFJJZDY0IiBieXRlcyAlIlBSSWQ2NCIg
ZmxhZ3MgJWQiCitudm1lX3Byd19hbGlnbmVkKHZvaWQgKnMsIGludCBpc193cml0ZSwgdWludDY0
X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IGZsYWdzLCBpbnQgbmlvdikgInMgJXAgaXNf
d3JpdGUgJWQgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5dGVzICUiUFJJZDY0IiBmbGFncyAlZCBuaW92
ICVkIgorbnZtZV93cml0ZV96ZXJvZXModm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRf
dCBieXRlcywgaW50IGZsYWdzKSAicyAlcCBvZmZzZXQgMHglIlBSSXg2NCIgYnl0ZXMgJSJQUklk
NjQiIGZsYWdzICVkIgogbnZtZV9xaW92X3VuYWxpZ25lZChjb25zdCB2b2lkICpxaW92LCBpbnQg
biwgdm9pZCAqYmFzZSwgc2l6ZV90IHNpemUsIGludCBhbGlnbikgInFpb3YgJXAgbiAlZCBiYXNl
ICVwIHNpemUgMHglenggYWxpZ24gMHgleCIKLW52bWVfcHJ3X2J1ZmZlcmVkKHZvaWQgKnMsIHVp
bnQ2NF90IG9mZnNldCwgdWludDY0X3QgYnl0ZXMsIGludCBuaW92LCBpbnQgaXNfd3JpdGUpICJz
ICVwIG9mZnNldCAlIlBSSWQ2NCIgYnl0ZXMgJSJQUklkNjQiIG5pb3YgJWQgaXNfd3JpdGUgJWQi
Ci1udm1lX3J3X2RvbmUodm9pZCAqcywgaW50IGlzX3dyaXRlLCB1aW50NjRfdCBvZmZzZXQsIHVp
bnQ2NF90IGJ5dGVzLCBpbnQgcmV0KSAicyAlcCBpc193cml0ZSAlZCBvZmZzZXQgJSJQUklkNjQi
IGJ5dGVzICUiUFJJZDY0IiByZXQgJWQiCi1udm1lX2RzbSh2b2lkICpzLCB1aW50NjRfdCBvZmZz
ZXQsIHVpbnQ2NF90IGJ5dGVzKSAicyAlcCBvZmZzZXQgJSJQUklkNjQiIGJ5dGVzICUiUFJJZDY0
IiIKLW52bWVfZHNtX2RvbmUodm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRl
cywgaW50IHJldCkgInMgJXAgb2Zmc2V0ICUiUFJJZDY0IiBieXRlcyAlIlBSSWQ2NCIgcmV0ICVk
IgorbnZtZV9wcndfYnVmZmVyZWQodm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBi
eXRlcywgaW50IG5pb3YsIGludCBpc193cml0ZSkgInMgJXAgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5
dGVzICUiUFJJZDY0IiBuaW92ICVkIGlzX3dyaXRlICVkIgorbnZtZV9yd19kb25lKHZvaWQgKnMs
IGludCBpc193cml0ZSwgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IHJldCkg
InMgJXAgaXNfd3JpdGUgJWQgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5dGVzICUiUFJJZDY0IiByZXQg
JWQiCitudm1lX2RzbSh2b2lkICpzLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzKSAi
cyAlcCBvZmZzZXQgMHglIlBSSXg2NCIgYnl0ZXMgJSJQUklkNjQiIgorbnZtZV9kc21fZG9uZSh2
b2lkICpzLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLCBpbnQgcmV0KSAicyAlcCBv
ZmZzZXQgMHglIlBSSXg2NCIgYnl0ZXMgJSJQUklkNjQiIHJldCAlZCIKIG52bWVfZG1hX21hcF9m
bHVzaCh2b2lkICpzKSAicyAlcCIKIG52bWVfZnJlZV9yZXFfcXVldWVfd2FpdCh2b2lkICpxKSAi
cSAlcCIKIG52bWVfY21kX21hcF9xaW92KHZvaWQgKnMsIHZvaWQgKmNtZCwgdm9pZCAqcmVxLCB2
b2lkICpxaW92LCBpbnQgZW50cmllcykgInMgJXAgY21kICVwIHJlcSAlcCBxaW92ICVwIGVudHJp
ZXMgJWQiCi0tIAoyLjI4LjAKCg==


