Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B60C206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNu31BtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B60C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa1T-0001e5-B6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZkZ-0004Jf-NU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZkY-0002vN-ND
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588593545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvBdJ5beAcx5ETaxyqLjGGsvHSXEGwdO8SCWGzPboug=;
 b=iNu31BtRYBfm0ygi8k9GLX16ZmXvq8BlBpH/7gHSepPcz29WibQZRQKZtQsw0tdLYlrIVL
 UgshCFOr8mO+R9Sv9kRsMSbNb6z0ZBs0njTw9tIACAh2QGgRM0QX/dpm+8eqszjqDAeelz
 FQFK0MIT77ZCaYMvTlmVWkxxVJrhHHg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-yry_MjBHPsuuOfh5M4D6sw-1; Mon, 04 May 2020 07:59:04 -0400
X-MC-Unique: yry_MjBHPsuuOfh5M4D6sw-1
Received: by mail-wr1-f72.google.com with SMTP id q13so1753827wrn.14
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JtHWGy8MS63RnTw62YE9/Nri9iozspFrFIvB4vm6Ufs=;
 b=DAV5uxOjFXWOT5LZwPcqKyuI/PinLVF0kKX+FFGISLRYDNHEkgk37r8rT1yvu+kF6F
 dLZsqlAW9brFnNi/dROiZVUjuJ3A/2+zT1fnyI3XLo45s4q9XTogXYLHijrnP7GelF3k
 A2XDO92P2h59kLDHfY8gxVkbTs3R0MKegwgrabbxY4SM5ZjMVCFzMHHPZbeP6LtF8wMm
 KlTVidNJfnLylIJtgpOX9COKT7xdc/dR15m4xMMNKaZu/Xo9n0PjEIEaHYDzQbzfBQ1i
 wWJ+QYF3VFbJuvTLmZD6Uu1mlohlA4jbLqzX/V/TcfCio/L6J3um+06v4wx24oQlnqRK
 p4ig==
X-Gm-Message-State: AGi0PuaC+Ap4ugYnLXAsTiFQhqBkvXTifDQPQetds5U0j0FsRCnFmHNN
 EwQfSLcels0pxRYvU68PhSKP7KfcKKLpcw7zvszLB1nNENkBbeqWpgFUMGZ4xzNdXkLAo2B+uc8
 cdRxln/MmtN2HsVY=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr14184560wmd.87.1588593542836; 
 Mon, 04 May 2020 04:59:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIoUoNKzHtakki1Y3rqsnGxwoG8otU9SeIdSkWIE4zIWiyR3cnL77EY4N8aqOWGLb8eBs/zZg==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr14184541wmd.87.1588593542671; 
 Mon, 04 May 2020 04:59:02 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 y9sm12523345wmm.26.2020.05.04.04.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:59:02 -0700 (PDT)
Date: Mon, 4 May 2020 07:59:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] checkpatch: ignore allowed diff list
Message-ID: <20200504115848.34410-3-mst@redhat.com>
References: <20200504115848.34410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504115848.34410-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow changing allowed diff list at any point:
- when changing code under test
- when adding expected files

It's just a list of files so easy to review and merge anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c3d08aa99f..0ba213e9f2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1261,12 +1261,13 @@ sub WARN {
 sub checkfilename {
 =09my ($name, $acpi_testexpected, $acpi_nontestexpected) =3D @_;
=20
-=09if ($name =3D~ m#^tests/data/acpi/# and
-=09=09# make exception for a shell script that rebuilds the files
-=09=09not $name =3D~ m#^\.sh$# or
-=09=09$name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
+        # Note: shell script that rebuilds the expected files is in the sa=
me
+        # directory as files themselves.
+        # Note: allowed diff list can be changed both when changing expect=
ed
+        # files and when changing tests.
+=09if ($name =3D~ m#^tests/data/acpi/# and not $name =3D~ m#^\.sh$#) {
 =09=09$$acpi_testexpected =3D $name;
-=09} else {
+=09} elsif ($name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
 =09=09$$acpi_nontestexpected =3D $name;
 =09}
 =09if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
--=20
MST


