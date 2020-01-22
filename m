Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C3BC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1420724656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyKEzAKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1420724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu92j-0007Vy-L2
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8vs-0007MT-LB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8vr-0004aB-Ic
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8vr-0004Zt-Eq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL7cOBRrNjS5xV9Me0lJk0ipNP0N1056GF7w4b0GCrQ=;
 b=VyKEzAKajt2wXLtVhR6yF/51JLSVEjvvn8DhtPoA9S5TNg+dkAqURi3SQIVMBsLUxwGVMt
 OexukHSQn3c/yknyPkrMk3TL8TUhwJm3jYs4O5JixJ5svHx/CGohXVvs0Jvp5TjrQ6DemV
 NTS62IrtQQ4F1XzeDdYVgZmZIjrLG/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-iw2ccxv8Mg2IAs6DJsBzqg-1; Wed, 22 Jan 2020 00:52:01 -0500
Received: by mail-wm1-f70.google.com with SMTP id w205so1612109wmb.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0NReYyn4JQkVdN7PoAGTBso0lphxyHmehPnh64blNL8=;
 b=LPa2zhy6d3RPqEHrnFGU6EKyzLakhruHMQ/fiIZFwVD4wDsZYGWwGg8omqlZKhSAg1
 YJG4t0hpfRv1Jn8JZeJ5nc9NLoydkMCxdjFNAeVJBlSGQFJitoog0YpxCM/TS5z1lw2O
 ayQWoUNXC12WEdY7lV/MUAbrwvBsM9c6lU1p9+7/b5cy3WW4767vt3vzbmEh9sDwY5xt
 ZqiMOVta0kFJmIGk5eWP3of+8ZhhXRQCy30Qw9dJ73De8q0ZFfKG1ciO9XkrF30xnvLV
 6T4rh4hlV4hACBVCojrGVLOyn/OZyhC0nx2QMw/ewzSuh/1Mal+7dDAg1sOSVYq+Zg4Z
 694Q==
X-Gm-Message-State: APjAAAXmVy3+a9hn1w6HXMd7FieAEUTpsA6qVGE0aEU1hHzl+jBEepa5
 Qg37JoA67LvgsZuP/9fqohGkv9Fd3aPrQ/hyllBl72mmIWknj7MbfwO0nIwKxl6mRegIanPw9Ai
 1hf7QmjrCG9A8g8w=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr9504381wrq.57.1579672319513; 
 Tue, 21 Jan 2020 21:51:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJsLnWpbO69m7ffZVTXV+HI3Bj2YrvoXhVtlT4qRybSTj6bD6vJ4e+WbI+gsf2RFn8fJjJ/A==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr9504361wrq.57.1579672319214; 
 Tue, 21 Jan 2020 21:51:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i10sm56700439wru.16.2020.01.21.21.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:51:58 -0800 (PST)
Date: Wed, 22 Jan 2020 00:51:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] acpi: cpuhp: spec: fix 'Command data' description
Message-ID: <20200122055115.429945-5-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: iw2ccxv8Mg2IAs6DJsBzqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Correct returned value description in case 'Command field' =3D=3D 0x0,
it's not PXM but CPU selector value with pending event

In addition describe 0 blanket value in case of not supported
'Command field' value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-6-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 4e65286ff5..d5108720bf 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -56,9 +56,8 @@ read access:
            3-7: reserved and should be ignored by OSPM
     [0x5-0x7] reserved
     [0x8] Command data: (DWORD access)
-          in case of error or unsupported command reads is 0xFFFFFFFF
-          current 'Command field' value:
-              0: returns PXM value corresponding to device
+          contains 0 unless value last stored in 'Command field' is one of=
:
+              0: contains 'CPU selector' value of a CPU with pending event=
[s]
=20
 write access:
     offset:
@@ -81,9 +80,9 @@ write access:
           value:
             0: selects a CPU device with inserting/removing events and
                following reads from 'Command data' register return
-               selected CPU (CPU selector value). If no CPU with events
-               found, the current CPU selector doesn't change and
-               corresponding insert/remove event flags are not set.
+               selected CPU ('CPU selector' value).
+               If no CPU with events found, the current 'CPU selector' doe=
sn't
+               change and corresponding insert/remove event flags are not =
modified.
             1: following writes to 'Command data' register set OST event
                register in QEMU
             2: following writes to 'Command data' register set OST status
--=20
MST


