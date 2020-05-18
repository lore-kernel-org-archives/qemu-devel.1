Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C731207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWZBmXxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C731207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabce-00020D-Lu
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabbt-0000iB-6p
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:58:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabbs-0004R0-2c
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589792335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdn8VCfgkteyNUxKS9hYGhs/54YrFa5Prt1Xdxt3huM=;
 b=UWZBmXxHRg7CC1xEQvD5ul/Gjo26LHfPdJTamYueARYiw5wSVhGIaxY+s2930XK0vZJNyl
 fPlTHX1svsgmXbiFiveDVEJjMRtCaYDLPAQLz/NYXbrp9dOYxvAwHxq/lhvTk3vihiatrN
 dtNJNovNVkE2fVMSP2eBKmnP13xGANQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-NF30lTE5OLWV20QXrDDIQg-1; Mon, 18 May 2020 04:58:51 -0400
X-MC-Unique: NF30lTE5OLWV20QXrDDIQg-1
Received: by mail-wm1-f72.google.com with SMTP id n66so5493377wme.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jdn8VCfgkteyNUxKS9hYGhs/54YrFa5Prt1Xdxt3huM=;
 b=MIARGQOfCp/AFYT6/V+FP6QFp9AMlWi8NBswRmrv3WfUNrQPZHeM2j8vGk5D4KZyep
 x8ZOhgoEHG3kk1Cn1V8+V4ckdOtMSGwDEbg3x8QlFY7vfHrzKcssMK29eYgbiu67un5O
 BGuxqREAYepbeuXXJQoJ0GbOwdVZYPSxeGUpMr8jvdvWg6CvwQc+DJGfDqQI6Y8ToFgU
 glr9ydgEoFw8DZ0v2PLI9cBoRIb7r/PARPQjqdntix1/cf5lkPjxlAp7gjTEX4eP28P+
 uu4oQsifEDrNxRPHMyOu+2eRznMFG8xvKun/Y5EGdEOJX6+W2irH+i9AjCLrtLs4ZHY0
 wojQ==
X-Gm-Message-State: AOAM531eWI0imnri9PuY+MOQuM33zzern4KSVsVpL0RrsiK1t0/BVWOc
 ZEHC0fZt1p/L/YXh69Fqagr7DoNxl7LFkPPaYSmfvI4Qj8MymT9Th0i2ABVriSdR19hUUF/ikcp
 e9AfVhDxCImuDtM0=
X-Received: by 2002:adf:cd83:: with SMTP id q3mr19349574wrj.187.1589792330770; 
 Mon, 18 May 2020 01:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybEUm5Wjpeg5HBMZkdte8hrlYhKBo3P6eIZw5TCJamsV3wELqc7F7hRZJnDryrOEG48bHEtQ==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr19349565wrj.187.1589792330623; 
 Mon, 18 May 2020 01:58:50 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t14sm11686202wrs.1.2020.05.18.01.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 01:58:49 -0700 (PDT)
Subject: Re: [PATCH 20/24] riscv: Fix type of SiFive[EU]SocState, member
 parent_obj
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-21-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f1312bd-4018-c1b4-4d1a-9c1a1a0c7e67@redhat.com>
Date: Mon, 18 May 2020 10:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-21-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:04 AM, Markus Armbruster wrote:
> Device "riscv.sifive.e.soc" is a direct subtype of TYPE_DEVICE, but
> its instance struct SiFiveESoCState's member @parent_obj is
> SysBusDevice instead of DeviceState.  Correct that.
> 
> Same for "riscv.sifive.u.soc"'s instance struct SiFiveUSoCState.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/hw/riscv/sifive_e.h | 2 +-
>   include/hw/riscv/sifive_u.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 25ce7aa9d5..f05644df7c 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -29,7 +29,7 @@
>   
>   typedef struct SiFiveESoCState {
>       /*< private >*/
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>   
>       /*< public >*/
>       RISCVHartArrayState cpus;
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 16c297ec5f..5f62cf5f85 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -31,7 +31,7 @@
>   
>   typedef struct SiFiveUSoCState {
>       /*< private >*/
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>   
>       /*< public >*/
>       CPUClusterState e_cluster;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


