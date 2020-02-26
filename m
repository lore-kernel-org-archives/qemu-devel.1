Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559762084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhL+0qvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559762084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6soE-0006xL-IP
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfj-0006oD-Q3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfh-0001CX-P9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfg-0001AD-Pf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CczPzEBWhhpjWKucs1+Hoc+p5ZrBciU/h88CuRi6XY8=;
 b=fhL+0qvomfwQyDaSit6Ok925hL/xnV8gisLKlBJG8SSNuSEWDsMLYJM+PC6Zn0H89zxQ/4
 LcgolSTCQ3lH5yCcEN6soKPG21oQhdCyGnohzP0eZHZeqeR5ARn+AN+DG44gyRAHZ8Ocnb
 Q99rY6wBmTWKbQM6s5nJxd2GK1YJ0sI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-wVv09p4-MyGkzM3vJH8gMQ-1; Wed, 26 Feb 2020 04:07:56 -0500
X-MC-Unique: wVv09p4-MyGkzM3vJH8gMQ-1
Received: by mail-wr1-f70.google.com with SMTP id s13so1183546wru.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i0G0n0Ave2olUcIJuOrc5QTfak11CeuD33nep9puVrE=;
 b=k4osOiqIBiRsE1SAVa/L06cbx7gTZIScWn1Hsg+m9C61ZeTqj71ymPurqhF8Vpb1MD
 2B7pIkmA8QAp4+WpqKEjqt4yeMkA6ZBUU7lgAVU/gNdU5ALOP1r/NU0B1x3EF5ZSv5e/
 gAHrNTWA+j2q3MHmqjAGOejfLbYeuyIAfZo4s5LhQa/Tdq2MQJwhiJNx6NGUlGHcH6di
 MjADhZBQmPZp4aYqPXmw/5/a2GUSfbdbSilU9a6pDc/5uzqu0NDCKN98I6UDuORmrfuR
 zFFJMs+AcoCByAOZJActhy4tqe5uaUzO5rUGeg4XNIC0Joi0paxjhgdqB6oVpUCB4TS7
 COuA==
X-Gm-Message-State: APjAAAUny2Xj7CSq1cTgSE1iGYVq4ARXSNu4YkzVwiJ0H8P+f/EVMOA5
 wrwPSmFWDsPwwKRKnnojHp8yc5hDP0EyEVd88rUj60w/0SvNdw9Ulszx6UpU/BLySx8or92z72O
 fBMjuC843tNw/G0I=
X-Received: by 2002:a5d:5303:: with SMTP id e3mr4244792wrv.274.1582708075214; 
 Wed, 26 Feb 2020 01:07:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPdcDSk8WRQ6mzDsjSXAjMFOqtSj+mEyoiH7XMFfiWa/sfTqoeh67VbEpqn+qlUWjJw+aIaQ==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr4244771wrv.274.1582708075000; 
 Wed, 26 Feb 2020 01:07:55 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w1sm2419365wro.72.2020.02.26.01.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:53 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/30] acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
Message-ID: <20200226090010.708934-29-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
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


