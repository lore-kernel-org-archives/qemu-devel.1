Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C880B206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fN7/5qv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C880B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEbx-0007JE-3d
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUF-0000wz-A4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUB-0001ga-RZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2QwBFExPnrm+QSOonZAHZYTv+JWyU5E11O8o1MzXlk=;
 b=fN7/5qv5DRGaJhmlymLI3YEoTYr6CG2sKyjOr7rXuAy09+xFZ3l01K8GNkjDdepu4vjrwe
 H7PH/XakQQAYBxGAqFCiH+IWzhbpe1W20oHf0vmGsDXQG0eS1LC7QiLTZIJ6SoRkxAPkCK
 ZOx6opddj1bk5/fBaPwnxKGinkP3XKU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-jRsTOEvsMGSh30DSeKQmEA-1; Wed, 24 Jun 2020 19:07:12 -0400
X-MC-Unique: jRsTOEvsMGSh30DSeKQmEA-1
Received: by mail-wm1-f70.google.com with SMTP id o13so4786912wmh.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P2QwBFExPnrm+QSOonZAHZYTv+JWyU5E11O8o1MzXlk=;
 b=rXHAN28huY4/2I+6pStNGyQM3NWG8qB6jwiKs/XaeIzkEdp5haBl9P1klieh1KKiS0
 YinAJ/rw6qYcm1nTUOn8jByVwtepQaVYuPs8A2FGn6BWbf/MJo8YJa4WeQh+CBpdnWDB
 gYskn7l2n9M7mGuOR1MANiS1vLADnpBHolbM3lmsE3TFubeW9ihyIgQj50cpc+NdwrUA
 TFs4d46UWFYuE7zgdYFEnLOndX1h61pj5Ba0X6wfYC6VX9Bn2aiW7M/67A6Mloyi1khH
 nbGTVn1jJ7D7W12YCpjY8EkWBBIbmoKXR8feMHtQcs1P2NPOx2/V4u3xLB+ErJHz2beZ
 0EEA==
X-Gm-Message-State: AOAM532vtsAA16QaLbQ2tfx7cEmZ1kjZ5b8tjwnzwVEiyUR3tqNfLzkM
 G3UfBabQ/QCDcZpQWCZ5a7h2Qa7qSrBwVoGnfAqh16yLvvQ6OIoOykuPTu1PSchvqpWzJYUYViX
 snOMZw+xkA37IDkk=
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr2379698wrq.425.1593040030362; 
 Wed, 24 Jun 2020 16:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze2iV2qsngQG7j3SZlkR/9CJ+L5U0si23SP92JJig0dRqd2ib5WamexHA5Mnd7nndhDrokFQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr2379685wrq.425.1593040030192; 
 Wed, 24 Jun 2020 16:07:10 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 j41sm30234145wre.12.2020.06.24.16.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:09 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] docs/specs/tpm: ACPI boot now supported for TPM/ARM
Message-ID: <20200624230609.703104-16-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Ard Biesheuvel <ardb@kernel.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

ACPI boot now is supported. Let's remove the comment
saying it is not.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200622140620.17229-4-eric.auger@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/tpm.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 5e61238bc5..eeeb93730a 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -346,8 +346,6 @@ In case an Arm virt machine is emulated, use the following command line:
     -drive if=pflash,format=raw,file=flash0.img,readonly \
     -drive if=pflash,format=raw,file=flash1.img
 
-  On Arm, ACPI boot with TPM is not yet supported.
-
 In case SeaBIOS is used as firmware, it should show the TPM menu item
 after entering the menu with 'ESC'.
 
-- 
MST


