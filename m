Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD18C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551632070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTLMukF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551632070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRdI-000308-JC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcH-0001WP-JQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcE-0006Qk-4i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ukgUgGWacAHYtACorfui2amVT9QmeLTFQeZL/Kctvdc=;
 b=CTLMukF5TAnN8jxOsKdkAqoiCs9ZDbskZW1x7k7ergGE1+0YgatS8Aw7EqePf4DKo5OWKT
 ObYrW4ttsi1qWPH+iHua7Q73PydwgdjMGRUxhwff6tfNNxib8fbBV6nvcrKEReXa+J6DHm
 VOKT3Z79dbHq+NhDWnKlxmkV0XqJsDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-aHkijQt0P6O8q10w-o-T8g-1; Mon, 06 Jul 2020 09:56:59 -0400
X-MC-Unique: aHkijQt0P6O8q10w-o-T8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37BB7804006;
 Mon,  6 Jul 2020 13:56:58 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E91785D9F3;
 Mon,  6 Jul 2020 13:56:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/5] virtio-pci: enable blk and scsi multi-queue by default
Date: Mon,  6 Jul 2020 14:56:45 +0100
Message-Id: <20200706135650.438362-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djQ6DQogKiBTb3JyeSBmb3IgdGhlIGxvbmcgZGVsYXkuIEkgY29uc2lkZXJlZCByZXBsYWNpbmcg
dGhpcyBzZXJpZXMgd2l0aCBhIHNpbXBsZXINCiAgIGFwcHJvYWNoLiBSZWFsIGhhcmR3YXJlIHNo
aXBzIHdpdGggYSBmaXhlZCBudW1iZXIgb2YgcXVldWVzIChlLmcuIDEyOCkuIFRoZQ0KICAgZXF1
aXZhbGVudCBjYW4gYmUgZG9uZSBpbiBRRU1VIHRvby4gVGhhdCB3YXkgd2UgZG9uJ3QgbmVlZCB0
byBtYWdpY2FsbHkgc2l6ZQ0KICAgbnVtX3F1ZXVlcy4gSW4gdGhlIGVuZCBJIGRlY2lkZWQgYWdh
aW5zdCB0aGlzIGFwcHJvYWNoIGJlY2F1c2UgdGhlIExpbnV4DQogICB2aXJ0aW9fYmxrLmtvIGFu
ZCB2aXJ0aW9fc2NzaS5rbyBndWVzdCBkcml2ZXJzIHVuY29uZGl0aW9uYWxseSBpbml0aWFsaXpl
ZA0KICAgYWxsIGF2YWlsYWJsZSBxdWV1ZXMgdW50aWwgcmVjZW50bHkgKGl0IHdhcyB3cml0dGVu
IHdpdGgNCiAgIG51bV9xdWV1ZXM9bnVtX3ZjcHVzIGluIG1pbmQpLiBJdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgZm9yIGEgMSBDUFUgZ3Vlc3QgdG8NCiAgIGJyaW5nIHVwIDEyOCB2aXJ0cXVldWVzICh3
YXN0ZSBvZiByZXNvdXJjZXMgYW5kIHBvc3NpYmx5IHdlaXJkIHBlcmZvcm1hbmNlDQogICBlZmZl
Y3RzIHdpdGggYmxrLW1xKS4NCiAqIEhvbm9yIG1heGltdW0gbnVtYmVyIG9mIE1TSS1YIHZlY3Rv
cnMgYW5kIHZpcnRxdWV1ZXMgW0RhbmllbCBCZXJyYW5nZV0NCiAqIFVwZGF0ZSBjb21taXQgZGVz
Y3JpcHRpb25zIHRvIG1lbnRpb24gbWF4aW11bSBNU0ktWCB2ZWN0b3IgYW5kIHZpcnRxdWV1ZQ0K
ICAgY2FwcyBbUmFwaGFlbF0NCnYzOg0KICogSW50cm9kdWNlIHZpcnRpb19wY2lfb3B0aW1hbF9u
dW1fcXVldWVzKCkgaGVscGVyIHRvIGVuZm9yY2UgVklSVElPX1FVRVVFX01BWA0KICAgaW4gb25l
IHBsYWNlDQogKiBVc2UgVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEIGNvbnN0YW50IGluIGFsbCBj
YXNlcyBbQ29ybmVsaWFdDQogKiBVcGRhdGUgaHcvY29yZS9tYWNoaW5lLmMgY29tcGF0IHByb3Bl
cnRpZXMgZm9yIFFFTVUgNS4wIFtNaWNoYWVsXQ0KdjM6DQogKiBBZGQgbmV3IHBlcmZvcm1hbmNl
IHJlc3VsdHMgdGhhdCBkZW1vbnN0cmF0ZSB0aGUgc2NhbGFiaWxpdHkNCiAqIE1lbnRpb24gdGhh
dCB0aGlzIGlzIFBDSS1zcGVjaWZpYyBbQ29ybmVsaWFdDQp2MjoNCiAqIExldCB0aGUgdmlydGlv
LURFVklDRS1wY2kgZGV2aWNlIHNlbGVjdCBudW0tcXVldWVzIGJlY2F1c2UgdGhlIG9wdGltYWwN
CiAgIG11bHRpLXF1ZXVlIGNvbmZpZ3VyYXRpb24gbWF5IGRpZmZlciBiZXR3ZWVuIHZpcnRpby1w
Y2ksIHZpcnRpby1tbWlvLCBhbmQNCiAgIHZpcnRpby1jY3cgW0Nvcm5lbGlhXQ0KDQpFbmFibGlu
ZyBtdWx0aS1xdWV1ZSBvbiB2aXJ0aW8tcGNpIHN0b3JhZ2UgZGV2aWNlcyBpbXByb3ZlcyBwZXJm
b3JtYW5jZSBvbiBTTVANCmd1ZXN0cyBiZWNhdXNlIHRoZSBjb21wbGV0aW9uIGludGVycnVwdCBp
cyBoYW5kbGVkIG9uIHRoZSB2Q1BVIHRoYXQgc3VibWl0dGVkDQp0aGUgSS9PIHJlcXVlc3QuICBU
aGlzIGF2b2lkcyBJUElzIGluc2lkZSB0aGUgZ3Vlc3QuDQoNCk5vdGUgdGhhdCBwZXJmb3JtYW5j
ZSBpcyB1bmNoYW5nZWQgaW4gdGhlc2UgY2FzZXM6DQoxLiBVbmlwcm9jZXNzb3IgZ3Vlc3RzLiAg
VGhleSBkb24ndCBoYXZlIElQSXMuDQoyLiBBcHBsaWNhdGlvbiB0aHJlYWRzIG1pZ2h0IGJlIHNj
aGVkdWxlZCBvbiB0aGUgc29sZSB2Q1BVIHRoYXQgaGFuZGxlcw0KICAgY29tcGxldGlvbiBpbnRl
cnJ1cHRzIHB1cmVseSBieSBjaGFuY2UuICAoVGhpcyBpcyBvbmUgcmVhc29uIHdoeSBiZW5jaG1h
cmsNCiAgIHJlc3VsdHMgY2FuIHZhcnkgbm90aWNhYmx5IGJldHdlZW4gcnVucy4pDQozLiBVc2Vy
cyBtYXkgYmluZCB0aGUgYXBwbGljYXRpb24gdG8gdGhlIHZDUFUgdGhhdCBoYW5kbGVzIGNvbXBs
ZXRpb24NCiAgIGludGVycnVwdHMuDQoNClNldCB0aGUgbnVtYmVyIG9mIHF1ZXVlcyB0byB0aGUg
bnVtYmVyIG9mIHZDUFVzIGJ5IGRlZmF1bHQgb24gdmlydGlvLWJsayBhbmQNCnZpcnRpby1zY3Np
IFBDSSBkZXZpY2VzLiAgT2xkZXIgbWFjaGluZSB0eXBlcyBjb250aW51ZSB0byBkZWZhdWx0IHRv
IDEgcXVldWUNCmZvciBsaXZlIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Lg0KDQpSYW5kb20gcmVh
ZCBwZXJmb3JtYW5jZToNCiAgICAgIElPUFMNCnE9MSAgICA3OGsNCnE9MzIgIDEwNGsgICszMyUN
Cg0KQm9vdCB0aW1lOg0KICAgICAgRHVyYXRpb24NCnE9MSAgICAgICAgNTFzDQpxPTMyICAgICAx
bTQxcyAgKzk4JQ0KDQpHdWVzdCBjb25maWd1cmF0aW9uOiAzMiB2Q1BVcywgMTAxIHZpcnRpby1i
bGstcGNpIGRpc2tzDQoNClByZXZpb3VzbHkgbWVhc3VyZWQgcmVzdWx0cyBvbiBhIDQgdkNQVSBn
dWVzdCB3ZXJlIGFsc28gcG9zaXRpdmUgYnV0IHNob3dlZCBhDQpzbWFsbGVyIDEtNCUgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnQuICBUaGV5IGFyZSBubyBsb25nZXIgdmFsaWQgYmVjYXVzZQ0Kc2ln
bmlmaWNhbnQgZXZlbnQgbG9vcCBvcHRpbWl6YXRpb25zIGhhdmUgYmVlbiBtZXJnZWQuDQoNClN0
ZWZhbiBIYWpub2N6aSAoNSk6DQogIHZpcnRpby1wY2k6IGFkZCB2aXJ0aW9fcGNpX29wdGltYWxf
bnVtX3F1ZXVlcygpIGhlbHBlcg0KICB2aXJ0aW8tc2NzaTogaW50cm9kdWNlIGEgY29uc3RhbnQg
Zm9yIGZpeGVkIHZpcnRxdWV1ZXMNCiAgdmlydGlvLXNjc2k6IGRlZmF1bHQgbnVtX3F1ZXVlcyB0
byAtc21wIE4NCiAgdmlydGlvLWJsazogZGVmYXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTg0KICB2
aG9zdC11c2VyLWJsazogZGVmYXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTg0KDQogaHcvdmlydGlv
L3ZpcnRpby1wY2kuaCAgICAgICAgICAgICB8ICA5ICsrKysrKysrKw0KIGluY2x1ZGUvaHcvdmly
dGlvL3Zob3N0LXVzZXItYmxrLmggfCAgMiArKw0KIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1i
bGsuaCAgICAgfCAgMiArKw0KIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLmggICAgfCAg
NSArKysrKw0KIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgICAgICAgICAgfCAgNiArKysrKy0N
CiBody9ibG9jay92aXJ0aW8tYmxrLmMgICAgICAgICAgICAgIHwgIDYgKysrKystDQogaHcvY29y
ZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrDQogaHcvc2NzaS92aG9zdC1z
Y3NpLmMgICAgICAgICAgICAgICB8ICAzICsrLQ0KIGh3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMg
ICAgICAgICAgfCAgNSArKystLQ0KIGh3L3Njc2kvdmlydGlvLXNjc2kuYyAgICAgICAgICAgICAg
fCAxMyArKysrKysrKy0tLS0NCiBody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2kuYyAgICAgICAgIHwg
IDkgKysrKysrKy0tDQogaHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jICAgICB8ICA0ICsr
KysNCiBody92aXJ0aW8vdmhvc3QtdXNlci1zY3NpLXBjaS5jICAgIHwgIDkgKysrKysrKy0tDQog
aHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMgICAgICAgICB8ICA3ICsrKysrKy0NCiBody92aXJ0
aW8vdmlydGlvLXBjaS5jICAgICAgICAgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQogaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5jICAgICAgICB8ICA5ICsrKysrKyst
LQ0KIDE2IGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkN
Cg0KLS0gDQoyLjI2LjINCg0K


