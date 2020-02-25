Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A3BC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E974221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv4e5Vwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E974221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c9V-0002ld-1R
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bvG-0002R8-GY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvE-0001qY-Kz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvE-0001pg-Gz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CczPzEBWhhpjWKucs1+Hoc+p5ZrBciU/h88CuRi6XY8=;
 b=Mv4e5VwrLwN4U1vK4DmfhLhit6xungcAFFdNTWQKS82NtafmEFoxXnrgaMUz5C/y8gJmh0
 Qwgh7cgksyYTZWdiKu0ni4m0bxco8TZxgMMseA+8N+yFOPUgdFDwzM+BPF97nMS32uRJRy
 C7Yr1QIJUDfzU5LTnvsr/AT0WoobLsw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-RaFU9gQdPBi9U8SyW6i-MQ-1; Tue, 25 Feb 2020 10:14:52 -0500
X-MC-Unique: RaFU9gQdPBi9U8SyW6i-MQ-1
Received: by mail-qt1-f198.google.com with SMTP id z25so15190798qto.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i0G0n0Ave2olUcIJuOrc5QTfak11CeuD33nep9puVrE=;
 b=mOopvqu2s1s/hOxMagFwey65cYBErxvt0qbFKbwKfBG3H+/93tnVBxKl3D4uinHzKs
 KUOvoTt9jGDyv1wvFGgHh1bW51U/tD1763KUXS2/BEJw5kzL8wMUFQuTrhg8LXPXHAl9
 yVmIIkO0wWszFAViQ3/6/yVt6suwkPfYJGwz6xr0Y9UimhOpHtGG9nyu4Lvs1ltPtqtK
 OPWNSEqvnTUaj0anlXF74CR1xixKpaVckqj57patEcYBe4IMZmiiH2zBbfeu+oqviJwi
 87CmAVaCEA9f4Vl0hTRzDbS+kl0qsOREzqFdSZ7lhv7dnLEpTPfPENuInhWZaBG9FORU
 bKGg==
X-Gm-Message-State: APjAAAVhrnzxB01HkRNGgT9hCsoPztwTfhM42FOapfYIt4ME/QxWkD4s
 0y1+h/FUDJ3jzZ8VQxseVM7C7sB/xFEO6C+JLB8RjkSzzyuezGVTQg3Tm2sBrGjja1164S4rw1x
 hNMsyWphVwyS4HjU=
X-Received: by 2002:ac8:498f:: with SMTP id f15mr53954496qtq.123.1582643691373; 
 Tue, 25 Feb 2020 07:14:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGVt7dN13aXum412QJ+5kYWa+gxbxrriNZS5ebQzvewP5dAOtGXwuFpCAZWY7hhu6OFBN67w==
X-Received: by 2002:ac8:498f:: with SMTP id f15mr53954472qtq.123.1582643691128; 
 Tue, 25 Feb 2020 07:14:51 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 i28sm7891147qtc.57.2020.02.25.07.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:50 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
Message-ID: <20200225151210.647797-29-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Commit 3a61c8db9d25 introduced CPHP_GET_CPU_ID_CMD command but
did not sufficiently describe it. Fix it by adding missing command
documentation.

Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1580306781-228371-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index a8ce5e7402..9bb22d1270 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -94,6 +94,8 @@ write access:
                register in QEMU
             2: following writes to 'Command data' register set OST status
                register in QEMU
+            3: following reads from 'Command data' and 'Command data 2' re=
turn
+               architecture specific CPU ID value for currently selected C=
PU.
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
--=20
MST


