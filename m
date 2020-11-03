Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E63C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C8520757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy8zclHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C8520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3Xu-0005fd-TG
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka3Wt-0004th-Rb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka3Wr-0003ft-5g
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604437662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xAHtZYdNtkukTkRG6nyPanVuBIfzdaG/bOhy97uBrI=;
 b=Hy8zclHTGDprpiLU8oUExswbTA2Xr7xWN3xQpszkzmX9LUepvuOGiq/6oerBb/fd7+JZyK
 bFEonWeooNo9gWnQ7ZyhTL2ddfPwBxd76WVGMB8dHL2W/znrlxfONBP67WG8yKoB5cc4PL
 0QmrjqcvzksnQ2C9XwpuLzjMjFvaFZQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-E1t4A_iUOTS0Pd2Dv-7TAA-1; Tue, 03 Nov 2020 16:07:41 -0500
X-MC-Unique: E1t4A_iUOTS0Pd2Dv-7TAA-1
Received: by mail-wr1-f71.google.com with SMTP id w6so652306wrk.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9xAHtZYdNtkukTkRG6nyPanVuBIfzdaG/bOhy97uBrI=;
 b=EXkefvan5fD0bim5nxt3o6KMLTHjooZvPU3dxnVWFIBhAM1b2TXUQcV3ELwxk+ljDl
 puf+zMCohjdfSWmmX7Lue94bLVi/QaGl93yfhJb3wublPKCb6Ezrze89xLUZtsTO/nLD
 w/QcKEVRWVkOEwW+navCPevKheB2vhizmR3adi8/PGvR4xzBXdNqI5bc11rDUddNtyyL
 lwDkBTqvMAtah1GoEkIvhUhNyp57z75B7tVU6nAeHWyRoAm22vTG9cAT8AEoJgly1IGM
 eDv0m5ERz1FzzczmLyPRkQkSEFtGPuv0r/4t7UsPiNDLyGe9F4HAaZddFzz8JvOP7Cun
 kysQ==
X-Gm-Message-State: AOAM531+HAAkAYtR6cQCU7SpvuzE1BmjwS8JAvB3c8P1IG5AzmjfHF8c
 P2Lt7RDyQ4mCx96csStCK08pXbk476vlnwPd8A8ejpAukCQ4+JiO98+aszv3eH5vW04dA+MwVSG
 eymu1t8r29c5uDFY=
X-Received: by 2002:adf:97dd:: with SMTP id t29mr28372321wrb.322.1604437659818; 
 Tue, 03 Nov 2020 13:07:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPURpHemfeHYzNjkVb9M857XgsvOyFiLsumO8sDtfb7R/6wkUqNNEWOw0WneGTDioxcig2yQ==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr28372291wrb.322.1604437659502; 
 Tue, 03 Nov 2020 13:07:39 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm4511wmh.10.2020.11.03.13.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:07:38 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <CABgObfYN+_GsVS89oxRThCivox0F6BJ6XjM3d2gro85y-_17=g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a7209fb-5e77-d42e-c823-87573897598b@redhat.com>
Date: Tue, 3 Nov 2020 22:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CABgObfYN+_GsVS89oxRThCivox0F6BJ6XjM3d2gro85y-_17=g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 9:57 PM, Paolo Bonzini wrote:
> On Tue, Nov 3, 2020 at 6:01 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 11/3/20 5:52 PM, Daniel P. Berrangé wrote:
>>> On Tue, Nov 03, 2020 at 05:46:03PM +0100, Philippe Mathieu-Daudé wrote:
>>>> We test './configure --without-default-devices' since commit
>>>> 20885b5b169 (".travis.yml: test that no-default-device builds
>>>> do not regress") in Travis-CI.
>>>>
>>>> One minor difference: the GitLab Ubuntu docker image has the
>>>> Xen devel packages installed. As it is automatically selected,
>>>> we need to disable it with the --disable-xen option, else the
>>>> build fails:
>>>>
>>>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
>>>>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>>>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
>>>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
>>>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
> 
> All these symbols are defined in hw/9pfs/meson.build's fs_ss, which is
> conditional on CONFIG_9PFS. So:
> 
> diff --git a/accel/Kconfig b/accel/Kconfig
> index 2ad94a3839..d24664d736 100644
> --- a/accel/Kconfig
> +++ b/accel/Kconfig
> @@ -7,3 +7,4 @@ config KVM
>  config XEN
>      bool
>      select FSDEV_9P if VIRTFS
> +    select 9PFS if VIRTFS

Without this line ^ it works! Thanks :*

Can you reply with your S-o-b? :)

> 
> or alternatively (and I think better):
> 
> diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> index d3ebd73730..3ae5749661 100644
> --- a/hw/9pfs/Kconfig
> +++ b/hw/9pfs/Kconfig
> @@ -2,12 +2,8 @@ config FSDEV_9P
>      bool
>      depends on VIRTFS
> 
> -config 9PFS
> -    bool
> -
>  config VIRTIO_9P
>      bool
>      default y
>      depends on VIRTFS && VIRTIO
>      select FSDEV_9P
> -    select 9PFS
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index cc09426212..99be5d9119 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -15,6 +15,6 @@ fs_ss.add(files(
>    'coxattr.c',
>  ))
>  fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
> -softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
> +softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
> 
>  specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
> 
> Paolo
> 


