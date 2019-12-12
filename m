Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51164C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8702077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbnXp0qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8702077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO8r-0007C9-BF
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxv-0002no-Pp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxu-0005rc-Ix
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxu-0005qO-C3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id d5so2374013wmb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QXKe1oNgve+OXaCcf1sLHSgFBHpdluWz0a0oY/3Sum0=;
 b=lbnXp0qbFTeOQcCKczI5GT52V/VV5PatZmnn08ucUOHZPEJYIK2TlN9PWRgjfB/pnk
 ojgG1LO/wCjxTbfq2V503SuqRGHRDIZX7ofrW2CAvkihodgD0nPf4oLjMsQjwhDbTuLJ
 WyJMz41APvAimjQFSHoOa/Un++zkVC8AbxMCkWik8CbiphdzEJBZduJubcBGOAT0A5Od
 mcBjhdtdLx565uUTc1z+BmuByzQTh+Q94f/h/5F61+uuSn9KaN127buKKusA21qWEanI
 Yvya72eGorJUsA5JY1Mkh9RHt6FBPwclhCrkE1haH5Y4kvnGxc726enZA+xPRl7WW4C2
 mBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QXKe1oNgve+OXaCcf1sLHSgFBHpdluWz0a0oY/3Sum0=;
 b=s1xgNaIyxlIIxUi+W8Uj2mJqt7+R+diafuWofTkN8VRl9k+bYetjyJe8PZJnvhI0FU
 ppgfy9CyxyZgzLNFQvFR/YJBkI2h69FOhFE1Utbl98CiMc2KmSBxLTjeJVxhbh5J4+iR
 CVjVYwuEW0FAfNxMGS9UpZOWJi67YmVenCBoPcQZnftU4jDN22B5mT5Utx1p0FLRr+9U
 iQYH4/9Y0oHX/IIttbukK2kXUitR4ofpVDC6uSiI48+ofvOP6e+ax6KfSnhwjYrlmxj+
 FWjpLyoGW/ratoZawxTqPhTc8KRUNppfyx8Ekx7ke7VCq7zkLNwzCasrQ5A2+DQbC99R
 icnQ==
X-Gm-Message-State: APjAAAWRKMVN4OWEJ5eMXy8TMhjCLyQLz+9fn8dQDx3YZXaqJEIN+AgE
 nu25Day3LEclZJXoSWRvhv80StzC
X-Google-Smtp-Source: APXvYqxXXktcZ2rVyffo5iUym+ZCdqxTag7Ywwyw3dKkgjNLoJ19f/pg39Ah+glLoiyViup6A7imWQ==
X-Received: by 2002:a05:600c:2409:: with SMTP id
 9mr6038404wmp.109.1576155189003; 
 Thu, 12 Dec 2019 04:53:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 011/132] meson: add version.o
Date: Thu, 12 Dec 2019 13:50:55 +0100
Message-Id: <1576155176-2464-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 18b8710..ba4d891 100644
--- a/meson.build
+++ b/meson.build
@@ -23,8 +23,14 @@ configure_file(input: files('scripts/ninjatool.py'),
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
+version_res = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+
+  win = import('windows')
+  version_res = win.compile_resources('version.rc',
+                                      depend_files: files('pc-bios/qemu-nsis.ico'),
+                                      include_directories: include_directories('.'))
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
@@ -177,4 +183,5 @@ util_ss = util_ss.apply(config_host, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), m, glib, socket])
-qemuutil = declare_dependency(link_with: libqemuutil)
+qemuutil = declare_dependency(link_with: libqemuutil,
+                              sources: version_res)
-- 
1.8.3.1



