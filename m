Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84567C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F97C21475
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrNiMZnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F97C21475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSk1-0004MI-Ji
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSgt-0007s5-Kb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSgr-0005LM-Oj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zi3c1CLyzhm/hFW/MAE40l5DhuZUVhVzINXpHZciyOc=;
 b=BrNiMZnTlQDa91aOH9Tq8wfKl25qZuLN6oyPcSRefINMe8gDkqnKiY5Kcal0f705cXc/cq
 wEGDRe6UJjyFyndsncRdy/OVi8w0Jj9E16lBw6j07+5sukglqt2dTKlEFL7JFwS0veWHDK
 OXKh2xgkQMM9R9FsUT3ZCSs64qAlgf0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-qy3UmzXkNeaoJ6DtrxwxUQ-1; Wed, 17 Jun 2020 03:40:55 -0400
X-MC-Unique: qy3UmzXkNeaoJ6DtrxwxUQ-1
Received: by mail-il1-f197.google.com with SMTP id v14so910499ilo.19
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zi3c1CLyzhm/hFW/MAE40l5DhuZUVhVzINXpHZciyOc=;
 b=jaQjsVPorP34/M6dHW1p5phE1cq+9ypwlkGSGTu78tWIXCX5giv9u8G53nl2SbWbOz
 BR7dc5mupULjOtshJI4DXCTefCVTMprJsuO1KboYXXFX/9RrokFIxQmwkASsHLqEFSP/
 hnmdA+/nmbwcixJMUnhBhCfT4y9jSd17sc7YYYznJ4UErVmdouQtcb48KBGhLXSWIhLs
 kxBApGXHajds+gp7txYZMHumPlorgGM1+bX4lSmzR/X438kHZLGRcxIYeDNthbb03gLM
 RLebNJ8o1bJuZu+Ro6KzlC/XiPCVzBCpCH7C6ivtfesxgw5Vht7XpiONEraK8VswwX7q
 Wwxw==
X-Gm-Message-State: AOAM531n/1SjQxxSldda0sGFdcuQdzbBkpmQjNP5dlOA24V4cfUsab7G
 SfqWOWvVC5QMfm+Nnp9lqN3XAaKTDP1YcbHQ2M+FgRRjm21hpw9vvI03XQ/n7AEzVUgM82wMwba
 JWzPaGKBCUJ000jjS2FeC+M6h4lmkfM4=
X-Received: by 2002:a5e:de03:: with SMTP id e3mr7226786iok.0.1592379654893;
 Wed, 17 Jun 2020 00:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmfiWcCE7JhLBNyN0pK+ZaDYn0FBQ5rOPlEczs4xvbnM6reiCxBmPI6bQ+gvZdBgE1Ieh99fdSpmFKiG5v168=
X-Received: by 2002:a5e:de03:: with SMTP id e3mr7226773iok.0.1592379654662;
 Wed, 17 Jun 2020 00:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-7-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-7-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:40:43 +0400
Message-ID: <CAMxuvawf+Nmw5v0p7r9ncMFOm+FeB=xFpEd8awqcHNj07M7FBw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] tests: Add updated DSDT
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:57 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Add the updated DSDT following the interrupt enablement.
>
> @@ -5,13 +5,13 @@
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/q35/DSDT.tis, Mon Jun 15 09:57:05 2020
> + * Disassembly of /tmp/aml-Y77YL0, Mon Jun 15 09:57:05 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x000020A5 (8357)
> + *     Length           0x000020A8 (8360)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math supp=
ort
> - *     Checksum         0xAD
> + *     Checksum         0x77
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
> @@ -3162,6 +3162,8 @@
>                          0xFED40000,         // Address Base
>                          0x00005000,         // Address Length
>                          )
> +                    IRQNoFlags ()
> +                        {13}
>                  })
>                  OperationRegion (TPP2, SystemMemory, 0xFED45100, 0x5A)
>                  Field (TPP2, AnyAcc, NoLock, Preserve)
> **
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/data/acpi/q35/DSDT.tis                | Bin 8357 -> 8360 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>
> diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
> index 56b6fb0c3298517d080e38fea05a748b9f1dba54..3f9db960aa05d399fa7f8449e=
6db688788211832 100644
> GIT binary patch
> delta 64
> zcmZ4LxWbXkCD<iog#rTuWBEp|KeC)oS~2m#PVoX>llkS`nVeK7N60A%iEs(FaWXJ6
> UFkJb^5Wv8o#GtUbT~3Y(068!Z;Q#;t
>
> delta 61
> zcmZ4CxYUu$CD<iosR9E7<Jyf}e`GoRHDls~o#F-DC-cj>Gx@7bj*wH}7v$n=3D<78lD
> RV7T&+A%KBlbC;YP695=3D#58(g+
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index bb4ce8967b..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.tis",
> --
> 2.24.1
>


