Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C289E207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVBqGfwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C289E207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtOR-0007Uw-Up
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtKD-00080E-Qc
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:30:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtKB-0001HZ-9B
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIvng08gon8Ipk/wyhOgeDtd8Qqfx9bJCFGe2ev+7HQ=;
 b=LVBqGfwMNPcqVG33xVYP0iLpFKR8pxEDChiLTkO/yihMPNhV2MdJYVHpMech89xABRC7JD
 sCQ4Ee0M92hL6TnZCQiKurTyO8l940mlt3fsY4S6OHfDRxxsF9sIzGdDRetl4Pzj22QB+Y
 pTR1OPDP6WooKigk2047fyyQA+pdbmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-ZsRPhRVuPwWWWzaXbcFcAw-1; Wed, 27 May 2020 06:30:09 -0400
X-MC-Unique: ZsRPhRVuPwWWWzaXbcFcAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1896180183C;
 Wed, 27 May 2020 10:30:08 +0000 (UTC)
Received: from localhost (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3AD21BCBE;
 Wed, 27 May 2020 10:29:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] vhost-user-blk: default num_queues to -smp N
Date: Wed, 27 May 2020 11:29:25 +0100
Message-Id: <20200527102925.128013-6-stefanha@redhat.com>
In-Reply-To: <20200527102925.128013-1-stefanha@redhat.com>
References: <20200527102925.128013-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgcmVxdWVzdCB2aXJ0cXVldWVzIHRvIG1h
dGNoIHRoZSBudW1iZXIKb2YgdkNQVXMuICBUaGlzIGVuc3VyZXMgdGhhdCBjb21wbGV0aW9uIGlu
dGVycnVwdHMgYXJlIGhhbmRsZWQgb24gdGhlCnNhbWUgdkNQVSB0aGF0IHN1Ym1pdHRlZCB0aGUg
cmVxdWVzdC4gIE5vIElQSSBpcyBuZWNlc3NhcnkgdG8gY29tcGxldGUKYW4gSS9PIHJlcXVlc3Qg
YW5kIHBlcmZvcm1hbmNlIGlzIGltcHJvdmVkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29o
dWNrQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaCB8
IDIgKysKIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgICAgICAgICAgfCA2ICsrKysrLQogaHcv
Y29yZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8IDEgKwogaHcvdmlydGlvL3Zob3N0LXVz
ZXItYmxrLXBjaS5jICAgICB8IDQgKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3Qt
dXNlci1ibGsuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLmgKaW5kZXggMzRh
ZDZmMGMwZS4uMjkyZDE3MTQ3YyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3Qt
dXNlci1ibGsuaAorKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay5oCkBAIC0y
NSw2ICsyNSw4IEBACiAjZGVmaW5lIFZIT1NUX1VTRVJfQkxLKG9iaikgXAogICAgICAgICBPQkpF
Q1RfQ0hFQ0soVkhvc3RVc2VyQmxrLCAob2JqKSwgVFlQRV9WSE9TVF9VU0VSX0JMSykKIAorI2Rl
ZmluZSBWSE9TVF9VU0VSX0JMS19BVVRPX05VTV9RVUVVRVMgVUlOVDE2X01BWAorCiB0eXBlZGVm
IHN0cnVjdCBWSG9zdFVzZXJCbGsgewogICAgIFZpcnRJT0RldmljZSBwYXJlbnRfb2JqOwogICAg
IENoYXJCYWNrZW5kIGNoYXJkZXY7CmRpZmYgLS1naXQgYS9ody9ibG9jay92aG9zdC11c2VyLWJs
ay5jIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYwppbmRleCA5ZDhjMGIzOTA5Li43YTg2Mzk1
MTZmIDEwMDY0NAotLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCisrKyBiL2h3L2Jsb2Nr
L3Zob3N0LXVzZXItYmxrLmMKQEAgLTM4NSw2ICszODUsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF91
c2VyX2Jsa19kZXZpY2VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAg
ICAgICAgIHJldHVybjsKICAgICB9CiAKKyAgICBpZiAocy0+bnVtX3F1ZXVlcyA9PSBWSE9TVF9V
U0VSX0JMS19BVVRPX05VTV9RVUVVRVMpIHsKKyAgICAgICAgcy0+bnVtX3F1ZXVlcyA9IDE7Cisg
ICAgfQogICAgIGlmICghcy0+bnVtX3F1ZXVlcyB8fCBzLT5udW1fcXVldWVzID4gVklSVElPX1FV
RVVFX01BWCkgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2aG9zdC11c2VyLWJsazogaW52
YWxpZCBudW1iZXIgb2YgSU8gcXVldWVzIik7CiAgICAgICAgIHJldHVybjsKQEAgLTQ5Niw3ICs0
OTksOCBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfdmhvc3RfdXNl
cl9ibGsgPSB7CiAKIHN0YXRpYyBQcm9wZXJ0eSB2aG9zdF91c2VyX2Jsa19wcm9wZXJ0aWVzW10g
PSB7CiAgICAgREVGSU5FX1BST1BfQ0hSKCJjaGFyZGV2IiwgVkhvc3RVc2VyQmxrLCBjaGFyZGV2
KSwKLSAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1ZXMiLCBWSG9zdFVzZXJCbGssIG51
bV9xdWV1ZXMsIDEpLAorICAgIERFRklORV9QUk9QX1VJTlQxNigibnVtLXF1ZXVlcyIsIFZIb3N0
VXNlckJsaywgbnVtX3F1ZXVlcywKKyAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9C
TEtfQVVUT19OVU1fUVVFVUVTKSwKICAgICBERUZJTkVfUFJPUF9VSU5UMzIoInF1ZXVlLXNpemUi
LCBWSG9zdFVzZXJCbGssIHF1ZXVlX3NpemUsIDEyOCksCiAgICAgREVGSU5FX1BST1BfQklUKCJj
b25maWctd2NlIiwgVkhvc3RVc2VyQmxrLCBjb25maWdfd2NlLCAwLCB0cnVlKSwKICAgICBERUZJ
TkVfUFJPUF9FTkRfT0ZfTElTVCgpLApkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9o
dy9jb3JlL21hY2hpbmUuYwppbmRleCA0YWJhM2JkZDNjLi44Y2M0YjU0ZWVjIDEwMDY0NAotLS0g
YS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hpbmUuYwpAQCAtMzIsNiArMzIs
NyBAQCBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNV8wW10gPSB7CiAgICAgeyAidmlydGlvLWJs
ay1kZXZpY2UiLCAibnVtLXF1ZXVlcyIsICIxIn0sCiAgICAgeyAidmlydGlvLXNjc2ktZGV2aWNl
IiwgIm51bV9xdWV1ZXMiLCAiMSJ9LAogICAgIHsgInZob3N0LXNjc2kiLCAibnVtX3F1ZXVlcyIs
ICIxIn0sCisgICAgeyAidmhvc3QtdXNlci1ibGsiLCAibnVtLXF1ZXVlcyIsICIxIn0sCiAgICAg
eyAidmhvc3QtdXNlci1zY3NpIiwgIm51bV9xdWV1ZXMiLCAiMSJ9LAogfTsKIGNvbnN0IHNpemVf
dCBod19jb21wYXRfNV8wX2xlbiA9IEdfTl9FTEVNRU5UUyhod19jb21wYXRfNV8wKTsKZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kuYyBiL2h3L3ZpcnRpby92aG9zdC11
c2VyLWJsay1wY2kuYwppbmRleCA1OGQ3YzMxNzM1Li4xYzhhYjdmNWU2IDEwMDY0NAotLS0gYS9o
dy92aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNpLmMKKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIt
YmxrLXBjaS5jCkBAIC01NCw2ICs1NCwxMCBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2Jsa19w
Y2lfcmVhbGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBjaV9kZXYsIEVycm9yICoqZXJycCkKICAgICBW
SG9zdFVzZXJCbGtQQ0kgKmRldiA9IFZIT1NUX1VTRVJfQkxLX1BDSSh2cGNpX2Rldik7CiAgICAg
RGV2aWNlU3RhdGUgKnZkZXYgPSBERVZJQ0UoJmRldi0+dmRldik7CiAKKyAgICBpZiAoZGV2LT52
ZGV2Lm51bV9xdWV1ZXMgPT0gVkhPU1RfVVNFUl9CTEtfQVVUT19OVU1fUVVFVUVTKSB7CisgICAg
ICAgIGRldi0+dmRldi5udW1fcXVldWVzID0gdmlydGlvX3BjaV9vcHRpbWFsX251bV9xdWV1ZXMo
MCk7CisgICAgfQorCiAgICAgaWYgKHZwY2lfZGV2LT5udmVjdG9ycyA9PSBERVZfTlZFQ1RPUlNf
VU5TUEVDSUZJRUQpIHsKICAgICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gZGV2LT52ZGV2Lm51
bV9xdWV1ZXMgKyAxOwogICAgIH0KLS0gCjIuMjUuNAoK


