Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C40820781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+VwDs5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C40820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5oLx-0005b3-1K
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oKN-0003tq-KE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oKK-0007AI-KN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597229388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQ45tqp8SaqX8OfuFH3rp5Q3ZXUef2GT5+Omm/cVV9g=;
 b=C+VwDs5YtisYavIdndrAVJ19R5VCusq3J11vWPtgQgFqng+/+t18/XxgXZ/ufR/LE7LKAj
 ZGSzgAGvouhYgSklO+o+a9Tf06Fs7/SyuDorKNTIgcq/UTfPdhEEnPm9nWCCcpph1Raa/t
 GovL1ENArp9UbUYtaaB4hjwlE6d2o3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-1niw20NON0-i_PXqcQxOJw-1; Wed, 12 Aug 2020 06:49:46 -0400
X-MC-Unique: 1niw20NON0-i_PXqcQxOJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F1C101C8A0;
 Wed, 12 Aug 2020 10:49:44 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF4060C84;
 Wed, 12 Aug 2020 10:49:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtio-crypto: don't modify elem->in/out_sg
Date: Wed, 12 Aug 2020 11:49:18 +0100
Message-Id: <20200812104918.107116-4-stefanha@redhat.com>
In-Reply-To: <20200812104918.107116-1-stefanha@redhat.com>
References: <20200812104918.107116-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
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
b2YgdGhlIGNvZGUsIHNvIGRvIHRoZSBzaW1wbGUKdGhpbmcgaW5zdGVhZC4KClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBody92aXJ0aW8v
dmlydGlvLWNyeXB0by5jIHwgMTcgKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aXJ0aW8tY3J5cHRvLmMgYi9ody92aXJ0aW8vdmlydGlvLWNyeXB0by5jCmluZGV4IDZkYTEyZTMx
NWYuLjU0ZjliYmI3ODkgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMKKysr
IGIvaHcvdmlydGlvL3ZpcnRpby1jcnlwdG8uYwpAQCAtMjI4LDYgKzIyOCw4IEBAIHN0YXRpYyB2
b2lkIHZpcnRpb19jcnlwdG9faGFuZGxlX2N0cmwoVmlydElPRGV2aWNlICp2ZGV2LCBWaXJ0UXVl
dWUgKnZxKQogICAgIHNpemVfdCBzOwogCiAgICAgZm9yICg7OykgeworICAgICAgICBnX2F1dG9m
cmVlIHN0cnVjdCBpb3ZlYyAqb3V0X2lvdl9jb3B5ID0gTlVMTDsKKwogICAgICAgICBlbGVtID0g
dmlydHF1ZXVlX3BvcCh2cSwgc2l6ZW9mKFZpcnRRdWV1ZUVsZW1lbnQpKTsKICAgICAgICAgaWYg
KCFlbGVtKSB7CiAgICAgICAgICAgICBicmVhazsKQEAgLTI0MCw5ICsyNDIsMTIgQEAgc3RhdGlj
IHZvaWQgdmlydGlvX2NyeXB0b19oYW5kbGVfY3RybChWaXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRR
dWV1ZSAqdnEpCiAgICAgICAgIH0KIAogICAgICAgICBvdXRfbnVtID0gZWxlbS0+b3V0X251bTsK
LSAgICAgICAgb3V0X2lvdiA9IGVsZW0tPm91dF9zZzsKKyAgICAgICAgb3V0X2lvdl9jb3B5ID0g
Z19tZW1kdXAoZWxlbS0+b3V0X3NnLCBzaXplb2Yob3V0X2lvdlswXSkgKiBvdXRfbnVtKTsKKyAg
ICAgICAgb3V0X2lvdiA9IG91dF9pb3ZfY29weTsKKwogICAgICAgICBpbl9udW0gPSBlbGVtLT5p
bl9udW07CiAgICAgICAgIGluX2lvdiA9IGVsZW0tPmluX3NnOworCiAgICAgICAgIGlmICh1bmxp
a2VseShpb3ZfdG9fYnVmKG91dF9pb3YsIG91dF9udW0sIDAsICZjdHJsLCBzaXplb2YoY3RybCkp
CiAgICAgICAgICAgICAgICAgICAgICE9IHNpemVvZihjdHJsKSkpIHsKICAgICAgICAgICAgIHZp
cnRpb19lcnJvcih2ZGV2LCAidmlydGlvLWNyeXB0byByZXF1ZXN0IGN0cmxfaGRyIHRvbyBzaG9y
dCIpOwpAQCAtNTgyLDYgKzU4Nyw4IEBAIHZpcnRpb19jcnlwdG9faGFuZGxlX3JlcXVlc3QoVmly
dElPQ3J5cHRvUmVxICpyZXF1ZXN0KQogICAgIGludCBxdWV1ZV9pbmRleCA9IHZpcnRpb19jcnlw
dG9fdnEycSh2aXJ0aW9fZ2V0X3F1ZXVlX2luZGV4KHJlcXVlc3QtPnZxKSk7CiAgICAgc3RydWN0
IHZpcnRpb19jcnlwdG9fb3BfZGF0YV9yZXEgcmVxOwogICAgIGludCByZXQ7CisgICAgZ19hdXRv
ZnJlZSBzdHJ1Y3QgaW92ZWMgKmluX2lvdl9jb3B5ID0gTlVMTDsKKyAgICBnX2F1dG9mcmVlIHN0
cnVjdCBpb3ZlYyAqb3V0X2lvdl9jb3B5ID0gTlVMTDsKICAgICBzdHJ1Y3QgaW92ZWMgKmluX2lv
djsKICAgICBzdHJ1Y3QgaW92ZWMgKm91dF9pb3Y7CiAgICAgdW5zaWduZWQgaW5fbnVtOwpAQCAt
NTk4LDkgKzYwNSwxMyBAQCB2aXJ0aW9fY3J5cHRvX2hhbmRsZV9yZXF1ZXN0KFZpcnRJT0NyeXB0
b1JlcSAqcmVxdWVzdCkKICAgICB9CiAKICAgICBvdXRfbnVtID0gZWxlbS0+b3V0X251bTsKLSAg
ICBvdXRfaW92ID0gZWxlbS0+b3V0X3NnOworICAgIG91dF9pb3ZfY29weSA9IGdfbWVtZHVwKGVs
ZW0tPm91dF9zZywgc2l6ZW9mKG91dF9pb3ZbMF0pICogb3V0X251bSk7CisgICAgb3V0X2lvdiA9
IG91dF9pb3ZfY29weTsKKwogICAgIGluX251bSA9IGVsZW0tPmluX251bTsKLSAgICBpbl9pb3Yg
PSBlbGVtLT5pbl9zZzsKKyAgICBpbl9pb3ZfY29weSA9IGdfbWVtZHVwKGVsZW0tPmluX3NnLCBz
aXplb2YoaW5faW92WzBdKSAqIGluX251bSk7CisgICAgaW5faW92ID0gaW5faW92X2NvcHk7CisK
ICAgICBpZiAodW5saWtlbHkoaW92X3RvX2J1ZihvdXRfaW92LCBvdXRfbnVtLCAwLCAmcmVxLCBz
aXplb2YocmVxKSkKICAgICAgICAgICAgICAgICAhPSBzaXplb2YocmVxKSkpIHsKICAgICAgICAg
dmlydGlvX2Vycm9yKHZkZXYsICJ2aXJ0aW8tY3J5cHRvIHJlcXVlc3Qgb3V0aGRyIHRvbyBzaG9y
dCIpOwotLSAKMi4yNi4yCgo=


