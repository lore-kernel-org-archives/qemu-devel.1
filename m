Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF0C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483B824655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFwiq6GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483B824655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9uG-0001FD-UQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9q3-0004GL-CW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9q2-0007o0-6n
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9q2-0007nm-3j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL7cOBRrNjS5xV9Me0lJk0ipNP0N1056GF7w4b0GCrQ=;
 b=PFwiq6GBd1VFjMQrK6TVPJ4L/4HdWTMoNVB4sRHMJS4A69it/49wxIL2dkTQxawd8G4olq
 0KieIj8mqB2V/uxM0i15o7xAPyWPYoryns75/qH/Jlmx+D6xcCMdpzPjT22ZlBxItYQm15
 umT/zAMQhMAC9gZsuETHSnf50U7Vkg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-Xoc7q06rPpmklxhoyTu_Mg-1; Wed, 22 Jan 2020 01:50:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so2612902wrw.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0NReYyn4JQkVdN7PoAGTBso0lphxyHmehPnh64blNL8=;
 b=J+ca0WCLtDcx5h79tGeB7yygDq0xnyUDsyWwAFQICvtk4Vh8wgZkMl90tsHrDQJJ5x
 sid7VU/+aKbhcvh7kLEtFzzGvuB7u4nW6/YoyqPyNx/1IyD6pjN4IhGgh7e7Gl7m8isc
 lXJ07AeGmYg1q4Pu4B01S81e61hEdICoR0FbWLEwnlPE4lyEvND+Og0GWrzM5hiLKXq2
 SSddwG9Axg098iGoDuJ9TYATq7US6lqefvbBXNQGJ095Zk3SpCVn6v/NxzRDEMdQpUKJ
 +F+YNo1YHLUB04fXD7tAENVMMz1NxWCeySyR5XjGxtXPfsMyTf2AH5Sp2Vjf2xBAprLk
 em6g==
X-Gm-Message-State: APjAAAUmGbBFQ+ciky+XtFsOv9Ur4/VUmIv7i64RIHYk44/f8y6FpHlq
 asQEz9IctmZ75Mb1/lm9b3r+HFMbOnReCBPtlVzFjBEx6JJ0ZMSMM80pdg4F45rX54aFM6IZQtx
 OSVW7ekQvNSHTTxs=
X-Received: by 2002:a5d:6987:: with SMTP id g7mr9012025wru.422.1579675802438; 
 Tue, 21 Jan 2020 22:50:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2OTrpQoMnscysa7K5/ivHhpeRPioT4Fg9oVUKRCAOy/kjGECDU3cD4xp145Gom1xRaWLcvw==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr9012009wru.422.1579675802252; 
 Tue, 21 Jan 2020 22:50:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 t12sm55393616wrs.96.2020.01.21.22.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:01 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/17] acpi: cpuhp: spec: fix 'Command data' description
Message-ID: <20200122064907.512501-5-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Xoc7q06rPpmklxhoyTu_Mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


