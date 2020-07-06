Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2884C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C3B2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKx7c2Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C3B2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRgX-0000F2-AN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRci-00029K-Uq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcg-0006V2-GI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYGCi0QB0SAc/mJAncRYzQLFnJOLAK+wSPTimfQliR0=;
 b=HKx7c2AyG+K8e0k9QvMmltp+XE+2rl0u7R9TIV7ZZbI3q8dHRrLVQSoGYCmUlTdjcAkPNb
 RG/f14JJjAIoXwuOAV632f/CCOAJOBrR9rTDztOjERq3yANiZsJdqd12uOcq2T0ARx+pqB
 8kM0eEdRBPzLyXTyf7eMbC+688CJco0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-tqlJc260MWelnA8ws-NxAw-1; Mon, 06 Jul 2020 09:57:26 -0400
X-MC-Unique: tqlJc260MWelnA8ws-NxAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9AD219200C0;
 Mon,  6 Jul 2020 13:57:24 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF539512FE;
 Mon,  6 Jul 2020 13:57:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/5] vhost-user-blk: default num_queues to -smp N
Date: Mon,  6 Jul 2020 14:56:50 +0100
Message-Id: <20200706135650.438362-6-stefanha@redhat.com>
In-Reply-To: <20200706135650.438362-1-stefanha@redhat.com>
References: <20200706135650.438362-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgcmVxdWVzdCB2aXJ0cXVldWVzIHRvIG1h
dGNoIHRoZSBudW1iZXIKb2YgdkNQVXMuICBUaGlzIGVuc3VyZXMgdGhhdCBjb21wbGV0aW9uIGlu
dGVycnVwdHMgYXJlIGhhbmRsZWQgb24gdGhlCnNhbWUgdkNQVSB0aGF0IHN1Ym1pdHRlZCB0aGUg
cmVxdWVzdC4gIE5vIElQSSBpcyBuZWNlc3NhcnkgdG8gY29tcGxldGUKYW4gSS9PIHJlcXVlc3Qg
YW5kIHBlcmZvcm1hbmNlIGlzIGltcHJvdmVkLiAgVGhlIG1heGltdW0gbnVtYmVyIG9mIE1TSS1Y
CnZlY3RvcnMgYW5kIHZpcnRxdWV1ZXMgbGltaXQgYXJlIHJlc3BlY3RlZC4KClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IENv
cm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvaHcvdmlydGlvL3Zo
b3N0LXVzZXItYmxrLmggfCAyICsrCiBody9ibG9jay92aG9zdC11c2VyLWJsay5jICAgICAgICAg
IHwgNiArKysrKy0KIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgICAgICAgICAgfCAxICsKIGh3
L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kuYyAgICAgfCA0ICsrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC11c2Vy
LWJsay5oCmluZGV4IDM0YWQ2ZjBjMGUuLjI5MmQxNzE0N2MgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3Qt
dXNlci1ibGsuaApAQCAtMjUsNiArMjUsOCBAQAogI2RlZmluZSBWSE9TVF9VU0VSX0JMSyhvYmop
IFwKICAgICAgICAgT0JKRUNUX0NIRUNLKFZIb3N0VXNlckJsaywgKG9iaiksIFRZUEVfVkhPU1Rf
VVNFUl9CTEspCiAKKyNkZWZpbmUgVkhPU1RfVVNFUl9CTEtfQVVUT19OVU1fUVVFVUVTIFVJTlQx
Nl9NQVgKKwogdHlwZWRlZiBzdHJ1Y3QgVkhvc3RVc2VyQmxrIHsKICAgICBWaXJ0SU9EZXZpY2Ug
cGFyZW50X29iajsKICAgICBDaGFyQmFja2VuZCBjaGFyZGV2OwpkaWZmIC0tZ2l0IGEvaHcvYmxv
Y2svdmhvc3QtdXNlci1ibGsuYyBiL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMKaW5kZXggYTAw
Yjg1NDczNi4uMzlhZWM0MmRhZSAxMDA2NDQKLS0tIGEvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsu
YworKysgYi9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCkBAIC00MjAsNiArNDIwLDkgQEAgc3Rh
dGljIHZvaWQgdmhvc3RfdXNlcl9ibGtfZGV2aWNlX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwg
RXJyb3IgKiplcnJwKQogICAgICAgICByZXR1cm47CiAgICAgfQogCisgICAgaWYgKHMtPm51bV9x
dWV1ZXMgPT0gVkhPU1RfVVNFUl9CTEtfQVVUT19OVU1fUVVFVUVTKSB7CisgICAgICAgIHMtPm51
bV9xdWV1ZXMgPSAxOworICAgIH0KICAgICBpZiAoIXMtPm51bV9xdWV1ZXMgfHwgcy0+bnVtX3F1
ZXVlcyA+IFZJUlRJT19RVUVVRV9NQVgpIHsKICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmhv
c3QtdXNlci1ibGs6IGludmFsaWQgbnVtYmVyIG9mIElPIHF1ZXVlcyIpOwogICAgICAgICByZXR1
cm47CkBAIC01MzEsNyArNTM0LDggQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2
bXN0YXRlX3Zob3N0X3VzZXJfYmxrID0gewogCiBzdGF0aWMgUHJvcGVydHkgdmhvc3RfdXNlcl9i
bGtfcHJvcGVydGllc1tdID0gewogICAgIERFRklORV9QUk9QX0NIUigiY2hhcmRldiIsIFZIb3N0
VXNlckJsaywgY2hhcmRldiksCi0gICAgREVGSU5FX1BST1BfVUlOVDE2KCJudW0tcXVldWVzIiwg
Vkhvc3RVc2VyQmxrLCBudW1fcXVldWVzLCAxKSwKKyAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51
bS1xdWV1ZXMiLCBWSG9zdFVzZXJCbGssIG51bV9xdWV1ZXMsCisgICAgICAgICAgICAgICAgICAg
ICAgIFZIT1NUX1VTRVJfQkxLX0FVVE9fTlVNX1FVRVVFUyksCiAgICAgREVGSU5FX1BST1BfVUlO
VDMyKCJxdWV1ZS1zaXplIiwgVkhvc3RVc2VyQmxrLCBxdWV1ZV9zaXplLCAxMjgpLAogICAgIERF
RklORV9QUk9QX0JJVCgiY29uZmlnLXdjZSIsIFZIb3N0VXNlckJsaywgY29uZmlnX3djZSwgMCwg
dHJ1ZSksCiAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwKZGlmZiAtLWdpdCBhL2h3L2Nv
cmUvbWFjaGluZS5jIGIvaHcvY29yZS9tYWNoaW5lLmMKaW5kZXggODQ1ZjY0NzZjYi4uMzFiZmFh
Y2RiNSAxMDA2NDQKLS0tIGEvaHcvY29yZS9tYWNoaW5lLmMKKysrIGIvaHcvY29yZS9tYWNoaW5l
LmMKQEAgLTMwLDYgKzMwLDcgQEAKIAogR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzVfMFtdID0g
ewogICAgIHsgInZob3N0LXNjc2kiLCAibnVtX3F1ZXVlcyIsICIxIn0sCisgICAgeyAidmhvc3Qt
dXNlci1ibGsiLCAibnVtLXF1ZXVlcyIsICIxIn0sCiAgICAgeyAidmhvc3QtdXNlci1zY3NpIiwg
Im51bV9xdWV1ZXMiLCAiMSJ9LAogICAgIHsgInZpcnRpby1iYWxsb29uLWRldmljZSIsICJwYWdl
LXBvaXNvbiIsICJmYWxzZSIgfSwKICAgICB7ICJ2aXJ0aW8tYmxrLWRldmljZSIsICJudW0tcXVl
dWVzIiwgIjEifSwKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kuYyBi
L2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kuYwppbmRleCA0ZjVkNWNiZjQ0Li5hNjJhNzFl
MDY3IDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNpLmMKKysrIGIvaHcv
dmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jCkBAIC01NCw2ICs1NCwxMCBAQCBzdGF0aWMgdm9p
ZCB2aG9zdF91c2VyX2Jsa19wY2lfcmVhbGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBjaV9kZXYsIEVy
cm9yICoqZXJycCkKICAgICBWSG9zdFVzZXJCbGtQQ0kgKmRldiA9IFZIT1NUX1VTRVJfQkxLX1BD
SSh2cGNpX2Rldik7CiAgICAgRGV2aWNlU3RhdGUgKnZkZXYgPSBERVZJQ0UoJmRldi0+dmRldik7
CiAKKyAgICBpZiAoZGV2LT52ZGV2Lm51bV9xdWV1ZXMgPT0gVkhPU1RfVVNFUl9CTEtfQVVUT19O
VU1fUVVFVUVTKSB7CisgICAgICAgIGRldi0+dmRldi5udW1fcXVldWVzID0gdmlydGlvX3BjaV9v
cHRpbWFsX251bV9xdWV1ZXMoMCk7CisgICAgfQorCiAgICAgaWYgKHZwY2lfZGV2LT5udmVjdG9y
cyA9PSBERVZfTlZFQ1RPUlNfVU5TUEVDSUZJRUQpIHsKICAgICAgICAgdnBjaV9kZXYtPm52ZWN0
b3JzID0gZGV2LT52ZGV2Lm51bV9xdWV1ZXMgKyAxOwogICAgIH0KLS0gCjIuMjYuMgoK


