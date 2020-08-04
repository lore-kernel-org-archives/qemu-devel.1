Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED5F2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcChT1Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED5F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2pX4-00073h-Eu
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 01:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUp-0005RP-7M
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUn-0004g6-JQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596518896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYSfj/Ob3hj80XgXQHZ5qM94CUH/7Nprc+H/+M2FE6Q=;
 b=EcChT1Ic/fLBegKyMlu8ugUWx4/PVTjDFGBoQxiABo3rvGt0yGJHlhJVZ0vma7i21hQaFA
 RZYAewjDW+D8FpxUz4H/4cwDu0PWaaKu6JAkGdIZLsbNwfkcaafus02PXmSLLZya52Ga4z
 k7JTh5b2RnOpZw8LKZlew/GcnAo0ACo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-gurlA-gjPoaIU-68BzRCbA-1; Tue, 04 Aug 2020 01:28:14 -0400
X-MC-Unique: gurlA-gjPoaIU-68BzRCbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7691DE1;
 Tue,  4 Aug 2020 05:28:13 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CEB28A181;
 Tue,  4 Aug 2020 05:28:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] async: rename event_notifier_dummy_cb/poll()
Date: Tue,  4 Aug 2020 06:28:02 +0100
Message-Id: <20200804052804.1165291-2-stefanha@redhat.com>
In-Reply-To: <20200804052804.1165291-1-stefanha@redhat.com>
References: <20200804052804.1165291-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGV2ZW50X25vdGlmaWVyXyooKSBwcmVmaXggY2FuIGJlIGNvbmZ1c2VkIHdpdGggdGhlIEV2
ZW50Tm90aWZpZXIKQVBJcyB0aGF0IGFyZSBhbHNvIGNhbGxlZCBldmVudF9ub3RpZmllcl8qKCku
CgpSZW5hbWUgdGhlIGZ1bmN0aW9ucyB0byBhaW9fY29udGV4dF9ub3RpZmllcl8qKCkgdG8gbWFr
ZSBpdCBjbGVhciB0aGF0CnRoZXkgcmVsYXRlIHRvIHRoZSBBaW9Db250ZXh0Ojpub3RpZmllciBm
aWVsZC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiB1dGlsL2FzeW5jLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvYXN5bmMuYyBiL3V0
aWwvYXN5bmMuYwppbmRleCAxMzE5ZWVlM2JjLi5kOWY5ODdlMTMzIDEwMDY0NAotLS0gYS91dGls
L2FzeW5jLmMKKysrIGIvdXRpbC9hc3luYy5jCkBAIC00NDUsMTIgKzQ0NSwxMiBAQCBzdGF0aWMg
dm9pZCBhaW9fdGltZXJsaXN0X25vdGlmeSh2b2lkICpvcGFxdWUsIFFFTVVDbG9ja1R5cGUgdHlw
ZSkKICAgICBhaW9fbm90aWZ5KG9wYXF1ZSk7CiB9CiAKLXN0YXRpYyB2b2lkIGV2ZW50X25vdGlm
aWVyX2R1bW15X2NiKEV2ZW50Tm90aWZpZXIgKmUpCitzdGF0aWMgdm9pZCBhaW9fY29udGV4dF9u
b3RpZmllcl9kdW1teV9jYihFdmVudE5vdGlmaWVyICplKQogewogfQogCiAvKiBSZXR1cm5zIHRy
dWUgaWYgYWlvX25vdGlmeSgpIHdhcyBjYWxsZWQgKGUuZy4gYSBCSCB3YXMgc2NoZWR1bGVkKSAq
Lwotc3RhdGljIGJvb2wgZXZlbnRfbm90aWZpZXJfcG9sbCh2b2lkICpvcGFxdWUpCitzdGF0aWMg
Ym9vbCBhaW9fY29udGV4dF9ub3RpZmllcl9wb2xsKHZvaWQgKm9wYXF1ZSkKIHsKICAgICBFdmVu
dE5vdGlmaWVyICplID0gb3BhcXVlOwogICAgIEFpb0NvbnRleHQgKmN0eCA9IGNvbnRhaW5lcl9v
ZihlLCBBaW9Db250ZXh0LCBub3RpZmllcik7CkBAIC01MDgsOCArNTA4LDggQEAgQWlvQ29udGV4
dCAqYWlvX2NvbnRleHRfbmV3KEVycm9yICoqZXJycCkKIAogICAgIGFpb19zZXRfZXZlbnRfbm90
aWZpZXIoY3R4LCAmY3R4LT5ub3RpZmllciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZh
bHNlLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgZXZlbnRfbm90aWZpZXJfZHVtbXlfY2Is
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICBldmVudF9ub3RpZmllcl9wb2xsKTsKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFpb19jb250ZXh0X25vdGlmaWVyX2R1bW15X2NiLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZpZXJfcG9sbCk7CiAjaWZk
ZWYgQ09ORklHX0xJTlVYX0FJTwogICAgIGN0eC0+bGludXhfYWlvID0gTlVMTDsKICNlbmRpZgot
LSAKMi4yNi4yCgo=


