Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57877C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E1D20752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+9b4AEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E1D20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcFS-0005rw-6T
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6q-0006e3-Lc
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22283
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6o-0006di-Le
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UID8CLohk74zjOVDUEVQis/G1qp2PmqbcHjIyNMq0d4=;
 b=S+9b4AEIhh085Y0o5Zbnj9LB5zrPNz9JqfLyKRqRUOFJQVLD6JTOppLfQyum6CRffGOl4v
 8TxxrzWIWK7OB+eAPYIaYwVxCC6sL5b1HG1coJHXKxl+8JCcJeA/+1Ndo4k+Idjen9yDgd
 C82dnFxATzMISnfhNUFKHuKlMg7SauY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-zP_pqI23PrC_Fz0LW8A4sg-1; Mon, 04 May 2020 10:30:12 -0400
X-MC-Unique: zP_pqI23PrC_Fz0LW8A4sg-1
Received: by mail-wr1-f71.google.com with SMTP id s11so10857018wru.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PIecKvn+pW1NWjGz2AOTukLgcDwueyrP0dqTTa10Ozk=;
 b=r8NuG6YQtv0UPbF/xl3+nNlXH+bi4Lo0tITdCFY6vgdu223SGS/9ar0QSsIEPAjdUU
 D0I8cHTUJ5CW6gCQfGUIUEvFSF4azgvcmrQ9jxFSVushI4OVDRpX7d2T+MwM1NzShlag
 mNtYP2RVSdrcyT7ndleDeaTgM8ud3xl0s1C+NFpcmmtkGP5GRVNKcVmo16Esl+6w4uKg
 /tRNM8DWtBuREpcVytE3O4DRnyDdRJ5SNAUA+Pukf6yqKQJpiOX53lD+s2JxBHPIqJDp
 6DhuudL181azZq2TZNmx17K70AqvmXRQcTCadpbBOA96Pt9dcA54rn1AUIrh9uOYeOdY
 keOw==
X-Gm-Message-State: AGi0PuYIi0jaugzPI7l4muJQKXrvjwKYwlDUh3w+ekIhdjnDda4oCbPA
 Gmuyg4FSpxuKz+vMgqXjgppLElyoymwWytaiNXjvfyhGsicXwvYeh5i4t3bYYCu0t8DX9yTB74D
 OO9NTna9MhfI3vOE=
X-Received: by 2002:adf:f981:: with SMTP id f1mr1559142wrr.244.1588602610655; 
 Mon, 04 May 2020 07:30:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypK0L8Q1A1DOlwpMbsQmynBirbqCK+R+s7bEyY229DpqoXVmSWjT7sbkY/6/6B5RUJBvnEaS4A==
X-Received: by 2002:adf:f981:: with SMTP id f1mr1559127wrr.244.1588602610499; 
 Mon, 04 May 2020 07:30:10 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 u12sm14364098wmu.25.2020.05.04.07.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:10 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] acpi: unit-test: Ignore diff in WAET ACPI table
Message-ID: <20200504142814.157589-24-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

This is done as a preparation for the following patch to expose WAET
ACPI table to guest.

This patch performs steps 1-3 as describes in
tests/qtest/bios-tables-test.c.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200313145009.144820-2-liran.alon@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 tests/data/acpi/pc/WAET                     | 0
 tests/data/acpi/q35/WAET                    | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/pc/WAET
 create mode 100644 tests/data/acpi/q35/WAET

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index dfb8523c8b..b269a1e3e5 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/WAET",
+"tests/data/acpi/q35/WAET",
diff --git a/tests/data/acpi/pc/WAET b/tests/data/acpi/pc/WAET
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/WAET b/tests/data/acpi/q35/WAET
new file mode 100644
index 0000000000..e69de29bb2
--=20
MST


