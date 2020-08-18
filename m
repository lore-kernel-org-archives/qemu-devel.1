Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D8AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF50208C7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVKy2bsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF50208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83Vs-0001am-6p
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82gq-0004jy-Vv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82go-0002Qi-2V
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1CPwUyyJ9DJZFcv0OPojo7vILgxsfZnSiYwrXjr+nX0=;
 b=XVKy2bshcKLN8w+k9jSTn8jxMc9ZOcGlUue+aSgPUZv0QOroHGhfwQYV2GOOz7cTOBVDmp
 ICGM8NVTpajYMQN2kyeZ0a6kstMMACbP944Z5N8YCigjFmDcVrf6OHQ538lNR7GVPy59K/
 Vfv9g4IXX/O2x8ae9jp7W9OOlZdHF0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-Gu6PFkqhM7Gc6DYowI7FpQ-1; Tue, 18 Aug 2020 10:34:09 -0400
X-MC-Unique: Gu6PFkqhM7Gc6DYowI7FpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9EFE10066FB;
 Tue, 18 Aug 2020 14:34:02 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFCA5D9E8;
 Tue, 18 Aug 2020 14:33:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/7] virtio-pci: enable blk and scsi multi-queue by default
Date: Tue, 18 Aug 2020 15:33:41 +0100
Message-Id: <20200818143348.310613-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, cohuck@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djY6DQogKiBSZWJhc2VkIG9udG8gUUVNVSA1LjEgYW5kIGFkZGVkIHRoZSBub3ctbmVjZXNzYXJ5
IG1hY2hpbmUgY29tcGF0IG9wdHMuDQoNCnY0Og0KICogU29ycnkgZm9yIHRoZSBsb25nIGRlbGF5
LiBJIGNvbnNpZGVyZWQgcmVwbGFjaW5nIHRoaXMgc2VyaWVzIHdpdGggYSBzaW1wbGVyDQogICBh
cHByb2FjaC4gUmVhbCBoYXJkd2FyZSBzaGlwcyB3aXRoIGEgZml4ZWQgbnVtYmVyIG9mIHF1ZXVl
cyAoZS5nLiAxMjgpLiBUaGUNCiAgIGVxdWl2YWxlbnQgY2FuIGJlIGRvbmUgaW4gUUVNVSB0b28u
IFRoYXQgd2F5IHdlIGRvbid0IG5lZWQgdG8gbWFnaWNhbGx5IHNpPQ0KemUNCiAgIG51bV9xdWV1
ZXMuIEluIHRoZSBlbmQgSSBkZWNpZGVkIGFnYWluc3QgdGhpcyBhcHByb2FjaCBiZWNhdXNlIHRo
ZSBMaW51eA0KICAgdmlydGlvX2Jsay5rbyBhbmQgdmlydGlvX3Njc2kua28gZ3Vlc3QgZHJpdmVy
cyB1bmNvbmRpdGlvbmFsbHkgaW5pdGlhbGl6ZWQNCiAgIGFsbCBhdmFpbGFibGUgcXVldWVzIHVu
dGlsIHJlY2VudGx5IChpdCB3YXMgd3JpdHRlbiB3aXRoDQogICBudW1fcXVldWVzPTNEbnVtX3Zj
cHVzIGluIG1pbmQpLiBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgZm9yIGEgMSBDUFUgZ3Vlc3QgdG8N
CiAgIGJyaW5nIHVwIDEyOCB2aXJ0cXVldWVzICh3YXN0ZSBvZiByZXNvdXJjZXMgYW5kIHBvc3Np
Ymx5IHdlaXJkIHBlcmZvcm1hbmNlDQogICBlZmZlY3RzIHdpdGggYmxrLW1xKS4NCiAqIEhvbm9y
IG1heGltdW0gbnVtYmVyIG9mIE1TSS1YIHZlY3RvcnMgYW5kIHZpcnRxdWV1ZXMgW0RhbmllbCBC
ZXJyYW5nZV0NCiAqIFVwZGF0ZSBjb21taXQgZGVzY3JpcHRpb25zIHRvIG1lbnRpb24gbWF4aW11
bSBNU0ktWCB2ZWN0b3IgYW5kIHZpcnRxdWV1ZQ0KICAgY2FwcyBbUmFwaGFlbF0NCnYzOg0KICog
SW50cm9kdWNlIHZpcnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzKCkgaGVscGVyIHRvIGVuZm9y
Y2UgVklSVElPX1FVRVVFX009DQpBWA0KICAgaW4gb25lIHBsYWNlDQogKiBVc2UgVklSVElPX1ND
U0lfVlFfTlVNX0ZJWEVEIGNvbnN0YW50IGluIGFsbCBjYXNlcyBbQ29ybmVsaWFdDQogKiBVcGRh
dGUgaHcvY29yZS9tYWNoaW5lLmMgY29tcGF0IHByb3BlcnRpZXMgZm9yIFFFTVUgNS4wIFtNaWNo
YWVsXQ0KdjM6DQogKiBBZGQgbmV3IHBlcmZvcm1hbmNlIHJlc3VsdHMgdGhhdCBkZW1vbnN0cmF0
ZSB0aGUgc2NhbGFiaWxpdHkNCiAqIE1lbnRpb24gdGhhdCB0aGlzIGlzIFBDSS1zcGVjaWZpYyBb
Q29ybmVsaWFdDQp2MjoNCiAqIExldCB0aGUgdmlydGlvLURFVklDRS1wY2kgZGV2aWNlIHNlbGVj
dCBudW0tcXVldWVzIGJlY2F1c2UgdGhlIG9wdGltYWwNCiAgIG11bHRpLXF1ZXVlIGNvbmZpZ3Vy
YXRpb24gbWF5IGRpZmZlciBiZXR3ZWVuIHZpcnRpby1wY2ksIHZpcnRpby1tbWlvLCBhbmQNCiAg
IHZpcnRpby1jY3cgW0Nvcm5lbGlhXQ0KDQpFbmFibGluZyBtdWx0aS1xdWV1ZSBvbiB2aXJ0aW8t
cGNpIHN0b3JhZ2UgZGV2aWNlcyBpbXByb3ZlcyBwZXJmb3JtYW5jZSBvbiBTTVANCmd1ZXN0cyBi
ZWNhdXNlIHRoZSBjb21wbGV0aW9uIGludGVycnVwdCBpcyBoYW5kbGVkIG9uIHRoZSB2Q1BVIHRo
YXQgc3VibWl0dGVkDQp0aGUgSS9PIHJlcXVlc3QuICBUaGlzIGF2b2lkcyBJUElzIGluc2lkZSB0
aGUgZ3Vlc3QuDQoNCk5vdGUgdGhhdCBwZXJmb3JtYW5jZSBpcyB1bmNoYW5nZWQgaW4gdGhlc2Ug
Y2FzZXM6DQoxLiBVbmlwcm9jZXNzb3IgZ3Vlc3RzLiAgVGhleSBkb24ndCBoYXZlIElQSXMuDQoy
LiBBcHBsaWNhdGlvbiB0aHJlYWRzIG1pZ2h0IGJlIHNjaGVkdWxlZCBvbiB0aGUgc29sZSB2Q1BV
IHRoYXQgaGFuZGxlcw0KICAgY29tcGxldGlvbiBpbnRlcnJ1cHRzIHB1cmVseSBieSBjaGFuY2Uu
ICAoVGhpcyBpcyBvbmUgcmVhc29uIHdoeSBiZW5jaG1hcmsNCiAgIHJlc3VsdHMgY2FuIHZhcnkg
bm90aWNhYmx5IGJldHdlZW4gcnVucy4pDQozLiBVc2VycyBtYXkgYmluZCB0aGUgYXBwbGljYXRp
b24gdG8gdGhlIHZDUFUgdGhhdCBoYW5kbGVzIGNvbXBsZXRpb24NCiAgIGludGVycnVwdHMuDQoN
ClNldCB0aGUgbnVtYmVyIG9mIHF1ZXVlcyB0byB0aGUgbnVtYmVyIG9mIHZDUFVzIGJ5IGRlZmF1
bHQgb24gdmlydGlvLWJsayBhbmQNCnZpcnRpby1zY3NpIFBDSSBkZXZpY2VzLiAgT2xkZXIgbWFj
aGluZSB0eXBlcyBjb250aW51ZSB0byBkZWZhdWx0IHRvIDEgcXVldWUNCmZvciBsaXZlIG1pZ3Jh
dGlvbiBjb21wYXRpYmlsaXR5Lg0KDQpSYW5kb20gcmVhZCBwZXJmb3JtYW5jZToNCiAgICAgIElP
UFMNCnE9M0QxICAgIDc4aw0KcT0zRDMyICAxMDRrICArMzMlDQoNCkJvb3QgdGltZToNCiAgICAg
IER1cmF0aW9uDQpxPTNEMSAgICAgICAgNTFzDQpxPTNEMzIgICAgIDFtNDFzICArOTglDQoNCkd1
ZXN0IGNvbmZpZ3VyYXRpb246IDMyIHZDUFVzLCAxMDEgdmlydGlvLWJsay1wY2kgZGlza3MNCg0K
UHJldmlvdXNseSBtZWFzdXJlZCByZXN1bHRzIG9uIGEgNCB2Q1BVIGd1ZXN0IHdlcmUgYWxzbyBw
b3NpdGl2ZSBidXQgc2hvd2VkIGENCnNtYWxsZXIgMS00JSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVu
dC4gIFRoZXkgYXJlIG5vIGxvbmdlciB2YWxpZCBiZWNhdXNlDQpzaWduaWZpY2FudCBldmVudCBs
b29wIG9wdGltaXphdGlvbnMgaGF2ZSBiZWVuIG1lcmdlZC4NCg0KUGV0ZXIgTWF5ZGVsbCAoMSk6
DQogIE9wZW4gNS4yIGRldmVsb3BtZW50IHRyZWUNCg0KU3RlZmFuIEhham5vY3ppICg2KToNCiAg
aHc6IGFkZCA1LjIgbWFjaGluZSB0eXBlcyBhbmQgNS4xIGNvbXBhdCBvcHRpb25zDQogIHZpcnRp
by1wY2k6IGFkZCB2aXJ0aW9fcGNpX29wdGltYWxfbnVtX3F1ZXVlcygpIGhlbHBlcg0KICB2aXJ0
aW8tc2NzaTogaW50cm9kdWNlIGEgY29uc3RhbnQgZm9yIGZpeGVkIHZpcnRxdWV1ZXMNCiAgdmly
dGlvLXNjc2ktcGNpOiBkZWZhdWx0IG51bV9xdWV1ZXMgdG8gLXNtcCBODQogIHZpcnRpby1ibGst
cGNpOiBkZWZhdWx0IG51bV9xdWV1ZXMgdG8gLXNtcCBODQogIHZob3N0LXVzZXItYmxrLXBjaTog
ZGVmYXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTg0KDQogaHcvdmlydGlvL3ZpcnRpby1wY2kuaCAg
ICAgICAgICAgICB8ICA5ICsrKysrKysrKw0KIGluY2x1ZGUvaHcvYm9hcmRzLmggICAgICAgICAg
ICAgICAgfCAgMyArKysNCiBpbmNsdWRlL2h3L2kzODYvcGMuaCAgICAgICAgICAgICAgIHwgIDMg
KysrDQogaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaCB8ICAyICsrDQogaW5jbHVk
ZS9ody92aXJ0aW8vdmlydGlvLWJsay5oICAgICB8ICAyICsrDQogaW5jbHVkZS9ody92aXJ0aW8v
dmlydGlvLXNjc2kuaCAgICB8ICA1ICsrKysrDQogaHcvYXJtL3ZpcnQuYyAgICAgICAgICAgICAg
ICAgICAgICB8ICA5ICsrKysrKysrLQ0KIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgICAgICAg
ICAgfCAgNiArKysrKy0NCiBody9ibG9jay92aXJ0aW8tYmxrLmMgICAgICAgICAgICAgIHwgIDYg
KysrKystDQogaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrKysr
Kw0KIGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKysrDQogaHcvaTM4
Ni9wY19waWl4LmMgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0NCiBody9pMzg2
L3BjX3EzNS5jICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKystDQogaHcvcHBjL3Nw
YXByLmMgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKy0tDQogaHcvczM5MHgv
czM5MC12aXJ0aW8tY2N3LmMgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0NCiBody9zY3NpL3Zo
b3N0LXNjc2kuYyAgICAgICAgICAgICAgIHwgIDMgKystDQogaHcvc2NzaS92aG9zdC11c2VyLXNj
c2kuYyAgICAgICAgICB8ICA1ICsrKy0tDQogaHcvc2NzaS92aXJ0aW8tc2NzaS5jICAgICAgICAg
ICAgICB8IDEzICsrKysrKysrLS0tLQ0KIGh3L3ZpcnRpby92aG9zdC1zY3NpLXBjaS5jICAgICAg
ICAgfCAgOSArKysrKysrLS0NCiBody92aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNpLmMgICAgIHwg
IDQgKysrKw0KIGh3L3ZpcnRpby92aG9zdC11c2VyLXNjc2ktcGNpLmMgICAgfCAgOSArKysrKysr
LS0NCiBody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYyAgICAgICAgIHwgIDcgKysrKysrLQ0KIGh3
L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiBody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLmMgICAgICAgIHwgIDkgKysr
KysrKy0tDQogVkVSU0lPTiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQogMjUg
ZmlsZXMgY2hhbmdlZCwgMTg0IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KDQotLT0y
MA0KMi4yNi4yDQoNCg==


