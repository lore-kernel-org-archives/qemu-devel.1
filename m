Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B88C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F800206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLR2caxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F800206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsj0b-0007gi-Gd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsizw-00079D-A0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:30:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsizt-0000Wh-Mv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594110636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81j/f2SmubbTpLMzcDih/UI4HfgaG+g54LGVwewlpCI=;
 b=FLR2caxb7QimYzKck1DAyke8CQVUZqU8ZjAWTWfIhYDFGTCpFE7olnVPSdujFEnN/epcSp
 J/gMmmvaQYmHXWewTdZ53CxKVxjKpZAbY0KFnEOrI8p8gyNdCQvb7myIqAXJJNIhtOnf6x
 U/4yZapcw+NkbLztcS/UJtvbj/JJtAI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-CNLsbJ4PMNis2IRKj9uNBA-1; Tue, 07 Jul 2020 04:30:32 -0400
X-MC-Unique: CNLsbJ4PMNis2IRKj9uNBA-1
Received: by mail-oo1-f71.google.com with SMTP id n21so4887069oos.20
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=81j/f2SmubbTpLMzcDih/UI4HfgaG+g54LGVwewlpCI=;
 b=VE7WlOk3XwdgyKXmQBEIXWvqAZ6a+ltGE3/zU8TLxKi3O7mLBTiIRXHC1zPXzACgu4
 ousoK4PmRmdRp+QLXdh/8bT7U2gsSWhSdUnCzDswaAfDXhnz9WcM8fCyjevwoiiuxX0J
 1qlJ2cwzDu93qNwGOOb/x2pvZ97tQrKm502N6SNAEZR4fWvDlU5iGpVI9QPOF65ga9U2
 HyP3htOGmV8BJz7ilfCCplj3ySktROxxwwt0v9DVLqlXk4XZcIp1yrQe0uYcBntLF6iF
 3NTm0wtj/pkQzIlmQP/Lhaeyne/M0oZubfPwxzTiu1kvphi8lGKaX8pG+QXi4xutHi9D
 oG7Q==
X-Gm-Message-State: AOAM531ejum100px+E56ITJm6tQKx7oVbEKNjuWE0hfI8RnnDfnCiFAB
 uk4E4ARqtpmSTyk0aTa4S9kuasxblFgltHfBMmpUMKv2risjSzavWtMhGA249VrIC2l2GU+oc6k
 ECyIg5nbJfZlvhInOQEtCEmkD9rb6gRQ=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr46558505otg.79.1594110631573; 
 Tue, 07 Jul 2020 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1GLQ4C5KvHBoJTmy4/q+ap5E7gM2KOi/AS2uUKKO/ULUCG12OOaijbFC0kAU3Q7A52cuArpVYJ/j6Tf3Ab7w=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr46558493otg.79.1594110631312; 
 Tue, 07 Jul 2020 01:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-6-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-6-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 7 Jul 2020 10:30:20 +0200
Message-ID: <CAP+75-V-Uu8-Uk8jMwkgb3xJpFoef=k6p=ejaY4=+njkdb3ZeQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 3:39 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Only move the state machine to ReceivingData if there is no
> pending error. This avoids later OOB access while processing
> commands queued.
>
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>
>   4.3.3 Data Read
>
>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
>   4.3.4 Data Write
>
>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
> WP_VIOLATION errors are not modified: the error bit is set, we
> stay in receive-data state, wait for a stop command. All further
> data transfer is ignored. See the check on sd->card_status at the
> beginning of sd_read_data() and sd_write_data().
>
> Fixes: CVE-2020-13253
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)
> ---
>  hw/sd/sd.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 04451fdad2..7e0d684aca 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1167,13 +1167,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>      case 17:   /* CMD17:  READ_SINGLE_BLOCK */
>          switch (sd->state) {
>          case sd_transfer_state:
> -            sd->state =3D sd_sendingdata_state;
> -            sd->data_start =3D addr;
> -            sd->data_offset =3D 0;
>
>              if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
>              }
> +
> +            sd->state =3D sd_sendingdata_state;
> +            sd->data_start =3D addr;
> +            sd->data_offset =3D 0;
>              return sd_r1;
>
>          default:
> @@ -1184,13 +1186,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
>          switch (sd->state) {
>          case sd_transfer_state:
> -            sd->state =3D sd_sendingdata_state;
> -            sd->data_start =3D addr;
> -            sd->data_offset =3D 0;
>
>              if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;

Unfortunately this breaks guests (Linux at least) when sd->size is not
a power of 2,
as Linux doesn't expect unrealistic SD card sizes.

>              }
> +
> +            sd->state =3D sd_sendingdata_state;
> +            sd->data_start =3D addr;
> +            sd->data_offset =3D 0;
>              return sd_r1;
>
>          default:
> @@ -1230,14 +1234,17 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> +
> +            if (sd->data_start + sd->blk_len > sd->size) {
> +                sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
> +            }
> +
>              sd->state =3D sd_receivingdata_state;
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -            }
>              if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
>              }
> @@ -1257,14 +1264,17 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> +
> +            if (sd->data_start + sd->blk_len > sd->size) {
> +                sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
> +            }
> +
>              sd->state =3D sd_receivingdata_state;
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -            }
>              if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
>              }
> --
> 2.21.3
>


