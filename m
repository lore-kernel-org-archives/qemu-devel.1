Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B49C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD4820878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er+Jngks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD4820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRy0A-0001VC-TF
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxzE-0000fX-VJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxzC-0007HH-Hk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602509733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvbXSClYIzwj2r2gYxWjlhXEfDIn1+3uI+VyMvrDSfU=;
 b=Er+JngksxdwSMeD5YDr7IltcyCa5gWi9dadken/4azLjxxct2YaBezFe/7btQqzGKoyR/0
 G5oHYxfYg7SFYS0VTqnZdJnNl0ygp03a4O6y25huHhAq2NmnHoEbEpqhy8CAFEPDmCjQaY
 Fge1wwBBMfs893wlaommAI255iZrBHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-IaxAWq3APESnLAcEHxxxSg-1; Mon, 12 Oct 2020 09:35:29 -0400
X-MC-Unique: IaxAWq3APESnLAcEHxxxSg-1
Received: by mail-wm1-f70.google.com with SMTP id 13so5778105wmf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NvbXSClYIzwj2r2gYxWjlhXEfDIn1+3uI+VyMvrDSfU=;
 b=V3f/fgjCRkznQKHMxZxYmYjuXgf8zOwWAUWBt7Ur/ecKRWb7d4UFLC+7iEGroyDaH4
 lcJXOvjXyTwWYA0H/xcbO84rTpa6GTchS82GJmOtV2blnQZ+IDQTZusDmAo/yNHk8GwU
 9ECSpUyJnESiE74BfIbjwnv5RnqynXwSgMIrRFLxJI/p6ul4xPnJc+3oDRkwSp2xM8Mg
 L5b3khuc414POoa0fGZL8K0dJqLsLxmcFz5iDnKEVJGoZy9Qb80mAbKdgovz/ugrn0kS
 taELmIOEsbU0I4LWsXLJXzFm25wb+IzEUfqHbCrNgH0xOeOLg39N7WB5QAblnda9uMWK
 QO3w==
X-Gm-Message-State: AOAM533RO9UprXuahxU0o4raarK4O7Ou3nzEmyn/E5CBqv1XmUD/gwcs
 FdbbWxremv9R5GyUmT1rNsKom5R+0HS6nsEuf8KaxrxRNlauYwIrUOykxdQ8aZAgP8P47hGL+Tk
 ZfUOeu3bCBD+uMLc=
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr10880182wmg.70.1602509728213; 
 Mon, 12 Oct 2020 06:35:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXYbZ7OWNFRh5uWxEQRMW1SSndZfMjlaf+bg5jNDDFFbVuwnCdtfm+p0KnqZFK2n3vX1vcEw==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr10880172wmg.70.1602509728024; 
 Mon, 12 Oct 2020 06:35:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o4sm6560487wrv.8.2020.10.12.06.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 06:35:27 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi: remove dead code
To: Elena Afanasova <eafanasova@gmail.com>, hare@suse.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org
References: <ea41618a040224242fced25fc3d09d3b1f75a06a.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <98c5390e-aabd-82e8-e596-a53c90754ccf@redhat.com>
Date: Mon, 12 Oct 2020 15:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ea41618a040224242fced25fc3d09d3b1f75a06a.camel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Elena,

On 10/12/20 3:32 PM, Elena Afanasova wrote:
> Since MEGASAS_MAX_SGE is defined to be 128 the following if statement can be removed.
> Spotted by PVS-Studio.
> 
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>   hw/scsi/megasas.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index e24c12d7ee..6dcaad55fa 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2393,8 +2393,6 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>       }
>       if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>           s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
> -    } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
> -        s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;

See previous discussion:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg668850.html

>       } else {
>           s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;
>       }
> 


