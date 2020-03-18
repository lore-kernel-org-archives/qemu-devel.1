Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3178C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D24620768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cF+l/Bdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D24620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWF1-00027U-JS
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEWEN-0001hZ-PQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEWEM-00027Z-IQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEWEM-00026Y-DX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584528441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKbl2gdakDnsss68pO3DwNBI2RJLzcn3HLqrbDPnicE=;
 b=cF+l/BdfaNlZ1RunCztSFMwt/hjvgJyg14QCnKcZVAiueGRungBlK3eYkRiRv8OWfIIKT7
 4Jbui5sR9d/OUtXhzF7/W3levB4cNI8QMHCt1vt6fIxJXvvLywnX0MjG2uTJgSSf731tXU
 57NukEjV+zSu7W8AJdcsTwu5BgyhOSk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-mUaTxi0JPb2ymfFYV-dTOw-1; Wed, 18 Mar 2020 06:47:20 -0400
X-MC-Unique: mUaTxi0JPb2ymfFYV-dTOw-1
Received: by mail-wr1-f70.google.com with SMTP id g4so4471185wrv.12
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 03:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LKbl2gdakDnsss68pO3DwNBI2RJLzcn3HLqrbDPnicE=;
 b=FI4ovxsLYRgi5LQOtaqABeokVLWL8heIHx3h0mnJvFjSDPv9a8bv0lpgbY8kv3lBPI
 rEzgjcM3tqTO14RRT0w4UOzrak0poU4ZaOhdtHJAxmR/30QS1EQp+x9qI84vlrOTS6Jx
 NmVGbnLxSSl3kkw3/CznaR5bMW8cqw9BXTWKhLMZ+/z0uQD9pErjTIOn9o+xmgcpjSH3
 cPb/coOpQBVo5ggrXk+FHmFsiwe0Q5L91N5ZZTfHEylX50GrfdhYpVYgo6unC5cA3IJi
 awqzMCjsMsJiCYqdR3pOswmVGJZPHbPmu/4mh2/YluSNO3b2zOdhTL5xvahWh675JNY9
 XRNw==
X-Gm-Message-State: ANhLgQ1/amAChEo3hjxJdc0yp5R6zp3BzoOu7Rx2NyFp6fCZ2Cs2WNGU
 Gmvdj8DzxSgnz6sS/mfHNQRsEdoR7ndM79V6Y2WtimOFtzcKyNQ+mvt6OdaWBgdh1Y4sQpRXV73
 +pQM9BASKhLxdWw8=
X-Received: by 2002:a05:600c:414a:: with SMTP id
 h10mr4774630wmm.53.1584528438965; 
 Wed, 18 Mar 2020 03:47:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6QEyK7MKwIlimvDdvXm+q/eoL1TfJoKZZRCh4m7XwIEtVFEoAQsBVgh3bhgZ7ZjODEfdsBw==
X-Received: by 2002:a05:600c:414a:: with SMTP id
 h10mr4774601wmm.53.1584528438752; 
 Wed, 18 Mar 2020 03:47:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id p8sm8987104wrw.19.2020.03.18.03.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 03:47:16 -0700 (PDT)
Subject: Re: [PATCH v2] MAINTAINERS: Add an entry for the HVF accelerator
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200316171825.42544-1-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb70fb93-7b2d-b684-c25f-f2fe6774381c@redhat.com>
Date: Wed, 18 Mar 2020 11:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316171825.42544-1-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 18:18, Roman Bolshakov wrote:
> Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Patrick Colp <patrick.colp@oracle.com>
> Cc: Cameron Esfahani <dirty@apple.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Heiher <r@hev.cc>
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
> 
> Changes since v1:
>   Status is changed to Maintained instead of Supported.
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc636..8649ff9cda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -405,6 +405,13 @@ S: Supported
>  F: target/i386/kvm.c
>  F: scripts/kvm/vmxcap
>  
> +X86 HVF CPUs
> +M: Roman Bolshakov <r.bolshakov@yadro.com>
> +S: Maintained
> +F: accel/stubs/hvf-stub.c
> +F: target/i386/hvf/
> +F: include/sysemu/hvf.h
> +
>  WHPX CPUs
>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>  S: Supported
> 

Queued, thanks.

Paolo


