Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F8C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4953E24656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWg0kNpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4953E24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ircE9-0000ZH-8T
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ircCz-0007wH-I3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ircCr-0002Qk-PK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:31:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ircCo-0002OD-GC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579069865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ah7YO5ihS+llvpQStMerRSYuJLi8vPRLqxeROsrfTwU=;
 b=WWg0kNpMCYlmsX1oBg1xJwvx8YKEWLrLQpEsHhym0d90aeENhJp8x+GL1o6vnW7CJkmGqz
 Em/a0x9CCxCFjBc9jj4mUGyFsgv5xwDc/NM5rZQwZQegeupt0mM4RHadnwKGoWV2as7hlD
 /FSgNLY5q6MIW/FKURbQQIt1xmmMWr8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-InxOm8c3OUigrIWorCoDDQ-1; Wed, 15 Jan 2020 01:31:04 -0500
Received: by mail-qt1-f200.google.com with SMTP id d18so10598038qtp.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wyTusgh69XEfBhc65/d3WUkzIkz6FnK9MLw53Bk1Xf4=;
 b=hAKmQ85JR85xRoTYmB5rJkBGn5iqTXT96ZgJ1Y6wziw4JhaiWJLO7ovvGOWA3YIs4p
 TFDUsu2MTK78QLOrArwIU3QscGLus3VWI2la8S69VRjqSlZJo1dPVaG2V32a1lspLggh
 7AVpibWBjptEprYz/nBcK2hee1irnzC9+wnr9oQF9CLFAd5r8WwABJUFp8bKbRpYSOjp
 7yS0TX2EJ6pn0f5bNXQ5s9pXvB6r2fQQbJiHOGXZOuQ36UNBH1hOj1Id1Okm9jHcI7p4
 V7WJTqlg92swVDEmNzD7Ddieai96Q/IS5hlJ/AeSG1n9Y+zTyMunsy+xCFO/Jei8hcIN
 Lqxg==
X-Gm-Message-State: APjAAAXWaGS8uVnPdJqxox/2ky32qP3XL1/i1476K++Wt0dqgRYx+4mi
 qZQy48FkpM9lIOnciTXieMgrDcNS7rX4bdxaXSpHYsKx6aNe7/eykncTJ9vyFd3H6Kee9XxGSMz
 qCGstBj9t3q6oyzk=
X-Received: by 2002:a05:620a:899:: with SMTP id
 b25mr25974583qka.197.1579069863537; 
 Tue, 14 Jan 2020 22:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYZ9DvDvhAtc7phoL6dn98nMgC1DLHfOoNbL/P1CZuRUNEI/FEZLS9rbQIo0mfQg3xiwcEMw==
X-Received: by 2002:a05:620a:899:: with SMTP id
 b25mr25974568qka.197.1579069863308; 
 Tue, 14 Jan 2020 22:31:03 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id u16sm7948257qku.19.2020.01.14.22.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 22:31:02 -0800 (PST)
Date: Wed, 15 Jan 2020 01:30:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200115011412-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
 <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
MIME-Version: 1.0
In-Reply-To: <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
X-MC-Unique: InxOm8c3OUigrIWorCoDDQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Problem is IASL disassembler still doesn't work on all hosts
we want to support. And its output isn't really stable enough
to act as a golden master.

Until we have a better tool, I propose the contributor just follows all
steps 1-6.  The reason they have been listed as maintainer action items
is really just so that multiple patches affecting same ACPI table
can be applied, with maintainer resolving conflicts himself.
But this job can be pushed to contributors if as in the case of ARM
maintainer isn't really interested in reading ACPI code anyway.

So I propose the following patch - comments?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index f1ac2d7e96..3a6a3e7257 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -16,7 +16,10 @@
  * 1. add empty files for new tables, if any, under tests/data/acpi
  * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
  * 3. commit the above *before* making changes that affect the tables
- * Maintainer:
+ *
+ * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolve =
conflicts
+ * in binary commit created in step 6):
+ *
  * After 1-3 above tests will pass but ignore differences with the expecte=
d files.
  * You will also notice that tests/bios-tables-test-allowed-diff.h lists
  * a bunch of files. This is your hint that you need to do the below:
@@ -28,13 +31,17 @@
  * output. If not - disassemble them yourself in any way you like.
  * Look at the differences - make sure they make sense and match what the
  * changes you are merging are supposed to do.
+ * Save the changes, preferably in form of ASL diff for the the commit log=
 in
+ * step 6.
  *
  * 5. From build directory, run:
  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
- * 6. Now commit any changes.
- * 7. Before doing a pull request, make sure tests/bios-tables-test-allowe=
d-diff.h
- *    is empty - this will ensure following changes to ACPI tables will
- *    be noticed.
+ * 6. Now commit any changes to the expected binary, include diff from ste=
p 4
+ *    in commit log.
+ * 7. Before sending patches to the list (Contributor)
+ *    or before doing a pull request (Maintainer), make sure
+ *    tests/bios-tables-test-allowed-diff.h is empty - this will ensure
+ *    following changes to ACPI tables will be noticed.
  */
=20
 #include "qemu/osdep.h"


