Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901022249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PREjjwGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901022249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAna-0001hi-8l
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVAm7-0000mn-0T
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVAm5-0004NY-6z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603273875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/7+57KWfByrzSirBzC07W6MRKWBxUXyRadvQKELtv4=;
 b=PREjjwGsP8WslRsSR4wluVaKQG2PRUr+fIC9AylIuxfJswPyvxgPmgSl6fp4yqAAM7AVv8
 DJ+I2hl5IBPDM0W3EKWx7fmru3YBzUt1S/Og3dJKwNv1idq0VnmorfVDU3gxPUBfDPj14g
 QIYhGJp7/4/tcNjT7IE7WdMzyq4nn2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280--v6baz3BPmqmo2TUXlptKQ-1; Wed, 21 Oct 2020 05:51:14 -0400
X-MC-Unique: -v6baz3BPmqmo2TUXlptKQ-1
Received: by mail-wm1-f69.google.com with SMTP id y83so720760wmc.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 02:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L/7+57KWfByrzSirBzC07W6MRKWBxUXyRadvQKELtv4=;
 b=ppgCJoQVk03Vj2+B7+jV0qF0xCevBNylBY8qtDP7UnNocV6kl6WYrtOfeY5AAN3IuB
 g9UvWP0iXLSkbRnlWzDqJ4PFb3vWRjia9AmEBB2pTxM/LZYewe7sdeDoEi4WeojYwWfX
 Rx5IIj80FVtB0lNY/k+CDMC6DzoqNoj4Ub5xLjBFwLPNBIKxc3ovci0fsXjLKsRTrQnf
 rOWgZcc1IqMp/TnxpR+rDXE4s76GOGq3RuZTpbhkrzKlOjJ0OAFv+B8gp1kEzYB12fqB
 SSaRlrKr7zbE4Y00fNMl+ROPJqWHp/AbjwehlBLeYiezJHA69svwvMO0k2Lf3kqM7LpE
 yLvQ==
X-Gm-Message-State: AOAM533nAxJ+1dpEtK//BMDQ5sQwvDhP01QN7sGHx9amcZAXhtjj0g8Y
 TggJqtKt9qUxcOYbGZR4J8PTPSf8on5f8j4nv/7ZD/F0cFQKVopd5PlVtUEi6sGgLTjQaLuHmSs
 UbJ+8+XBzrFxVYR0=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr2599424wmk.158.1603273872618; 
 Wed, 21 Oct 2020 02:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLaQckMCaOoubckmgs4ApIdVTW7q9wGerR70UeugF6bvvDnMaxQ+azydA7N5pXGd+NWhKqjA==
X-Received: by 2002:a1c:2402:: with SMTP id k2mr2599403wmk.158.1603273872372; 
 Wed, 21 Oct 2020 02:51:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x1sm2884922wrl.41.2020.10.21.02.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 02:51:11 -0700 (PDT)
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201020162211.401204-1-berrange@redhat.com>
 <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
 <20201021083803.GC412988@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aae2164f-0973-f7b3-3146-1ea659c00922@redhat.com>
Date: Wed, 21 Oct 2020 11:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021083803.GC412988@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: libvir-list@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 10:38, Daniel P. Berrangé wrote:
> On Tue, Oct 20, 2020 at 07:22:03PM +0200, Paolo Bonzini wrote:
>> On 20/10/20 18:22, Daniel P. Berrangé wrote:
>>> @@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
>>>          break;
>>>  #if defined(CONFIG_LINUX)
>>>      case QEMU_OPTION_enablefips:
>>> +        warn_report("-enable-fips is deprecated, please build QEMU with "
>>> +                    "the `libgcrypt` library as the cryptography provider "
>>> +                    "to enable FIPS compliance");
>>>          fips_set_state(true);
>>>          break;
>>>  #endif
>>
>> Should you also remove fips_set_state(true) and make fips_get_state()
>> return the contents of /proc/sys/crypto/fips_enabled, so that VNC
>> password authentication is disabled?
> 
> I did think about doing that, but decided that since my intention is
> to delete all trace of fips_get_state / fips_set_state at the end of
> the deprecation period, that it'd be saner just to leave the semantics
> unchanged during the deprecation period.

But would it be correct?  In order to have the advertised behavior of
"enable FIPS compliance just with procfs, no need to do anything in
QEMU" you need to disable VNC password authentication; so while
fips_set_state is an abomination, fips_get_state should remain.

> Deprecation notices shouldn't really be associated with changes in
> functionality at time they are introduced.

I think you can consider it a bugfix since no one sets fips_enabled
without knowing what they're doing.

Paolo


