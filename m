Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C851C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8C020671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm1DzEDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8C020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLvV-00076L-EI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLuo-0006RP-2p
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:25:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLul-0008UO-Rn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8n9uSFH3/2lDvoisR3M8DbByPbGY0Z245lijpiumG84=;
 b=Mm1DzEDk7b3+zEAAJySJp+PAjxYx6YBohl5uQu9d0Z3PCVCpIL9Bwf04fqKD0AaGBXVAJt
 CT2iLsjMQ6NJVFR6LG7f4Bw0Wqb1L8lI8LHLv+E3Qtawny9GT9SzzF/HUkyfezE2pX5ALo
 RjbBffwYIGXPaNjt7tcxFhw0hWM94As=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-OTTr7-8bM5GZL4Mg1XqOBg-1; Wed, 20 May 2020 06:25:27 -0400
X-MC-Unique: OTTr7-8bM5GZL4Mg1XqOBg-1
Received: by mail-wr1-f70.google.com with SMTP id 90so1199626wrg.23
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8n9uSFH3/2lDvoisR3M8DbByPbGY0Z245lijpiumG84=;
 b=t6ChizpPOEuqOyEn7pe0/TjIn2603EScrkdQGodo3jPpsgcB6vfwIwq3hTe2qccqGs
 uvAPDXVWbRH7IfptHe8OXvyBefv22JV+ct/8WzQqY4Z6FIpJoU+sp+8bEtuo9/lUmWXW
 opBZAsc1BaXe5YIjbN1uwDTI2hZUoISkhVIzIJYI008b9FNLbj5hYNT7UwdWpbXZY45N
 PLHiXLuQckjt2j3U8GAYflvsulJMrH6bg/btmHoce4NON1byhIjlQqxs8UpND7Yt5Q5c
 BnWQTR0MQqiaNGOzFYyXAJOAqc3X5j/rm9apnakpCYcSbKDfgSo3B8upe3tmhvYpxSez
 o5wA==
X-Gm-Message-State: AOAM533UVYA7pQY/C7QOIgZj/mtCxyGOy7mfMcugtCdkWISPxt/RwpKv
 LwJGg7hnwpPTsbw5+Fdc9B1EkJARke0ZMe4EdZKFcy1nyG9EgaJAJKOZ5/pB4Vey0kKi6cmFPmr
 6y6j8wCe1ndNbU9k=
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr4105239wmh.93.1589970326360;
 Wed, 20 May 2020 03:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVxySPHMSZHk6BK3PsM3lN3zXAS3vxEamKmRn0oD/U9enSeWxs6OvUoQ+aW4JJ3kkLn5GTpw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr4105215wmh.93.1589970326073;
 Wed, 20 May 2020 03:25:26 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h1sm2687480wme.42.2020.05.20.03.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:25:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] testing: Build WHPX enabled binaries
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190919105932.19412-1-philmd@redhat.com>
 <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
 <0806fcfd-9468-07ec-4695-25ee35005a64@redhat.com>
Message-ID: <2e5c6b54-2ffc-6cac-cc53-71b24f2660f4@redhat.com>
Date: Wed, 20 May 2020 12:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0806fcfd-9468-07ec-4695-25ee35005a64@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Justin Terry <juterry@microsoft.com>, 1879672@bugs.launchpad.net,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+launchpad ticket

On 9/19/19 1:26 PM, Philippe Mathieu-Daudé wrote:
> On 9/19/19 1:18 PM, Stefan Weil wrote:
>> Am 19.09.2019 um 12:59 schrieb Philippe Mathieu-Daudé:
>>> Add a job to cross-build QEMU with WHPX enabled.
>>>
>>> Use the Win10SDK headers from the Android Project, as commented
>>> in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.html
>>>
>>> Based-on: <20190918121101.30690-1-philmd@redhat.com>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
>>>
>>> Philippe Mathieu-Daudé (2):
>>>    tests/docker: Add fedora-win10sdk-cross image
>>>    .shippable.yml: Build WHPX enabled binaries
>>>
>>>   .shippable.yml                                |  2 ++
>>>   tests/docker/Makefile.include                 |  1 +
>>>   .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
>>>   3 files changed, 24 insertions(+)
>>>   create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
>>>
>>
>> Please note that the required header files are part of the Win10SDK
>> which is not published under a free license, so I am afraid that they
>> cannot be used with QEMU code to produce free binaries.
> 
> Yes :S
> 
>> I have addressed that some time ago, and Justin Terry is still looking
>> for a solution on the Microsoft side.
> 
> Oh this is a good news, thanks for caring about this issue,
> and thanks Justin for looking for a solution!
> 
> Trying to understand how WHPX is used, I noticed there are much many
> Windows QEMU users than I thought, and it would be nice if we can have
> some upstream CI testing to not break the various projects using it.
> 
> Regards,
> 
> Phil.
> 


