Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7274BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3045E20707
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xo3i6z1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3045E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIwO-0004hK-Cx
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuH-0001lS-Q7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIuG-0004J7-4l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsReAXs+dPUL8HFnO/3zojF1/6SDvYdyCpVVhkLzaZ4=;
 b=Xo3i6z1X2qNl7MEPrHdsqQeTztbEL0pqL2Q+eE9d5h8JuuMVn7vuxkVeHLk0VjOheKgrzn
 cv9Rj+8d8zKbmSZCQGvDkxViFQY0EpLfZCQ1K+7QiuCyDrJOwB702GyqLjpGIutf9ooMek
 yqMqizRtLqqMhK1Agz1pA1HXYCh2j6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-AhnFzwObOaa3zFkJfHZTHQ-1; Thu, 27 Aug 2020 10:29:27 -0400
X-MC-Unique: AhnFzwObOaa3zFkJfHZTHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32EF8801AE8;
 Thu, 27 Aug 2020 14:29:26 +0000 (UTC)
Received: from localhost (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE1F95C1D0;
 Thu, 27 Aug 2020 14:29:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tracetool: add out_lineno and out_next_lineno to out()
Date: Thu, 27 Aug 2020 15:29:13 +0100
Message-Id: <20200827142915.108730-3-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-1-stefanha@redhat.com>
References: <20200827142915.108730-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSB0aGUgb3V0cHV0IGZpbGUgbGluZSBudW1iZXIgYW5kIG5leHQgbGluZSBudW1iZXIgYXZh
aWxhYmxlIHRvCm91dCgpLgoKQSBsYXRlciBwYXRjaCB3aWxsIHVzZSB0aGlzIHRvIGltcHJvdmUg
ZXJyb3IgbWVzc2FnZXMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQogc2NyaXB0cy90cmFjZXRvb2wvX19pbml0X18ucHkgfCAxMCArKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc2NyaXB0cy90cmFjZXRvb2wvX19pbml0X18ucHkgYi9zY3JpcHRzL3RyYWNl
dG9vbC9fX2luaXRfXy5weQppbmRleCA5ODEwNGZhNTBlLi5lNGVlNGQ1ZTYxIDEwMDY0NAotLS0g
YS9zY3JpcHRzL3RyYWNldG9vbC9fX2luaXRfXy5weQorKysgYi9zY3JpcHRzL3RyYWNldG9vbC9f
X2luaXRfXy5weQpAQCAtMzEsNiArMzEsNyBAQCBkZWYgZXJyb3IoKmxpbmVzKToKICAgICBzeXMu
ZXhpdCgxKQogCiAKK291dF9saW5lbm8gPSAxCiBvdXRfZmlsZW5hbWUgPSAnPG5vbmU+Jwogb3V0
X2ZvYmogPSBzeXMuc3Rkb3V0CiAKQEAgLTQ1LDEyICs0NiwxOSBAQCBkZWYgb3V0KCpsaW5lcywg
Kiprd2FyZ3MpOgogICAgIFlvdSBjYW4gdXNlIGt3YXJncyBhcyBhIHNob3J0aGFuZCBmb3IgbWFw
cGluZyB2YXJpYWJsZXMgd2hlbiBmb3JtYXRpbmcgYWxsCiAgICAgdGhlIHN0cmluZ3MgaW4gbGlu
ZXMuCiAKLSAgICBUaGUgJ291dF9maWxlbmFtZScga3dhcmcgaXMgYXV0b21hdGljYWxseSBhZGRl
ZCB3aXRoIHRoZSBvdXRwdXQgZmlsZW5hbWUuCisgICAgVGhlICdvdXRfbGluZW5vJyBrd2FyZyBp
cyBhdXRvbWF0aWNhbGx5IGFkZGVkIHRvIHJlZmxlY3QgdGhlIGN1cnJlbnQgb3V0cHV0CisgICAg
ZmlsZSBsaW5lIG51bWJlci4gVGhlICdvdXRfbmV4dF9saW5lbm8nIGt3YXJnIGlzIGFsc28gYXV0
b21hdGljYWxseSBhZGRlZAorICAgIHdpdGggdGhlIG5leHQgb3V0cHV0IGxpbmUgbnVtYmVyLiBU
aGUgJ291dF9maWxlbmFtZScga3dhcmcgaXMgYXV0b21hdGljYWxseQorICAgIGFkZGVkIHdpdGgg
dGhlIG91dHB1dCBmaWxlbmFtZS4KICAgICAiIiIKKyAgICBnbG9iYWwgb3V0X2xpbmVubwogICAg
IG91dHB1dCA9IFtdCiAgICAgZm9yIGwgaW4gbGluZXM6CisgICAgICAgIGt3YXJnc1snb3V0X2xp
bmVubyddID0gb3V0X2xpbmVubworICAgICAgICBrd2FyZ3NbJ291dF9uZXh0X2xpbmVubyddID0g
b3V0X2xpbmVubyArIDEKICAgICAgICAga3dhcmdzWydvdXRfZmlsZW5hbWUnXSA9IG91dF9maWxl
bmFtZQogICAgICAgICBvdXRwdXQuYXBwZW5kKGwgJSBrd2FyZ3MpCisgICAgICAgIG91dF9saW5l
bm8gKz0gMQogCiAgICAgb3V0X2ZvYmoud3JpdGVsaW5lcygiXG4iLmpvaW4ob3V0cHV0KSArICJc
biIpCiAKLS0gCjIuMjYuMgoK


