Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856692083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbZfJpQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856692083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo5B-0001FW-Tj
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzs-0004YA-KM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzq-0008HY-UK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKmmhtjbbMd4B37UMRyp5VloG9uMAGkWR1Fvk8XbqmA=;
 b=KbZfJpQNEwArl5LLgj7OWrA/HRLOnqN3gMbRm0l2UfvZcK+oSPZxvnWVLI3uWukV+PllaL
 POnoExaf52vxwb+nS+k8n/cPmIyUCnVBJDIW8+jA44u/Y98fss2M33Z2M0jLiN+Zns/EM1
 dAjcIAr5jXe1GlPFwKdxiUGhXyBGjx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-GVL-aUC2Op6K-Xnq5BUyBg-1; Fri, 25 Sep 2020 09:42:44 -0400
X-MC-Unique: GVL-aUC2Op6K-Xnq5BUyBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 712C8807341;
 Fri, 25 Sep 2020 13:42:43 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1767A60C15;
 Fri, 25 Sep 2020 13:42:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] qemu-storage-daemon: avoid compiling blockdev_ss twice
Date: Fri, 25 Sep 2020 14:42:27 +0100
Message-Id: <20200925134229.246169-3-stefanha@redhat.com>
In-Reply-To: <20200925134229.246169-1-stefanha@redhat.com>
References: <20200925134229.246169-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW50cm9kdWNlIGxpYmJsa2Rldi5mYSB0byBhdm9pZCByZWNvbXBpbGluZyBibG9ja2Rldl9zcyB0
d2ljZS4KClN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4K
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKy0tCiBzdG9yYWdlLWRh
ZW1vbi9tZXNvbi5idWlsZCB8ICAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVp
bGQKaW5kZXggZWI4NGI5N2ViYi4uMThkNjg5YjQyMyAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQK
KysrIGIvbWVzb24uYnVpbGQKQEAgLTg1Nyw3ICs4NTcsNiBAQCBibG9ja2Rldl9zcy5hZGQoZmls
ZXMoCiBibG9ja2Rldl9zcy5hZGQod2hlbjogJ0NPTkZJR19QT1NJWCcsIGlmX3RydWU6IGZpbGVz
KCdvcy1wb3NpeC5jJykpCiBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX1dJTjMyJywgaWZf
dHJ1ZTogW2ZpbGVzKCdvcy13aW4zMi5jJyldKQogCi1zb2Z0bW11X3NzLmFkZF9hbGwoYmxvY2tk
ZXZfc3MpCiBzb2Z0bW11X3NzLmFkZChmaWxlcygKICAgJ2Jvb3RkZXZpY2UuYycsCiAgICdkbWEt
aGVscGVycy5jJywKQEAgLTk1Miw2ICs5NTEsMTUgQEAgYmxvY2sgPSBkZWNsYXJlX2RlcGVuZGVu
Y3kobGlua193aG9sZTogW2xpYmJsb2NrXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxp
bmtfYXJnczogJ0BibG9jay5zeW1zJywKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlcGVu
ZGVuY2llczogW2NyeXB0bywgaW9dKQogCitibG9ja2Rldl9zcyA9IGJsb2NrZGV2X3NzLmFwcGx5
KGNvbmZpZ19ob3N0LCBzdHJpY3Q6IGZhbHNlKQorbGliYmxvY2tkZXYgPSBzdGF0aWNfbGlicmFy
eSgnYmxvY2tkZXYnLCBibG9ja2Rldl9zcy5zb3VyY2VzKCkgKyBnZW5oLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IGJsb2NrZGV2X3NzLmRlcGVuZGVuY2llcygp
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYW1lX3N1ZmZpeDogJ2ZhJywKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYnVpbGRfYnlfZGVmYXVsdDogZmFsc2UpCisKK2Jsb2Nr
ZGV2ID0gZGVjbGFyZV9kZXBlbmRlbmN5KGxpbmtfd2hvbGU6IFtsaWJibG9ja2Rldl0sCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9ja10pCisKIHFtcF9z
cyA9IHFtcF9zcy5hcHBseShjb25maWdfaG9zdCwgc3RyaWN0OiBmYWxzZSkKIGxpYnFtcCA9IHN0
YXRpY19saWJyYXJ5KCdxbXAnLCBxbXBfc3Muc291cmNlcygpICsgZ2VuaCwKICAgICAgICAgICAg
ICAgICAgICAgICAgIGRlcGVuZGVuY2llczogcW1wX3NzLmRlcGVuZGVuY2llcygpLApAQCAtOTY4
LDcgKzk3Niw3IEBAIGZvcmVhY2ggbSA6IGJsb2NrX21vZHMgKyBzb2Z0bW11X21vZHMKICAgICAg
ICAgICAgICAgICBpbnN0YWxsX2RpcjogY29uZmlnX2hvc3RbJ3FlbXVfbW9kZGlyJ10pCiBlbmRm
b3JlYWNoCiAKLXNvZnRtbXVfc3MuYWRkKGF1dGh6LCBibG9jaywgY2hhcmRldiwgY3J5cHRvLCBp
bywgcW1wKQorc29mdG1tdV9zcy5hZGQoYXV0aHosIGJsb2NrZGV2LCBjaGFyZGV2LCBjcnlwdG8s
IGlvLCBxbXApCiBjb21tb25fc3MuYWRkKHFvbSwgcWVtdXV0aWwpCiAKIGNvbW1vbl9zcy5hZGRf
YWxsKHdoZW46ICdDT05GSUdfU09GVE1NVScsIGlmX3RydWU6IFtzb2Z0bW11X3NzXSkKZGlmZiAt
LWdpdCBhL3N0b3JhZ2UtZGFlbW9uL21lc29uLmJ1aWxkIGIvc3RvcmFnZS1kYWVtb24vbWVzb24u
YnVpbGQKaW5kZXggMDQwOWFjYzNmNS4uYzVhZGNlODFjMyAxMDA2NDQKLS0tIGEvc3RvcmFnZS1k
YWVtb24vbWVzb24uYnVpbGQKKysrIGIvc3RvcmFnZS1kYWVtb24vbWVzb24uYnVpbGQKQEAgLTEs
NyArMSw2IEBACiBxc2Rfc3MgPSBzcy5zb3VyY2Vfc2V0KCkKIHFzZF9zcy5hZGQoZmlsZXMoJ3Fl
bXUtc3RvcmFnZS1kYWVtb24uYycpKQotcXNkX3NzLmFkZChibG9jaywgY2hhcmRldiwgcW1wLCBx
b20sIHFlbXV1dGlsKQotcXNkX3NzLmFkZF9hbGwoYmxvY2tkZXZfc3MpCitxc2Rfc3MuYWRkKGJs
b2NrZGV2LCBjaGFyZGV2LCBxbXAsIHFvbSwgcWVtdXV0aWwpCiAKIHN1YmRpcigncWFwaScpCiAK
LS0gCjIuMjYuMgoK


