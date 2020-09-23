Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC41F208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9CnG1nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC41F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7OB-0005R2-JV
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7ME-0003MS-Mj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MC-0006Cn-Of
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myjanPibXqn+oY0JLUMW1FomBqv40jx/nCcbopY/EI0=;
 b=E9CnG1nh3tFwmdxqRrrv/fUoofVqN70YkBZiJ9/oILeT6nJ4vBI2shEEUh520tz3sxXtQR
 nHPFsSc7H9QFevTg6enHenB1ERj2L6SbiheHDgK2xUx7fIbg+ra8qo2J2zrGoWh672Okqa
 oLK8ErckhQB8B2aXu5hAvZxzaUmujwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-ZJHxYsEFN_eFF1lpjdS7Hg-1; Wed, 23 Sep 2020 12:10:54 -0400
X-MC-Unique: ZJHxYsEFN_eFF1lpjdS7Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3561A801ABE;
 Wed, 23 Sep 2020 16:10:53 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B0CA7368B;
 Wed, 23 Sep 2020 16:10:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/13] virtio: add vhost-user-fs-ccw device
Date: Wed, 23 Sep 2020 17:10:21 +0100
Message-Id: <20200923161031.69474-4-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogSGFsaWwgUGFzaWMgPHBhc2ljQGxpbnV4LmlibS5jb20+CgpXaXJlIHVwIHRoZSBDQ1cg
ZGV2aWNlIGZvciB2aG9zdC11c2VyLWZzLgoKUmV2aWV3ZWQtYnk6IENvcm5lbGlhIEh1Y2sgPGNv
aHVja0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBIYWxpbCBQYXNpYyA8cGFzaWNAbGludXgu
aWJtLmNvbT4KTWVzc2FnZS1pZDogMjAyMDA5MDExNTAwMTkuMjkyMjktMi1taGFydG1heUBsaW51
eC5pYm0uY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KLS0tCiBody9zMzkweC92aG9zdC11c2VyLWZzLWNjdy5jIHwgNzUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiBody9zMzkweC9tZXNvbi5idWlsZCAgICAgICAgIHwg
IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvczM5MHgvdmhvc3QtdXNlci1mcy1jY3cuYwoKZGlmZiAtLWdpdCBhL2h3L3MzOTB4L3Zo
b3N0LXVzZXItZnMtY2N3LmMgYi9ody9zMzkweC92aG9zdC11c2VyLWZzLWNjdy5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLjZjNmYyNjkyOTMKLS0tIC9kZXYvbnVsbAor
KysgYi9ody9zMzkweC92aG9zdC11c2VyLWZzLWNjdy5jCkBAIC0wLDAgKzEsNzUgQEAKKy8qCisg
KiB2aXJ0aW8gY2N3IHZob3N0LXVzZXItZnMgaW1wbGVtZW50YXRpb24KKyAqCisgKiBDb3B5cmln
aHQgMjAyMCBJQk0gQ29ycC4KKyAqCisgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIgb3IgKGF0CisgKiB5b3VyIG9wdGlvbikg
YW55IGxhdGVyIHZlcnNpb24uIFNlZSB0aGUgQ09QWUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwK
KyAqIGRpcmVjdG9yeS4KKyAqLworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJo
dy9xZGV2LXByb3BlcnRpZXMuaCIKKyNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCisjaW5jbHVkZSAi
aHcvdmlydGlvL3Zob3N0LXVzZXItZnMuaCIKKyNpbmNsdWRlICJ2aXJ0aW8tY2N3LmgiCisKK3R5
cGVkZWYgc3RydWN0IFZIb3N0VXNlckZTQ2N3IHsKKyAgICBWaXJ0aW9DY3dEZXZpY2UgcGFyZW50
X29iajsKKyAgICBWSG9zdFVzZXJGUyB2ZGV2OworfSBWSG9zdFVzZXJGU0NjdzsKKworI2RlZmlu
ZSBUWVBFX1ZIT1NUX1VTRVJfRlNfQ0NXICJ2aG9zdC11c2VyLWZzLWNjdyIKKyNkZWZpbmUgVkhP
U1RfVVNFUl9GU19DQ1cob2JqKSBcCisgICAgICAgIE9CSkVDVF9DSEVDSyhWSG9zdFVzZXJGU0Nj
dywgKG9iaiksIFRZUEVfVkhPU1RfVVNFUl9GU19DQ1cpCisKKworc3RhdGljIFByb3BlcnR5IHZo
b3N0X3VzZXJfZnNfY2N3X3Byb3BlcnRpZXNbXSA9IHsKKyAgICBERUZJTkVfUFJPUF9CSVQoImlv
ZXZlbnRmZCIsIFZpcnRpb0Njd0RldmljZSwgZmxhZ3MsCisgICAgICAgICAgICAgICAgICAgIFZJ
UlRJT19DQ1dfRkxBR19VU0VfSU9FVkVOVEZEX0JJVCwgdHJ1ZSksCisgICAgREVGSU5FX1BST1Bf
VUlOVDMyKCJtYXhfcmV2aXNpb24iLCBWaXJ0aW9DY3dEZXZpY2UsIG1heF9yZXYsCisgICAgICAg
ICAgICAgICAgICAgICAgIFZJUlRJT19DQ1dfTUFYX1JFViksCisgICAgREVGSU5FX1BST1BfRU5E
X09GX0xJU1QoKSwKK307CisKK3N0YXRpYyB2b2lkIHZob3N0X3VzZXJfZnNfY2N3X3JlYWxpemUo
VmlydGlvQ2N3RGV2aWNlICpjY3dfZGV2LCBFcnJvciAqKmVycnApCit7CisgICAgVkhvc3RVc2Vy
RlNDY3cgKmRldiA9IFZIT1NUX1VTRVJfRlNfQ0NXKGNjd19kZXYpOworICAgIERldmljZVN0YXRl
ICp2ZGV2ID0gREVWSUNFKCZkZXYtPnZkZXYpOworCisgICAgcWRldl9yZWFsaXplKHZkZXYsIEJV
UygmY2N3X2Rldi0+YnVzKSwgZXJycCk7Cit9CisKK3N0YXRpYyB2b2lkIHZob3N0X3VzZXJfZnNf
Y2N3X2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCit7CisgICAgVkhvc3RVc2VyRlNDY3cgKmRl
diA9IFZIT1NUX1VTRVJfRlNfQ0NXKG9iaik7CisgICAgVmlydGlvQ2N3RGV2aWNlICpjY3dfZGV2
ID0gVklSVElPX0NDV19ERVZJQ0Uob2JqKTsKKworICAgIGNjd19kZXYtPmZvcmNlX3JldmlzaW9u
XzEgPSB0cnVlOworICAgIHZpcnRpb19pbnN0YW5jZV9pbml0X2NvbW1vbihvYmosICZkZXYtPnZk
ZXYsIHNpemVvZihkZXYtPnZkZXYpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
WVBFX1ZIT1NUX1VTRVJfRlMpOworfQorCitzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2ZzX2Njd19j
bGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkKK3sKKyAgICBEZXZpY2VD
bGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOworICAgIFZpcnRJT0NDV0RldmljZUNsYXNz
ICprID0gVklSVElPX0NDV19ERVZJQ0VfQ0xBU1Moa2xhc3MpOworCisgICAgay0+cmVhbGl6ZSA9
IHZob3N0X3VzZXJfZnNfY2N3X3JlYWxpemU7CisgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhk
Yywgdmhvc3RfdXNlcl9mc19jY3dfcHJvcGVydGllcyk7CisgICAgc2V0X2JpdChERVZJQ0VfQ0FU
RUdPUllfU1RPUkFHRSwgZGMtPmNhdGVnb3JpZXMpOworfQorCitzdGF0aWMgY29uc3QgVHlwZUlu
Zm8gdmhvc3RfdXNlcl9mc19jY3cgPSB7CisgICAgLm5hbWUgICAgICAgICAgPSBUWVBFX1ZIT1NU
X1VTRVJfRlNfQ0NXLAorICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9WSVJUSU9fQ0NXX0RFVklD
RSwKKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihWSG9zdFVzZXJGU0NjdyksCisgICAgLmlu
c3RhbmNlX2luaXQgPSB2aG9zdF91c2VyX2ZzX2Njd19pbnN0YW5jZV9pbml0LAorICAgIC5jbGFz
c19pbml0ICAgID0gdmhvc3RfdXNlcl9mc19jY3dfY2xhc3NfaW5pdCwKK307CisKK3N0YXRpYyB2
b2lkIHZob3N0X3VzZXJfZnNfY2N3X3JlZ2lzdGVyKHZvaWQpCit7CisgICAgdHlwZV9yZWdpc3Rl
cl9zdGF0aWMoJnZob3N0X3VzZXJfZnNfY2N3KTsKK30KKwordHlwZV9pbml0KHZob3N0X3VzZXJf
ZnNfY2N3X3JlZ2lzdGVyKQpkaWZmIC0tZ2l0IGEvaHcvczM5MHgvbWVzb24uYnVpbGQgYi9ody9z
MzkweC9tZXNvbi5idWlsZAppbmRleCBiNjM3ODJkODdhLi45NDhjZWFlN2E3IDEwMDY0NAotLS0g
YS9ody9zMzkweC9tZXNvbi5idWlsZAorKysgYi9ody9zMzkweC9tZXNvbi5idWlsZApAQCAtNDEs
NiArNDEsNyBAQCB2aXJ0aW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVklSVElPX1NDU0knLCBpZl90
cnVlOiBmaWxlcygndmlydGlvLWNjdy1zY3NpLmMnKSkKIHZpcnRpb19zcy5hZGQod2hlbjogJ0NP
TkZJR19WSVJUSU9fU0VSSUFMJywgaWZfdHJ1ZTogZmlsZXMoJ3ZpcnRpby1jY3ctc2VyaWFsLmMn
KSkKIHZpcnRpb19zcy5hZGQod2hlbjogWydDT05GSUdfVklSVElPXzlQJywgJ0NPTkZJR19WSVJU
RlMnXSwgaWZfdHJ1ZTogZmlsZXMoJ3ZpcnRpby1jY3ctYmxrLmMnKSkKIHZpcnRpb19zcy5hZGQo
d2hlbjogJ0NPTkZJR19WSE9TVF9WU09DSycsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC12c29jay1j
Y3cuYycpKQordmlydGlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVJfRlMnLCBpZl90
cnVlOiBmaWxlcygndmhvc3QtdXNlci1mcy1jY3cuYycpKQogczM5MHhfc3MuYWRkX2FsbCh3aGVu
OiAnQ09ORklHX1ZJUlRJT19DQ1cnLCBpZl90cnVlOiB2aXJ0aW9fc3MpCiAKIGh3X2FyY2ggKz0g
eydzMzkweCc6IHMzOTB4X3NzfQotLSAKMi4yNi4yCgo=


