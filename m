Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D163DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F54C20691
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArGFSEM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54C20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUo9Z-0001hg-0F
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUo8T-00019Z-6R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUo8R-0007sz-Hx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603186850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pFmRnUj4P6Idat7sFgatzfJgjw1WDGMML1e6wmyH/fI=;
 b=ArGFSEM+y6QytqOcDSUnxbYtvTFr0mA8RWVO2PiruNKL+4pqFzvePyp7MNEKdfyLx4koHE
 Bbf1U9+w8BdajWOg4JrqYN80TDB9I1Zpolup7B3YhNMfLPcd9rvyHmH/ORe/dAgt4TvX4z
 zPg7moY1N8zzGXFJya+Hn5n8+fJ3/EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-OeXtIrDSMt24tFC5hVxWuA-1; Tue, 20 Oct 2020 05:40:48 -0400
X-MC-Unique: OeXtIrDSMt24tFC5hVxWuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92CC76408E
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:40:47 +0000 (UTC)
Received: from localhost (ovpn-115-35.ams2.redhat.com [10.36.115.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78E3E5D9D2;
 Tue, 20 Oct 2020 09:40:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/tracetool: silence SystemTap dtrace(1) long long
 warnings
Date: Tue, 20 Oct 2020 10:40:43 +0100
Message-Id: <20201020094043.159935-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U3lzdGVtVGFwJ3MgZHRyYWNlKDEpIHByaW50cyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgd2hlbiBp
dCBlbmNvdW50ZXJzCmxvbmcgbG9uZyBhcmd1bWVudHM6CgogIFdhcm5pbmc6IC91c3IvYmluL2R0
cmFjZTp0cmFjZS90cmFjZS1kdHJhY2UtaHdfdmlydGlvLmR0cmFjZTo3Njogc3ludGF4IGVycm9y
IG5lYXI6CiAgcHJvYmUgdmhvc3RfdmRwYV9kZXZfc3RhcnQKCiAgV2FybmluZzogUHJvY2VlZGlu
ZyBhcyBpZiAtLW5vLXB5cGFyc2luZyB3YXMgZ2l2ZW4uCgpVc2UgdGhlIHVpbnQ2NF90IGFuZCBp
bnQ2NF90IHR5cGVzLCByZXNwZWN0aXZlbHkuIFRoaXMgd29ya3Mgd2l0aCBhbGwKaG9zdCBDUFUg
MzItIGFuZCA2NC1iaXQgZGF0YSBtb2RlbHMgKElMUDMyLCBMUDY0LCBhbmQgTExQNjQpIHRoYXQg
UUVNVQpzdXBwb3J0cy4KClJlcG9ydGVkLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJl
ZGhhdC5jb20+ClN1Z2dlc3RlZC1ieTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVk
aGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgotLS0KIHNjcmlwdHMvdHJhY2V0b29sL2Zvcm1hdC9kLnB5IHwgNiArKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zY3JpcHRzL3RyYWNldG9v
bC9mb3JtYXQvZC5weSBiL3NjcmlwdHMvdHJhY2V0b29sL2Zvcm1hdC9kLnB5CmluZGV4IDM1Mzcy
MmY4OWMuLmViZmI3MTQyMDAgMTAwNjQ0Ci0tLSBhL3NjcmlwdHMvdHJhY2V0b29sL2Zvcm1hdC9k
LnB5CisrKyBiL3NjcmlwdHMvdHJhY2V0b29sL2Zvcm1hdC9kLnB5CkBAIC01Nyw2ICs1NywxMiBA
QCBkZWYgZ2VuZXJhdGUoZXZlbnRzLCBiYWNrZW5kLCBncm91cCk6CiAgICAgICAgICAgICAgICAg
IyBBdm9pZCBpdCBieSBjaGFuZ2luZyBwcm9iZSB0eXBlIHRvIHNpZ25lZCBjaGFyICogYmVmb3Jl
aGFuZC4KICAgICAgICAgICAgICAgICBpZiB0eXBlXyA9PSAnaW50OF90IConOgogICAgICAgICAg
ICAgICAgICAgICB0eXBlXyA9ICdzaWduZWQgY2hhciAqJworCisgICAgICAgICAgICAjIFN5c3Rl
bVRhcCBkdHJhY2UoMSkgZW1pdHMgYSB3YXJuaW5nIHdoZW4gbG9uZyBsb25nIGlzIHVzZWQKKyAg
ICAgICAgICAgIHR5cGVfID0gdHlwZV8ucmVwbGFjZSgndW5zaWduZWQgbG9uZyBsb25nJywgJ3Vp
bnQ2NF90JykKKyAgICAgICAgICAgIHR5cGVfID0gdHlwZV8ucmVwbGFjZSgnc2lnbmVkIGxvbmcg
bG9uZycsICdpbnQ2NF90JykKKyAgICAgICAgICAgIHR5cGVfID0gdHlwZV8ucmVwbGFjZSgnbG9u
ZyBsb25nJywgJ2ludDY0X3QnKQorCiAgICAgICAgICAgICBpZiBuYW1lIGluIFJFU0VSVkVEX1dP
UkRTOgogICAgICAgICAgICAgICAgIG5hbWUgKz0gJ18nCiAgICAgICAgICAgICBhcmdzLmFwcGVu
ZCh0eXBlXyArICcgJyArIG5hbWUpCi0tIAoyLjI2LjIKCg==


