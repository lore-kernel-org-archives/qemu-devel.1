Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8D7206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUmx9dJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8D7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBMN-0002B9-16
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJg-0006P8-PE
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJf-0000iy-VF
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUvdZ9WOLD61EuJIHtGb6cIb8n0l3/qyiO43STZSrdY=;
 b=cUmx9dJpdM225LGWo+dNa+nfYhNfdwv4z69PADj30Za4Q8q8WvU9Kd8ulwFgC47wNZl3aK
 ijBhbh2mtJxhWlZL8mBDFxGyB0SQ+O7TEt5T1tb7AXQODcpz4am1fW4H+SoO7asjSFfDyf
 zn/fDJ6FxHetWOhOhEdbtCQ25UPjxEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-943U-aW1MuaIJyqJiK7W1w-1; Fri, 22 May 2020 13:18:37 -0400
X-MC-Unique: 943U-aW1MuaIJyqJiK7W1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1F88005AA;
 Fri, 22 May 2020 17:18:35 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D69857820A;
 Fri, 22 May 2020 17:18:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] virtio: enable VIRTIO_F_RING_PACKED for all devices
Date: Fri, 22 May 2020 18:17:26 +0100
Message-Id: <20200522171726.648279-6-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-1-stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
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
ZGUvaHcvdmlydGlvL3ZpcnRpby5oIHwgIDIgKy0KIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAg
IHwgMTggKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlv
LmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaAppbmRleCBiNjlkNTE3NDk2Li5mZDViNGEy
MDQ0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaAorKysgYi9pbmNsdWRl
L2h3L3ZpcnRpby92aXJ0aW8uaApAQCAtMjkyLDcgKzI5Miw3IEBAIHR5cGVkZWYgc3RydWN0IFZp
cnRJT1JOR0NvbmYgVmlydElPUk5HQ29uZjsKICAgICBERUZJTkVfUFJPUF9CSVQ2NCgiaW9tbXVf
cGxhdGZvcm0iLCBfc3RhdGUsIF9maWVsZCwgXAogICAgICAgICAgICAgICAgICAgICAgIFZJUlRJ
T19GX0lPTU1VX1BMQVRGT1JNLCBmYWxzZSksIFwKICAgICBERUZJTkVfUFJPUF9CSVQ2NCgicGFj
a2VkIiwgX3N0YXRlLCBfZmllbGQsIFwKLSAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fRl9S
SU5HX1BBQ0tFRCwgZmFsc2UpCisgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfUklOR19Q
QUNLRUQsIHRydWUpCiAKIGh3YWRkciB2aXJ0aW9fcXVldWVfZ2V0X2Rlc2NfYWRkcihWaXJ0SU9E
ZXZpY2UgKnZkZXYsIGludCBuKTsKIGJvb2wgdmlydGlvX3F1ZXVlX2VuYWJsZWQoVmlydElPRGV2
aWNlICp2ZGV2LCBpbnQgbik7CmRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2Nv
cmUvbWFjaGluZS5jCmluZGV4IGJiM2E3YjE4YjEuLjM1OThjM2M4MjUgMTAwNjQ0Ci0tLSBhL2h3
L2NvcmUvbWFjaGluZS5jCisrKyBiL2h3L2NvcmUvbWFjaGluZS5jCkBAIC0yOCw3ICsyOCwyMyBA
QAogI2luY2x1ZGUgImh3L21lbS9udmRpbW0uaCIKICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0
ZS5oIgogCi1HbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNV8wW10gPSB7fTsKK0dsb2JhbFByb3Bl
cnR5IGh3X2NvbXBhdF81XzBbXSA9IHsKKyAgICB7ICJ2aG9zdC11c2VyLWJsayIsICJwYWNrZWQi
LCAib2ZmIiB9LAorICAgIHsgInZob3N0LXVzZXItZnMtZGV2aWNlIiwgInBhY2tlZCIsICJvZmYi
IH0sCisgICAgeyAidmhvc3QtdnNvY2stZGV2aWNlIiwgInBhY2tlZCIsICJvZmYiIH0sCisgICAg
eyAidmlydGlvLTlwLWRldmljZSIsICJwYWNrZWQiLCAib2ZmIiB9LAorICAgIHsgInZpcnRpby1i
YWxsb29uLWRldmljZSIsICJwYWNrZWQiLCAib2ZmIiB9LAorICAgIHsgInZpcnRpby1ibGstZGV2
aWNlIiwgInBhY2tlZCIsICJvZmYiIH0sCisgICAgeyAidmlydGlvLWNyeXB0by1kZXZpY2UiLCAi
cGFja2VkIiwgIm9mZiIgfSwKKyAgICB7ICJ2aXJ0aW8tZ3B1LWRldmljZSIsICJwYWNrZWQiLCAi
b2ZmIiB9LAorICAgIHsgInZpcnRpby1pbnB1dC1kZXZpY2UiLCAicGFja2VkIiwgIm9mZiIgfSwK
KyAgICB7ICJ2aXJ0aW8taW9tbXUtZGV2aWNlIiwgInBhY2tlZCIsICJvZmYiIH0sCisgICAgeyAi
dmlydGlvLW5ldC1kZXZpY2UiLCAicGFja2VkIiwgIm9mZiIgfSwKKyAgICB7ICJ2aXJ0aW8tcG1l
bSIsICJwYWNrZWQiLCAib2ZmIiB9LAorICAgIHsgInZpcnRpby1ybmctZGV2aWNlIiwgInBhY2tl
ZCIsICJvZmYiIH0sCisgICAgeyAidmlydGlvLXNjc2ktY29tbW9uIiwgInBhY2tlZCIsICJvZmYi
IH0sCisgICAgeyAidmlydGlvLXNlcmlhbC1kZXZpY2UiLCAicGFja2VkIiwgIm9mZiIgfSwKK307
CiBjb25zdCBzaXplX3QgaHdfY29tcGF0XzVfMF9sZW4gPSBHX05fRUxFTUVOVFMoaHdfY29tcGF0
XzVfMCk7CiAKIEdsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF80XzJbXSA9IHsKLS0gCjIuMjUuMwoK


