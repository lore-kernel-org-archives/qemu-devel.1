Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E550AC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 18:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC8C20722
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeKZaYoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC8C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFiXE-00076B-N5
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFiWT-0006bh-AL
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFiWS-0005nF-9l
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:07:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32821)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFiWS-0005mt-5S
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584814019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dHIuwAyVBsvEh3b6AaO91mVUSN9VJdKbBusaSbi+Pc=;
 b=ZeKZaYoavRIkFxuckz/fyCDPeWvwbaQYFDUMY3qfyxa5WiAhqTSu80dXoYU/4w8OR9TjH+
 TVlevO2M76QMCzFi+SgQtMyIrLHNuB1fP5MHk6gmfhPrZgfPbSH9KfF5VAfNHhrzzs0Imc
 aRq1zjaUF4OXIC2B1jRxD7GekfZL7lI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ENoTi6gSM-id-Q6VHIjzjg-1; Sat, 21 Mar 2020 14:06:55 -0400
X-MC-Unique: ENoTi6gSM-id-Q6VHIjzjg-1
Received: by mail-wm1-f69.google.com with SMTP id 20so3163960wmk.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 11:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2CY4o0hvh+WX+fISBMHVCs5uag77dyJmuNXgNpVzhgI=;
 b=Tsz0MgE2i3l9MS3mv0WNbkuWav/aFG/sGlxE8U7MtKSE+15QP+YKHrfQ85ydKlz2WL
 q1LqHTmp5zPMaiPnfPpMfyPtx6sIo9Yff9z0l1lCNcyaMsme6AH9Jpt4mzP1tDPTnnyQ
 rjfcmvN1932x/wcEUwiLo3dUgrsXUqbuwPcm64qjwkDjO04zkn196SoKWinz2NtmTSSF
 Gvzp7vEMddj7RAFB8lrv4AwTVvaGR6q1dOOwcoIJhta49YyiPR5bkL2MD2dgTrhFhFCZ
 mXKkjs/+9/y+WAwhPYo7VKyxXQs2p25+BdY7L9ZbvTwGtyWMyJy3OnWG1GJw5JiY4bKQ
 QhRg==
X-Gm-Message-State: ANhLgQ1rdWS64QeB7P9N9Vsxy5FkIhhFBkV0QC7Xo644YHxYxO18bi+H
 s1rvjPKcUgmkKruI9Zjyw5tELF4RCsTIK3ramwGc2LKA7W18sZnzyR+ct0HJOgQNfUVMxsSDti0
 Nun1IFGBQiQQSSY0=
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr16785630wme.125.1584814014111; 
 Sat, 21 Mar 2020 11:06:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv93Q2zGkivik8eYrQdZ7ADD64W+w+ZYoht+HSL7CV1FAda+qkUsbsFsOH5WapVrflfvygnMA==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr16785617wme.125.1584814013910; 
 Sat, 21 Mar 2020 11:06:53 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id a16sm13410215wmm.20.2020.03.21.11.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 11:06:53 -0700 (PDT)
Subject: Re: [PATCH] spapr: Fix memory leak in h_client_architecture_support()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158481206205.336182.16106097429336044843.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2785805d-d6a7-a5b5-846f-500857308840@redhat.com>
Date: Sat, 21 Mar 2020 19:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158481206205.336182.16106097429336044843.stgit@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 6:34 PM, Greg Kurz wrote:
> This is the only error path that needs to free the previously allocated
> ov1.
>=20
> Reported-by: Coverity (CID 1421924)
> Fixes: cbd0d7f36322 "spapr: Fail CAS if option vector table cannot be par=
sed"
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr_hcall.c |    1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 40c86e91eb89..0d50fc911790 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1726,6 +1726,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>       }
>       ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
>       if (!ov5_guest) {
> +        spapr_ovec_cleanup(ov1_guest);

Quicker than using g_autoptr(), so for 5.0:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           warn_report("guest didn't provide option vector 5");
>           return H_PARAMETER;
>       }
>=20


