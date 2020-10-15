Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63BE21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XarQQ9Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63BE21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwtl-0004Ys-UU
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSwsN-0003sn-9A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSwsJ-0006D6-Qo
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602743790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7qH3UFHQZG+2tNBejFKcS/1FMjPkNChDpM4bd9TnS8=;
 b=XarQQ9BvdMx520d3tvXTBJlnKmlewztaM9dJQcI2EhB3CDWjbhvaHLVwCRWEylXpKwVcHj
 3tKZlqjrS5TjezaCqLAnoNCsNmk69uvoY7DtAA/JGqheOHyEYyBXnR7IEywnwIwUXtpi0g
 QgZBXTbmftef9kv4DMSpa4eP3rMCdRc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-PeQUSUzJMpKllMexKk4EgA-1; Thu, 15 Oct 2020 02:36:29 -0400
X-MC-Unique: PeQUSUzJMpKllMexKk4EgA-1
Received: by mail-ed1-f72.google.com with SMTP id g8so889921eds.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 23:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+7qH3UFHQZG+2tNBejFKcS/1FMjPkNChDpM4bd9TnS8=;
 b=K1R+TzymD9PG4UKa27jEWpoHNen59AMfrSWQkCPggsxXHbGY2fklrO4wveV6VWCp69
 LQbkHbaWjjBGLuku/lEV5m/0f2CjNdZMYxddtKhDaKJuY5iRnL+LbMEM/EUGJzq3ez2u
 Uh8LIau06hVakitOTyPi+nC8xYWfZviFhKdWQmko/vLFJxqLLgoWjI8+qykQv1WstnHA
 QUwC38uWN0/+llVzcKbQ5kStSEYWGQEgpfLnn9bkVjRlCgpoyD+JIhJLVq5TFig9dGEP
 VEjQTRxngwns1ncH9hUDVDKD1S1PXrKTNab/aH5+AFu6dg5U84mFvw9RJf/Lz0FO8ifQ
 fTFA==
X-Gm-Message-State: AOAM531cI/Bt76bftQ4fq1zDlqmIIMlU8Ptvh4QUjCgMo8+iK6oU7HQb
 gGOSEG9MByE8QfxIG63Uh30V/9zILqQSKoAH3jCNdQ18ofnD+dW6uhh80iUbZ2FrBQjggAVhtQd
 M0HygukLahCefkwU=
X-Received: by 2002:a17:906:cc53:: with SMTP id
 mm19mr2820861ejb.514.1602743787903; 
 Wed, 14 Oct 2020 23:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWIzo6Nt/Rygpg5drTNyqZ8ziFQzL8S0T+PT3Mu4oDOHbAO/gr77oF0t33RH23R/LIeuNSBQ==
X-Received: by 2002:a17:906:cc53:: with SMTP id
 mm19mr2820844ejb.514.1602743787689; 
 Wed, 14 Oct 2020 23:36:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:83:5a63:f601:3a08?
 ([2001:b07:6468:f312:83:5a63:f601:3a08])
 by smtp.gmail.com with ESMTPSA id i4sm872020ejz.62.2020.10.14.23.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 23:36:27 -0700 (PDT)
Subject: Re: [PATCH 5/7] dockerfiles: enable Centos 8 PowerTools
To: Cleber Rosa <crosa@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <20201014135416.1290679-6-pbonzini@redhat.com>
 <20201014204950.GA1203215@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <854b88db-c95d-2d96-8848-8de762e4f97e@redhat.com>
Date: Thu, 15 Oct 2020 08:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014204950.GA1203215@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: alex.bennee@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/20 22:49, Cleber Rosa wrote:
> On Wed, Oct 14, 2020 at 09:54:14AM -0400, Paolo Bonzini wrote:
>> ninja is included in the CentOS PowerTools repository.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/dockerfiles/centos8.docker | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
>> index 0fc2697491..e31d366fc1 100644
>> --- a/tests/docker/dockerfiles/centos8.docker
>> +++ b/tests/docker/dockerfiles/centos8.docker
>> @@ -1,6 +1,9 @@
>>  FROM centos:8.1.1911
>>  
>> +RUN dnf -y install dnf-plugins-core
>> +RUN dnf config-manager --set-enabled PowerTools
> 
> Since config-manager won't be used besides here, I think it's safe and
> cheaper to simply do:
> 
>    RUN sed -i /etc/yum.repos.d/CentOS-PowerTools.repo -e 's/^enabled=0/enabled=1/'
> 
> It's also a single command, reducing the number of layers.

Yeah, I'm lazy. :)  I'll use Dan's suggestion.

Paolo


