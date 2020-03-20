Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1902C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AD32076C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evrv/9Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AD32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEyF-0006p3-G8
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jFEvj-00049a-Nq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jFEvi-00016v-F5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jFEvi-00016r-BQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ij6wvb5J1RcSkz7+GPTNk0YJefNIdneAbM1aUHavAsw=;
 b=Evrv/9VqFQhTOZ2GZs1TNq+r4xk4hQmp1xqAmAES19yKyvTKCaJhzFo2xMxUAdEjreADaE
 VNbUSjp6m6b2DrqNsJ7I+ym4YCkeEterz4SjyTPtG8xFm9ilQKwP0nlcOcs1pl1/mGnBUm
 nQfprAsw71BXZTnLx/dsfFg90+LErZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-TFvvHJAlOTme1vvA12aczQ-1; Fri, 20 Mar 2020 06:31:04 -0400
X-MC-Unique: TFvvHJAlOTme1vvA12aczQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B31A800D4E;
 Fri, 20 Mar 2020 10:31:03 +0000 (UTC)
Received: from localhost (ovpn-114-252.ams2.redhat.com [10.36.114.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01E2019C58;
 Fri, 20 Mar 2020 10:30:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 1/4] virtio-scsi: introduce a constant for fixed
 virtqueues
Date: Fri, 20 Mar 2020 10:30:38 +0000
Message-Id: <20200320103041.129527-2-stefanha@redhat.com>
In-Reply-To: <20200320103041.129527-1-stefanha@redhat.com>
References: <20200320103041.129527-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGV2ZW50IGFuZCBjb250cm9sIHZpcnRxdWV1ZXMgYXJlIGFsd2F5cyBwcmVzZW50LCByZWdh
cmRsZXNzIG9mIHRoZQptdWx0aS1xdWV1ZSBjb25maWd1cmF0aW9uLiAgRGVmaW5lIGEgY29uc3Rh
bnQgc28gdGhhdCB2aXJ0cXVldWUgbnVtYmVyCmNhbGN1bGF0aW9ucyBhcmUgZWFzaWVyIHRvIHJl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
ClJldmlld2VkLWJ5OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT4KLS0tCiBody9z
Y3NpL3Zob3N0LXVzZXItc2NzaS5jICAgICAgIHwgMiArLQogaHcvc2NzaS92aXJ0aW8tc2NzaS5j
ICAgICAgICAgICB8IDcgKysrKy0tLQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaCB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jIGIvaHcvc2NzaS92aG9zdC11
c2VyLXNjc2kuYwppbmRleCBhMDFiZjYzYTA4Li5lOTc1MmJhYTg5IDEwMDY0NAotLS0gYS9ody9z
Y3NpL3Zob3N0LXVzZXItc2NzaS5jCisrKyBiL2h3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMKQEAg
LTExNSw3ICsxMTUsNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX3Njc2lfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgIGdvdG8gZnJlZV92aXJ0aW87CiAg
ICAgfQogCi0gICAgdnNjLT5kZXYubnZxcyA9IDIgKyB2cy0+Y29uZi5udW1fcXVldWVzOworICAg
IHZzYy0+ZGV2Lm52cXMgPSBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQgKyB2cy0+Y29uZi5udW1f
cXVldWVzOwogICAgIHZzYy0+ZGV2LnZxcyA9IGdfbmV3MChzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVl
LCB2c2MtPmRldi5udnFzKTsKICAgICB2c2MtPmRldi52cV9pbmRleCA9IDA7CiAgICAgdnNjLT5k
ZXYuYmFja2VuZF9mZWF0dXJlcyA9IDA7CmRpZmYgLS1naXQgYS9ody9zY3NpL3ZpcnRpby1zY3Np
LmMgYi9ody9zY3NpL3ZpcnRpby1zY3NpLmMKaW5kZXggNDcyYmJkMjMzYi4uNDI3YWQ4M2M1MCAx
MDA2NDQKLS0tIGEvaHcvc2NzaS92aXJ0aW8tc2NzaS5jCisrKyBiL2h3L3Njc2kvdmlydGlvLXNj
c2kuYwpAQCAtMTkxLDcgKzE5MSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19zY3NpX3NhdmVfcmVx
dWVzdChRRU1VRmlsZSAqZiwgU0NTSVJlcXVlc3QgKnNyZXEpCiAgICAgVmlydElPU0NTSVJlcSAq
cmVxID0gc3JlcS0+aGJhX3ByaXZhdGU7CiAgICAgVmlydElPU0NTSUNvbW1vbiAqdnMgPSBWSVJU
SU9fU0NTSV9DT01NT04ocmVxLT5kZXYpOwogICAgIFZpcnRJT0RldmljZSAqdmRldiA9IFZJUlRJ
T19ERVZJQ0UocmVxLT5kZXYpOwotICAgIHVpbnQzMl90IG4gPSB2aXJ0aW9fZ2V0X3F1ZXVlX2lu
ZGV4KHJlcS0+dnEpIC0gMjsKKyAgICB1aW50MzJfdCBuID0gdmlydGlvX2dldF9xdWV1ZV9pbmRl
eChyZXEtPnZxKSAtIFZJUlRJT19TQ1NJX1ZRX05VTV9GSVhFRDsKIAogICAgIGFzc2VydChuIDwg
dnMtPmNvbmYubnVtX3F1ZXVlcyk7CiAgICAgcWVtdV9wdXRfYmUzMnMoZiwgJm4pOwpAQCAtODky
LDEwICs4OTIsMTEgQEAgdm9pZCB2aXJ0aW9fc2NzaV9jb21tb25fcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LAogICAgICAgICAgICAgICAgIHNpemVvZihWaXJ0SU9TQ1NJQ29uZmlnKSk7CiAKICAg
ICBpZiAocy0+Y29uZi5udW1fcXVldWVzID09IDAgfHwKLSAgICAgICAgICAgIHMtPmNvbmYubnVt
X3F1ZXVlcyA+IFZJUlRJT19RVUVVRV9NQVggLSAyKSB7CisgICAgICAgICAgICBzLT5jb25mLm51
bV9xdWV1ZXMgPiBWSVJUSU9fUVVFVUVfTUFYIC0gVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEKSB7
CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkludmFsaWQgbnVtYmVyIG9mIHF1ZXVlcyAoPSAl
IiBQUkl1MzIgIiksICIKICAgICAgICAgICAgICAgICAgICAgICAgICAibXVzdCBiZSBhIHBvc2l0
aXZlIGludGVnZXIgbGVzcyB0aGFuICVkLiIsCi0gICAgICAgICAgICAgICAgICAgcy0+Y29uZi5u
dW1fcXVldWVzLCBWSVJUSU9fUVVFVUVfTUFYIC0gMik7CisgICAgICAgICAgICAgICAgICAgcy0+
Y29uZi5udW1fcXVldWVzLAorICAgICAgICAgICAgICAgICAgIFZJUlRJT19RVUVVRV9NQVggLSBW
SVJUSU9fU0NTSV9WUV9OVU1fRklYRUQpOwogICAgICAgICB2aXJ0aW9fY2xlYW51cCh2ZGV2KTsK
ICAgICAgICAgcmV0dXJuOwogICAgIH0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zp
cnRpby1zY3NpLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5oCmluZGV4IDI0ZTc2
ODkwOWQuLjlmMjkzYmNiODAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1z
Y3NpLmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaApAQCAtMzYsNiArMzYs
OSBAQAogI2RlZmluZSBWSVJUSU9fU0NTSV9NQVhfVEFSR0VUICAyNTUKICNkZWZpbmUgVklSVElP
X1NDU0lfTUFYX0xVTiAgICAgMTYzODMKIAorLyogTnVtYmVyIG9mIHZpcnRxdWV1ZXMgdGhhdCBh
cmUgYWx3YXlzIHByZXNlbnQgKi8KKyNkZWZpbmUgVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEICAg
IDIKKwogdHlwZWRlZiBzdHJ1Y3QgdmlydGlvX3Njc2lfY21kX3JlcSBWaXJ0SU9TQ1NJQ21kUmVx
OwogdHlwZWRlZiBzdHJ1Y3QgdmlydGlvX3Njc2lfY21kX3Jlc3AgVmlydElPU0NTSUNtZFJlc3A7
CiB0eXBlZGVmIHN0cnVjdCB2aXJ0aW9fc2NzaV9jdHJsX3RtZl9yZXEgVmlydElPU0NTSUN0cmxU
TUZSZXE7Ci0tIAoyLjI0LjEKCg==


