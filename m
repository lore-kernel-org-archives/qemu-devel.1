Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08065C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29548206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKsZHOcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29548206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQUEs-00067k-1k
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQUEB-0005hk-3S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQUE7-0006Oj-Im
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602157009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHMyyw+2p8BS3U8iHSSbubCiURNTDwEdVjEwsIu91II=;
 b=gKsZHOcAxW2KGGPQZC1bToaq5bunt97huqlik+F1OIGaYmtRA4dnwExAS+g3dF04pQQPqA
 4q400ZwVQAy/1Arb1urJzZ2nZ1BiIDL/FlaaHS3Z9nMVa8BE6TL8EP/6ovacGTQCkFz504
 jpaPXufW8vJTN7SEPmRfIDnhHAc2V3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-wIcYjk8ZPx2H7QRAVHDQgg-1; Thu, 08 Oct 2020 07:36:48 -0400
X-MC-Unique: wIcYjk8ZPx2H7QRAVHDQgg-1
Received: by mail-wr1-f71.google.com with SMTP id r16so3755385wrm.18
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 04:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KHMyyw+2p8BS3U8iHSSbubCiURNTDwEdVjEwsIu91II=;
 b=g10/aQxCobhd3yw1k3rrV77yzAsnBqi+LHfG8Ww9gfzlPttecUf8OFDStk5ssi0cEo
 +lIoXYGv93Nkx1gBo/E3SzGQgBhZqO44wboN9XlrgDyDxlney++ptrWAiVlZaVfwYPNs
 1QO8m0eXYs6hpQJtlyNVZIBlTf/0XHhvsHkGtWj9uWUzesq2kX3CNsvBy6BP9oX2KzJp
 UZNc718PMVnMhz1txAnYcXbj0Yp76RXZShxAoYBQn9ihbfepGR7PEY7X5gklTaWQO0G+
 6Q0g+1xKFKwhheRmUVHmQff1K81rWQwqb6hP119rMKRxVQdIXjiYRmZwJzU2pRIl1+rj
 4p7g==
X-Gm-Message-State: AOAM531gSSL+uydcNlgVEZPn9coqNfExFou4WAPWJFi0wdsogEW8KNNL
 EwjeHyUsSf0ZEvzI2ozcquiXYHiHqURTyi0y061+5tdrBR26GbXARBalX/9//UuYOCM6axEX2ej
 A0pemlzOjTscdpTc=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr8751954wrv.200.1602157006800; 
 Thu, 08 Oct 2020 04:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2fsP4bsAGatWuAFVi5H5/kBDmS4jZH+HVqRzoin86Cn3f+ciSa0EQl7jROlFXUePvQVjWSQ==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr8751925wrv.200.1602157006479; 
 Thu, 08 Oct 2020 04:36:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id o6sm7012608wrm.69.2020.10.08.04.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 04:36:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] exec: split out non-softmmu-specific parts
To: Claudio Fontana <cfontana@suse.de>
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-3-pbonzini@redhat.com>
 <cb553da1-9cd1-1933-d678-8580a3c0d8f3@suse.de>
 <027d0f5c-d5c4-911b-b349-f63895fc164d@redhat.com>
 <b6e4d4e0-6170-b3e6-f2f7-e337c71b0403@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ad53a3b-f28b-b53b-2541-3108e40e282a@redhat.com>
Date: Thu, 8 Oct 2020 13:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b6e4d4e0-6170-b3e6-f2f7-e337c71b0403@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 13:02, Claudio Fontana wrote:
>>> What is the role of this new module?
>>
>> It's [...] "4-500 lines of code for the target
>> specific parts of the CPU QOM object, plus a few functions for user-mode
>> emulation that do not have a better place".
>>
>> It's basically sitting between hw/core/cpu.c and target/*/cpu.c.  Hence
>> the non-descriptive name. :)
>>
>>> Or its this basically a "leftovers" file for which we did not find a proper role yet?
>>
>> The user-mode parts are, but most of it is implementing the QOM CPU
>> object.  We can move those functions to hw/core/cpu.c and make that file
>> target-dependent, I wouldn't object to that.
> 
> this gives me an idea, we already basically have a target-specific part of a cpu QEMU object.

Which is? :)  Sorry I don't follow.  We have one that depends on the
target architecture (methods in the CPU class), but not one that depends
on the target kind.  We could add more methods in the CPU class for
that, but I'm not sure it would be useful because (unlike CPUs of which
in theory there could be >1 class in the system) the whole emulation
_has_ to be either user-level or system.

> I basically was looking for a place to graft accelerator-specific code in order to refactor target/i386/cpu..., 
> to split between tcg stuff and non-tcg stuff, and thus refactor even more code.
> 
> In the past I thought to put them here for example:
> 
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 3e96f8d668..3716c3e949 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -72,6 +72,12 @@ typedef struct X86CPUClass {
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
>      DeviceReset parent_reset;
> +
> +    /* methods operating on CPUX86State */
> +    uint32_t (*cpu_compute_eflags)(CPUX86State *env);
> +    void (*cpu_set_mxcsr)(CPUX86State *env, uint32_t mxcsr);
> +    void (*cpu_set_fpuc)(CPUX86State *env, uint16_t fpuc);
> +    void (*cpu_report_tpr_access)(CPUX86State *env, TPRAccess access);
>  } X86CPUClass;
>  
>  typedef struct X86CPU X86CPU;

I think in this case you would have an X86AccelOps struct and a global
variable pointing to it.

Paolo


