Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018E9C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 00:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC14C246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 00:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZR2DlXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC14C246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8YbO-0003dF-TU
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 19:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8Yac-0003B1-WB
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8Yab-0001G8-DS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:05:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8Yab-0001Fk-2A
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583107539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5rLcWjxn4Kz9LrcZV9TV6ytiiS+1gfamL40ROnvYos=;
 b=HZR2DlXpIIKANK9bu9d8q2xNFah7V858w7UU6Hij7I+yK6AaW4tgzpSYDrAchgX8f/VNS1
 nm8+5jfJ2ZDSkwL5EPL2z1orpaHzLqWxD0vUkahDdBfdKdVOIuPNQhAcns0TR6inhGqCvu
 kOkkhlZHCQxe05O2FwmObT5LtguOPEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-r8oKEKOWOC2FQrpoocJ1Mg-1; Sun, 01 Mar 2020 19:05:36 -0500
X-MC-Unique: r8oKEKOWOC2FQrpoocJ1Mg-1
Received: by mail-wr1-f72.google.com with SMTP id n7so811299wro.9
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 16:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m5rLcWjxn4Kz9LrcZV9TV6ytiiS+1gfamL40ROnvYos=;
 b=aPtcR4s1HCV9w4CLylBSh2bmNaOSh0XTFCUmKn9JcXMT9N925jhM69fz7GadexnyIv
 yk1DNjQJshzckNQW1qNyi/kWxymXZkV9Gt8VZEnNLfMgwRDraftYyaSGmzYUr5ptk1+K
 FgpsXOJJtFoWW+WR9FCadOKM0UOaJAgnEDrUwIaIP4SEL4eAJ7Nl8/oSwQDWzvqzWJ0/
 wD9Wh+FmITaPLRhMdcwIh14tNEX23MDcT1aPA65Df4CCQyifnZLS+3aN91flLVGhSpdC
 O1Qb65aMDEa5gOL2M3PTpa41gUq2aoXCthIZQHOaLWMS6lsy4UwFt8W0gMnbEUA5pjgX
 bA9g==
X-Gm-Message-State: APjAAAVj1vVyzzRkZN/ROBE6Xned7qYK5PJUCgmCULiy8KS9sYxsORAb
 R3gX47/yE00NAT9deECcyE/XZFEChTJAazZSKtlE0LNfuRKPMPaMv2NXEf5qas21oWmnFyCiVsI
 k0+DUS4qEcC25KvI=
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18269690wrs.21.1583107535089; 
 Sun, 01 Mar 2020 16:05:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrG5J4anA53Wt7bXrLdN7ka6qquN5VtCo0hdOPthithwmh+dNKEcTuatSPVqU6X1JMAjTvWw==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18269673wrs.21.1583107534850; 
 Sun, 01 Mar 2020 16:05:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e1d9:d940:4798:2d81?
 ([2001:b07:6468:f312:e1d9:d940:4798:2d81])
 by smtp.gmail.com with ESMTPSA id o11sm12878553wrn.6.2020.03.01.16.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 16:05:34 -0800 (PST)
Subject: Re: [PATCH v3] i386: Fix GCC warning with snprintf when HAX is enabled
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200301192156.19357-1-jcfaracco@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52fadd00-d59a-0096-52a2-f44f49a85d7b@redhat.com>
Date: Mon, 2 Mar 2020 01:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301192156.19357-1-jcfaracco@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/03/20 20:21, Julio Faracco wrote:
> +    assert(vm_id < 0);
> +
> +    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
> +                 vm_id) < 0)
> +        return NULL;
> +
>      return name;
>  }
>  
> @@ -140,8 +145,12 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>          return NULL;
>      }
>  
> -    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> -             vm_id, vcpu_id);
> +    assert(vm_id < 0 || vcpu_id < 0);
> +
> +    if (snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> +                 vm_id, vcpu_id) < 0)


Can you just replace snprintf with g_strdup_printf instead?  Then you
can also remove MAX_VM_ID and MAX_VCPU_ID.

Paolo


