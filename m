Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD8C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9B92073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5OSii6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9B92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8Ah-0007lb-7I
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jH88Q-0004H6-6v
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jH88O-0006jc-Tm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:40:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jH88O-0006j1-MF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585150799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FX4gSFmtJA5uddGUCvwNhTZpVsQjZEMoMoyO/WY+bpA=;
 b=f5OSii6+HcV/ssZoPelxLsopz/PR+ZnByqS2YJAI53asOyuLBQFsrVr1TzRoSWkKW0+l46
 rAcaoQBsICObW/SotDTwOlzrsKSUCY1KEF4XjrsGpGCdeSCKaGQsVe4qByrb2X+xvwzPNp
 RNotBXSdUIo/01TpwiGBQ2WcfLlegHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-qPuXztz-OPSaWUilzeHNxw-1; Wed, 25 Mar 2020 11:39:57 -0400
X-MC-Unique: qPuXztz-OPSaWUilzeHNxw-1
Received: by mail-wm1-f69.google.com with SMTP id x23so831924wmj.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FX4gSFmtJA5uddGUCvwNhTZpVsQjZEMoMoyO/WY+bpA=;
 b=HdVD1UW086E5FSX2QUkpEzynXlFnMr8SYrib8WglxCLAX56O++0S0XzzfwLfRpoF4n
 kC1T98bvtYD2zFMHGXYF0TinjqN4qroymww4n3FpIg2YDSCA3/7fnm2eKr4CincAFH66
 aproy+lzHe3D+ftVNLGstvFh4bHbT6ALBi8KSdnRMfs+2mJSkGdphhjRR6kAY1aq2S+0
 E9y9GwE44QAcpKNs4CqdXoXpW5kpMulJS5wpLl66iIA9MYdrVpoiUMr0+fvqm2QpKbgq
 StwMm1gYkCfd3VucSQin6Krww2xmWIdUi21+BmtMqvydlBfj/LKTPvtz81Aa4rCo9O1f
 hy2Q==
X-Gm-Message-State: ANhLgQ2VbjeboHBqtmjaGqMZTjmDVC0ndE9AWmG+O1Re2NaUBEwlAfPN
 +7qJi2G5eWjNBWmQcP9eK/I1TbVlE4U6e9vg1ck0uN9zZRtOuFhLXaGN0XclB2FFW/DIMIrIhg6
 ZKAGanG8hzc0e0do=
X-Received: by 2002:a1c:2002:: with SMTP id g2mr4006638wmg.122.1585150796584; 
 Wed, 25 Mar 2020 08:39:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt1ATdvlMob9wSADjtzW1yZGcEmS5pAuB6rTI461mqk30o+bd0Bc+hXGI5bjqrefbPreE73xA==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr4006609wmg.122.1585150796288; 
 Wed, 25 Mar 2020 08:39:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc?
 ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
 by smtp.gmail.com with ESMTPSA id f9sm34437502wrc.71.2020.03.25.08.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 08:39:55 -0700 (PDT)
Subject: Re: [PATCH v3] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
To: Olaf Hering <olaf@aepfle.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200325064736.22416-1-olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9123dcfd-862f-8986-b728-f4b3d806aea6@redhat.com>
Date: Wed, 25 Mar 2020 16:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325064736.22416-1-olaf@aepfle.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/03/20 07:47, Olaf Hering wrote:
> To cover both the existing and the broken case of 'xenfv' in a single
> qemu binary, a new compatibility variant of 'xenfv-qemu4' must be added
> which targets domUs started with qemu-4.0, qemu-4.1 and qemu-4.2. The
> existing 'xenfv' restores compatibility of qemu5+ with qemu2/3.

As mentioned earlier, this is not enough, because migration support is
just the tip of the iceberg.  If you want migration to work, the machine
type must present consistent hardware across all QEMU versions.

The xenfv-qemu4 machine type is still presenting different hardware than
QEMU 4.x (see hw_compat_4_2/hw_compat_4_1/hw_compat_4_0 - what QEMU 4.x
version are you interested in?).  Likewise the xenfv machine type is
still presenting different hardware than QEMU 3.x (same as the above,
plus hw_compat_3_1 and pc_compat_3_1).

Paolo

> ---
>  hw/i386/pc_piix.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e6756216f9..ef23da88d9 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -948,11 +948,26 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>  
>  
>  #ifdef CONFIG_XEN
> +static void xenfv_qemu_4_x_machine_options(MachineClass *m)
> +{
> +    m->desc = "Xen Fully-virtualized PC (qemu 4.x compat)";
> +    m->max_cpus = HVM_MAX_VCPUS;
> +    m->default_machine_opts = "accel=xen";
> +    m->smbus_no_migration_support = false;
> +}
> +
> +DEFINE_PC_MACHINE(xenfv_qemu4, "xenfv-qemu4", pc_xen_hvm_init,
> +                  xenfv_qemu_4_x_machine_options);
> +
>  static void xenfv_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      m->desc = "Xen Fully-virtualized PC";
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
> +    m->smbus_no_migration_support = true;
> +    pcmc->pvh_enabled = false;
>  }
>  
>  DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
> 


