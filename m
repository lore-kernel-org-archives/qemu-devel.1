Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85320C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE0B208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/XxrpEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE0B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7ON-0005ru-22
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MN-0003f7-NM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7ML-0006Ee-MZ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UK0hisR5IR/XPUhfLKsAU3JrlBWQI1s3gJcYm2HJOiw=;
 b=J/XxrpEh7FVE/UIQder4sOhmgMkBzoFpB/7Fnzw1/oewn33Ny7g7x4vB9JKvWHlugC9g43
 aeeQnXYZFZmKFdkscLd59Iu3x9VvbKPW0PapngOBwOB2Q3yEODp4YE5gZyvem3q29Toifl
 47ROmbLlAnkeDB/rMbTjoVq5eOii9aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-YXqY7IAqPWqR9cBJDXW7ng-1; Wed, 23 Sep 2020 12:11:06 -0400
X-MC-Unique: YXqY7IAqPWqR9cBJDXW7ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8801C100746B;
 Wed, 23 Sep 2020 16:11:05 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB9B5D98D;
 Wed, 23 Sep 2020 16:11:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/13] virtio-crypto: don't modify elem->in/out_sg
Date: Wed, 23 Sep 2020 17:10:24 +0100
Message-Id: <20200923161031.69474-7-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Li Qiang <liq3ea@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
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
b2YgdGhlIGNvZGUsIHNvIGRvIHRoZSBzaW1wbGUKdGhpbmcgaW5zdGVhZC4KClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IExp
IFFpYW5nIDxsaXEzZWFAZ21haWwuY29tPgpNZXNzYWdlLUlkOiA8MjAyMDA5MTcwOTQ0NTUuODIy
Mzc5LTQtc3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBody92aXJ0aW8vdmlydGlvLWNyeXB0by5j
IHwgMTcgKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMg
Yi9ody92aXJ0aW8vdmlydGlvLWNyeXB0by5jCmluZGV4IDZkYTEyZTMxNWYuLjU0ZjliYmI3ODkg
MTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMKKysrIGIvaHcvdmlydGlvL3Zp
cnRpby1jcnlwdG8uYwpAQCAtMjI4LDYgKzIyOCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19jcnlw
dG9faGFuZGxlX2N0cmwoVmlydElPRGV2aWNlICp2ZGV2LCBWaXJ0UXVldWUgKnZxKQogICAgIHNp
emVfdCBzOwogCiAgICAgZm9yICg7OykgeworICAgICAgICBnX2F1dG9mcmVlIHN0cnVjdCBpb3Zl
YyAqb3V0X2lvdl9jb3B5ID0gTlVMTDsKKwogICAgICAgICBlbGVtID0gdmlydHF1ZXVlX3BvcCh2
cSwgc2l6ZW9mKFZpcnRRdWV1ZUVsZW1lbnQpKTsKICAgICAgICAgaWYgKCFlbGVtKSB7CiAgICAg
ICAgICAgICBicmVhazsKQEAgLTI0MCw5ICsyNDIsMTIgQEAgc3RhdGljIHZvaWQgdmlydGlvX2Ny
eXB0b19oYW5kbGVfY3RybChWaXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRRdWV1ZSAqdnEpCiAgICAg
ICAgIH0KIAogICAgICAgICBvdXRfbnVtID0gZWxlbS0+b3V0X251bTsKLSAgICAgICAgb3V0X2lv
diA9IGVsZW0tPm91dF9zZzsKKyAgICAgICAgb3V0X2lvdl9jb3B5ID0gZ19tZW1kdXAoZWxlbS0+
b3V0X3NnLCBzaXplb2Yob3V0X2lvdlswXSkgKiBvdXRfbnVtKTsKKyAgICAgICAgb3V0X2lvdiA9
IG91dF9pb3ZfY29weTsKKwogICAgICAgICBpbl9udW0gPSBlbGVtLT5pbl9udW07CiAgICAgICAg
IGluX2lvdiA9IGVsZW0tPmluX3NnOworCiAgICAgICAgIGlmICh1bmxpa2VseShpb3ZfdG9fYnVm
KG91dF9pb3YsIG91dF9udW0sIDAsICZjdHJsLCBzaXplb2YoY3RybCkpCiAgICAgICAgICAgICAg
ICAgICAgICE9IHNpemVvZihjdHJsKSkpIHsKICAgICAgICAgICAgIHZpcnRpb19lcnJvcih2ZGV2
LCAidmlydGlvLWNyeXB0byByZXF1ZXN0IGN0cmxfaGRyIHRvbyBzaG9ydCIpOwpAQCAtNTgyLDYg
KzU4Nyw4IEBAIHZpcnRpb19jcnlwdG9faGFuZGxlX3JlcXVlc3QoVmlydElPQ3J5cHRvUmVxICpy
ZXF1ZXN0KQogICAgIGludCBxdWV1ZV9pbmRleCA9IHZpcnRpb19jcnlwdG9fdnEycSh2aXJ0aW9f
Z2V0X3F1ZXVlX2luZGV4KHJlcXVlc3QtPnZxKSk7CiAgICAgc3RydWN0IHZpcnRpb19jcnlwdG9f
b3BfZGF0YV9yZXEgcmVxOwogICAgIGludCByZXQ7CisgICAgZ19hdXRvZnJlZSBzdHJ1Y3QgaW92
ZWMgKmluX2lvdl9jb3B5ID0gTlVMTDsKKyAgICBnX2F1dG9mcmVlIHN0cnVjdCBpb3ZlYyAqb3V0
X2lvdl9jb3B5ID0gTlVMTDsKICAgICBzdHJ1Y3QgaW92ZWMgKmluX2lvdjsKICAgICBzdHJ1Y3Qg
aW92ZWMgKm91dF9pb3Y7CiAgICAgdW5zaWduZWQgaW5fbnVtOwpAQCAtNTk4LDkgKzYwNSwxMyBA
QCB2aXJ0aW9fY3J5cHRvX2hhbmRsZV9yZXF1ZXN0KFZpcnRJT0NyeXB0b1JlcSAqcmVxdWVzdCkK
ICAgICB9CiAKICAgICBvdXRfbnVtID0gZWxlbS0+b3V0X251bTsKLSAgICBvdXRfaW92ID0gZWxl
bS0+b3V0X3NnOworICAgIG91dF9pb3ZfY29weSA9IGdfbWVtZHVwKGVsZW0tPm91dF9zZywgc2l6
ZW9mKG91dF9pb3ZbMF0pICogb3V0X251bSk7CisgICAgb3V0X2lvdiA9IG91dF9pb3ZfY29weTsK
KwogICAgIGluX251bSA9IGVsZW0tPmluX251bTsKLSAgICBpbl9pb3YgPSBlbGVtLT5pbl9zZzsK
KyAgICBpbl9pb3ZfY29weSA9IGdfbWVtZHVwKGVsZW0tPmluX3NnLCBzaXplb2YoaW5faW92WzBd
KSAqIGluX251bSk7CisgICAgaW5faW92ID0gaW5faW92X2NvcHk7CisKICAgICBpZiAodW5saWtl
bHkoaW92X3RvX2J1ZihvdXRfaW92LCBvdXRfbnVtLCAwLCAmcmVxLCBzaXplb2YocmVxKSkKICAg
ICAgICAgICAgICAgICAhPSBzaXplb2YocmVxKSkpIHsKICAgICAgICAgdmlydGlvX2Vycm9yKHZk
ZXYsICJ2aXJ0aW8tY3J5cHRvIHJlcXVlc3Qgb3V0aGRyIHRvbyBzaG9ydCIpOwotLSAKMi4yNi4y
Cgo=


