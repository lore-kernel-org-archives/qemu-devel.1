Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B01C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB5E21527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB+hrEM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5E21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY2R-0004a4-FW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1P-0002aL-TJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1O-0002mx-3h
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59rIalcZrwHt0NJUqAA9C7WNDBbvVuB3dbh12aNtP4M=;
 b=YB+hrEM7Wqxs332dsei7EUeiwC865tlGD/OeTR7c9hzmIIqFp2vpMSl18OEDGmFHEccbL5
 A0Pl+mujCjTOLuv7Puz+W37c3wEsiCXPeBw6s+sqNvYH+k40aYVra5G7OXnCiMsHOrZr+O
 BAKyUF51ZLr/jZ7bVOkwYd2VpFAtd+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-KtnRcEhYN7Gqr5ve9sA4AQ-1; Wed, 17 Jun 2020 09:22:25 -0400
X-MC-Unique: KtnRcEhYN7Gqr5ve9sA4AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C117E84B871;
 Wed, 17 Jun 2020 13:22:24 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE5B512FE;
 Wed, 17 Jun 2020 13:22:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] block/nvme: don't access CQE after moving cq.head
Date: Wed, 17 Jun 2020 14:21:57 +0100
Message-Id: <20200617132201.1832152-4-stefanha@redhat.com>
In-Reply-To: <20200617132201.1832152-1-stefanha@redhat.com>
References: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU2VyZ2lvIExv
cGV6IDxzbHBAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgfCA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYmxv
Y2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IGQ1NjdlY2UzZjQuLjM0NDg5MzgxMWEgMTAw
NjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9udm1lLmMKQEAgLTMyMSwxMSArMzIx
LDE0IEBAIHN0YXRpYyBib29sIG52bWVfcHJvY2Vzc19jb21wbGV0aW9uKEJEUlZOVk1lU3RhdGUg
KnMsIE5WTWVRdWV1ZVBhaXIgKnEpCiAgICAgcS0+YnVzeSA9IHRydWU7CiAgICAgYXNzZXJ0KHEt
PmluZmxpZ2h0ID49IDApOwogICAgIHdoaWxlIChxLT5pbmZsaWdodCkgeworICAgICAgICBpbnQg
cmV0OwogICAgICAgICBpbnQxNl90IGNpZDsKKwogICAgICAgICBjID0gKE52bWVDcWUgKikmcS0+
Y3EucXVldWVbcS0+Y3EuaGVhZCAqIE5WTUVfQ1FfRU5UUllfQllURVNdOwogICAgICAgICBpZiAo
KGxlMTZfdG9fY3B1KGMtPnN0YXR1cykgJiAweDEpID09IHEtPmNxX3BoYXNlKSB7CiAgICAgICAg
ICAgICBicmVhazsKICAgICAgICAgfQorICAgICAgICByZXQgPSBudm1lX3RyYW5zbGF0ZV9lcnJv
cihjKTsKICAgICAgICAgcS0+Y3EuaGVhZCA9IChxLT5jcS5oZWFkICsgMSkgJSBOVk1FX1FVRVVF
X1NJWkU7CiAgICAgICAgIGlmICghcS0+Y3EuaGVhZCkgewogICAgICAgICAgICAgcS0+Y3FfcGhh
c2UgPSAhcS0+Y3FfcGhhc2U7CkBAIC0zNDQsNyArMzQ3LDcgQEAgc3RhdGljIGJvb2wgbnZtZV9w
cm9jZXNzX2NvbXBsZXRpb24oQkRSVk5WTWVTdGF0ZSAqcywgTlZNZVF1ZXVlUGFpciAqcSkKICAg
ICAgICAgcHJlcS0+YnVzeSA9IGZhbHNlOwogICAgICAgICBwcmVxLT5jYiA9IHByZXEtPm9wYXF1
ZSA9IE5VTEw7CiAgICAgICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZxLT5sb2NrKTsKLSAgICAgICAg
cmVxLmNiKHJlcS5vcGFxdWUsIG52bWVfdHJhbnNsYXRlX2Vycm9yKGMpKTsKKyAgICAgICAgcmVx
LmNiKHJlcS5vcGFxdWUsIHJldCk7CiAgICAgICAgIHFlbXVfbXV0ZXhfbG9jaygmcS0+bG9jayk7
CiAgICAgICAgIHEtPmluZmxpZ2h0LS07CiAgICAgICAgIHByb2dyZXNzID0gdHJ1ZTsKLS0gCjIu
MjYuMgoK


