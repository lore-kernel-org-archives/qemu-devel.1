Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42669C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080E120786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1oi0wI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080E120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83dL-0005w0-8o
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82hB-0005Ih-Qh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h9-0002WS-TJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dg4wwNlM3UA8oFWJ+eNd0CyqfAcH8r5+f9d3B+KbHLw=;
 b=V1oi0wI1jarZKzLAuP09C7xY6XhK/aohpc73CbmfQsQvUwyPZeOxLs6uAI3Np7MblIHXkq
 JRkZMWrD9pVURkT+8AM+RE2Hu5FLQwVjmdyJfOkGiIryG8YHvfRzqgiCaxpE7zJrtDSv7l
 y1o72hS18ZVwYjqR28xzv5QkQspp6fE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Tvo8x58pOMWIWCKJsuH7Ng-1; Tue, 18 Aug 2020 10:34:30 -0400
X-MC-Unique: Tvo8x58pOMWIWCKJsuH7Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04C08DFFEB;
 Tue, 18 Aug 2020 14:34:16 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6445C70A;
 Tue, 18 Aug 2020 14:34:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/7] vhost-user-blk-pci: default num_queues to -smp N
Date: Tue, 18 Aug 2020 15:33:48 +0100
Message-Id: <20200818143348.310613-8-stefanha@redhat.com>
In-Reply-To: <20200818143348.310613-1-stefanha@redhat.com>
References: <20200818143348.310613-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgcmVxdWVzdCB2aXJ0cXVldWVzIHRvIG1h
dGNoIHRoZSBudW1iZXIKb2YgdkNQVXMuICBUaGlzIGVuc3VyZXMgdGhhdCBjb21wbGV0aW9uIGlu
dGVycnVwdHMgYXJlIGhhbmRsZWQgb24gdGhlCnNhbWUgdkNQVSB0aGF0IHN1Ym1pdHRlZCB0aGUg
cmVxdWVzdC4gIE5vIElQSSBpcyBuZWNlc3NhcnkgdG8gY29tcGxldGUKYW4gSS9PIHJlcXVlc3Qg
YW5kIHBlcmZvcm1hbmNlIGlzIGltcHJvdmVkLiAgVGhlIG1heGltdW0gbnVtYmVyIG9mIE1TSS1Y
CnZlY3RvcnMgYW5kIHZpcnRxdWV1ZXMgbGltaXQgYXJlIHJlc3BlY3RlZC4KClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IENv
cm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUmFwaGFlbCBOb3J3
aXR6IDxyYXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+Ci0tLQogaW5jbHVkZS9ody92aXJ0aW8v
dmhvc3QtdXNlci1ibGsuaCB8IDIgKysKIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgICAgICAg
ICAgfCA2ICsrKysrLQogaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8IDEgKwog
aHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jICAgICB8IDQgKysrKwogNCBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXVz
ZXItYmxrLmgKaW5kZXggMzRhZDZmMGMwZS4uMjkyZDE3MTQ3YyAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaAorKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9z
dC11c2VyLWJsay5oCkBAIC0yNSw2ICsyNSw4IEBACiAjZGVmaW5lIFZIT1NUX1VTRVJfQkxLKG9i
aikgXAogICAgICAgICBPQkpFQ1RfQ0hFQ0soVkhvc3RVc2VyQmxrLCAob2JqKSwgVFlQRV9WSE9T
VF9VU0VSX0JMSykKIAorI2RlZmluZSBWSE9TVF9VU0VSX0JMS19BVVRPX05VTV9RVUVVRVMgVUlO
VDE2X01BWAorCiB0eXBlZGVmIHN0cnVjdCBWSG9zdFVzZXJCbGsgewogICAgIFZpcnRJT0Rldmlj
ZSBwYXJlbnRfb2JqOwogICAgIENoYXJCYWNrZW5kIGNoYXJkZXY7CmRpZmYgLS1naXQgYS9ody9i
bG9jay92aG9zdC11c2VyLWJsay5jIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYwppbmRleCBh
MDBiODU0NzM2Li4zOWFlYzQyZGFlIDEwMDY0NAotLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJs
ay5jCisrKyBiL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMKQEAgLTQyMCw2ICs0MjAsOSBAQCBz
dGF0aWMgdm9pZCB2aG9zdF91c2VyX2Jsa19kZXZpY2VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvciAqKmVycnApCiAgICAgICAgIHJldHVybjsKICAgICB9CiAKKyAgICBpZiAocy0+bnVt
X3F1ZXVlcyA9PSBWSE9TVF9VU0VSX0JMS19BVVRPX05VTV9RVUVVRVMpIHsKKyAgICAgICAgcy0+
bnVtX3F1ZXVlcyA9IDE7CisgICAgfQogICAgIGlmICghcy0+bnVtX3F1ZXVlcyB8fCBzLT5udW1f
cXVldWVzID4gVklSVElPX1FVRVVFX01BWCkgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2
aG9zdC11c2VyLWJsazogaW52YWxpZCBudW1iZXIgb2YgSU8gcXVldWVzIik7CiAgICAgICAgIHJl
dHVybjsKQEAgLTUzMSw3ICs1MzQsOCBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9u
IHZtc3RhdGVfdmhvc3RfdXNlcl9ibGsgPSB7CiAKIHN0YXRpYyBQcm9wZXJ0eSB2aG9zdF91c2Vy
X2Jsa19wcm9wZXJ0aWVzW10gPSB7CiAgICAgREVGSU5FX1BST1BfQ0hSKCJjaGFyZGV2IiwgVkhv
c3RVc2VyQmxrLCBjaGFyZGV2KSwKLSAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1ZXMi
LCBWSG9zdFVzZXJCbGssIG51bV9xdWV1ZXMsIDEpLAorICAgIERFRklORV9QUk9QX1VJTlQxNigi
bnVtLXF1ZXVlcyIsIFZIb3N0VXNlckJsaywgbnVtX3F1ZXVlcywKKyAgICAgICAgICAgICAgICAg
ICAgICAgVkhPU1RfVVNFUl9CTEtfQVVUT19OVU1fUVVFVUVTKSwKICAgICBERUZJTkVfUFJPUF9V
SU5UMzIoInF1ZXVlLXNpemUiLCBWSG9zdFVzZXJCbGssIHF1ZXVlX3NpemUsIDEyOCksCiAgICAg
REVGSU5FX1BST1BfQklUKCJjb25maWctd2NlIiwgVkhvc3RVc2VyQmxrLCBjb25maWdfd2NlLCAw
LCB0cnVlKSwKICAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpLApkaWZmIC0tZ2l0IGEvaHcv
Y29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYwppbmRleCA3ZjY1ZmE4NzQzLi5lYTI2
ZDYxMjM3IDEwMDY0NAotLS0gYS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hp
bmUuYwpAQCAtMzAsNiArMzAsNyBAQAogCiBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNV8xW10g
PSB7CiAgICAgeyAidmhvc3Qtc2NzaSIsICJudW1fcXVldWVzIiwgIjEifSwKKyAgICB7ICJ2aG9z
dC11c2VyLWJsayIsICJudW0tcXVldWVzIiwgIjEifSwKICAgICB7ICJ2aG9zdC11c2VyLXNjc2ki
LCAibnVtX3F1ZXVlcyIsICIxIn0sCiAgICAgeyAidmlydGlvLWJsay1kZXZpY2UiLCAibnVtLXF1
ZXVlcyIsICIxIn0sCiAgICAgeyAidmlydGlvLXNjc2ktZGV2aWNlIiwgIm51bV9xdWV1ZXMiLCAi
MSJ9LApkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jIGIvaHcvdmly
dGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jCmluZGV4IDRmNWQ1Y2JmNDQuLmE2MmE3MWUwNjcgMTAw
NjQ0Ci0tLSBhL2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kuYworKysgYi9ody92aXJ0aW8v
dmhvc3QtdXNlci1ibGstcGNpLmMKQEAgLTU0LDYgKzU0LDEwIEBAIHN0YXRpYyB2b2lkIHZob3N0
X3VzZXJfYmxrX3BjaV9yZWFsaXplKFZpcnRJT1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKipl
cnJwKQogICAgIFZIb3N0VXNlckJsa1BDSSAqZGV2ID0gVkhPU1RfVVNFUl9CTEtfUENJKHZwY2lf
ZGV2KTsKICAgICBEZXZpY2VTdGF0ZSAqdmRldiA9IERFVklDRSgmZGV2LT52ZGV2KTsKIAorICAg
IGlmIChkZXYtPnZkZXYubnVtX3F1ZXVlcyA9PSBWSE9TVF9VU0VSX0JMS19BVVRPX05VTV9RVUVV
RVMpIHsKKyAgICAgICAgZGV2LT52ZGV2Lm51bV9xdWV1ZXMgPSB2aXJ0aW9fcGNpX29wdGltYWxf
bnVtX3F1ZXVlcygwKTsKKyAgICB9CisKICAgICBpZiAodnBjaV9kZXYtPm52ZWN0b3JzID09IERF
Vl9OVkVDVE9SU19VTlNQRUNJRklFRCkgewogICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSBk
ZXYtPnZkZXYubnVtX3F1ZXVlcyArIDE7CiAgICAgfQotLSAKMi4yNi4yCgo=


