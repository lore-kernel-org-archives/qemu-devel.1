Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D422072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYZULzy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D422072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEzh-0000rp-8F
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jFEw7-0004VB-JG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jFEw6-0001Ck-Ew
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jFEw6-0001Cg-Bj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFhchIj2XThDo52KiqEGTbwZeUi7LE4DUlc0yBM6SkI=;
 b=GYZULzy3OFJtsruOpQTxFJkc/YdaUtE+jGDPmHaAGO3Kg0QfSRnW9h+5B5lqI6LYRDZyu4
 vkSJGurQH6MTS9TqHaLnk1A0CDUqQn28vN6kcsOFAsHxkU+yC7GMl1sQT+kGq+rtmsyHx6
 lkDkgckvOZT14hr7r0ZC2zFnwZAs6z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-5qRIbVOnMYGf6B9SVSr0nQ-1; Fri, 20 Mar 2020 06:31:28 -0400
X-MC-Unique: 5qRIbVOnMYGf6B9SVSr0nQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99400800D4E;
 Fri, 20 Mar 2020 10:31:27 +0000 (UTC)
Received: from localhost (ovpn-114-252.ams2.redhat.com [10.36.114.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D42CF19C58;
 Fri, 20 Mar 2020 10:31:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 4/4] vhost-user-blk: default num_queues to -smp N
Date: Fri, 20 Mar 2020 10:30:41 +0000
Message-Id: <20200320103041.129527-5-stefanha@redhat.com>
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

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgcmVxdWVzdCB2aXJ0cXVldWVzIHRvIG1h
dGNoIHRoZSBudW1iZXIKb2YgdkNQVXMuICBUaGlzIGVuc3VyZXMgdGhhdCBjb21wbGV0aW9uIGlu
dGVycnVwdHMgYXJlIGhhbmRsZWQgb24gdGhlCnNhbWUgdkNQVSB0aGF0IHN1Ym1pdHRlZCB0aGUg
cmVxdWVzdC4gIE5vIElQSSBpcyBuZWNlc3NhcnkgdG8gY29tcGxldGUKYW4gSS9PIHJlcXVlc3Qg
YW5kIHBlcmZvcm1hbmNlIGlzIGltcHJvdmVkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29o
dWNrQHJlZGhhdC5jb20+Ci0tLQogaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYyAgICAgICAgICB8
IDYgKysrKystCiBody9jb3JlL21hY2hpbmUuYyAgICAgICAgICAgICAgICAgIHwgMSArCiBody92
aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNpLmMgICAgIHwgNiArKysrKysKIGluY2x1ZGUvaHcvdmly
dGlvL3Zob3N0LXVzZXItYmxrLmggfCAyICsrCiA0IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9ibG9jay92aG9zdC11c2VyLWJs
ay5jIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYwppbmRleCAxMjkyNWE0N2VjLi41YzI3NWFm
OTM1IDEwMDY0NAotLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCisrKyBiL2h3L2Jsb2Nr
L3Zob3N0LXVzZXItYmxrLmMKQEAgLTQwMyw2ICs0MDMsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF91
c2VyX2Jsa19kZXZpY2VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAg
ICAgICAgIHJldHVybjsKICAgICB9CiAKKyAgICBpZiAocy0+bnVtX3F1ZXVlcyA9PSBWSE9TVF9V
U0VSX0JMS19BVVRPX05VTV9RVUVVRVMpIHsKKyAgICAgICAgcy0+bnVtX3F1ZXVlcyA9IDE7Cisg
ICAgfQogICAgIGlmICghcy0+bnVtX3F1ZXVlcyB8fCBzLT5udW1fcXVldWVzID4gVklSVElPX1FV
RVVFX01BWCkgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2aG9zdC11c2VyLWJsazogaW52
YWxpZCBudW1iZXIgb2YgSU8gcXVldWVzIik7CiAgICAgICAgIHJldHVybjsKQEAgLTUxMSw3ICs1
MTQsOCBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfdmhvc3RfdXNl
cl9ibGsgPSB7CiAKIHN0YXRpYyBQcm9wZXJ0eSB2aG9zdF91c2VyX2Jsa19wcm9wZXJ0aWVzW10g
PSB7CiAgICAgREVGSU5FX1BST1BfQ0hSKCJjaGFyZGV2IiwgVkhvc3RVc2VyQmxrLCBjaGFyZGV2
KSwKLSAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1ZXMiLCBWSG9zdFVzZXJCbGssIG51
bV9xdWV1ZXMsIDEpLAorICAgIERFRklORV9QUk9QX1VJTlQxNigibnVtLXF1ZXVlcyIsIFZIb3N0
VXNlckJsaywgbnVtX3F1ZXVlcywKKyAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9C
TEtfQVVUT19OVU1fUVVFVUVTKSwKICAgICBERUZJTkVfUFJPUF9VSU5UMzIoInF1ZXVlLXNpemUi
LCBWSG9zdFVzZXJCbGssIHF1ZXVlX3NpemUsIDEyOCksCiAgICAgREVGSU5FX1BST1BfQklUKCJj
b25maWctd2NlIiwgVkhvc3RVc2VyQmxrLCBjb25maWdfd2NlLCAwLCB0cnVlKSwKICAgICBERUZJ
TkVfUFJPUF9FTkRfT0ZfTElTVCgpLApkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9o
dy9jb3JlL21hY2hpbmUuYwppbmRleCBjOTkzYjhmNDg5Li4xM2QwMGFiZGM0IDEwMDY0NAotLS0g
YS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hpbmUuYwpAQCAtMzgsNiArMzgs
NyBAQCBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNF8yW10gPSB7CiAgICAgeyAidmlydGlvLXNj
c2ktZGV2aWNlIiwgInNlZ19tYXhfYWRqdXN0IiwgIm9mZiJ9LAogICAgIHsgInZob3N0LWJsay1k
ZXZpY2UiLCAic2VnX21heF9hZGp1c3QiLCAib2ZmIn0sCiAgICAgeyAidmhvc3Qtc2NzaSIsICJu
dW1fcXVldWVzIiwgIjEifSwKKyAgICB7ICJ2aG9zdC11c2VyLWJsayIsICJudW0tcXVldWVzIiwg
IjEifSwKICAgICB7ICJ2aG9zdC11c2VyLXNjc2kiLCAibnVtX3F1ZXVlcyIsICIxIn0sCiAgICAg
eyAidXNiLWhvc3QiLCAic3VwcHJlc3MtcmVtb3RlLXdha2UiLCAib2ZmIiB9LAogICAgIHsgInVz
Yi1yZWRpciIsICJzdXBwcmVzcy1yZW1vdGUtd2FrZSIsICJvZmYiIH0sCmRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNpLmMgYi9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGst
cGNpLmMKaW5kZXggOGQzZDc2NjQyNy4uODQ2ZmVjODNhYyAxMDA2NDQKLS0tIGEvaHcvdmlydGlv
L3Zob3N0LXVzZXItYmxrLXBjaS5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2ku
YwpAQCAtMTksNiArMTksNyBAQAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKIAogI2luY2x1ZGUg
InN0YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX3BjaS5oIgorI2luY2x1ZGUgImh3L2JvYXJk
cy5oIgogI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8uaCIKICNpbmNsdWRlICJody92aXJ0aW8v
dmhvc3QtdXNlci1ibGsuaCIKICNpbmNsdWRlICJody9wY2kvcGNpLmgiCkBAIC01NCw2ICs1NSwx
MSBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2Jsa19wY2lfcmVhbGl6ZShWaXJ0SU9QQ0lQcm94
eSAqdnBjaV9kZXYsIEVycm9yICoqZXJycCkKICAgICBWSG9zdFVzZXJCbGtQQ0kgKmRldiA9IFZI
T1NUX1VTRVJfQkxLX1BDSSh2cGNpX2Rldik7CiAgICAgRGV2aWNlU3RhdGUgKnZkZXYgPSBERVZJ
Q0UoJmRldi0+dmRldik7CiAKKyAgICAvKiAxOjEgdnEgdG8gdmNwdSBtYXBwaW5nIGlzIGlkZWFs
IGJlY2F1c2UgaXQgYXZvaWRzIElQSXMgKi8KKyAgICBpZiAoZGV2LT52ZGV2Lm51bV9xdWV1ZXMg
PT0gVkhPU1RfVVNFUl9CTEtfQVVUT19OVU1fUVVFVUVTKSB7CisgICAgICAgIGRldi0+dmRldi5u
dW1fcXVldWVzID0gY3VycmVudF9tYWNoaW5lLT5zbXAuY3B1czsKKyAgICB9CisKICAgICBpZiAo
dnBjaV9kZXYtPm52ZWN0b3JzID09IERFVl9OVkVDVE9SU19VTlNQRUNJRklFRCkgewogICAgICAg
ICB2cGNpX2Rldi0+bnZlY3RvcnMgPSBkZXYtPnZkZXYubnVtX3F1ZXVlcyArIDE7CiAgICAgfQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaCBiL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLmgKaW5kZXggMDVlYTBhZDE4My4uYzI4MDI3YzdjOCAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaAorKysgYi9pbmNs
dWRlL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay5oCkBAIC0yNSw2ICsyNSw4IEBACiAjZGVmaW5l
IFZIT1NUX1VTRVJfQkxLKG9iaikgXAogICAgICAgICBPQkpFQ1RfQ0hFQ0soVkhvc3RVc2VyQmxr
LCAob2JqKSwgVFlQRV9WSE9TVF9VU0VSX0JMSykKIAorI2RlZmluZSBWSE9TVF9VU0VSX0JMS19B
VVRPX05VTV9RVUVVRVMgVUlOVDE2X01BWAorCiB0eXBlZGVmIHN0cnVjdCBWSG9zdFVzZXJCbGsg
ewogICAgIFZpcnRJT0RldmljZSBwYXJlbnRfb2JqOwogICAgIENoYXJCYWNrZW5kIGNoYXJkZXY7
Ci0tIAoyLjI0LjEKCg==


