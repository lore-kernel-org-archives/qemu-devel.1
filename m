Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8338C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857412074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROp95BS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857412074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6ok-0003lb-Nz
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6ni-0002T0-Ls
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:34:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6nh-0006tq-31
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:34:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id k2so3159709ots.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hWXWYJTXkuTqo3CUEMsAfd/R4sAEzt8NMJoEF221juw=;
 b=ROp95BS7g+F9CTgMVDMZ2esh7U+11uulsFE/nqZIwBcgHLc/KCoT+gNHMlC8PV4oku
 giHpIwvcJ5OsONAkBGYRVp5tUg0m5C5nJP8pu1RojJmxmxZnNHLnSWKBUIoyZWmupIf+
 lUSyRgY4xE98FqCz7O1RKa3VzEntkB8dsZyC/ori2Cr2c5kDIjBs4B157OtFznOEpIYu
 Rq9qjZt1plIpiOm7SNY+6RTNaSPS/cEREIuyRpwYR8Q3VgZwWjLYZ6pca45gbZMsRmno
 GfTcS7qCzMBtJa7pFXrmKk6PVgJ7SrYWBPUevj4zIvu3fj5HaAyl8J0LPPbIQZvQTGeP
 5neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hWXWYJTXkuTqo3CUEMsAfd/R4sAEzt8NMJoEF221juw=;
 b=YToEeE+kBc9u/WUTNcdKByk+lMKmIEIIVMVNxsY6dsr9daLze+L3xErhOfRtDKbWVJ
 fWdvKxMbimumtpWjRoOimQ2VqTe3yZEHaQu8nY+Vvn/fM1wVoPUQwoC72ErmGKblncGZ
 RlTD0jG28tyfxMaYPkJ8bWaH5KHuCFUuEjn7W1sw/3WsG9kjd13l8XaSPV55L6OV82QH
 yQ6/hZc62ywOL9JAdOjJejjgWJ8rdr2fJQXMf/ukS7bXHQMfhZdiXRPFzhtTl68BW/2O
 +rB8YWPJxxG4rOgc8N0o3ZGKhhEIlVMoUR2jgjqhAHdkxLNWzK+G3oARr+VosbSmuIhb
 97DA==
X-Gm-Message-State: AOAM533gC6YZOfAM6M0eu61e8yvon6ja/DzEyam+/qNcRdVlpUh4KdwA
 +N+2AfDKnam8dxD5IROf+5lOocpr6ZYzZVlfby4=
X-Google-Smtp-Source: ABdhPJyiS7pekTGTsMEe+2MPclOzPjYvCnauo9iKe/lfbhYL+WB643Dj87B8QDK6hQzM7zsevb/GW3ZzqGvhagnJqYY=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr8317379ote.353.1598492039908; 
 Wed, 26 Aug 2020 18:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-9-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-9-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:33:23 +0800
Message-ID: <CAKXe6SKOGjK75Yc42+dAuugA79ghHwRHiaOMcUeL9BoZXvHyxA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dc390: Use TYPE_DC390_DEVICE constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:44=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/scsi/esp-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 497a8d5901..90432ef107 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -521,7 +521,7 @@ static void dc390_class_init(ObjectClass *klass, void=
 *data)
>  }
>
>  static const TypeInfo dc390_info =3D {
> -    .name =3D "dc390",
> +    .name =3D TYPE_DC390_DEVICE,
>      .parent =3D TYPE_AM53C974_DEVICE,
>      .instance_size =3D sizeof(DC390State),
>      .class_init =3D dc390_class_init,
> --
> 2.26.2
>
>

