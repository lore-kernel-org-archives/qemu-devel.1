Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EBAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D7E20853
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs6o9SFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D7E20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSfl-0005o4-Ke
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSee-0004SS-El
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:38:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSec-0004o0-QF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ClMhna20Rma45ApqZ85KbVBLPUKCIx/Ep1Kd67/J+E=;
 b=Zs6o9SFss/L53NIaDV5ROQRLXMUDtZKKPFpvhspOQTqkbKfmVkAbQF/irrVC4v9jChqA0A
 iLK2R38a/w+sSGOY2XPSmhK8eIl9nuikr7edVs8t7urpiiNI4D8rxjDVpbiPcfhZ4o3WQe
 gqeyQWRxT/dLS31DXY4X4Jtpsi7Mnl4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-YMbttxPkNVWLWPD9Eg8uDA-1; Wed, 17 Jun 2020 03:38:36 -0400
X-MC-Unique: YMbttxPkNVWLWPD9Eg8uDA-1
Received: by mail-io1-f70.google.com with SMTP id v14so1208136iob.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1ClMhna20Rma45ApqZ85KbVBLPUKCIx/Ep1Kd67/J+E=;
 b=roa6XoV/o3BqCDYeQ6BpirclOfCVebmStfN8eNBtNP0JvIvSIurjI+6qKs4bQD7I7I
 8YSZQWP3nvJIrnujJOtCgL2+uml+C+WpIntSr4IpiqMijtFTD+anWeoZVb3ZfxjAmDC5
 LTMCUVdcXIFGCxGIPAN0ytVAr1XZ6uTmOb981OoCvX5WqOZsRc9+l++wkTfixZO3j16C
 OdRTIuSLBbWG/y+6jd98K9hTG6AfC1U5q42Ketxqf3pUBXb5lxfQVKmuAC2KPkF5Atz9
 ACAuAlUubSwtEDAryNwjBjKCoCGSS93Ws9WIz2TvsBivctumiGl1oBrrQC9Gxa0pB8MF
 yGeg==
X-Gm-Message-State: AOAM530+d4TZJaqW9hfWtkSW8Q9AhUiXJRuV9SLERBD+YcKOxdfuki2a
 lT1tObzpb4lP2swQMckzRnrmqIFaA6webEiYfBnEzMx6W0QZgCisqHuqXBbo4VLgXNwCqNjn7RE
 P8jLkTjqz8zafXHpcnUmLUj5W40PoX1o=
X-Received: by 2002:a92:8419:: with SMTP id l25mr6780025ild.182.1592379515746; 
 Wed, 17 Jun 2020 00:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztbM5pgUG91i72tmyW8dUh25KCiZKIEbJ2nRhS/LLO/kAHm3DfZrhDXixYGftLy07VR3w+0uLEHPWhwM7di1A=
X-Received: by 2002:a92:8419:: with SMTP id l25mr6780015ild.182.1592379515534; 
 Wed, 17 Jun 2020 00:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-4-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-4-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:38:24 +0400
Message-ID: <CAMxuvawoGnmA=-GOR1rkhVqxTSMxbprED0xGE8_0jr2Uf8EECw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] tests: Temporarily ignore DSDT table differences
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
> Ignore DSDT table differences before enabling IRQ support for TPM.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..bb4ce8967b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.tis",
> --
> 2.24.1
>


