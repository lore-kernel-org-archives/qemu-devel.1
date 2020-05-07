Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A68DC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5981920936
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feIARmUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhBR-0001FP-GH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWhAR-0000gV-Ak
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWhAQ-0002Fg-LE
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588860385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgpkSAB4aYm83fF1MQXdA3q4GnA+MIysRace50xQgyQ=;
 b=feIARmUp0nw/vcc8TxVrsGvW8UJMcNMaSUPJUy74E6o3KzHr9W0OZTG3mBPUGxz1BeNAtO
 EXcamnz7woUSJQwOZcJuddKiov4bw2FexlpyDOGIOqrWQ1j87irCpeHArdMMpFBpupSz+q
 vuVjr8tIKhQclaskkYRVZZFNzGFrqFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-5jCf-JfUNFmjwthGj5-2IA-1; Thu, 07 May 2020 10:06:23 -0400
X-MC-Unique: 5jCf-JfUNFmjwthGj5-2IA-1
Received: by mail-wr1-f69.google.com with SMTP id v17so3488674wrq.8
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 07:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7yHdn2zv7bu7GD+CmSNhVsw4B3CePSSvW+0cMSqhRHQ=;
 b=HdAjfxA5CLhHmSM7zcM5tEl2PJnRNqBe/8JkyU+JTnE6gOa0omjgMNWu/Ro72GTtOT
 uLqrIxCxkoaYKCmbZLkN7hfRtCuB7pGfxbtSzMnoBlZkiIKD3wcOnIaco2q3UmIyAs6b
 DOosIBCAdXwoVhMQSHkRzUxsrtwrWJIEVBSqe60SMyA0bGy444g3LxJYwtTb3rj7fTfW
 jh8T8eSjrvg03bPAZIDoGy9WQGyu+HBUk4ngKwTtI+rlg0sVFP52DQUMZnoOArCAgCRt
 /WRxb4k2HtCRHoPltCj9d05h1YuyBi8zx+loxlb54UgP6WI5PQ2xmZFfpd1wwEgEqcE7
 phiw==
X-Gm-Message-State: AGi0PuZpl8XQxTXPeoWj3ViMdsVRsiT0Qjr+urwGQa5fvc10rTIpVjZP
 ZGLa9YMP7ZK7YPJXKBU0So7ul55KuztRXzvbiMBwK2hyySbirbDkngVQnvVzq3iPoJSaiNzjF3O
 xi6uFVFu44W0ibyk=
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr15574830wra.391.1588860381418; 
 Thu, 07 May 2020 07:06:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypK40OuLTNwunjn8LYMLKn/QeuTL7cl4me9QQW3NZDQ81URtC6RMWSH92w1qPhQPW0tvnAzzJQ==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr15574802wra.391.1588860381192; 
 Thu, 07 May 2020 07:06:21 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id k4sm3811703wmf.41.2020.05.07.07.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 07:06:20 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] floppy: make isa_fdc_get_drive_max_chs static
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-16-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62b2b0dc-9aa1-48f3-04e9-6957fbbdd087@redhat.com>
Date: Thu, 7 May 2020 16:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507131640.14041-16-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
> acpi aml generator needs this, but it is in floppy code now
> so we can make the function static.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/block/fdc.h | 2 --
>   hw/block/fdc.c         | 4 ++--
>   2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index c15ff4c62315..5d71cf972268 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -16,7 +16,5 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
>                          DriveInfo **fds, qemu_irq *fdc_tc);
>  =20
>   FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
> -void isa_fdc_get_drive_max_chs(FloppyDriveType type,
> -                               uint8_t *maxc, uint8_t *maxh, uint8_t *ma=
xs);
>  =20
>   #endif
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 40faa088b5f7..499a580b993c 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2744,8 +2744,8 @@ FloppyDriveType isa_fdc_get_drive_type(ISADevice *f=
dc, int i)
>       return isa->state.drives[i].drive;
>   }
>  =20
> -void isa_fdc_get_drive_max_chs(FloppyDriveType type,
> -                               uint8_t *maxc, uint8_t *maxh, uint8_t *ma=
xs)
> +static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *max=
c,
> +                                      uint8_t *maxh, uint8_t *maxs)
>   {
>       const FDFormat *fdf;
>  =20
>=20


