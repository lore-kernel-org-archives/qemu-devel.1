Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130F921475
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm8OA7nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130F921475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSit-0002OS-BE
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSfS-0005c3-Ch
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:39:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSfQ-0004sF-Pa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4UROLzYsj9W8t/oenxoariN+wLC21KvWh/krAuS1V4=;
 b=gm8OA7nSpCAMHKoRQ3e1jy0TEDXLQrJl+lr/jFw/Kv6/SNkUMDn+w15P1yADShGSeeWVum
 lfsiHfy+K6MuWsDA24dTPDRS8e8xEOIHEiyDTng+buiXcHbbAS7lb2qg4Yax8ILXyPyDxj
 8D9fxr9T54u7LKDDF87IywgVTo+NUIs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-g4R-NWzDOhm2AW0OAhPulA-1; Wed, 17 Jun 2020 03:39:26 -0400
X-MC-Unique: g4R-NWzDOhm2AW0OAhPulA-1
Received: by mail-io1-f70.google.com with SMTP id g3so1204218ioc.20
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F4UROLzYsj9W8t/oenxoariN+wLC21KvWh/krAuS1V4=;
 b=Xygj28NENyCA6MaMyF8X6gp5/lkHPq+wSQ9rXsUCtj8c2iuKT//aPFPwm74dkxoWl3
 w2vigxQRsrj3Aw1PgciplzuPOfyIGbSGnwm880F0tJAfZgNrtbGygCD7WQacswHNgJiv
 Ot0WltwB0bry5xz03VfkXV8KJR4fcm9C954rJrkjBIYiwdLPQ2edj46fDTw9YknJI7QT
 XIG4NdLgjKNIpX/6FCTk2PKeaMQxd1mNSxIC21+fGRfJMFRjs7zrx834pWBmzI72ld09
 oT8nDi5ZCBLbYNXw8wI1xVQ9HZLmQqM4/3Ul7XiXL8EqT6NJBAG2vtI97t6QtdmQrKrB
 PUsA==
X-Gm-Message-State: AOAM532AfRKQAKLDY1kwx+zyQqqWtWHxht/q045KMN7UmuVT41MNVDZy
 oMmxSkXCxhpOPBirug1xqxA6BGSAn77JKcDMGrAMpO6fk/TPLiWf1B1b2nG5XeNsP9pDO4Yllc+
 3sP1aLZWCmXy+oDE+sJnLMVUoqV0czUI=
X-Received: by 2002:a05:6e02:ee8:: with SMTP id
 j8mr6932431ilk.11.1592379566061; 
 Wed, 17 Jun 2020 00:39:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/1ddRpXi1xPUZBXWCXyRvR77L+EKwNKVieKH+u459xNyhUz+FfVKgy/cEqbfRKMV1ZD2KfZCrTVtSSCwZImo=
X-Received: by 2002:a05:6e02:ee8:: with SMTP id
 j8mr6932424ilk.11.1592379565921; 
 Wed, 17 Jun 2020 00:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-9-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-9-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:39:14 +0400
Message-ID: <CAMxuvayuymiptNLJJiG617OtqkkkKq8yH+=cg07LzOcZTpG1uQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] tpm: Disable interrupt support for TIS on sysbus
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:58 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Disable interrupt support for the TIS on sysbus.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/acpi/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d356f2e06e..21f81690a5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -25,7 +25,7 @@
>  #define TPM_TIS_ADDR_SIZE           0x5000
>
>  #define TPM_TIS_ISA_IRQ             13    /* only one possible */
> -#define TPM_TIS_SYSBUS_IRQ          5
> +#define TPM_TIS_SYSBUS_IRQ          TPM_IRQ_DISABLED
>
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>  #define TPM_TIS_LOCALITY_SHIFT      12
> --
> 2.24.1
>


