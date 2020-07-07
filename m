Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ACC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF28D206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2lkusNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF28D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsmFn-0006kj-Uq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsmFE-0006Lf-W1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:58:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsmFC-0003De-O1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594123117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVTeZLi1kytkrEJTRv38xvUOv0GpjxnFg9u7Mw5mAMw=;
 b=W2lkusNKtKC8WvPi+9v4l9rdggaNzN1XFsUbkf8eX2kJZfE76mK0htkMSJgxWgSn0CJDE+
 S/IQbKnukn616WPX39lYRW38GptelV9jsIzKiZRs/f+ovACwn5pRnAZJv+K5oaCX8eoaMf
 hYOAp2sYcbVR9n9LRJZByKDIkZ+2PoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-50bH8kSpM_KWPoTgPdqgGg-1; Tue, 07 Jul 2020 07:58:35 -0400
X-MC-Unique: 50bH8kSpM_KWPoTgPdqgGg-1
Received: by mail-wr1-f71.google.com with SMTP id b14so48564376wrp.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 04:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVTeZLi1kytkrEJTRv38xvUOv0GpjxnFg9u7Mw5mAMw=;
 b=Hs4SHekK6l8eER+CJdQxeD4pUERIIe1bOS54PuaPGo44hca9lNtdTHfrPIwFLil8n6
 5dj4vlVPzmZb2dytUIKr58DB7fj6CW3bkeN6pI7u9wXkHjWC0U/Mi79pTn3veLmI3Gbc
 G2eqp0qU5VIcVK6znLQvpFdD1MEFMkcKOBXxp0cnhh9QGxM+3IGzNOJCX+D1SsRr1WJj
 InLrkZsI3sY9fouA4dd6WuaeKMDbBAj+90mxWbeLQ9lqT9ncrG+0i4m/sagFoWQSAzfW
 Cl7RJm1QBIVyK8H0G/Tk/sNH8LB88DQ7A21rF7NTsCxcscTyIL/P4ATcsyNKxVFg/HrG
 dE8g==
X-Gm-Message-State: AOAM531Qn4/5SfPrqJ8ooS7c+bXzSMcc8BD/F2JYruyPapqIo0+oeYl6
 qyVdZiuzuEtgUzrBP88V5XilUr3Ood91EvMwfYUAN8ACxSdistj7/UXhNyqnTsDhgwqXEiXpJHj
 BdnNhnfHbJdaEi5I=
X-Received: by 2002:adf:d842:: with SMTP id k2mr55189539wrl.239.1594123113975; 
 Tue, 07 Jul 2020 04:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEhK/D+nYS4MAK+M4+LT5Wi7GWhii27p+5dOAAbpjFG+d02dsQCryARMBmUnLNiUz5lbkIzQ==
X-Received: by 2002:adf:d842:: with SMTP id k2mr55189527wrl.239.1594123113752; 
 Tue, 07 Jul 2020 04:58:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id d13sm652545wrq.89.2020.07.07.04.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 04:58:33 -0700 (PDT)
Subject: Re: [PULL 31/53] KVM: x86: believe what KVM says about WAITPKG
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-32-pbonzini@redhat.com>
 <55c743389f61f010b901dfe211f2a832112d53b5.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4700d930-722f-5dae-d2c8-3229d8ab8c0a@redhat.com>
Date: Tue, 7 Jul 2020 13:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <55c743389f61f010b901dfe211f2a832112d53b5.camel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 13:42, Maxim Levitsky wrote:
>> +bool kvm_has_waitpkg(void)
>> +{
>> +    return has_msr_umwait;
> Note that this depends on the fix in the kernel
> to report this msr only when UMWAIT is supported.
> I personally don't mind that.
> 
> If we want to support older kernels that don't,
> then we have to run 'cpuid' ourselves and check the result.
> 
> Otherwise looks good to me.

Yes, the original kernel version was completely busted but fortunately
the fix will make it into stable kernels, probably faster than it can
make into QEMU releases...

Paolo


