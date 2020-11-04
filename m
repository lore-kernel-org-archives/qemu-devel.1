Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D7A2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Paoovf3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D7A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKo3-0000xa-9X
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKaw-0007rK-K7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKao-0008Hy-Na
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHvoV2B3WQz+lxhYN6O++y+eS6CLPSgx/ZnTCxfcSRc=;
 b=Paoovf3q0LCFELMxFBzHeo54cwkuhuwRs9fiVNWEZXCFcRbNXOD4RpfXvjWCQk3lXlw6Is
 2EWHmKmCLmWakv6Yud2Z2Daacuxqj6Ba7sfSebNZA7Drd8hm1ZvgnCIG4SIwMgluEgxLiL
 6bzNViO5hkDO52NOQibwvP/JnxDTZQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-01OgfL0VPa6UVujx8NoT_w-1; Wed, 04 Nov 2020 10:20:53 -0500
X-MC-Unique: 01OgfL0VPa6UVujx8NoT_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D41C16D58E;
 Wed,  4 Nov 2020 15:20:51 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0B161177;
 Wed,  4 Nov 2020 15:20:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/33] block/nvme: Correct minimum device page size
Date: Wed,  4 Nov 2020 15:18:15 +0000
Message-Id: <20201104151828.405824-21-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2hpbGUg
dHJ5aW5nIHRvIHNpbXBsaWZ5IHRoZSBjb2RlIHVzaW5nIGEgbWFjcm8sIHdlIGZvcmdvdAp0aGUg
MTItYml0IHNoaWZ0Li4uIENvcnJlY3QgdGhhdC4KCkZpeGVzOiBmYWQxZWI2ODg2MiAoImJsb2Nr
L252bWU6IFVzZSByZWdpc3RlciBkZWZpbml0aW9ucyBmcm9tICdibG9jay9udm1lLmgnIikKUmVw
b3J0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMjkwOTMzMDYuMTA2Mzg3OS0x
OS1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQu
Y29tPgotLS0KIGJsb2NrL252bWUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252
bWUuYwppbmRleCBiYjc1NDQ4YTA5Li5iZDM4NjBhYzRlIDEwMDY0NAotLS0gYS9ibG9jay9udm1l
LmMKKysrIGIvYmxvY2svbnZtZS5jCkBAIC03NTUsNyArNzU1LDcgQEAgc3RhdGljIGludCBudm1l
X2luaXQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5hbWVz
cGFjZSwKICAgICAgICAgZ290byBvdXQ7CiAgICAgfQogCi0gICAgcy0+cGFnZV9zaXplID0gTUFY
KDQwOTYsIDEgPDwgTlZNRV9DQVBfTVBTTUlOKGNhcCkpOworICAgIHMtPnBhZ2Vfc2l6ZSA9IDF1
IDw8ICgxMiArIE5WTUVfQ0FQX01QU01JTihjYXApKTsKICAgICBzLT5kb29yYmVsbF9zY2FsZSA9
ICg0IDw8IE5WTUVfQ0FQX0RTVFJEKGNhcCkpIC8gc2l6ZW9mKHVpbnQzMl90KTsKICAgICBicy0+
Ymwub3B0X21lbV9hbGlnbm1lbnQgPSBzLT5wYWdlX3NpemU7CiAgICAgYnMtPmJsLnJlcXVlc3Rf
YWxpZ25tZW50ID0gcy0+cGFnZV9zaXplOwotLSAKMi4yOC4wCgo=


