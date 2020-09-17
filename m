Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49070C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6D520770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmN7RGdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6D520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqZe-0006Br-Ua
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTx-0000hC-EK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTv-00006O-Mo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600335932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYDJ/Zvj7srLjreYqEwMBZbWjj85qGyGwORDGpJy/fo=;
 b=MmN7RGdBHKhtv9BNNyzkEc7REWAaXtleg3yhRanHUq06IV1YIuJs/cjGJ4Xt6ptIE9NmpT
 8VmN/wsn05WU0l9CmSsvKl483gmsZLNX9PgMzGbSWxCzvT+/DINp57YbuYDoef4WzX9+sT
 O0fDm9oGbsQUo7NbmGo3RtJC542CJgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-oPTjxXJzMuCKeS184WK1dw-1; Thu, 17 Sep 2020 05:45:28 -0400
X-MC-Unique: oPTjxXJzMuCKeS184WK1dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD5E10BBEE1;
 Thu, 17 Sep 2020 09:45:27 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3ACF5DE51;
 Thu, 17 Sep 2020 09:45:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] virtio-crypto: don't modify elem->in/out_sg
Date: Thu, 17 Sep 2020 10:44:55 +0100
Message-Id: <20200917094455.822379-4-stefanha@redhat.com>
In-Reply-To: <20200917094455.822379-1-stefanha@redhat.com>
References: <20200917094455.822379-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QSBudW1iZXIgb2YgaW92X2Rpc2NhcmRfZnJvbnQvYmFjaygpIG9wZXJhdGlvbnMgYXJlIG1hZGUg
YnkKdmlydGlvLWNyeXB0by4gVGhlIGVsZW0tPmluL291dF9zZyBpb3ZlYyBhcnJheXMgYXJlIG1v
ZGlmaWVkIGJ5IHRoZXNlCm9wZXJhdGlvbnMsIHJlc3VsdGluZyB2aXJ0cXVldWVfdW5tYXBfc2co
KSBjYWxscyBvbiBkaWZmZXJlbnQgYWRkcmVzc2VzCnRoYW4gd2VyZSBvcmlnaW5hbGx5IG1hcHBl
ZC4KClRoaXMgaXMgcHJvYmxlbWF0aWMgYmVjYXVzZSBkaXJ0eSBtZW1vcnkgbWF5IG5vdCBiZSBs
b2dnZWQgY29ycmVjdGx5LApNZW1vcnlSZWdpb24gcmVmY291bnRzIG1heSBiZSBsZWFrZWQsIGFu
ZCB0aGUgbm9uLVJBTSBib3VuY2UgYnVmZmVyIGNhbgpiZSBsZWFrZWQuCgpUYWtlIGEgY29weSBv
ZiB0aGUgZWxlbS0+aW4vb3V0X3NnIGFycmF5cyBzbyB0aGF0IHRoZSBvcmlnaW5hbHMgYXJlCnBy
ZXNlcnZlZC4gVGhlIGlvdl9kaXNjYXJkX3VuZG8oKSBBUEkgY291bGQgYmUgdXNlZCBpbnN0ZWFk
ICh3aXRoIGJldHRlcgpwZXJmb3JtYW5jZSkgYnV0IHJlcXVpcmVzIGNhcmVmdWwgYXVkaXRpbmcg
b2YgdGhlIGNvZGUsIHNvIGRvIHRoZSBzaW1wbGUKdGhpbmcgaW5zdGVhZC4KClJldmlld2VkLWJ5
OiBMaSBRaWFuZyA8bGlxM2VhQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGh3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMg
fCAxNyArKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1jcnlwdG8uYyBi
L2h3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMKaW5kZXggNmRhMTJlMzE1Zi4uNTRmOWJiYjc4OSAx
MDA2NDQKLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1jcnlwdG8uYworKysgYi9ody92aXJ0aW8vdmly
dGlvLWNyeXB0by5jCkBAIC0yMjgsNiArMjI4LDggQEAgc3RhdGljIHZvaWQgdmlydGlvX2NyeXB0
b19oYW5kbGVfY3RybChWaXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRRdWV1ZSAqdnEpCiAgICAgc2l6
ZV90IHM7CiAKICAgICBmb3IgKDs7KSB7CisgICAgICAgIGdfYXV0b2ZyZWUgc3RydWN0IGlvdmVj
ICpvdXRfaW92X2NvcHkgPSBOVUxMOworCiAgICAgICAgIGVsZW0gPSB2aXJ0cXVldWVfcG9wKHZx
LCBzaXplb2YoVmlydFF1ZXVlRWxlbWVudCkpOwogICAgICAgICBpZiAoIWVsZW0pIHsKICAgICAg
ICAgICAgIGJyZWFrOwpAQCAtMjQwLDkgKzI0MiwxMiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fY3J5
cHRvX2hhbmRsZV9jdHJsKFZpcnRJT0RldmljZSAqdmRldiwgVmlydFF1ZXVlICp2cSkKICAgICAg
ICAgfQogCiAgICAgICAgIG91dF9udW0gPSBlbGVtLT5vdXRfbnVtOwotICAgICAgICBvdXRfaW92
ID0gZWxlbS0+b3V0X3NnOworICAgICAgICBvdXRfaW92X2NvcHkgPSBnX21lbWR1cChlbGVtLT5v
dXRfc2csIHNpemVvZihvdXRfaW92WzBdKSAqIG91dF9udW0pOworICAgICAgICBvdXRfaW92ID0g
b3V0X2lvdl9jb3B5OworCiAgICAgICAgIGluX251bSA9IGVsZW0tPmluX251bTsKICAgICAgICAg
aW5faW92ID0gZWxlbS0+aW5fc2c7CisKICAgICAgICAgaWYgKHVubGlrZWx5KGlvdl90b19idWYo
b3V0X2lvdiwgb3V0X251bSwgMCwgJmN0cmwsIHNpemVvZihjdHJsKSkKICAgICAgICAgICAgICAg
ICAgICAgIT0gc2l6ZW9mKGN0cmwpKSkgewogICAgICAgICAgICAgdmlydGlvX2Vycm9yKHZkZXYs
ICJ2aXJ0aW8tY3J5cHRvIHJlcXVlc3QgY3RybF9oZHIgdG9vIHNob3J0Iik7CkBAIC01ODIsNiAr
NTg3LDggQEAgdmlydGlvX2NyeXB0b19oYW5kbGVfcmVxdWVzdChWaXJ0SU9DcnlwdG9SZXEgKnJl
cXVlc3QpCiAgICAgaW50IHF1ZXVlX2luZGV4ID0gdmlydGlvX2NyeXB0b192cTJxKHZpcnRpb19n
ZXRfcXVldWVfaW5kZXgocmVxdWVzdC0+dnEpKTsKICAgICBzdHJ1Y3QgdmlydGlvX2NyeXB0b19v
cF9kYXRhX3JlcSByZXE7CiAgICAgaW50IHJldDsKKyAgICBnX2F1dG9mcmVlIHN0cnVjdCBpb3Zl
YyAqaW5faW92X2NvcHkgPSBOVUxMOworICAgIGdfYXV0b2ZyZWUgc3RydWN0IGlvdmVjICpvdXRf
aW92X2NvcHkgPSBOVUxMOwogICAgIHN0cnVjdCBpb3ZlYyAqaW5faW92OwogICAgIHN0cnVjdCBp
b3ZlYyAqb3V0X2lvdjsKICAgICB1bnNpZ25lZCBpbl9udW07CkBAIC01OTgsOSArNjA1LDEzIEBA
IHZpcnRpb19jcnlwdG9faGFuZGxlX3JlcXVlc3QoVmlydElPQ3J5cHRvUmVxICpyZXF1ZXN0KQog
ICAgIH0KIAogICAgIG91dF9udW0gPSBlbGVtLT5vdXRfbnVtOwotICAgIG91dF9pb3YgPSBlbGVt
LT5vdXRfc2c7CisgICAgb3V0X2lvdl9jb3B5ID0gZ19tZW1kdXAoZWxlbS0+b3V0X3NnLCBzaXpl
b2Yob3V0X2lvdlswXSkgKiBvdXRfbnVtKTsKKyAgICBvdXRfaW92ID0gb3V0X2lvdl9jb3B5Owor
CiAgICAgaW5fbnVtID0gZWxlbS0+aW5fbnVtOwotICAgIGluX2lvdiA9IGVsZW0tPmluX3NnOwor
ICAgIGluX2lvdl9jb3B5ID0gZ19tZW1kdXAoZWxlbS0+aW5fc2csIHNpemVvZihpbl9pb3ZbMF0p
ICogaW5fbnVtKTsKKyAgICBpbl9pb3YgPSBpbl9pb3ZfY29weTsKKwogICAgIGlmICh1bmxpa2Vs
eShpb3ZfdG9fYnVmKG91dF9pb3YsIG91dF9udW0sIDAsICZyZXEsIHNpemVvZihyZXEpKQogICAg
ICAgICAgICAgICAgICE9IHNpemVvZihyZXEpKSkgewogICAgICAgICB2aXJ0aW9fZXJyb3IodmRl
diwgInZpcnRpby1jcnlwdG8gcmVxdWVzdCBvdXRoZHIgdG9vIHNob3J0Iik7Ci0tIAoyLjI2LjIK
Cg==


