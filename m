Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523522075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ycf3RDx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523522075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxEZ-0000J9-GJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxC6-0004Mh-2L
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxC4-0001ak-Ij
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+29Q88WMP6bnu7l14pY5RPMQUIG9etzOO7rYlk3+i0=;
 b=Ycf3RDx9DUitke2cT7MHjVAAkCSSyZeKgSTgvF/huODHnbinX+36l1WfjSVEXWfKlp65N2
 nIP49LxVrCLjhKVd+ZlohSJ3FbjNaluAhsoiGo81OmBLi+s/Mez61RxhBme0PgycrW3KvX
 LkNnvIaQ5Gezdv/TsxmxrZhuC72aoII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-DBaj6I-YO3q9wo1WgCihpQ-1; Tue, 19 May 2020 04:01:41 -0400
X-MC-Unique: DBaj6I-YO3q9wo1WgCihpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B664180070E;
 Tue, 19 May 2020 08:01:40 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F1826062D;
 Tue, 19 May 2020 08:01:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] tests/fuzz: Extract pciconfig_fuzz_qos() method
Date: Tue, 19 May 2020 09:00:51 +0100
Message-Id: <20200519080054.146495-6-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKRXh0cmFj
dCB0aGUgZ2VuZXJpYyBwY2ljb25maWdfZnV6el9xb3MoKSBtZXRob2QgZnJvbQppNDQwZnhfZnV6
el9xb3MoKS4gVGhpcyB3aWxsIGhlbHAgdG8gd3JpdGUgdGVzdHMgbm90CnNwZWNpZmljIHRvIHRo
ZSBpNDQwRlggY29udHJvbGxlci4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MTQxNDM0MzMuMTg1Njkt
Ni1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jIHwgMjAg
KysrKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enou
YyBiL3Rlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYwppbmRleCBjMTk3YjAyNmRiLi41NThm
YTE3YzkzIDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMKKysrIGIv
dGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jCkBAIC04NCw3ICs4NCw3IEBAIHN0YXRpYyB2
b2lkIGk0NDBmeF9mdXp6X3F0ZXN0KFFUZXN0U3RhdGUgKnMsCiAgICAgZmx1c2hfZXZlbnRzKHMp
OwogfQogCi1zdGF0aWMgdm9pZCBpNDQwZnhfZnV6el9xb3MoUVRlc3RTdGF0ZSAqcywKK3N0YXRp
YyB2b2lkIHBjaWNvbmZpZ19mdXp6X3FvcyhRVGVzdFN0YXRlICpzLCBRUENJQnVzICpidXMsCiAg
ICAgICAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKkRhdGEsIHNpemVfdCBTaXplKSB7CiAgICAgLyoK
ICAgICAgKiBTYW1lIGFzIGk0NDBmeF9mdXp6X3F0ZXN0LCBidXQgdXNpbmcgUU9TLiBkZXZmbiBp
cyBpbmNvcnBvcmF0ZWQgaW50byB0aGUKQEAgLTk3LDExICs5Nyw2IEBAIHN0YXRpYyB2b2lkIGk0
NDBmeF9mdXp6X3FvcyhRVGVzdFN0YXRlICpzLAogICAgICAgICB1aW50MzJfdCB2YWx1ZTsKICAg
ICB9IGE7CiAKLSAgICBzdGF0aWMgUVBDSUJ1cyAqYnVzOwotICAgIGlmICghYnVzKSB7Ci0gICAg
ICAgIGJ1cyA9IHFwY2lfbmV3X3BjKHMsIGZ1enpfcW9zX2FsbG9jKTsKLSAgICB9Ci0KICAgICB3
aGlsZSAoU2l6ZSA+PSBzaXplb2YoYSkpIHsKICAgICAgICAgbWVtY3B5KCZhLCBEYXRhLCBzaXpl
b2YoYSkpOwogICAgICAgICBzd2l0Y2ggKGEub3Bjb2RlICUgQUNUSU9OX01BWCkgewpAQCAtMTMw
LDYgKzEyNSwxOSBAQCBzdGF0aWMgdm9pZCBpNDQwZnhfZnV6el9xb3MoUVRlc3RTdGF0ZSAqcywK
ICAgICBmbHVzaF9ldmVudHMocyk7CiB9CiAKK3N0YXRpYyB2b2lkIGk0NDBmeF9mdXp6X3FvcyhR
VGVzdFN0YXRlICpzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHVuc2lnbmVk
IGNoYXIgKkRhdGEsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IFNpemUpCit7
CisgICAgc3RhdGljIFFQQ0lCdXMgKmJ1czsKKworICAgIGlmICghYnVzKSB7CisgICAgICAgIGJ1
cyA9IHFwY2lfbmV3X3BjKHMsIGZ1enpfcW9zX2FsbG9jKTsKKyAgICB9CisKKyAgICBwY2ljb25m
aWdfZnV6el9xb3MocywgYnVzLCBEYXRhLCBTaXplKTsKK30KKwogc3RhdGljIHZvaWQgaTQ0MGZ4
X2Z1enpfcW9zX2ZvcmsoUVRlc3RTdGF0ZSAqcywKICAgICAgICAgY29uc3QgdW5zaWduZWQgY2hh
ciAqRGF0YSwgc2l6ZV90IFNpemUpIHsKICAgICBpZiAoZm9yaygpID09IDApIHsKLS0gCjIuMjUu
MwoK


