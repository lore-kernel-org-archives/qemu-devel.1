Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B42C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80987208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHFEN9Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80987208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43tt-0002ct-K9
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j43je-0007Ql-Aq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j43jd-0007de-9f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j43jd-0007dQ-6F
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582035624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1URDudQA43tkpJJIFu7DKO6uQTr6PesR1xXXrF9Y2c=;
 b=BHFEN9Z84xarraHwkk3DHixcWF5naneQkhZbtB5SixFumb58sMaAAk+9aYZ2n1T1Fm3uSG
 0OdcqMb2PO86SCoUT82A+fostlLgAc8MfUk65WorjAmAZ1+rE6ctUFyNYz88HWNQUIsMcs
 KxZ3txQ8/i5QnX+KMQz6XMEWHRXppkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-c4GMMBHnMOi14a3t-CesbQ-1; Tue, 18 Feb 2020 09:20:22 -0500
Received: by mail-wr1-f71.google.com with SMTP id o9so10932255wrw.14
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 06:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dby0bbbTN0qoct6/4D46hB2yEK0ttVkxuhLtJTaK6Dg=;
 b=WWSXbzqZ5iUPboe9IvsEC/uky6Xe/7B3VlGKLgndb72Cg+Ohx09mbkI62k+O5fKhrm
 TfH+pj2jlW6+1NkyDI8gefSIm+iGaggKXcpIbqDikc+uy0VCjFtZXrYWOS9rO+Soyll9
 Q5teDVT6LrwQVlILtq50shaySi2Wp98p8y0AhBNTeWp642ifPjdtGN/LCxUGaDECI8v8
 4htbdD0IL5ylpxg2GJGgJD6kOqS1bdVF92phEs1pDzsAN7Dy+ak2uShOxwJzbzehLzO5
 XAJYnIixyLBf/9NZ1HLi4juCW0644qYzndPkPNZ0Lyz+K7pnsmbHZBLMIc86IYuud3Lo
 i3Mw==
X-Gm-Message-State: APjAAAXluudvgu5nuKHasKIpAD07dUhBmelO87/ZO4K+s+En5FBSVGf7
 z972CQ55QFgWg/TN6sUautiZRx91gLaGevmtFrEy7IaIGbipGCyZZR+MwVPvDMbJInfRve16Hbc
 q7IDuIYMkz6HTXDo=
X-Received: by 2002:adf:cd03:: with SMTP id w3mr29776995wrm.191.1582035621231; 
 Tue, 18 Feb 2020 06:20:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjyxkbfhlpKkKqdMVOFidw68j25T92ALlorWEzCJJJ81C3Aexuerf2OPepl8UaKNWZjiRe3w==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr29776986wrm.191.1582035621020; 
 Tue, 18 Feb 2020 06:20:21 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l6sm3775204wmg.42.2020.02.18.06.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 06:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 1/3] .travis.yml: Expand OSX code coverage
Date: Tue, 18 Feb 2020 15:20:16 +0100
Message-Id: <20200218142018.7224-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218142018.7224-1-philmd@redhat.com>
References: <20200218142018.7224-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: c4GMMBHnMOi14a3t-CesbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install more packages to cover more components:

    ./configure
    [...]
    host CPU          x86_64
    strip binaries    yes
    Cocoa support     yes
    TLS priority      NORMAL
    GNUTLS support    yes
    nettle            yes (3.4.1)
    libtasn1          yes
    PAM               yes
    iconv support     yes
    curses support    no
    curl support      yes
    Audio drivers     coreaudio
    vde support       yes
    HAX support       yes
    HVF support       yes
    TCG support       yes
    vhost-net support yes
    vhost-crypto support yes
    vhost-user support yes
    vhost-user-fs support yes
    libusb            yes
    libiscsi support  yes
    libssh support    yes
    lzo support       yes
    snappy support    yes
    bzip2 support     yes
    lzfse support     yes
    [...]

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5887055951..08ef2c011c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -279,10 +279,19 @@ matrix:
         homebrew:
           packages:
             - ccache
+            - libgcrypt
+            - libiscsi
+            - libssh2
+            - libusb
+            - lzfse
+            - lzo
+            - gettext
             - glib
-            - pixman
             - gnu-sed
+            - pixman
             - python
+            - snappy
+            - vde
           update: true
       before_script:
         - brew link --overwrite python
--=20
2.21.1


