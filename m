Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ABBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80A205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGb0bRn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80A205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zHq-0005Ws-9x
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zHE-00055N-1L
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:55:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zHB-0005Oq-Bd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597748132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IeVUgjT0y8IeC8JvA8kLA0zF0jg/OQMGCHh29i0BTXM=;
 b=GGb0bRn8XB7J0IC75MX7mAU2ajIPVs0mj7FkYOeWYOppIvzPH6MMwT+wEIjSKBEPmTuOqL
 NBUm0RywSzQd6+b81JBPenlYozSzIP6Qvdq66bxms+5RR254cB0VYbYfyfxGVZrivOlgmc
 UGq9pvgwSSpaGhQq2h0DbkdxJ3ChGhI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-w6ALilkcMGS6gw4copCXOQ-1; Tue, 18 Aug 2020 06:55:30 -0400
X-MC-Unique: w6ALilkcMGS6gw4copCXOQ-1
Received: by mail-wm1-f70.google.com with SMTP id p23so5959612wmc.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IeVUgjT0y8IeC8JvA8kLA0zF0jg/OQMGCHh29i0BTXM=;
 b=h8OF/SOSpCgYrfio++Vz4OSWGGFpS+kR/pWFUHI8TCDo5VQBivKl5lqLPqOj+nM8Do
 sq6Xz3BwBKll2TZe50TZL9NkCmi2p0kiT+VM9yxvFs3KytwK4/6e/4nhMvr6iFG+KZeA
 VP6dfTjvpGWPBnmpUj4Z72UQKt36THSCw/fkAkYMXelGMQonfDZKLQHxnwl+SKN55qrm
 n/GjvmevFFXAxvXKeMRCQHV6S7ksaCdE1lJHaGNzQIt0QOVU3PaxUEtY1RpQXm9lKf8s
 44112usCmysnD+2W4YVFBU5LRvo3G8hBMVrb0ezGdd5IjP63nhTxEPpbwQKbz76Ml9ya
 B03A==
X-Gm-Message-State: AOAM531WyLE5tHmOhTeD3qdFh35lTN8VECWMOZCexJNXKb2yaN5BHTwG
 BN2y+4A/AM/D2MaiYcRSxavLCHUgfOLm328hs2s+QDSgdAexJQtZDU5Qcej39Bz/TC0u6l2bu2F
 jKS3jrjAvMzh78Us=
X-Received: by 2002:adf:e382:: with SMTP id e2mr20219661wrm.306.1597748129625; 
 Tue, 18 Aug 2020 03:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx92C1ALA8izRY7ynbodAqwXXeryS21UhB7XybjlS0Pjt1GgMPrmGmCNoPwGX0pObjFevXRrA==
X-Received: by 2002:adf:e382:: with SMTP id e2mr20219645wrm.306.1597748129368; 
 Tue, 18 Aug 2020 03:55:29 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g188sm35498727wma.5.2020.08.18.03.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:55:28 -0700 (PDT)
Subject: Re: [PATCH 094/150] meson: convert hw/tpm
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817143723.343284-95-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <6deac9ff-089b-ea17-70fa-941363d7115b@redhat.com>
Date: Tue, 18 Aug 2020 12:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817143723.343284-95-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo, Marc-André,

On 8/17/20 4:36 PM, Paolo Bonzini wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs     | 1 -
>  hw/meson.build       | 1 +
>  hw/tpm/Makefile.objs | 6 ------
>  hw/tpm/meson.build   | 8 ++++++++
>  4 files changed, 9 insertions(+), 7 deletions(-)
>  delete mode 100644 hw/tpm/Makefile.objs
>  create mode 100644 hw/tpm/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index c2619bbb50..f0e5728d13 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -29,7 +29,6 @@ devices-dirs-$(CONFIG_SCSI) += scsi/
>  devices-dirs-y += sd/
>  devices-dirs-y += ssi/
>  devices-dirs-y += timer/
> -devices-dirs-$(CONFIG_TPM) += tpm/

I suppose you simplified this line due to Kconfig selecting
CONFIG_TPM automatically. Maybe worth mentioning in the
description.

>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 89bd6adb70..2ddf6bad33 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -3,6 +3,7 @@ subdir('mem')
>  subdir('nubus')
>  subdir('semihosting')
>  subdir('smbios')
> +subdir('tpm')
>  subdir('usb')
>  subdir('vfio')
>  subdir('virtio')
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> deleted file mode 100644
> index 6fc05be67c..0000000000
> --- a/hw/tpm/Makefile.objs
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
> -common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
> -common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
> -common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
> -common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
> -obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> new file mode 100644
> index 0000000000..1c68d81d6a
> --- /dev/null
> +++ b/hw/tpm/meson.build
> @@ -0,0 +1,8 @@
> +softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
> +softmmu_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
> +softmmu_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
> +softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
> +
> +specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_TIS'], if_true: files('tpm_ppi.c'))
> +specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_CRB'], if_true: files('tpm_ppi.c'))

I don't understand the 'CONFIG_SOFTMMU' use.

Since specific_ss is a source_set(), why not simply use:

 specific_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
 specific_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))

Thanks,

Phil.

> +specific_ss.add(when: 'CONFIG_TPM_SPAPR', if_true: files('tpm_spapr.c'))
> 


