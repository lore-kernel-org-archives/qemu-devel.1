Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9133C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31BB21734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn87qiOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inOL5-0005qq-0e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 09:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inOKT-0005Pq-MP
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inOKR-00009k-9w
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:53:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inOKR-0008US-0Q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578063209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPZAL90FJ0jMTaihWwxMMnJW0vgBq1yoZ21MwpdXQYQ=;
 b=Bn87qiOJf7lfxclecFKMJxvCQ05BIDaYk6by8yLN7YeKUjFQ6w/PwqUYtpDhEm++gQp2Ct
 5epJP3BqykS7k7btUMYTQbDxax0RBEal82m14hdc2bfvpO3QuHCwGD1FGSpxoLOQ/M7QIa
 QxQZ9buxlC8VK8fUawiigz34yHaj2uw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-BFcZ6xoGNoahUx1jyQPUJA-1; Fri, 03 Jan 2020 09:53:28 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so1386035wmg.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 06:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fFhAubnfmDkBnaeoV/+XATEx/0ouY2JX8978sZuxy88=;
 b=Py7iRVCMm5caaQx+a+o1ovHURNVJGerU3VxSJcrvrCFKLiB6uK7kIozN7aLqNfbDlH
 Y7/jBS3Z/p/DlYKRNp+tGtmGbLmYygPnhKOfCrjbd+jbOOKxORlYL5ATp+8aAwd0xJBV
 dyQU0JKdwJpPHjSdVLi5x2PixtWro9T2awxQ7K+tXbGmFxqVgSZdE2m/m8ahargHE45F
 u6aU8q94pkZMH6LHMY6fn6M+Wsl05S9glovcNq2Dp2CFirFHS4vHUm8ysHeWkkwq5q+B
 +dNQa+Zevf/c9k4rkytenUEh8juE0MFmO8Ut8aLOMmf9dm6yTzVjRg/Y0FEvrbSEhljh
 GGQQ==
X-Gm-Message-State: APjAAAXaFgF0ipOlL+7oy4Vy5FB2mupUGvfP1LeJGJjSOSTB/eSGFbGT
 252PiPS0e7qgm3djxgqiBuSCW1LcPfyZ8UO4kvNuVR2cIhReRlQiEDKHi1xo68CF9mV+Cc6Oo0Z
 x23pA2Ttu6lDaQYc=
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr20788597wmm.21.1578063207107; 
 Fri, 03 Jan 2020 06:53:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkoX2hxRoFAEDNJTAGVhS5rz/CvhRmuGe3IKewfKE3slDjpCdFHlqxb4Z03dkbhM4mfTYxXA==
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr20788526wmm.21.1578063205981; 
 Fri, 03 Jan 2020 06:53:25 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b21sm12603426wmd.37.2020.01.03.06.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 06:53:25 -0800 (PST)
Subject: Re: [PATCH] target/i386: kvm: print info when the kernel doesn't
 support ioctl(KVM_CAP_GET_MSR_FEATURES)
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, mtosatti@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com
References: <20200103143224.49187-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfe0997a-031c-4ddb-8153-4cf51017c304@redhat.com>
Date: Fri, 3 Jan 2020 15:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103143224.49187-1-liq3ea@163.com>
Content-Language: en-US
X-MC-Unique: BFcZ6xoGNoahUx1jyQPUJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 3:32 PM, Li Qiang wrote:
> The ioctl(KVM_CAP_GET_MSR_FEATURES) is quite new. In old platform that

Can you refer to the kernel version? "is quite new (introduced in vX.Y)"

> doesn't support this ioctl will sometimes make the user confusion. For
> example, when we do nested virtualiztion using host-passthrough model

"virtualization"

> the VM will has quite different cpu feature with the host.

I'm not native English speaking but I'd use:
"... will have quite different features than the host"

>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   target/i386/kvm.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b511906e3..9688f7a167 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1916,6 +1916,8 @@ static int kvm_get_supported_feature_msrs(KVMState =
*s)
>       }
>  =20
>       if (!kvm_check_extension(s, KVM_CAP_GET_MSR_FEATURES)) {
> +        info_report("ioctl(KVM_CAP_GET_MSR_FEATURES) is "
> +                    "not supported by this kernel.");

Please remove the trailing '.'

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>           return 0;
>       }
>  =20
>=20


