Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E915C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9A822267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1HAi9JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9A822267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYN5-0003xs-89
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVYLm-0003QT-4E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVYLi-0001Mw-VT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603364495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jd7ZinYlhJL91l+xpFgBo8DTa6p7krs4K+GSvcuyd1E=;
 b=B1HAi9JVccawfHM1Tsov6tF3HuYC67g0AyDwiQpmuLbZ+jDnmbQEPjnn1/VI14Wd2DlpGX
 OQDi+c9Uu/2eKpqy3I/ET7A5NDTL3ixXn7ldZfbSIB9tmk46njTKHPQdP+mO0iZhfqJAGX
 XVBuWcJbmvGvGMhJxYOvFmtIefCXaDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-4Gm48a1rM3WH3KomPzistA-1; Thu, 22 Oct 2020 07:01:33 -0400
X-MC-Unique: 4Gm48a1rM3WH3KomPzistA-1
Received: by mail-wr1-f71.google.com with SMTP id 33so469182wrf.22
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jd7ZinYlhJL91l+xpFgBo8DTa6p7krs4K+GSvcuyd1E=;
 b=ms+aqDL314VC2zgdpDdeqWcZHRMFxCe6emNgpZmr5TiY84kLwtjcaa26bS2h5T0dGc
 +UUYAgMJ6xNOgBR3iiwNOB9tnkQwhr9HUdoovSfDQYdlbJTU9NEcX3RePzCKGRmW7TIE
 CwB5C4gTiq3fJhkNm1OW9Z5+CydlkH/IUF919fkgYPMAW+BLfb1YWwFaaR3AS3yibEEm
 F5gdS2j9owrQ2SMKHzQHRAZqUhxM2qAl0wMbj4xnuErLILQH6zgHIvxqfQ4pIOqyQ87I
 oPvQV8b3qIJaSuMoH3+O5uggP1lQUBFC5VIpJYhBEXUZL/YF4oZonCxJ9Omi1Dy/0qQt
 xDfw==
X-Gm-Message-State: AOAM530Bga1vfoqyARU5WLKwdlD7fLkaMCQvJ4A+/oQQudbyA5Ulqagm
 Lh4VIc4ZpuIJMTq3FxG2NEbmBgcxU8WXvLLxTUqdEmnRMJ+rv1C4ayRQ8kZVWGtZmZmT5AexNXL
 d9Go5K6q0GXCsocQ=
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr2137519wrg.191.1603364492165; 
 Thu, 22 Oct 2020 04:01:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2BW3Ec6GFIY/JFNG7s2cjVhIV6ZjuJ9pCZwQOFjFYFUlwyjA1aCUU31iBnJTny5ex6her4A==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr2137478wrg.191.1603364491826; 
 Thu, 22 Oct 2020 04:01:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z191sm3029271wme.30.2020.10.22.04.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 04:01:31 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] hw/block/nvme: add dulbe support
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Thomas Huth <thuth@redhat.com>
References: <20201021221736.100779-1-its@irrelevant.dk>
 <20201021221736.100779-2-its@irrelevant.dk>
 <20201022022135.GA1663731@dhcp-10-100-145-180.wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9775e09-9a2e-3df1-afca-175fa55885e7@redhat.com>
Date: Thu, 22 Oct 2020 13:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022022135.GA1663731@dhcp-10-100-145-180.wdc.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 4:21 AM, Keith Busch wrote:
> On Thu, Oct 22, 2020 at 12:17:35AM +0200, Klaus Jensen wrote:
>> +            for (int i = 1; i <= n->num_namespaces; i++) {
> 
> You can call me old-school, but I don't think C should have allowed
> mixed declarations with code.

Since commit 7be41675f7c ("configure: Force the C standard to gnu99")
it is acceptable at the maintainer discretion. IOW if you don't want
declarations mixed with code, it is fine to ask contributors to not
do it in your subsystem.

Regards,

Phil.


