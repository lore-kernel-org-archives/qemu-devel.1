Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A448CC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8F6205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elqbiP6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8F6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdb7-0004jM-9g
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8U-0003GO-6i
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8S-0008BF-0o
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:10863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8Q-00088z-E7
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaQNKAOJWCJ0TkYGshllA/zY5mZPUlKZJvjUMpmytUk=;
 b=elqbiP6ilWRoxlq1zuTq6upkxOSyJq+7Kg+yjgdM2CPGI8hIKy0MBJmWJ4/STaMNsSk+et
 eN1MeG67dr7SXktzANdxHLqiKBoHaCjhtmqeJ/ah7fV8mv4bWazyiRQBUbXB1CH4RV8n91
 GXH9Yi0BkgEBGrsS08h5f1r2cwdFia4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-OQyMRfJ7Pn-xEhkBlekfXw-1; Sun, 15 Mar 2020 19:57:32 -0400
X-MC-Unique: OQyMRfJ7Pn-xEhkBlekfXw-1
Received: by mail-wm1-f72.google.com with SMTP id s20so4194937wmj.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z6xOhiDttpNha3dcUNHLkv4u9IpM4hzHtavFC7DQxi8=;
 b=lu5VcnCW5hivzEZkMdUDuTzfn/uVrwZiL9lvz4nEPAmSUC+NodM7aTxwoGqXMrsAE2
 V13fgw8BoRGCMr9kfo0QseqLFZgbOFFKTEx8vj64DAoLKaRWVVji3nwVMTpXKJDsJPy+
 hqDYlq8u03So5ShNfYugXHa8/+kcqE8b7htZxTGENdMjRMHPgndNLXo2e0BjF4Bx1pYA
 Ag9/5OPY37b+alDujZCzXp2bGus34sIC74WgBtTXanRoHQEBG5UVr7AKksWVtsnTmwfO
 6C30AZCPCsFrEqdXuxPuzzoN9GZf60BbXjFXd4cJhMHhMxgHg+MAi8kBULIVmCSi/2Bp
 z5rA==
X-Gm-Message-State: ANhLgQ2c1FOiLgtAN+RYrKv1/xTA4H/gvhL3w5ctHIXHnwy+CAFXMY39
 tcL09DO1YXZ7szV1wJ7QxMXa5M7Ere3rVSOT3FlhpwLtAqkbXcKJ6O7ch33Pp/M3MkJ8hhCsMp7
 iGEHcc20/6p0Bm/g=
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr25059324wmh.106.1584316650777; 
 Sun, 15 Mar 2020 16:57:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuqRHWoAzOfYRO1fI8H2/AB2Sep6HlNfQBtYtXFopxl51PHRuFJr6DrmgyBFP6Gzt30RYb3dw==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr25059297wmh.106.1584316650562; 
 Sun, 15 Mar 2020 16:57:30 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id u25sm27118389wml.17.2020.03.15.16.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] configure: Avoid building TCG when not needed
Date: Mon, 16 Mar 2020 00:57:06 +0100
Message-Id: <20200315235716.28448-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index eb49bb6680..c2ffcb0431 100755
--- a/configure
+++ b/configure
@@ -1650,6 +1650,10 @@ if [ "$ARCH" =3D "unknown" ]; then
   linux_user=3D"no"
 fi
=20
+if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no"=
 ] ; then
+  tcg=3D"no"
+fi
+
 default_target_list=3D""
=20
 mak_wilds=3D""
--=20
2.21.1


