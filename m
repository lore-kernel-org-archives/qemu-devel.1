Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A16DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A702100A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgnqwMO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A702100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJuC-0001Ef-FI
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmJps-0006jL-7o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:25:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmJpp-0005Cc-VZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592583944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4/8VCopb3LdQ9ocweieILvQnki01VB3cFX0hwScVkE=;
 b=HgnqwMO/OzbuXTmSEF/bMxXfrzd/FArTN0VTt8QooM9sYC9OaFc5GrhCpWTVsv5bgdBLv7
 KdMQRztLygcpdlW9P9fyxnFOc8ZybUkinDxSpVV9rNFice9gg9mfxqDfipseiaDMH+0qk5
 /MnuCNAGcrEjZOXxcvA1aUHJNY9CuqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-UX02FwMuP-yVPBXE1X7XvA-1; Fri, 19 Jun 2020 12:25:40 -0400
X-MC-Unique: UX02FwMuP-yVPBXE1X7XvA-1
Received: by mail-wr1-f69.google.com with SMTP id y16so690030wrr.20
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 09:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d4/8VCopb3LdQ9ocweieILvQnki01VB3cFX0hwScVkE=;
 b=br2Jp4NMnpeVGj3J1YQLQNtGD2qt1w0wNYkbninm+RFnSZna61jMDrDCcXSaFctLv5
 nZFUYZYoV3qkSyemdOGGN4pTVD2TzrVIyefuGIgFOCCSHODxNDrYIc0rPWoLw7eVYBSG
 r9J8k8g18RdRXvj8tzrCs68e2IlVclOSpaL3oxaw9On0dgGDLRfM6aXyvRgSw+nHDGRi
 H0JkLx+J13mHPcEsOe84slYPNLUPuihyL2zB6k4GFSN7fDBS7wfirTSOdB4UbJClBCy3
 2IRLFMF4ZCufA24eiSWQ5Xs57ZNzlfvVV80kXkMb4Xrd98aYvItbFk1y51kr1b1C4HgO
 hSpQ==
X-Gm-Message-State: AOAM53167+vOHNeMLW6CAAshPHOu37dOjNvtS5nqHi+k8mnMVwMgAidI
 7i2mx2DIibqp5r6Idbvoo/+uf7AFw20p4ATn8NZp3wF+OhEBFvikZcKxwwJ7y/9/7YMJ1b4Mz3P
 6CipTCY8BWPIxMYY=
X-Received: by 2002:a5d:420b:: with SMTP id n11mr4940573wrq.91.1592583939423; 
 Fri, 19 Jun 2020 09:25:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEraKPOsYCSAzhCsDeOFjFxRKxDlDU5aMy0+GNkW9QCjiKMhv/0CQexC/WpvLK6AoKsXhEwg==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr4940548wrq.91.1592583939177; 
 Fri, 19 Jun 2020 09:25:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id u4sm8039969wmb.48.2020.06.19.09.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 09:25:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
To: Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a6f8448-a7d9-9f1d-315d-2ca611ff4dbe@redhat.com>
Date: Fri, 19 Jun 2020 18:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619155344.79579-3-mgamal@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mtosatti@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 17:53, Mohammed Gamal wrote:
> If the CPU doesn't support GUEST_MAXPHYADDR < HOST_MAXPHYADDR we
> let QEMU choose to use the host MAXPHYADDR and print a warning to the
> user.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  target/i386/cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b1b311baa2..91c57117ce 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6589,6 +6589,17 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              uint32_t host_phys_bits = x86_host_phys_bits();
>              static bool warned;
>  
> +	    /*
> +	     * If host doesn't support setting physical bits on the guest,
> +	     * report it and return
> +	     */
> +	    if (cpu->phys_bits < host_phys_bits &&
> +		!kvm_has_smaller_maxphyaddr()) {
> +		warn_report("Host doesn't support setting smaller phys-bits."
> +			    " Using host phys-bits\n");
> +		cpu->phys_bits = host_phys_bits;
> +	    }
> +
>              /* Print a warning if the user set it to a value that's not the
>               * host value.
>               */
> 

You should remove the existing warning too.

Paolo


