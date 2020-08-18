Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F159C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2961620786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaHabO0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83ZM-00083v-9m
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h3-0004ul-IW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h0-0002U7-QB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVeNRqM224/wT/cjolJi+5I426fp5SQFqRKucSZEUf4=;
 b=RaHabO0YAAlvDrmxbA5gTf9thml4cCflDrDri7/lXP+W8W2e7OlweZi8mb3d99GOt6IU56
 SDcE2f7LhULIqitHeeTUUmcgz1e3VFE3BlChNgQN9AlSAQH10ar6PcIP0sv2gf3xQ9LkW0
 ZpdLRhLs3c2AAAzDv58eUy3srXwR2Cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-hmPlAJAIN0a_2xrCdgmijw-1; Tue, 18 Aug 2020 10:34:22 -0400
X-MC-Unique: hmPlAJAIN0a_2xrCdgmijw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B121084C9D;
 Tue, 18 Aug 2020 14:34:10 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40CCE10013C2;
 Tue, 18 Aug 2020 14:34:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/7] virtio-scsi: introduce a constant for fixed virtqueues
Date: Tue, 18 Aug 2020 15:33:45 +0100
Message-Id: <20200818143348.310613-5-stefanha@redhat.com>
In-Reply-To: <20200818143348.310613-1-stefanha@redhat.com>
References: <20200818143348.310613-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, cohuck@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGV2ZW50IGFuZCBjb250cm9sIHZpcnRxdWV1ZXMgYXJlIGFsd2F5cyBwcmVzZW50LCByZWdh
cmRsZXNzIG9mIHRoZQptdWx0aS1xdWV1ZSBjb25maWd1cmF0aW9uLiAgRGVmaW5lIGEgY29uc3Rh
bnQgc28gdGhhdCB2aXJ0cXVldWUgbnVtYmVyCmNhbGN1bGF0aW9ucyBhcmUgZWFzaWVyIHRvIHJl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
ClJldmlld2VkLWJ5OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT4KUmV2aWV3ZWQt
Ynk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT4KUmV2aWV3ZWQt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmV2aWV3ZWQt
Ynk6IFJhcGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tPgotLS0KIGlu
Y2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLmggfCAzICsrKwogaHcvc2NzaS92aG9zdC11c2Vy
LXNjc2kuYyAgICAgICB8IDIgKy0KIGh3L3Njc2kvdmlydGlvLXNjc2kuYyAgICAgICAgICAgfCA3
ICsrKystLS0KIGh3L3ZpcnRpby92aG9zdC1zY3NpLXBjaS5jICAgICAgfCAzICsrLQogaHcvdmly
dGlvL3Zob3N0LXVzZXItc2NzaS1wY2kuYyB8IDMgKystCiBody92aXJ0aW8vdmlydGlvLXNjc2kt
cGNpLmMgICAgIHwgMyArKy0KIDYgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5o
IGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaAppbmRleCAyNGU3Njg5MDlkLi45ZjI5
M2JjYjgwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5oCisrKyBi
L2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLmgKQEAgLTM2LDYgKzM2LDkgQEAKICNkZWZp
bmUgVklSVElPX1NDU0lfTUFYX1RBUkdFVCAgMjU1CiAjZGVmaW5lIFZJUlRJT19TQ1NJX01BWF9M
VU4gICAgIDE2MzgzCiAKKy8qIE51bWJlciBvZiB2aXJ0cXVldWVzIHRoYXQgYXJlIGFsd2F5cyBw
cmVzZW50ICovCisjZGVmaW5lIFZJUlRJT19TQ1NJX1ZRX05VTV9GSVhFRCAgICAyCisKIHR5cGVk
ZWYgc3RydWN0IHZpcnRpb19zY3NpX2NtZF9yZXEgVmlydElPU0NTSUNtZFJlcTsKIHR5cGVkZWYg
c3RydWN0IHZpcnRpb19zY3NpX2NtZF9yZXNwIFZpcnRJT1NDU0lDbWRSZXNwOwogdHlwZWRlZiBz
dHJ1Y3QgdmlydGlvX3Njc2lfY3RybF90bWZfcmVxIFZpcnRJT1NDU0lDdHJsVE1GUmVxOwpkaWZm
IC0tZ2l0IGEvaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyBiL2h3L3Njc2kvdmhvc3QtdXNlci1z
Y3NpLmMKaW5kZXggZjJlNTI0NDM4YS4uYThiODIxNDY2ZiAxMDA2NDQKLS0tIGEvaHcvc2NzaS92
aG9zdC11c2VyLXNjc2kuYworKysgYi9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jCkBAIC0xMTQs
NyArMTE0LDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9zY3NpX3JlYWxpemUoRGV2aWNlU3Rh
dGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICBnb3RvIGZyZWVfdmlydGlvOwogICAgIH0K
IAotICAgIHZzYy0+ZGV2Lm52cXMgPSAyICsgdnMtPmNvbmYubnVtX3F1ZXVlczsKKyAgICB2c2Mt
PmRldi5udnFzID0gVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEICsgdnMtPmNvbmYubnVtX3F1ZXVl
czsKICAgICB2c2MtPmRldi52cXMgPSBnX25ldzAoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSwgdnNj
LT5kZXYubnZxcyk7CiAgICAgdnNjLT5kZXYudnFfaW5kZXggPSAwOwogICAgIHZzYy0+ZGV2LmJh
Y2tlbmRfZmVhdHVyZXMgPSAwOwpkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aXJ0aW8tc2NzaS5jIGIv
aHcvc2NzaS92aXJ0aW8tc2NzaS5jCmluZGV4IGI0OTc3NTI2OWUuLmVlY2RkMDVhZjUgMTAwNjQ0
Ci0tLSBhL2h3L3Njc2kvdmlydGlvLXNjc2kuYworKysgYi9ody9zY3NpL3ZpcnRpby1zY3NpLmMK
QEAgLTE5MSw3ICsxOTEsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fc2NzaV9zYXZlX3JlcXVlc3Qo
UUVNVUZpbGUgKmYsIFNDU0lSZXF1ZXN0ICpzcmVxKQogICAgIFZpcnRJT1NDU0lSZXEgKnJlcSA9
IHNyZXEtPmhiYV9wcml2YXRlOwogICAgIFZpcnRJT1NDU0lDb21tb24gKnZzID0gVklSVElPX1ND
U0lfQ09NTU9OKHJlcS0+ZGV2KTsKICAgICBWaXJ0SU9EZXZpY2UgKnZkZXYgPSBWSVJUSU9fREVW
SUNFKHJlcS0+ZGV2KTsKLSAgICB1aW50MzJfdCBuID0gdmlydGlvX2dldF9xdWV1ZV9pbmRleChy
ZXEtPnZxKSAtIDI7CisgICAgdWludDMyX3QgbiA9IHZpcnRpb19nZXRfcXVldWVfaW5kZXgocmVx
LT52cSkgLSBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQ7CiAKICAgICBhc3NlcnQobiA8IHZzLT5j
b25mLm51bV9xdWV1ZXMpOwogICAgIHFlbXVfcHV0X2JlMzJzKGYsICZuKTsKQEAgLTg5MiwxMCAr
ODkyLDExIEBAIHZvaWQgdmlydGlvX3Njc2lfY29tbW9uX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRl
diwKICAgICAgICAgICAgICAgICBzaXplb2YoVmlydElPU0NTSUNvbmZpZykpOwogCiAgICAgaWYg
KHMtPmNvbmYubnVtX3F1ZXVlcyA9PSAwIHx8Ci0gICAgICAgICAgICBzLT5jb25mLm51bV9xdWV1
ZXMgPiBWSVJUSU9fUVVFVUVfTUFYIC0gMikgeworICAgICAgICAgICAgcy0+Y29uZi5udW1fcXVl
dWVzID4gVklSVElPX1FVRVVFX01BWCAtIFZJUlRJT19TQ1NJX1ZRX05VTV9GSVhFRCkgewogICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJJbnZhbGlkIG51bWJlciBvZiBxdWV1ZXMgKD0gJSIgUFJJ
dTMyICIpLCAiCiAgICAgICAgICAgICAgICAgICAgICAgICAgIm11c3QgYmUgYSBwb3NpdGl2ZSBp
bnRlZ2VyIGxlc3MgdGhhbiAlZC4iLAotICAgICAgICAgICAgICAgICAgIHMtPmNvbmYubnVtX3F1
ZXVlcywgVklSVElPX1FVRVVFX01BWCAtIDIpOworICAgICAgICAgICAgICAgICAgIHMtPmNvbmYu
bnVtX3F1ZXVlcywKKyAgICAgICAgICAgICAgICAgICBWSVJUSU9fUVVFVUVfTUFYIC0gVklSVElP
X1NDU0lfVlFfTlVNX0ZJWEVEKTsKICAgICAgICAgdmlydGlvX2NsZWFudXAodmRldik7CiAgICAg
ICAgIHJldHVybjsKICAgICB9CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2ku
YyBiL2h3L3ZpcnRpby92aG9zdC1zY3NpLXBjaS5jCmluZGV4IDA5NWFmMjNmM2YuLjA2ZTgxNGQz
MGUgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aG9zdC1zY3NpLXBjaS5jCisrKyBiL2h3L3ZpcnRp
by92aG9zdC1zY3NpLXBjaS5jCkBAIC01MCw3ICs1MCw4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Nj
c2lfcGNpX3JlYWxpemUoVmlydElPUENJUHJveHkgKnZwY2lfZGV2LCBFcnJvciAqKmVycnApCiAg
ICAgVmlydElPU0NTSUNvbW1vbiAqdnMgPSBWSVJUSU9fU0NTSV9DT01NT04odmRldik7CiAKICAg
ICBpZiAodnBjaV9kZXYtPm52ZWN0b3JzID09IERFVl9OVkVDVE9SU19VTlNQRUNJRklFRCkgewot
ICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSB2cy0+Y29uZi5udW1fcXVldWVzICsgMzsKKyAg
ICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gdnMtPmNvbmYubnVtX3F1ZXVlcyArCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19TQ1NJX1ZRX05VTV9GSVhFRCArIDE7CiAgICAg
fQogCiAgICAgcWRldl9yZWFsaXplKHZkZXYsIEJVUygmdnBjaV9kZXYtPmJ1cyksIGVycnApOwpk
aWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXItc2NzaS1wY2kuYyBiL2h3L3ZpcnRpby92
aG9zdC11c2VyLXNjc2ktcGNpLmMKaW5kZXggNDcwNWNkNTRlOC4uYWI2ZGZiNzFhOSAxMDA2NDQK
LS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXItc2NzaS1wY2kuYworKysgYi9ody92aXJ0aW8vdmhv
c3QtdXNlci1zY3NpLXBjaS5jCkBAIC01Niw3ICs1Niw4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Vz
ZXJfc2NzaV9wY2lfcmVhbGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBjaV9kZXYsIEVycm9yICoqZXJy
cCkKICAgICBWaXJ0SU9TQ1NJQ29tbW9uICp2cyA9IFZJUlRJT19TQ1NJX0NPTU1PTih2ZGV2KTsK
IAogICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05WRUNUT1JTX1VOU1BFQ0lGSUVE
KSB7Ci0gICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IHZzLT5jb25mLm51bV9xdWV1ZXMgKyAz
OworICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSB2cy0+Y29uZi5udW1fcXVldWVzICsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEICsgMTsK
ICAgICB9CiAKICAgICBxZGV2X3JlYWxpemUodmRldiwgQlVTKCZ2cGNpX2Rldi0+YnVzKSwgZXJy
cCk7CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLmMgYi9ody92aXJ0aW8v
dmlydGlvLXNjc2ktcGNpLmMKaW5kZXggYzIzYTEzNDIwMi4uM2ZmOWViN2VmNiAxMDA2NDQKLS0t
IGEvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5jCisrKyBiL2h3L3ZpcnRpby92aXJ0aW8tc2Nz
aS1wY2kuYwpAQCAtNTEsNyArNTEsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fc2NzaV9wY2lfcmVh
bGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBjaV9kZXYsIEVycm9yICoqZXJycCkKICAgICBjaGFyICpi
dXNfbmFtZTsKIAogICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05WRUNUT1JTX1VO
U1BFQ0lGSUVEKSB7Ci0gICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IHZzLT5jb25mLm51bV9x
dWV1ZXMgKyAzOworICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSB2cy0+Y29uZi5udW1fcXVl
dWVzICsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX1NDU0lfVlFfTlVNX0ZJ
WEVEICsgMTsKICAgICB9CiAKICAgICAvKgotLSAKMi4yNi4yCgo=


