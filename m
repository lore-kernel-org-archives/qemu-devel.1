Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C68C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F7F208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBpL7ONE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F7F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSeo-0004O8-Rj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSdZ-0003TD-99
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:37:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSdX-0004j6-Hr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWLY1FB3r/Id8vLvvBQnYkX64zV38I2qeMOakhNbn/E=;
 b=QBpL7ONEMJMwKHxZpKtBeQvCo8aTw0YFDhRNOpmleBet6rlPJ7cEZCjSO0z/fF3Khat+KG
 w8vrIxnsHFqT9xfub2b/dOupBk6GZSAsE3UkrCdcETT9dVxstQdU8beSFP53OR8GiYxZQo
 tTr2IWmBDwKoq1TR4vnT9JPAdL7ffUc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-lbpe8V4mOwOs5RjII2IFWQ-1; Wed, 17 Jun 2020 03:37:28 -0400
X-MC-Unique: lbpe8V4mOwOs5RjII2IFWQ-1
Received: by mail-il1-f199.google.com with SMTP id c29so908833ilf.20
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eWLY1FB3r/Id8vLvvBQnYkX64zV38I2qeMOakhNbn/E=;
 b=LSjc/N3MTjM08Dt+pe9f477pWuuaBW+IEnh/TEX5VK2c3ba/xZcmvWfFDY5PUpyO8k
 TthpXC8CFXg11sNQwkMTe8OrxGcok2OIzDFI+oyxsbqiBjj8jMuM6UAlh53b7yKhQKXt
 SrOMLLeXbE9cNBSxYeOYTo107m+kEi32bJ4jGEoaamF/fnMH2Bm4nx9OirHYxENvyXZW
 e403bz1FhPlzu36LngfNmSQ1V48CwEQ1eDGgpSHQLWEHBZ00DW4zFpv5zfrHB2cSdRFN
 gJ1nqwgGn9xR26XYNdq8Y/jodm0rqDjvXpsJb00xz74nbKI8jk3pyBq9mMBzxVL2/16m
 kRGQ==
X-Gm-Message-State: AOAM533E5r9kdd89xwhK5or2oJl/BU+yKEw2cSQkJI2uOxpEM1iTORY/
 NcJwdvyrsPZ5S6vN1Wjex1wDFGBbvLa+6Fu23I7p3X/6GJIwrFTbYZuVra4cyrKEIprqE+O2aTK
 6wmV4dQz0O2RgpGLtVQx/RcGOz12u4ec=
X-Received: by 2002:a05:6602:1616:: with SMTP id
 x22mr7280496iow.70.1592379447540; 
 Wed, 17 Jun 2020 00:37:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8Lsybg1bTCpPhk4AQ0gSz9tOZsp1l1NEhIxT4+/4NpZE5ie9F9YMkvGVjobBH/EehATaTA17ReQx7He0I6o0=
X-Received: by 2002:a05:6602:1616:: with SMTP id
 x22mr7280481iow.70.1592379447273; 
 Wed, 17 Jun 2020 00:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:37:16 +0400
Message-ID: <CAMxuvaze8sbWfcWtcj+JJJvvjd+0Pz4u4=pVFSDcTtq5gE_45w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] tpm_tis: Allow lowering of IRQ also when locality
 is not active
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:57 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> This patch fixes a bug that occurs when using interrupts. It
> allows to lower the IRQ also when a locality is not active.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_tis_common.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 1af4bce139..0f42696f1f 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -601,10 +601,6 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr =
addr,
>          /* hard wired -- ignore */
>          break;
>      case TPM_TIS_REG_INT_STATUS:
> -        if (s->active_locty !=3D locty) {
> -            break;
> -        }
> -
>          /* clearing of interrupt flags */
>          if (((val & TPM_TIS_INTERRUPTS_SUPPORTED)) &&
>              (s->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
> --
> 2.24.1
>


