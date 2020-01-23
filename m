Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C931E20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOZ947dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C931E20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueq2-0008VZ-CH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrB-0004j9-VV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrA-00032S-J8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrA-00030J-CG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id b19so2627771wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OucTBWXsjhFgmzRgCBoTRR2Qk1l2bk/1eGxf/v19814=;
 b=AOZ947dUpJUNt0ImnYdsmIR4oHJvg92uJIlY1faGeMPxXs+Hx2cyJ3CToMPPPjzsW1
 lYZrVvVhz05kC0EQoBcIi0TF6gok7QlvI3sHlc/5DlPUpR0Mz+lhA+bkVmihca5AytMh
 drOQhUvpKr7hYX7lcmezLFM1iha4rjTFzI9lEoiJppR0bpqUTwmZa/s6Edyd7faKOOy6
 HWK0Xj/wN/TouNedBpGXexZCkkErZx+uU1hj6/i87XrMYaKK+lG6LUTcTgrUj3E09BJH
 KKhUajG8a2+fW7HKyauwjhOrfRmvy6WK5vNP1ttJPzQ+TrzvMglHjV768QZAgSpwEbEJ
 +M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OucTBWXsjhFgmzRgCBoTRR2Qk1l2bk/1eGxf/v19814=;
 b=d4zoNobUAV0tC5hxDc+H3PTrErmQ2Qnc46L316oTVXwq78reXWUz2OgSxDVYxT+Tfc
 gnpfTE2wm6nmbw6EOhHqSddyY0Qh+Xc15yQtW/0NuHO8pSQiG4rZmo1QBZXXv7bRElkd
 zF3UGDt0KlOiVZlGDpzX+AjG/GByzm0y5PCMPwp4JYSTJwzPD0F6Oqm5BqejniSeVe4/
 FQFiZHDPA5yZSP6fuXcJ6AoNgZqrIJuJ5ZcZgL4GcZmhtf+yP7OuRcYu18v6nTG95Lcc
 GUTixEI6G3q/SBs8iAcFa1r8hmc0XYo108BsRz95HMUOuCYm7uMuSRFZ9PqOxA+PRGqH
 6XrQ==
X-Gm-Message-State: APjAAAW/KLNpwFWJBj0ZkmGRmRfea/qIbO4aohT0qYIZWHYN15PXSgNW
 0g/mzA0gF0TDxZv6bn31iHDnHsWc
X-Google-Smtp-Source: APXvYqz1cnMMVijYti84UU33HGEpmLm5QjRJP43b/T9vyB/nVZ6uKvJDrKpKUUkBOESfSpM3H4AS8w==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr4445066wmb.11.1579787350100; 
 Thu, 23 Jan 2020 05:49:10 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/59] qom/object: Display more helpful message when an
 interface is missing
Date: Thu, 23 Jan 2020 14:48:08 +0100
Message-Id: <1579787342-27146-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When adding new devices implementing QOM interfaces, we might
forgot to add the Kconfig dependency that pulls the required
objects in when building.

Since QOM dependencies are resolved at runtime, we don't get any
link-time failures, and QEMU aborts while starting:

  $ qemu ...
  Segmentation fault (core dumped)

  (gdb) bt
  #0  0x00007ff6e96b1e35 in raise () from /lib64/libc.so.6
  #1  0x00007ff6e969c895 in abort () from /lib64/libc.so.6
  #2  0x00005572bc5051cf in type_initialize (ti=0x5572be6f1200) at qom/object.c:323
  #3  0x00005572bc505074 in type_initialize (ti=0x5572be6f1800) at qom/object.c:301
  #4  0x00005572bc505074 in type_initialize (ti=0x5572be6e48e0) at qom/object.c:301
  #5  0x00005572bc506939 in object_class_by_name (typename=0x5572bc56109a) at qom/object.c:959
  #6  0x00005572bc503dd5 in cpu_class_by_name (typename=0x5572bc56109a, cpu_model=0x5572be6d9930) at hw/core/cpu.c:286

Since the caller has access to the qdev parent/interface names,
we can simply display them to avoid starting a debugger:

  $ qemu ...
  qemu: missing interface 'fancy-if' for object 'fancy-dev'
  Aborted (core dumped)

This commit is similar to e02bdf1cecd2 ("Display more helpful message
when an object type is missing").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118162348.17823-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 0d971ca..36123fb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -317,6 +317,11 @@ static void type_initialize(TypeImpl *ti)
 
         for (i = 0; i < ti->num_interfaces; i++) {
             TypeImpl *t = type_get_by_name(ti->interfaces[i].typename);
+            if (!t) {
+                error_report("missing interface '%s' for object '%s'",
+                             ti->interfaces[i].typename, parent->name);
+                abort();
+            }
             for (e = ti->class->interfaces; e; e = e->next) {
                 TypeImpl *target_type = OBJECT_CLASS(e->data)->type;
 
-- 
1.8.3.1



