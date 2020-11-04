Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A258C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF212074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVoWHBQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF212074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKkO-0004Dx-MJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKaL-0007Ux-53
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKaI-000857-Db
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmZBS99iFDnZn7fva4LVrBMSpGF1u0oIe5AGDQxIRi0=;
 b=TVoWHBQ/xKyi7IZl6gNw+gq/c1wOML0WhuO354u2vStVm7UOYzha708/O/cxV3Ts/DGE/S
 X97nqpa6BC50doQPvkcbwJi+vm8oKfhodsh42EKyR8JxQ5xcfCf9dBIEM8Q2YqVla2/53r
 w5dnlqPENzMPvy6l2W3VkP1SOymBXCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-C0lmJPs9MImVDsI707OigA-1; Wed, 04 Nov 2020 10:20:20 -0500
X-MC-Unique: C0lmJPs9MImVDsI707OigA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 922EE804763;
 Wed,  4 Nov 2020 15:20:18 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC2C55B4C7;
 Wed,  4 Nov 2020 15:20:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/33] block/nvme: Introduce Completion Queue definitions
Date: Wed,  4 Nov 2020 15:18:09 +0000
Message-Id: <20201104151828.405824-15-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKUmVuYW1l
IFN1Ym1pc3Npb24gUXVldWUgZmxhZ3Mgd2l0aCAnU3EnIHRvIGRpZmZlcmVudGlhdGUKc3VibWlz
c2lvbiBxdWV1ZSBmbGFncyBmcm9tIGNvbW1hbmQgcXVldWUgZmxhZ3MsIGFuZCBpbnRyb2R1Y2UK
Q29tcGxldGlvbiBRdWV1ZSBmbGFnIGRlZmluaXRpb25zLgoKUmV2aWV3ZWQtYnk6IEVyaWMgQXVn
ZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMjkwOTMzMDYuMTA2Mzg3OS0xMy1waGlsbWRA
cmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgotLS0K
IGluY2x1ZGUvYmxvY2svbnZtZS5oIHwgMTggKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2Jsb2NrL252bWUuaCBiL2luY2x1ZGUvYmxvY2svbnZtZS5oCmluZGV4IDhhNDZkOWNmMDEu
LjNlMDJkOWNhOTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmxvY2svbnZtZS5oCisrKyBiL2luY2x1
ZGUvYmxvY2svbnZtZS5oCkBAIC01MDEsNiArNTAxLDExIEBAIHR5cGVkZWYgc3RydWN0IFFFTVVf
UEFDS0VEIE52bWVDcmVhdGVDcSB7CiAjZGVmaW5lIE5WTUVfQ1FfRkxBR1NfUEMoY3FfZmxhZ3Mp
ICAoY3FfZmxhZ3MgJiAweDEpCiAjZGVmaW5lIE5WTUVfQ1FfRkxBR1NfSUVOKGNxX2ZsYWdzKSAo
KGNxX2ZsYWdzID4+IDEpICYgMHgxKQogCitlbnVtIE52bWVGbGFnc0NxIHsKKyAgICBOVk1FX0NR
X1BDICAgICAgICAgID0gMSwKKyAgICBOVk1FX0NRX0lFTiAgICAgICAgID0gMiwKK307CisKIHR5
cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIE52bWVDcmVhdGVTcSB7CiAgICAgdWludDhfdCAgICAg
b3Bjb2RlOwogICAgIHVpbnQ4X3QgICAgIGZsYWdzOwpAQCAtNTE4LDEyICs1MjMsMTMgQEAgdHlw
ZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZUNyZWF0ZVNxIHsKICNkZWZpbmUgTlZNRV9TUV9G
TEFHU19QQyhzcV9mbGFncykgICAgICAoc3FfZmxhZ3MgJiAweDEpCiAjZGVmaW5lIE5WTUVfU1Ff
RkxBR1NfUVBSSU8oc3FfZmxhZ3MpICAgKChzcV9mbGFncyA+PiAxKSAmIDB4MykKIAotZW51bSBO
dm1lUXVldWVGbGFncyB7Ci0gICAgTlZNRV9RX1BDICAgICAgICAgICA9IDEsCi0gICAgTlZNRV9R
X1BSSU9fVVJHRU5UICA9IDAsCi0gICAgTlZNRV9RX1BSSU9fSElHSCAgICA9IDEsCi0gICAgTlZN
RV9RX1BSSU9fTk9STUFMICA9IDIsCi0gICAgTlZNRV9RX1BSSU9fTE9XICAgICA9IDMsCitlbnVt
IE52bWVGbGFnc1NxIHsKKyAgICBOVk1FX1NRX1BDICAgICAgICAgID0gMSwKKworICAgIE5WTUVf
U1FfUFJJT19VUkdFTlQgPSAwLAorICAgIE5WTUVfU1FfUFJJT19ISUdIICAgPSAxLAorICAgIE5W
TUVfU1FfUFJJT19OT1JNQUwgPSAyLAorICAgIE5WTUVfU1FfUFJJT19MT1cgICAgPSAzLAogfTsK
IAogdHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZUlkZW50aWZ5IHsKLS0gCjIuMjguMAoK


