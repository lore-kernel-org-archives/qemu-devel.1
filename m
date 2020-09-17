Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D506C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2500F206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="DX3NofpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2500F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIosI-0001ux-6z
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoem-0000MB-Dy
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:56057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoek-0004s1-7y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id q4so829089pjh.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eGvwMIg//nVaSwB5b6vp+yZxZ168K+i6gZVuZ3FBQKU=;
 b=DX3NofpQADEDS6vXuJyDLrlae1FvT+uN3J3EvqdqTADEgoK9ePi5CJX3ipOErv9VQu
 tm4lXBgIEB3jQLppnHjq29Ch81ZDtJDuArlh/ssQXRbbRVZqT/jc2MgZjWM7txYGkasO
 LZBFbjxmRS/s5tMiT59zU89ft41YbqCYxnqmigxLzkpqr9KTYnW/tuEHXdOpQUu7kuEW
 rnzFJxj0TBslLOzoQbBzGnSEcT606oz8TfLnooiyyiq3JiMlVDTfAk7erp/K2Q1sLNju
 lkNUqNTzyda3drZeVvvfdthIFcq67nde+RgIXku8q8zdedEC3gVndMZWHdlhWcrTmTXU
 s+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eGvwMIg//nVaSwB5b6vp+yZxZ168K+i6gZVuZ3FBQKU=;
 b=Nyo8oS5RmzK/JwrGMsNJ03DauRGAEMMvHYoV/zyI6xBVgjI2HfNYGSn2GU2PlVsb15
 UVbKL4UKy9byl/VwVbuSAwR5GEysnVIMF6fTZlAhDgGWgPZqMgT9bDIHx0msHlRG+Qun
 eUZNnpzpo9gmKsV/lLscBDHMgZIftg8Yzd9OuUoeypFoe4mclzLwD4wzlAeyQNkCe7/6
 NQAYGrT+gNSH8RdtWRiBflyN9TcVEov4w5ShZia7W60jxzP810R120brUBBqxZKOkBBQ
 XVnMF1cSTFYWIeY3xpiG4BDnJwIdqGGU8KCf7DI7m8606XL63PLhr+OKyPc9gKc95ui6
 ZKQg==
X-Gm-Message-State: AOAM5316oJAcZi2RDdFlA4OvIGqQ918l3ctliGR5hz4x4UzDK3Tij2sM
 A1uluj91ql7wrcwpIwKK+A7SGJTOXO3wPKJy
X-Google-Smtp-Source: ABdhPJybmoAdM28G1xW4YHUzYuGrkieAO7JeAj/gDqQX+V4DTDhFfQ9bcMjNs/iKKjGrryS3A0T6Jg==
X-Received: by 2002:a17:902:d909:b029:d1:f551:c354 with SMTP id
 c9-20020a170902d909b02900d1f551c354mr3906029plz.83.1600328916468; 
 Thu, 17 Sep 2020 00:48:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:35 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/12] tests/acpi: update golden master DSDT binary table
 blobs for q35
Date: Thu, 17 Sep 2020 13:17:30 +0530
Message-Id: <20200917074733.13612-11-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the change d7f82561fe ("piix4: don't reserve hw resources when
hotplug is off globally"), we make changes to the ACPI DSDT tables
such that some ACPI code are not generated when bsel is absent. Since
as of this point in time, in q35 machines, we do not use bsel for pci
buses, we need to update the DSDT table blobs.
This patch updates the golden master table blobs.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7670 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 8994 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7688 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8133 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9323 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7745 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9029 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8801 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7676 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8276 bytes
 10 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index bba8884073a27427b88ac0d733c9c87330a59366..4fad91b72e279b744b0528fd687c862d3a3d5cfa 100644
GIT binary patch
delta 33
pcmexo{mq)oCD<k8n=AtZqxeRyWwM-ZEHUxHPVoYElXuD50sy=Q3Pb<^

delta 42
ycmexn{m+`qCD<k8pDY6d<C=|J%VfFySYqOXo#F-DSSIh3wPhD!3vl)eVE_Owj0{Tv

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 9cac92418b5fcc2767dc74603d599642b59623fe..e4df7d1ca89578dd81be3539c8f83f073bb8db25 100644
GIT binary patch
delta 33
pcmZ4Gw#bdkCD<iINtuCx@ySN6OG=z>EHUxHPVoYElb<Qs0syHh3KIYT

delta 42
xcmZ4Fw#tpmCD<iIOPPUzv2r8VB_%FDmYDcpr+5K3mdQ_*Y}rNF0-XIq7y$jZ3mO0b

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index f08b7245f59aad491fcaa60e2bab1085c369ea1c..065399174575442201cc09ffa4939ddf90ac81b4 100644
GIT binary patch
delta 33
ocmeCT>9FB)33dtLkYiwAT)&ZPnJlLVYfOBwQ@nt~<ejqq0G06xDgXcg

delta 41
wcmeCM>9^r>33dtLmt$aH^xnv|OqSE1H6}jTDPF*R@=jTQb`iD!XTJ~z0NaZSF#rGn

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 57d859cef9fa16a8f125c4b338611c8472699f38..8d2395e3cb4383b30e3840caed0d09ccad0c7323 100644
GIT binary patch
delta 33
ocmX?Wf7G7KCD<k8s5}D$<AjY|rShC^EHUxHPVoYElRM>Y0kO^r)&Kwi

