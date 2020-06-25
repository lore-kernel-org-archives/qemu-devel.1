Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D0A2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGz53zWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D0A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPC0-0008PF-8p
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joPAl-0007AM-5m
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:31:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joPAj-0000Tp-FI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593081116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Whm9PAsHaoSsovpVOkvMzjsSaUmr/REL3wWXa/V6B6k=;
 b=bGz53zWmfqDNZXP6O0ZXvVm6bY2TdajDROhH8nlpHlS4HvMMgkq8Gy8R9r7minwTeJej8l
 e4QIWj+jbrtxLkb5rBF83OfMZvulE26XsXBeS6v5cdKI06QypUqcVVktJjE+ySILu3VP0j
 2dfkOKkW+sOWNXvEdwv0dVDpAcpnUWs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-yAbzffMOMpe7C69tqyWehQ-1; Thu, 25 Jun 2020 06:31:53 -0400
X-MC-Unique: yAbzffMOMpe7C69tqyWehQ-1
Received: by mail-wm1-f70.google.com with SMTP id b13so4536139wme.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Whm9PAsHaoSsovpVOkvMzjsSaUmr/REL3wWXa/V6B6k=;
 b=iSIkRFvz4IF9GFk9GfXfNeadfhw11AAaJNUA0KBXAcsv5i0WRvvs6xWiSfGoNAp6DF
 Li/IKvr9bcjoKtPbMh4rOL0FeWB9NqpFmmJ5uXWjLtonfbysW9ZaVtAMnS4s51pdC+Df
 76tS0FbRHHfjBAR7TIxxf4N/pqUCxJ2AlQM8a158gKWYPDiIqTkFchLt0f6CWsv76BCe
 Dp9AHMe69MnmYZCMIBPmL4sSFxTQUBmyz2BrvSd819cWyEiEKBfIvrs1shwo9+Dyqa+6
 jL8Z9NhTgoPlkttWgEBEgAB15dit7qBsqHMaesvYV+1R9l8voS1L0dl5OpmmoSdVVsWl
 OidQ==
X-Gm-Message-State: AOAM531qHvKOp/4MxkBIEDQxMIXxWidWhYQyOlaNpLiJxSZePAgB6AV9
 zSS2pm/BmHdIlmxD7F885ytFnKxC8bonXA1zRUcX6FRk7UEpAuwk6hkY62ylmZynkD7v8VpcIjn
 Q49bnfebxdEZZVg0=
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr2767120wmt.177.1593081111588; 
 Thu, 25 Jun 2020 03:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrwg8AE/ZUPxPwdUMgdz1y/083MhQwdZC1noUzFY3fUFtcKcDlEkA1ChU24m19yga+yPOSMg==
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr2767099wmt.177.1593081111386; 
 Thu, 25 Jun 2020 03:31:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id k126sm6423254wme.17.2020.06.25.03.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 03:31:50 -0700 (PDT)
Subject: Re: [PATCH 6/8] i386: hvf: Drop hvf_reset_vcpu()
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-7-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac800efc-c51d-e44c-de5c-cdef81d24dec@redhat.com>
Date: Thu, 25 Jun 2020 12:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624225850.16982-7-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 00:58, Roman Bolshakov wrote:
> +    uint64_t pdpte[4] = {0, 0, 0, 0};
> +    int i;
> +
> +    /* Reset IA-32e mode guest (LMA) */
> +    wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
> +

Where is the place (if any...) that calls macvm_set_cr0 and
macvm_set_cr4 from cpu_synchronize_*?  If you have such a place it
should take care of resetting LMA as well.  Assuming that no entry
controls are ever set is quite fragile.

Paolo


