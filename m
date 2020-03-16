Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C11C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753BD20575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2xsgJdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753BD20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpmR-0001Ne-5e
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoQx-0004mc-SB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQt-0008Ia-JP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQs-00080j-S2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhpLrWHmstqSUiAlUAf8U9dnNzPjzy8kiEMXQKoyIjw=;
 b=Y2xsgJdZBP9knielaIG+tUfUmmn/Rx2JRWQI1A9yXpgeqc6auQTzOswrZJtBsnCGvC1xCy
 uJbpZ4ZDZTgDMWvZLCrncpVov5s4L4ZiSWYd0qOOmvU3ana4Xh88T95Yw4fyFbzDXELAYD
 1DdDzFfZUhq6gCbgbf/SxFKUgkj29nY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-E1EaftofP-C_4J3TQY9h5Q-1; Mon, 16 Mar 2020 08:01:19 -0400
X-MC-Unique: E1EaftofP-C_4J3TQY9h5Q-1
Received: by mail-wm1-f70.google.com with SMTP id z16so623437wmi.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CwzxtCT6fp3y8R/rJchcUMX4hnazO9WzAjNlOCaueB8=;
 b=dCYOwQ3IXz6EQ7aqbjbc+meGFq4TmtSsrnlv6RZm8Lb/7NmKUh4u+qMYwqf/J9woMY
 XF0ITUegldVyC8uqgl865Qqi7xE3rFGV+BsY7X5Evxrgbew8/ZRn0/U5wrd8dlCO5xcS
 OJ73/IbT3iqPOkCfSM/OtDZhqNLVP3pRJUDTQg3z+TiwsoWBvsZO50NfMA+UDbI85Msp
 VBQo+ChghWYSNaEG8GxJk02d5U3x53ZLO4Ok82gGR7AypVbC5fhHTzLQ3VmVLGbE9LJ7
 +b2AbXPNgBo+MbVuJhZR6F84IYF3omklbhgSXn2Mm1PhgRrf7mP6a+DeBA2AgWHu74W6
 yCBg==
X-Gm-Message-State: ANhLgQ3UeNZTUJ9FAVQUSAVDmUTV7hyjpNn2kOUAfPD6KeOs8YWqIPtL
 Q0xbOD2kBfjMEgyb5n6hith7+Yc+GgJ2VP0mBZUxKEFSZRuZuwXeL46KfDjrRdbzJ59gNX/3+kp
 6XDf9PxWZ5L3MJ1E=
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr27188147wmh.130.1584360075337; 
 Mon, 16 Mar 2020 05:01:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvdy8nibxca1fkZ++RS/ecFylmmd3m12ZUxUJxVNHRwxNmFpf02zEM8V0QP5JChyo8mDwrgng==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr27188109wmh.130.1584360075109; 
 Mon, 16 Mar 2020 05:01:15 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id i1sm77124044wrs.18.2020.03.16.05.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
Date: Mon, 16 Mar 2020 13:00:42 +0100
Message-Id: <20200316120049.11225-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Patrick Colp <patrick.colp@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Patrick Colp <patrick.colp@oracle.com>
Cc: Cameron Esfahani <dirty@apple.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Heiher <r@hev.cc>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ec42a18f7..bcf40afb85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -420,6 +420,12 @@ F: accel/stubs/hax-stub.c
 F: target/i386/hax-all.c
 F: include/sysemu/hax.h
=20
+HVF Accelerator
+S: Orphan
+F: accel/stubs/hvf-stub.c
+F: target/i386/hvf/hvf.c
+F: include/sysemu/hvf.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.21.1


