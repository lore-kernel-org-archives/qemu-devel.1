Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A119C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26D420665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26D420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxRhK-0003pa-BU
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxRgw-0003Jy-Qu
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxRgv-0005CG-Oh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:58:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxRgv-0005BP-I8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:58:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so106833938wrf.11
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 00:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U1ObCjzvaP7ITJfIuCg5giPXYpapdJWX6GcJAC3/nnU=;
 b=bnhttbp3fZsWLCo+1Sy/umcWL6FvmOS8LYsF/Sv1dq+COewmbig1wq758MNSXEFVVE
 TIdJi8ackODxZBQotgfs4mDu+6t1P2XyQdIYM6LFuOw+oFxUxiGRtZxGiVB0l8Pe207E
 hglnAowivqhmCDCh9Uth4EG8r+ZwSqB+LmsOLaaF4kB6T7o8ZQJOSboU00mK42P8LDHa
 Lb/8lT/gNC4NgW2yHpdWEz7ycr/0JEoJpgS5/AEdYC5LOaPtBl1+t1scuHwOK72njK6w
 C1SEblUzpQMS6nQ9hTSOJnvgDSBI4ACSpd6gxdGfh7vOPlgmFPZkNXHXcsTpqms5DvH4
 UoUg==
X-Gm-Message-State: APjAAAUWR20CsX5SoKGefxykdUt0f6jNS5JA/MciqCFiUVh9T/o3osgm
 7tRwDnuAnq4t8n0ix20+eGjqdjGK9v0=
X-Google-Smtp-Source: APXvYqyiUkrf8LZvzPLaIksQbrg21VwYMGbZ5X3W8HzjOBHHlLNkuQYKNgp6NMyxrJx9x4SfGDbAEA==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr13506901wru.207.1565683080389; 
 Tue, 13 Aug 2019 00:58:00 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n14sm212280203wra.75.2019.08.13.00.57.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 00:57:59 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
References: <776d4705-f554-0c57-b231-ac66056d99f6@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <21fd66d0-5498-c4bf-dcee-ed8f38e2e7e8@redhat.com>
Date: Tue, 13 Aug 2019 09:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <776d4705-f554-0c57-b231-ac66056d99f6@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] kvm: vmxcap: Enhance with latest features
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

On 13/08/19 08:29, Jan Kiszka wrote:
> Based on SDM from May 2019.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/kvm/vmxcap | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
> index 99a8146aaa..d8c7d6dfb8 100755
> --- a/scripts/kvm/vmxcap
> +++ b/scripts/kvm/vmxcap
> @@ -178,7 +178,11 @@ controls = [
>              19: 'Conceal non-root operation from PT',
>              20: 'Enable XSAVES/XRSTORS',
>              22: 'Mode-based execute control (XS/XU)',
> +            23: 'Sub-page write permissions',
> +            24: 'GPA translation for PT',
>              25: 'TSC scaling',
> +            26: 'User wait and pause',
> +            28: 'ENCLV exiting',
>              },
>          cap_msr = MSR_IA32_VMX_PROCBASED_CTLS2,
>          ),
> @@ -197,6 +201,7 @@ controls = [
>              22: 'Save VMX-preemption timer value',
>              23: 'Clear IA32_BNDCFGS',
>              24: 'Conceal VM exits from PT',
> +            25: 'Clear IA32_RTIT_CTL',
>              },
>          cap_msr = MSR_IA32_VMX_EXIT_CTLS,
>          true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
> @@ -214,6 +219,7 @@ controls = [
>              15: 'Load IA32_EFER',
>              16: 'Load IA32_BNDCFGS',
>              17: 'Conceal VM entries from PT',
> +            18: 'Load IA32_RTIT_CTL',
>              },
>          cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
>          true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
> @@ -227,6 +233,7 @@ controls = [
>              6: 'HLT activity state',
>              7: 'Shutdown activity state',
>              8: 'Wait-for-SIPI activity state',
> +            14: 'PT in VMX operation',
>              15: 'IA32_SMBASE support',
>              (16,24): 'Number of CR3-target values',
>              (25,27): 'MSR-load/store count recommendation',
> @@ -249,6 +256,7 @@ controls = [
>              17: '1GB EPT pages',
>              20: 'INVEPT supported',
>              21: 'EPT accessed and dirty flags',
> +            22: 'Advanced VM-exit information for EPT violations',
>              25: 'Single-context INVEPT',
>              26: 'All-context INVEPT',
>              32: 'INVVPID supported',
> 

Queued, thanks.

Paolo

