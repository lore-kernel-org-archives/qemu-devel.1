Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB7FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25DF2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avreBh9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25DF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKnE-0008W0-Ux
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKaj-0007mL-L1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKag-0008C7-41
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiVtIXdwQ9KVMu0FHvAuY0DkhOuVMD1KuqG5i65tga4=;
 b=avreBh9xUUWRCFuODHo2/kce78l4UWw8UQ6pOvEXs306AQsYyrmwRSpkrfh5xRCD9xSeON
 1+TSSv9Z+NjXWz8bqqvLDo766DDiVKrvFVjkSHmTTYd9DKGZNyne+rdva88lexEISnNyBj
 5s0Qite4ZvSzkv5yCZaspXnhWBaOADc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-MoXFsoAfPsShyPViThmXOg-1; Wed, 04 Nov 2020 10:20:46 -0500
X-MC-Unique: MoXFsoAfPsShyPViThmXOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 598428030A8;
 Wed,  4 Nov 2020 15:20:44 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EED9D5D9CC;
 Wed,  4 Nov 2020 15:20:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/33] block/nvme: Set request_alignment at initialization
Date: Wed,  4 Nov 2020 15:18:14 +0000
Message-Id: <20201104151828.405824-20-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKQ29tbWl0
IGJkZDZhOTBhOWU1ICgiYmxvY2s6IEFkZCBWRklPIGJhc2VkIE5WTWUgZHJpdmVyIikKc2V0cyB0
aGUgcmVxdWVzdF9hbGlnbm1lbnQgaW4gbnZtZV9yZWZyZXNoX2xpbWl0cygpLgpGb3IgY29uc2lz
dGVuY3ksIGFsc28gc2V0IGl0IGR1cmluZyBpbml0aWFsaXphdGlvbi4KClJlcG9ydGVkLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMTgtcGhpbG1k
QHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0t
CiBibG9jay9udm1lLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlm
ZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCBjZDg3NTU1NWNhLi5i
Yjc1NDQ4YTA5IDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxvY2svbnZtZS5jCkBA
IC03NTgsNiArNzU4LDcgQEAgc3RhdGljIGludCBudm1lX2luaXQoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5hbWVzcGFjZSwKICAgICBzLT5wYWdlX3NpemUg
PSBNQVgoNDA5NiwgMSA8PCBOVk1FX0NBUF9NUFNNSU4oY2FwKSk7CiAgICAgcy0+ZG9vcmJlbGxf
c2NhbGUgPSAoNCA8PCBOVk1FX0NBUF9EU1RSRChjYXApKSAvIHNpemVvZih1aW50MzJfdCk7CiAg
ICAgYnMtPmJsLm9wdF9tZW1fYWxpZ25tZW50ID0gcy0+cGFnZV9zaXplOworICAgIGJzLT5ibC5y
ZXF1ZXN0X2FsaWdubWVudCA9IHMtPnBhZ2Vfc2l6ZTsKICAgICB0aW1lb3V0X21zID0gTUlOKDUw
MCAqIE5WTUVfQ0FQX1RPKGNhcCksIDMwMDAwKTsKIAogICAgIC8qIFJlc2V0IGRldmljZSB0byBn
ZXQgYSBjbGVhbiBzdGF0ZS4gKi8KLS0gCjIuMjguMAoK


