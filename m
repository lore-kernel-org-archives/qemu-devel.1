Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415720774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra2pU8vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiB2-0002fT-10
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihfH-0005Yh-0x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihfG-0007fE-1A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZxjrBJaT8eusDoBo1V3W0mMDRWiqAgNXG5M0R0cJ4=;
 b=Ra2pU8vhnlAyunE67stUEzce2nXceIh1DUOwm/iY+K/8j28pCnepqMBxAgaHCzQpVDxkB7
 fkLbm2F1dfWJzOyAmVrtyubb3ffj5ndO6dXiDClRlmp0v8C308QWzkEAy1CCnrsiHoHf+O
 LGFVyKl4xgg/v5UgHkpxAsVIwCsK4ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-PvG-7KOvMQSyiYyfOCn0Ww-1; Tue, 09 Jun 2020 13:03:51 -0400
X-MC-Unique: PvG-7KOvMQSyiYyfOCn0Ww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 361B9801504;
 Tue,  9 Jun 2020 17:03:50 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBED061984;
 Tue,  9 Jun 2020 17:03:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] virtio: enable VIRTIO_F_RING_PACKED for all devices
Date: Tue,  9 Jun 2020 18:02:18 +0100
Message-Id: <20200609170218.246468-8-stefanha@redhat.com>
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHBhY2tlZCB2aXJ0cXVldWUgbGF5b3V0IHdhcyBpbnRyb2R1Y2VkIGluIFZJUlRJTyAxLjEu
IEl0IGlzIGEgc2luZ2xlCnJpbmcgaW5zdGVhZCBvZiBhIHNwbGl0IGF2YWlsL3VzZWQgcmluZyBk
ZXNpZ24uIFRoZXJlIGFyZSBDUFUgY2FjaGUKYWR2YW50YWdlcyB0byB0aGlzIGxheW91dCBhbmQg
aXQgaXMgYWxzbyBzdWl0ZWQgYmV0dGVyIHRvIGhhcmR3YXJlCmltcGxlbWVudGF0aW9uLgoKVGhl
IHZob3N0LW5ldCBiYWNrZW5kIGhhcyBhbHJlYWR5IHN1cHBvcnRlZCBwYWNrZWQgdmlydHF1ZXVl
cyBmb3Igc29tZQp0aW1lLiBQZXJmb3JtYW5jZSBiZW5jaG1hcmtzIHNob3cgdGhhdCB2aXJ0aW8t
YmxrIHBlcmZvcm1hbmNlIG9uIE5WTWUKZHJpdmVzIGlzIGFsc28gaW1wcm92ZWQuCgpHbyBhaGVh
ZCBhbmQgZW5hYmxlIHRoaXMgZmVhdHVyZSBmb3IgYWxsIFZJUlRJTyBkZXZpY2VzLiBLZWVwIGl0
CmRpc2FibGVkIGZvciBRRU1VIDUuMCBhbmQgZWFybGllciBtYWNoaW5lIHR5cGVzLgoKU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby5oIHwgMiArLQogaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAg
fCA0ICsrKy0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmlydGlvLmgKaW5kZXggYjY5ZDUxNzQ5Ni4uZmQ1YjRhMjA0NCAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlv
LmgKQEAgLTI5Miw3ICsyOTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBWaXJ0SU9STkdDb25mIFZpcnRJ
T1JOR0NvbmY7CiAgICAgREVGSU5FX1BST1BfQklUNjQoImlvbW11X3BsYXRmb3JtIiwgX3N0YXRl
LCBfZmllbGQsIFwKICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fRl9JT01NVV9QTEFURk9S
TSwgZmFsc2UpLCBcCiAgICAgREVGSU5FX1BST1BfQklUNjQoInBhY2tlZCIsIF9zdGF0ZSwgX2Zp
ZWxkLCBcCi0gICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfUklOR19QQUNLRUQsIGZhbHNl
KQorICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELCB0cnVlKQogCiBo
d2FkZHIgdmlydGlvX3F1ZXVlX2dldF9kZXNjX2FkZHIoVmlydElPRGV2aWNlICp2ZGV2LCBpbnQg
bik7CiBib29sIHZpcnRpb19xdWV1ZV9lbmFibGVkKFZpcnRJT0RldmljZSAqdmRldiwgaW50IG4p
OwpkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYwppbmRl
eCBiYjNhN2IxOGIxLi5hOWJmNzZmMzE4IDEwMDY0NAotLS0gYS9ody9jb3JlL21hY2hpbmUuYwor
KysgYi9ody9jb3JlL21hY2hpbmUuYwpAQCAtMjgsNyArMjgsOSBAQAogI2luY2x1ZGUgImh3L21l
bS9udmRpbW0uaCIKICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgogCi1HbG9iYWxQcm9w
ZXJ0eSBod19jb21wYXRfNV8wW10gPSB7fTsKK0dsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF81XzBb
XSA9IHsKKyAgICB7ICJ2aXJ0aW8tZGV2aWNlIiwgInBhY2tlZCIsICJvZmYiIH0sCit9OwogY29u
c3Qgc2l6ZV90IGh3X2NvbXBhdF81XzBfbGVuID0gR19OX0VMRU1FTlRTKGh3X2NvbXBhdF81XzAp
OwogCiBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNF8yW10gPSB7Ci0tIAoyLjI2LjIKCg==