delta 42
xcmX?Vf7YJMCD<k8tULn)qv}SkQh6>vmYDcpr+5K3mdPFRw(KHo0nUCQ3;+bB3f%wz

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 9d5bd5744e2ba2e0f6126c3aba0bb36af865e499..df7422051c6feadeaa3b6733ad7efa67c339b49d 100644
GIT binary patch
delta 33
ocmezD@!EsSCD<h-TZMsvF>)i9v<jyiOH6#QQ@nuPWPKG|0ILxQ{r~^~

delta 42
xcmaFu@!5mRCD<jTScQRs@!du)X%#L%mYDcpr+5K3mdSc5w(KHo0nUCQ3;+_P3k3iG

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 5cd11de6a8fe47324e5f922823a22746882f19f5..c4ce5cc0ede822ea82656d078d7a8b7eee4a7516 100644
GIT binary patch
delta 33
ocmX?UbI^v%CD<jzQI3Iu(Q6~uM_EocmYDcpr+5Lo$*gj=0Hl8i@&Et;

delta 42
xcmX?TbJB*(CD<jzQ;vaw@%~1xkFs2TEHUxHPVoY6ER$K}Y}rNF0-XIq7yt{`3i$v4

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 05a7a73ec43130d5c3018bb462fd84981bfb151c..84614ffc1452358053b4c2be4b2edcb4d56a9ae6 100644
GIT binary patch
delta 33
ocmX@>cGQi_CD<jzRhfZ-kz*s*S0zq2mYDcpr+5Lo$(+iz0Hk>c=Kufz

delta 42
xcmX@=cGiu{CD<jzSDAr<aqdR0uS#5gEHUxHPVoY6ER#8uZP`WG0-XIq7yt`p3hn>^

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index efd3f1188f2b55da1514212d4be081a61c2a96e9..d8dd702b69cc24a6b58b8eaa79ea02439a2a7dd9 100644
GIT binary patch
delta 33
ocmaFi^3a9LCD<h-QHg<paqmX1|B9R*tTFMyPVoW`lZBN00lUBo5&!@I

delta 41
wcmaFp^1_A7CD<h-Ly3WbF>)i<e??Az)|mKUr+5MP$wEs0>>_Ld&VC^b00^lI82|tP

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 1978b55f1255402bf9bade0b91150b5cb49789a4..f36d22063a6eed4fb107ffd0e10477a2d6d7a983 100644
GIT binary patch
delta 33
pcmZp%`D4xH66_N4N0xzs@!&?THL{#;EHUxHPVoYElMl$+0sy+k3XK2&

delta 42
xcmexk-D1P#66_MfBFDhM7`l;bjVzZROH6#QQ@ns1%jEsCw(KHo0nUCQ3;^@W3X}i<

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 638de3872673d17b1958497d0e62c83653de1602..203030a61a92c204bb93c43fe79e546471ae2985 100644
GIT binary patch
delta 38
ucmccZaK(YkCD<h-M1g^U@x?~2O|qOGnlbUgPVoW`laI>UZRU~-WC8&31`DbH

delta 45
zcmccOaNB{)CD<h-T7iLqv1KFICRt8@&6xOLr+5MP$wy`F*hJU@oc%&JGsy)p0RTF+
B45<JB

-- 
2.17.1


