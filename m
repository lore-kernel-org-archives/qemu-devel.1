Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC8C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179362187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC8+HyYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179362187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irgLO-0005cm-8d
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 05:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irgKO-0004dU-Kn
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irgKM-0000MP-Eq
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:55:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irgKM-0000LU-AR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579085709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYm4STjo0zvl4Plz7L2NCP4gbfEvcI9vgr2OpNHvSBY=;
 b=DC8+HyYBI9GRdOWN4lCbwSkdbaxPFUjdMFsmCB5jhk/LbjeDh3oFsToNIP3k+PX9z04Lcr
 apwRMEaUbihZCzkjTBSKg08U3qWbLLPz+dhF41hF50awTsgoNJhoQ3jg+fsOtsJmnQRSJB
 AjOZpP9KncamJZiWiv5TKWVVHiyBNZk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-khe9lQZ9PAyPsmVZfWwF9w-1; Wed, 15 Jan 2020 05:55:08 -0500
Received: by mail-qv1-f70.google.com with SMTP id e10so10658898qvq.18
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 02:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fI0s8x4dmhvS60GpU4yvV4S9+sxcLuwS6FKjGsD8XzU=;
 b=dBEX4rTO8U5iHT5k8irj8Iap5gQHK7cykp48tpF1ieuRlTvCfKA8u546C3YEKb7m5R
 yIxXCM32/sTMnUMTZfwIUnHw9ZCnHChK+c7eONrH4rBKuMfjbsJtw4cKpgQBltPyElZy
 JM8EaivwLvlPzBfuY41eEL61PtL/OGUNqLWLjzr2gYO9HCaeN1yoqm/axz/FXO7UC2FM
 tgIIf/daMhcewt4Rgru1KjDsEMfgFJWy59YM+Owyk8cQ7D74MbcICWJV33NdfQ0JctVX
 mxf8NIb6opekZIymjK4j+58kTRYmxDkoZvxhhExZ7em7KVI1wgvxHyMU0oh3iXqmoEut
 aU4Q==
X-Gm-Message-State: APjAAAWsDl2XY8aX7y5xV2IQgQyvLn3sPEgsSI2TR3l6+4ft2PzRfFNF
 iENGlAxuzsgp9qpwz+W7Z93hmg5VdqITLBzgjUQgs0rNG/QEnxNUHrpnYhwk4JEpqBgZRK5JoS6
 xajew8FZp6xt01N0=
X-Received: by 2002:a37:68a:: with SMTP id 132mr25469610qkg.139.1579085706392; 
 Wed, 15 Jan 2020 02:55:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxLoyPhpNd5F9KPNVKKHNLiwHWSIRPkYZBetqh0lBMMib8TxHzrtUNVglBELFgHx4D1cxUWg==
X-Received: by 2002:a37:68a:: with SMTP id 132mr25469585qkg.139.1579085706064; 
 Wed, 15 Jan 2020 02:55:06 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id c6sm8081700qka.111.2020.01.15.02.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 02:55:05 -0800 (PST)
Date: Wed, 15 Jan 2020 05:55:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200115055408-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
 <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
 <20200115011412-mutt-send-email-mst@kernel.org>
 <7732900c-5490-6483-ca10-71c565e81945@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7732900c-5490-6483-ca10-71c565e81945@huawei.com>
X-MC-Unique: khe9lQZ9PAyPsmVZfWwF9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 05:25:50PM +0800, Guoheyi wrote:
>=20
> =E5=9C=A8 2020/1/15 14:30, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > Problem is IASL disassembler still doesn't work on all hosts
> > we want to support. And its output isn't really stable enough
> > to act as a golden master.
> >=20
> > Until we have a better tool, I propose the contributor just follows all
> > steps 1-6.  The reason they have been listed as maintainer action items
> > is really just so that multiple patches affecting same ACPI table
> > can be applied, with maintainer resolving conflicts himself.
> > But this job can be pushed to contributors if as in the case of ARM
> > maintainer isn't really interested in reading ACPI code anyway.
> >=20
> > So I propose the following patch - comments?
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> >=20
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> > index f1ac2d7e96..3a6a3e7257 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -16,7 +16,10 @@
> >    * 1. add empty files for new tables, if any, under tests/data/acpi
> >    * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
> >    * 3. commit the above *before* making changes that affect the tables
> > - * Maintainer:
> > + *
> > + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to reso=
lve conflicts
> > + * in binary commit created in step 6):
> > + *
> >    * After 1-3 above tests will pass but ignore differences with the ex=
pected files.
> >    * You will also notice that tests/bios-tables-test-allowed-diff.h li=
sts
> >    * a bunch of files. This is your hint that you need to do the below:
> > @@ -28,13 +31,17 @@
> >    * output. If not - disassemble them yourself in any way you like.
> >    * Look at the differences - make sure they make sense and match what=
 the
> >    * changes you are merging are supposed to do.
> > + * Save the changes, preferably in form of ASL diff for the the commit=
 log in
> NIT: 2 "the" before commit log
> > + * step 6.
> >    *
> >    * 5. From build directory, run:
> >    *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> > - * 6. Now commit any changes.
> > - * 7. Before doing a pull request, make sure tests/bios-tables-test-al=
lowed-diff.h
> > - *    is empty - this will ensure following changes to ACPI tables wil=
l
> > - *    be noticed.
> > + * 6. Now commit any changes to the expected binary, include diff from=
 step 4
> > + *    in commit log.
> > + * 7. Before sending patches to the list (Contributor)
> > + *    or before doing a pull request (Maintainer), make sure
> > + *    tests/bios-tables-test-allowed-diff.h is empty - this will ensur=
e
> > + *    following changes to ACPI tables will be noticed.
> >    */
>=20
> For contributors doing the full work, does that mean the patchset sent to
> the list contains the following parts?
>=20
> 1. patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.
>=20
> 2. patches 2-n: real changes, may contain multiple patches.
>=20
> 3. patch n+1: update golden master binaries and empty
> tests/bios-tables-test-allowed-diff.h
>=20
> Thanks,
>=20
> Heyi


Here's a hopefully better patch. Peter does this address the issue?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index f1ac2d7e96..3ab4872bd7 100644
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
@@ -28,13 +31,23 @@
  * output. If not - disassemble them yourself in any way you like.
  * Look at the differences - make sure they make sense and match what the
  * changes you are merging are supposed to do.
+ * Save the changes, preferably in form of ASL diff for the commit log in
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
+ *
+ * The resulting patchset/pull request then looks like this:
+ * - patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.
+ * - patches 2 - n: real changes, may contain multiple patches.
+ * - patch n + 1: update golden master binaries and empty
+ *   tests/bios-tables-test-allowed-diff.h
  */
=20
 #include "qemu/osdep.h"
diff --git a/roms/seabios b/roms/seabios
index f21b5a4aeb..c9ba5276e3 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
+Subproject commit c9ba5276e3217ac6a1ec772dbebf568ba3a8a55d


