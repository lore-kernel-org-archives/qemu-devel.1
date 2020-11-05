Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D67C55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF69221F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb9TNr0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF69221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakJ0-0002uQ-DI
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakI6-0002S8-Ed
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakI1-0003dW-Ia
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604602035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gymYpe+op2KEM+Ps+oRafXBrmFgAlplrrKUwf0lvO5k=;
 b=Wb9TNr0Ers56uuSGa5ig4f1B3n5nx9At9t63QCJYJvVYX1ce5l2hJo5gxn1ngaBSvijNSW
 mVVAvz2PlKwycQde5q08htkVq4OhwFc4UVUC6ddjNbAlvDhWMa/tW+XtU7SrXiPw5YlgyP
 RkhSt593RKsBb1MQ/+i0TiK6K/ATGbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-wRYUXxB7OkazfsaBzAHlAA-1; Thu, 05 Nov 2020 13:47:12 -0500
X-MC-Unique: wRYUXxB7OkazfsaBzAHlAA-1
Received: by mail-wr1-f69.google.com with SMTP id m20so1068222wrb.21
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 10:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gymYpe+op2KEM+Ps+oRafXBrmFgAlplrrKUwf0lvO5k=;
 b=XX6AOoLVIEnGZnpk3Gb7QItOmmQ/VYFEJ3euL5LqQ59Ev3E3xmSHfWcZiMGhTg360P
 1FKQbpOhDGlOKJwo4mQQUBDxwY1yyLpbMTUCt97RQEkuah55T+wY9TQgqMllaET7bQ3o
 EIt3xX2cp3+ZZEaUucdlt+uyHDbZQJzam64dlKuQp7k7HRs4QFI7JVolK4GLWOzS7t2c
 2csFoxNWM2JcTt1gXEY5TAGpi1ikLb22QmaCUYx3eCAkYUV4NBzcvqodvrJY4ZZYXG5s
 u+i+XTAeftQngs5n2w7fI1u5SpuLh79UDdNN5MckflsHPW5FKS1PLiFa0FpaqIxwOHG+
 0QRw==
X-Gm-Message-State: AOAM530vVYySWkJlTo7xzq7l/0o6y5E2mkX11pUSavNNVBrqfXLAuIX4
 WhBUtqDhod548kkQlaL97rVA3iReI58ZS7sxBVvS9QP9TuDqphPJERuI/1J8LltrxyCPvhY5rU7
 6LPjf+G208q3jv2I=
X-Received: by 2002:adf:f285:: with SMTP id k5mr4543033wro.299.1604602031123; 
 Thu, 05 Nov 2020 10:47:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6SiDJEH8bnGvlpIlzVFUkZN9yCp9a7K3ua4PSWNmYZPUMdgFzefLnB18DV7sFcgf0UooBog==
X-Received: by 2002:adf:f285:: with SMTP id k5mr4543007wro.299.1604602030859; 
 Thu, 05 Nov 2020 10:47:10 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v9sm3695027wrp.11.2020.11.05.10.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 10:47:10 -0800 (PST)
Subject: Re: [RFC PATCH 09/15] meson.build: introduce CONFIG_XEN_HVM flag
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <746b9511-afed-1a23-dd8d-937fb9c1fa91@redhat.com>
Date: Thu, 5 Nov 2020 19:47:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-10-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> While Xen traditionally uses i386-softmmu to run it's PV models on all
> architectures some models are very much x86 only. This includes the
> full hardware virtualisation (HVM) which is only used on x86 HW. By
> introducing the symbol we can also fix the inclusion of
> XEN_PCI_PASSTHROUGH which should only be built for x86 (and Linux)
> systems.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  meson.build   | 6 +++++-
>  accel/Kconfig | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 58e95227ea..46e4c2fc3a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -83,6 +83,7 @@ endif
>  if cpu in ['x86', 'x86_64']
>    accelerator_targets += {
>      'CONFIG_HAX': ['i386-softmmu', 'x86_64-softmmu'],
> +    'CONFIG_XEN_HVM': ['i386-softmmu', 'x86_64-softmmu'],

I'm confused while looking at
https://wiki.xen.org/wiki/Xen_Project_Software_Overview#ARM_Hosts

Maybe it makes sense to add both CONFIG_XEN_PV /
CONFIG_XEN_HVM accelerators?

>      'CONFIG_HVF': ['x86_64-softmmu'],
>      'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
>    }
> @@ -204,6 +205,9 @@ if not get_option('kvm').disabled() and targetos == 'linux'
>  endif
>  if not get_option('xen').disabled() and 'CONFIG_XEN_BACKEND' in config_host
>    accelerators += 'CONFIG_XEN'
> +  if host_machine.cpu() == 'x86_64'

Are you sure it is restricted to 64-bit host? I can't find
the reference.

> +    accelerators += 'CONFIG_XEN_HVM'
> +  endif
>    have_xen_pci_passthrough = not get_option('xen_pci_passthrough').disabled() and targetos == 'linux'


