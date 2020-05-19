Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE5FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960B420709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0wx699M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960B420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5oy-0007GK-Rm
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5ma-0002yq-Mo
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:12:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mW-0002Vn-Vw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589908315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp0y+Zg3ajzpKsP0+NwKrmoN1WDadhwx00K7pgQg8F8=;
 b=M0wx699MizNFBq1HYFNdWxBNgv7Et0AgRhbCXFtbP9qqFcZ8K73Ml6hUem+kpYaEx14Vct
 dOs0sIIFjgEQUoKl16ON4tLqVZKibedaAZaBUAwhp5tiPtVO9pnjVtZSpqaCFHsUO7U/Np
 QPwWzqjyAxf0JiGMVrDIkqX05plmyZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-qvQAiZXwNVOduU4I477xxA-1; Tue, 19 May 2020 13:11:53 -0400
X-MC-Unique: qvQAiZXwNVOduU4I477xxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A601005510;
 Tue, 19 May 2020 17:11:52 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E3550F54;
 Tue, 19 May 2020 17:11:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] block/nvme: don't access CQE after moving cq.head
Date: Tue, 19 May 2020 18:11:34 +0100
Message-Id: <20200519171138.201667-4-stefanha@redhat.com>
In-Reply-To: <20200519171138.201667-1-stefanha@redhat.com>
References: <20200519171138.201667-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8gbm90IGFjY2VzcyBhIENRRSBhZnRlciBpbmNyZW1lbnRpbmcgcS0+Y3EuaGVhZCBhbmQgcmVs
ZWFzaW5nIHEtPmxvY2suCkl0IGlzIHVubGlrZWx5IHRoYXQgdGhpcyBjYXVzZXMgcHJvYmxlbXMg
aW4gcHJhY3RpY2UgYnV0IGl0J3MgYSBsYXRlbnQKYnVnLgoKVGhlIHJlYXNvbiB3aHkgaXQgc2hv
dWxkIGJlIHNhZmUgYXQgdGhlIG1vbWVudCBpcyB0aGF0IGNvbXBsZXRpb24KcHJvY2Vzc2luZyBp
cyBub3QgcmUtZW50cmFudCBhbmQgdGhlIENRIGRvb3JiZWxsIGlzbid0IHdyaXR0ZW4gdW50aWwg
dGhlCmVuZCBvZiBudm1lX3Byb2Nlc3NfY29tcGxldGlvbigpLgoKTWFrZSB0aGlzIGNoYW5nZSBu
b3cgYmVjYXVzZSBRRU1VIGV4cGVjdHMgY29tcGxldGlvbiBwcm9jZXNzaW5nIHRvIGJlCnJlLWVu
dHJhbnQgYW5kIGxhdGVyIHBhdGNoZXMgd2lsbCBkbyB0aGF0LgoKU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDUg
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggNTI4NjIyNzA3NC4u
NmJmNThiYzZhYSAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpA
QCAtMzIxLDExICszMjEsMTQgQEAgc3RhdGljIGJvb2wgbnZtZV9wcm9jZXNzX2NvbXBsZXRpb24o
QkRSVk5WTWVTdGF0ZSAqcywgTlZNZVF1ZXVlUGFpciAqcSkKICAgICBxLT5idXN5ID0gdHJ1ZTsK
ICAgICBhc3NlcnQocS0+aW5mbGlnaHQgPj0gMCk7CiAgICAgd2hpbGUgKHEtPmluZmxpZ2h0KSB7
CisgICAgICAgIGludCByZXQ7CiAgICAgICAgIGludDE2X3QgY2lkOworCiAgICAgICAgIGMgPSAo
TnZtZUNxZSAqKSZxLT5jcS5xdWV1ZVtxLT5jcS5oZWFkICogTlZNRV9DUV9FTlRSWV9CWVRFU107
CiAgICAgICAgIGlmICgobGUxNl90b19jcHUoYy0+c3RhdHVzKSAmIDB4MSkgPT0gcS0+Y3FfcGhh
c2UpIHsKICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICB9CisgICAgICAgIHJldCA9IG52bWVf
dHJhbnNsYXRlX2Vycm9yKGMpOwogICAgICAgICBxLT5jcS5oZWFkID0gKHEtPmNxLmhlYWQgKyAx
KSAlIE5WTUVfUVVFVUVfU0laRTsKICAgICAgICAgaWYgKCFxLT5jcS5oZWFkKSB7CiAgICAgICAg
ICAgICBxLT5jcV9waGFzZSA9ICFxLT5jcV9waGFzZTsKQEAgLTM0NCw3ICszNDcsNyBAQCBzdGF0
aWMgYm9vbCBudm1lX3Byb2Nlc3NfY29tcGxldGlvbihCRFJWTlZNZVN0YXRlICpzLCBOVk1lUXVl
dWVQYWlyICpxKQogICAgICAgICBwcmVxLT5idXN5ID0gZmFsc2U7CiAgICAgICAgIHByZXEtPmNi
ID0gcHJlcS0+b3BhcXVlID0gTlVMTDsKICAgICAgICAgcWVtdV9tdXRleF91bmxvY2soJnEtPmxv
Y2spOwotICAgICAgICByZXEuY2IocmVxLm9wYXF1ZSwgbnZtZV90cmFuc2xhdGVfZXJyb3IoYykp
OworICAgICAgICByZXEuY2IocmVxLm9wYXF1ZSwgcmV0KTsKICAgICAgICAgcWVtdV9tdXRleF9s
b2NrKCZxLT5sb2NrKTsKICAgICAgICAgcS0+aW5mbGlnaHQtLTsKICAgICAgICAgcHJvZ3Jlc3Mg
PSB0cnVlOwotLSAKMi4yNS4zCgo=


