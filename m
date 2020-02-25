Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F8C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A8E21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFAUCiwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A8E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6btr-0007NW-Ay
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bt0-0005xs-6O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bsz-0000oW-6v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bsz-0000oB-2w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3d4o92HiKW0GkrgYyraxaRI0YnnUbnRMpXEK0wLk1g=;
 b=GFAUCiwZQN33H2gvYuYGXA6HmfjRy1GeXgMjly7AwTv8i12ut02vEULyEpLzpeJ+yH9gNO
 XmZA3DTDNDiuJ14ejPNw+w6DfxH8esavuvq79axHmWu4ujq+BxSEdqhP2WeZx7IIf/uJUj
 ui2J9TArUzM/6svBGhNN6+l+SXaUhTg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-gXOnsF7tNUCKGtamaXiAtg-1; Tue, 25 Feb 2020 10:12:34 -0500
X-MC-Unique: gXOnsF7tNUCKGtamaXiAtg-1
Received: by mail-qv1-f70.google.com with SMTP id z9so13185437qvo.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=caX16DlQRmHBI59+o89Wqp82tnjVscp7M1/GhbqHicQ=;
 b=ZNGfJiSNPoh5UeIQDCDXppcXTrhVCRWvfwI7hSchOFG6ioHkUajoySxXrK4tvRNmI7
 Arplfusb7+rYWRxfQIlPfb5U/kN5UiQyDipoxI3JIBGhRGJQ3RUTuRFpekin8o1fbjuW
 iG63LigW/tFCpHu4QOp0cMXiMtkFndWbfbF1BQZAgg56orYmCa+ZIplhDiJz7GubLcOF
 EY/tvJO/y1yGcEPs6JkTyyzdiaHTQRjDl79a3wK7fUcvm5U75e8s6ZrNT+AiqeVeiO8W
 1QzWRw1+6jY4rwiBnxKRW6it1kzzmypEUYYsdXrq+lsuC1OqKYDfNLJqe5JIbICE10pF
 5ePQ==
X-Gm-Message-State: APjAAAW9lDTPuICK8rPikx8I0Fbz/LAnmHMgFee64Y4LrLtPRO2TyEbW
 +yP9UuCd5xw5IFZv5cZMb5+4DSfIAvePwC/Ngqmi2Fktk8i9v3tvteTItpN/UpGuXrDQ0YN0D+u
 Cxk8IiOLa7uq+vg4=
X-Received: by 2002:aed:2284:: with SMTP id p4mr53136601qtc.329.1582643553898; 
 Tue, 25 Feb 2020 07:12:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqx61SHuYU7fo49VdiMEpr4z/EteNFTlFvooc5ZWv5FM3wnBrA7Z7N8iNBTnJBxNBUZflhFbPQ==
X-Received: by 2002:aed:2284:: with SMTP id p4mr53136583qtc.329.1582643553670; 
 Tue, 25 Feb 2020 07:12:33 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w1sm7770188qtk.31.2020.02.25.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:32 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] bios-tables-test: tell people how to update
Message-ID: <20200225151210.647797-2-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now just a pointer to the source file.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/bios-tables-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index b4752c644c..9c3c4680e4 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -426,7 +426,9 @@ static void test_acpi_asl(test_data *data)
=20
         fprintf(stderr,
                 "acpi-test: Warning! %.4s binary file mismatch. "
-                "Actual [aml:%s], Expected [aml:%s].\n",
+                "Actual [aml:%s], Expected [aml:%s].\n"
+                "See source file tests/qtest/bios-tables-test.c "
+                "for instructions on how to update expected files.\n",
                 exp_sdt->aml, sdt->aml_file, exp_sdt->aml_file);
=20
         all_tables_match =3D all_tables_match &&
--=20
MST


