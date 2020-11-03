Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F1C55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF1022384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W15u37OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF1022384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka45M-0005km-Bf
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka43o-0004jD-6k
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka43m-0000JH-Hy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604439705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM3I5DSypm6RCZCKotlaAScN5Xuuc7gd+4eG+dby6eU=;
 b=W15u37OQ0GsyGwxKxU92cYzPrXLyjUyyqkEGl1s56eH8wuot2S5gw6TrWqgvNYaC8er8+k
 //aMlB1Pjh8zoKDue8UIqhJ887GeBB2GQpXgIPKHhkEbluIwbcAEoVmIIc3P+5HI2DprSi
 ekXqERfQB3XH8rIbapl+qsGQVZAJ39k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528--u2pQ_Q3NfKzKdT6zG5ClA-1; Tue, 03 Nov 2020 16:41:43 -0500
X-MC-Unique: -u2pQ_Q3NfKzKdT6zG5ClA-1
Received: by mail-wr1-f69.google.com with SMTP id v5so8367057wrr.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XM3I5DSypm6RCZCKotlaAScN5Xuuc7gd+4eG+dby6eU=;
 b=PostW8sUSrjkBVWqflQ+vG70cJREP94pDVgMhTk5bgpSPnSheCyaxasfeV3nVIyqGC
 23ybYL2MB1iFUYjv7idX3SmZaWVc7WkogRJjcgB7i0xLLyiluGRTaE6tLdcb4yqCNm9Q
 hSu+s4FycoB0957rYj+86vLHBlh5nBqZry5WTOXboHUDGI6HU9LeHDpplgq8T/0Yn8yh
 s+CWdIR6taXbxDfFeFH6+fTjuYr+ssfYLOdiHqP55PmBrQhxhC0xdQ3TOY0oIf+nFRgp
 XHiFEeNsJi75DZAg6UzOHrvIdvXDElDHbNUi4qXPrx+NbbahqN3FabW/AUF8U/8ocgh4
 K1FQ==
X-Gm-Message-State: AOAM530tDIWZHVBMgnLuVDIhCrNInrEwZi5clJLfaZ9iokUw4X4VHfNu
 suQ+M93zRbOmxM7OifuUcQcDvKc+JbbvcqvCURxd6kAL6FB06qk1REAeqoHyxdqtG95wD6Io7GE
 GYt5po87obn/2lwM=
X-Received: by 2002:adf:e80d:: with SMTP id o13mr27272608wrm.3.1604439702266; 
 Tue, 03 Nov 2020 13:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwElsw6MvoW5uh6oW6XDhREJTT44OoViJqpgx5XSTkcJ6V+zMSrwsqUUjyG3CzCiZrJZeJI2A==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr27272593wrm.3.1604439702024; 
 Tue, 03 Nov 2020 13:41:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x22sm70660wmj.25.2020.11.03.13.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:41:41 -0800 (PST)
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
 <20201103160843.GP205187@redhat.com> <20201103222239.5463be00@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5cf3ef53-0bd1-8226-caac-3f847645c692@redhat.com>
Date: Tue, 3 Nov 2020 22:41:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103222239.5463be00@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 22:22, Igor Mammedov wrote:
> shall we also deprecate short forms for -cpu model,[feat|+feat|-feat]
> and in the end allow only -device compatible form i.e. -cpu type,feat=[on|off]
> 
> that would let us drop custom
>    x86_cpu_parse_featurestr,
>    ppc_cpu_parse_featurestr,
>    sparc_cpu_parse_features
> 
> and a bunch of cpu_class_by_name, where almost each target does its
> magic conversion of cpu_model to the type (which ranges from various
> prefix/suffix shuffling to completely ignoring cpu_model and returning
> a fixed cpu type)

Yes please. :)  But I would prefer someone else to do the work because I 
have quite some KVM backlog...

Paolo


