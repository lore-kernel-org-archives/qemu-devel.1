Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B224C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EF22076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fbGGrAS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EF22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Sh-0006i5-Uk
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kY9Ms-0000ib-P6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:57:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32195)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kY9Mq-0001qP-99
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1603983452; x=1635519452;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ub3X3nmwwI9EnNpGgNhf7oN3l+qi7oBFf2GMODdEW6U=;
 b=fbGGrAS+zPIpNiYQUYKqPHkno/ZnxfJxXLuIxASW9pkwZvMdYHZdGkUt
 kEuvxblPuRtCyAm9WUZ2b/0YvvfxNHDX+G5Zc0sSfICY3tfAkQNEuUSyX
 8TR2ZIc3FfBF27qe66ZFrh5kfBKDiK1v70WqZTcs+GstahHEtUAnK0AnN 8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Oct 2020 07:57:30 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 29 Oct 2020 07:57:29 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 70BD140F4; Thu, 29 Oct 2020 09:57:29 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu/int128: Add int128_or()
Date: Thu, 29 Oct 2020 09:57:26 -0500
Message-Id: <1603983447-27303-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:57:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIHRoZSBpbnQxMjhfb3IoKSBpbXBsZW1lbnRhdGlvbi4KClNpZ25lZC1vZmYtYnk6IFRheWxv
ciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+Ci0tLQogaW5jbHVkZS9xZW11L2ludDEyOC5o
IHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL3FlbXUvaW50MTI4LmggYi9pbmNsdWRlL3FlbXUvaW50MTI4LmgKaW5k
ZXggNzZlYTQwNS4uNTJmYzIzOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9xZW11L2ludDEyOC5oCisr
KyBiL2luY2x1ZGUvcWVtdS9pbnQxMjguaApAQCAtNTgsNiArNTgsMTEgQEAgc3RhdGljIGlubGlu
ZSBJbnQxMjggaW50MTI4X2FuZChJbnQxMjggYSwgSW50MTI4IGIpCiAgICAgcmV0dXJuIGEgJiBi
OwogfQogCitzdGF0aWMgaW5saW5lIEludDEyOCBpbnQxMjhfb3IoSW50MTI4IGEsIEludDEyOCBi
KQoreworICAgIHJldHVybiBhIHwgYjsKK30KKwogc3RhdGljIGlubGluZSBJbnQxMjggaW50MTI4
X3JzaGlmdChJbnQxMjggYSwgaW50IG4pCiB7CiAgICAgcmV0dXJuIGEgPj4gbjsKQEAgLTIwOCw2
ICsyMTMsMTEgQEAgc3RhdGljIGlubGluZSBJbnQxMjggaW50MTI4X2FuZChJbnQxMjggYSwgSW50
MTI4IGIpCiAgICAgcmV0dXJuIChJbnQxMjgpIHsgYS5sbyAmIGIubG8sIGEuaGkgJiBiLmhpIH07
CiB9CiAKK3N0YXRpYyBpbmxpbmUgSW50MTI4IGludDEyOF9vcihJbnQxMjggYSwgSW50MTI4IGIp
Cit7CisgICAgcmV0dXJuIChJbnQxMjgpIHsgYS5sbyB8IGIubG8sIGEuaGkgfCBiLmhpIH07Cit9
CisKIHN0YXRpYyBpbmxpbmUgSW50MTI4IGludDEyOF9yc2hpZnQoSW50MTI4IGEsIGludCBuKQog
ewogICAgIGludDY0X3QgaDsKLS0gCjIuNy40Cgo=

