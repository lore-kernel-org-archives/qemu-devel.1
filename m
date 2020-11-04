Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E97A2236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYpqRS+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E97A2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaH1n-0003gz-0N
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaH13-0003F8-Ss
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaH12-0002LV-5b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604489505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bo2QKL/Rv9trNd6Nivp/MSVbdaXde8Jn2GsQYH8VMqk=;
 b=XYpqRS+67Tf3UM983Y+NsN5nDowGfcn81qIclN3PuSbCIUjhC74eFUcmEqxsJgJz8fWPsW
 H048QdN1rM6PMjjVAGkWFCm1StO1hNQYp0KIPOkOztodYHuTWfiiNrSQBpvkfWRkM47M1H
 ZNxR6Nq23pizZoi9maFlFhJO9m8CC3s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-ZTJ7GfDNMJ-tEqL35625Bw-1; Wed, 04 Nov 2020 06:31:43 -0500
X-MC-Unique: ZTJ7GfDNMJ-tEqL35625Bw-1
Received: by mail-wm1-f71.google.com with SMTP id 8so527531wmg.6
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bo2QKL/Rv9trNd6Nivp/MSVbdaXde8Jn2GsQYH8VMqk=;
 b=mwimSla8maMvSXFhROWMjJR6dWDak66s1oS0BThcF8M3/+3LE+HodX+98+lFlMe3mb
 fHqSeczuaBXov7a/yw1hHvfccpmwrQKhCHLbvoxp0eelvWYTMCZGrXUgjgQ6QcQpqWG/
 gkaOXaFO0lSXylBRbUTdCGuozscv7V2xfonUkXxOBlPvUcP7j5X0SczKsC5vuyR5jO3B
 oO2ccp8dsdtyz7GR2e8Gm9CTVbsdsbIW8Z6Ln/K0+d/+YKSN8tMLVELDYdID9suDhaSN
 sD3M7F/ybcLVyPJlsBVk+RcUOMr+D1UthOFI+WauFPQ2S6tLv3Ni0pMCddzWqy5jZ3c6
 p6Gw==
X-Gm-Message-State: AOAM531L61Yi7RS4+is56NxnLfq9ylVJZLgIqRxwuy2tp8a5kRpsvDoi
 zRv7S0C738mSBZkrGTEIbKEnKW05UDkZM6883ypVSbAQQJYIEQW1wBF/ChKiVmS1LCGwBGoHxSi
 v7M7I2RfrhgxjlVY=
X-Received: by 2002:a5d:5743:: with SMTP id q3mr31446998wrw.167.1604489502253; 
 Wed, 04 Nov 2020 03:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRIiwTj8cCAKLn0baKK1r3vzhLmyvLz3BIxIcTOIkk6XuAciftCe2kvBphIuK1qEisr1qwQQ==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr31446989wrw.167.1604489502093; 
 Wed, 04 Nov 2020 03:31:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id l16sm2020043wrr.83.2020.11.04.03.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:31:41 -0800 (PST)
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
To: Markus Armbruster <armbru@redhat.com>
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <20201103162551.GQ205187@redhat.com>
 <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com>
 <871rh91q4d.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81b2bc92-2b87-d4ac-4ee2-b93b90a35726@redhat.com>
Date: Wed, 4 Nov 2020 12:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <871rh91q4d.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/20 09:29, Markus Armbruster wrote:
>>   It only hurts in the odd case of a boolean option becoming on/off/auto
>> or on/off/split.
> Another argument for deprecating values other than "on" and "off".

Unfortunately I'm fairly sure that I've seen yes/no in use.  I can buy 
insta-removal (not deprecation) of case-insensitivity.

Paolo


