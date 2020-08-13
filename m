Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C44620716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLQ01ZFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C44620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k680B-0003QJ-RQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67um-0002Hw-CS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:44:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39889
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67uk-0002VS-IE
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597304680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMrDvCPiLS3qactv2cpG6RZ0nflNlVJiAcKxN681dHU=;
 b=GLQ01ZFWeoH5IB40qrRZpibBXKVesT6TRBRZslD0J8oVoFtgMvapyR6NsnTsQPCF+Ewn/s
 BWG3KSnZUcKvLDSuYgDOgmZ6em3teF7hpgtgrztsy/qqcEzRkb/up8E/ZsUSXadrSOJFMG
 SIIa0f0+EUOJ9tLUBQMwMH94D+H91zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-PfXKr2MENmyJUZxR3QpR9w-1; Thu, 13 Aug 2020 03:44:37 -0400
X-MC-Unique: PfXKr2MENmyJUZxR3QpR9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C055107ACCA;
 Thu, 13 Aug 2020 07:44:34 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 584DF10013D5;
 Thu, 13 Aug 2020 07:44:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] scripts/tracetool: Fix dtrace generation for macOS
Date: Thu, 13 Aug 2020 06:22:49 +0100
Message-Id: <20200813052257.226142-2-stefanha@redhat.com>
In-Reply-To: <20200813052257.226142-1-stefanha@redhat.com>
References: <20200813052257.226142-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUm9tYW4gQm9sc2hha292IDxyLmJvbHNoYWtvdkB5YWRyby5jb20+CgpkdHJhY2UgVVNE
VCBpcyBmdWxseSBzdXBwb3J0ZWQgc2luY2UgT1MgWCAxMC42LiBUaGVyZSBhcmUgYSBmZXcKcGVj
dWxpYXJpdGllcyBjb21wYXJlZCB0byBvdGhlciBkdHJhY2UgZmxhdm9ycy4KCjEuIEl0IGRvZXNu
J3QgYWNjZXB0IGVtcHR5IGZpbGVzLgoyLiBJdCBkb2Vzbid0IHJlY29nbml6ZSBib29sIHR5cGUg
YnV0IGFjY2VwdHMgQzk5IF9Cb29sLgozLiBJdCBjb252ZXJ0cyBpbnQ4X3QgKiBpbiBwcm9iZSBw
b2ludHMgdG8gY2hhciAqIGluCiAgIGhlYWRlciBmaWxlcyBhbmQgaW50cm9kdWNlcyBbLVdwb2lu
dGVyLXNpZ25dIHdhcm5pbmcuCgpDYzogQ2FtZXJvbiBFc2ZhaGFuaSA8ZGlydHlAYXBwbGUuY29t
PgpTaWduZWQtb2ZmLWJ5OiBSb21hbiBCb2xzaGFrb3YgPHIuYm9sc2hha292QHlhZHJvLmNvbT4K
UmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KTWVzc2Fn
ZS1pZDogMjAyMDA3MTcwOTM1MTcuNzMzOTctMi1yLmJvbHNoYWtvdkB5YWRyby5jb20KU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHNjcmlw
dHMvdHJhY2V0b29sL2Zvcm1hdC9kLnB5IHwgMTUgKysrKysrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Njcmlw
dHMvdHJhY2V0b29sL2Zvcm1hdC9kLnB5IGIvc2NyaXB0cy90cmFjZXRvb2wvZm9ybWF0L2QucHkK
aW5kZXggMGFmYjVmM2Y0Ny4uMzUzNzIyZjg5YyAxMDA2NDQKLS0tIGEvc2NyaXB0cy90cmFjZXRv
b2wvZm9ybWF0L2QucHkKKysrIGIvc2NyaXB0cy90cmFjZXRvb2wvZm9ybWF0L2QucHkKQEAgLTEz
LDYgKzEzLDcgQEAgX19lbWFpbF9fICAgICAgPSAic3RlZmFuaGFAcmVkaGF0LmNvbSIKIAogCiBm
cm9tIHRyYWNldG9vbCBpbXBvcnQgb3V0Citmcm9tIHN5cyBpbXBvcnQgcGxhdGZvcm0KIAogCiAj
IFJlc2VydmVkIGtleXdvcmRzIGZyb20KQEAgLTM0LDcgKzM1LDggQEAgZGVmIGdlbmVyYXRlKGV2
ZW50cywgYmFja2VuZCwgZ3JvdXApOgogCiAgICAgIyBTeXN0ZW1UYXAncyBkdHJhY2UoMSkgd2Fy
bnMgYWJvdXQgZW1wdHkgInByb3ZpZGVyIHFlbXUge30iIGJ1dCBpcyBoYXBweQogICAgICMgd2l0
aCBhbiBlbXB0eSBmaWxlLiAgQXZvaWQgdGhlIHdhcm5pbmcuCi0gICAgaWYgbm90IGV2ZW50czoK
KyAgICAjIEJ1dCBkdHJhY2Ugb24gbWFjT1MgY2FuJ3QgZGVhbCB3aXRoIGVtcHR5IGZpbGVzLgor
ICAgIGlmIG5vdCBldmVudHMgYW5kIHBsYXRmb3JtICE9ICJkYXJ3aW4iOgogICAgICAgICByZXR1
cm4KIAogICAgIG91dCgnLyogVGhpcyBmaWxlIGlzIGF1dG9nZW5lcmF0ZWQgYnkgdHJhY2V0b29s
LCBkbyBub3QgZWRpdC4gKi8nCkBAIC00NCw2ICs0NiwxNyBAQCBkZWYgZ2VuZXJhdGUoZXZlbnRz
LCBiYWNrZW5kLCBncm91cCk6CiAgICAgZm9yIGUgaW4gZXZlbnRzOgogICAgICAgICBhcmdzID0g
W10KICAgICAgICAgZm9yIHR5cGVfLCBuYW1lIGluIGUuYXJnczoKKyAgICAgICAgICAgIGlmIHBs
YXRmb3JtID09ICJkYXJ3aW4iOgorICAgICAgICAgICAgICAgICMgbWFjT1MgZHRyYWNlIGFjY2Vw
dHMgb25seSBDOTkgX0Jvb2wKKyAgICAgICAgICAgICAgICBpZiB0eXBlXyA9PSAnYm9vbCc6Cisg
ICAgICAgICAgICAgICAgICAgIHR5cGVfID0gJ19Cb29sJworICAgICAgICAgICAgICAgIGlmIHR5
cGVfID09ICdib29sIConOgorICAgICAgICAgICAgICAgICAgICB0eXBlXyA9ICdfQm9vbCAqJwor
ICAgICAgICAgICAgICAgICMgSXQgY29udmVydHMgaW50OF90ICogaW4gcHJvYmUgcG9pbnRzIHRv
IGNoYXIgKiBpbiBoZWFkZXIKKyAgICAgICAgICAgICAgICAjIGZpbGVzIGFuZCBpbnRyb2R1Y2Vz
IFstV3BvaW50ZXItc2lnbl0gd2FybmluZy4KKyAgICAgICAgICAgICAgICAjIEF2b2lkIGl0IGJ5
IGNoYW5naW5nIHByb2JlIHR5cGUgdG8gc2lnbmVkIGNoYXIgKiBiZWZvcmVoYW5kLgorICAgICAg
ICAgICAgICAgIGlmIHR5cGVfID09ICdpbnQ4X3QgKic6CisgICAgICAgICAgICAgICAgICAgIHR5
cGVfID0gJ3NpZ25lZCBjaGFyIConCiAgICAgICAgICAgICBpZiBuYW1lIGluIFJFU0VSVkVEX1dP
UkRTOgogICAgICAgICAgICAgICAgIG5hbWUgKz0gJ18nCiAgICAgICAgICAgICBhcmdzLmFwcGVu
ZCh0eXBlXyArICcgJyArIG5hbWUpCi0tIAoyLjI2LjIKCg==


