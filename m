Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860EBC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E7E2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Snkg8g4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E7E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ZLL-0005QU-G6
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ZKV-0004PA-Df
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ZKT-0002tW-E6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ZKT-0002ra-9T
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583348712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfDIjHcV2k7IlJa94e8XX89Qcm/Uz6Dl3wfDXcaeQzE=;
 b=Snkg8g4oBqlAY6TeBWSH7gDERmQYy4cIkRKK7t+DPOEfCg70nrUOG0PdX77I4RKKgyPyUg
 q+lh5LPXb615BjEpjSe5/ZYVFlryF9saXNw/YEQPJ48vkeJYzgvd9hCkZmsdTnZFHBqG4G
 NG4QFQONtTCx5pmTDYkEd10cOIpptns=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-VkOpkFeNP2-X-gJ3VkMG6Q-1; Wed, 04 Mar 2020 14:05:07 -0500
X-MC-Unique: VkOpkFeNP2-X-gJ3VkMG6Q-1
Received: by mail-ed1-f70.google.com with SMTP id g11so2307483edu.10
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 11:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lfDIjHcV2k7IlJa94e8XX89Qcm/Uz6Dl3wfDXcaeQzE=;
 b=XC0y27Bvss+fLGbmM20NyGurRyUyJQ1xboHghsHKYXdpsot/IPjrxzGooh/96Ku3hn
 bmDHFd2dLHUpCRwtwcc8jQCwTEM4mfSRcjr+6PVd+kx4P4sjDW33iY7mZ/EVHyGMowXS
 fWSmFP8x3XadPeLSCcxsXIYbftpvmv/6e1M5DiQqc7g3rWRats9h00SUklBrGs7DGrNK
 iiAFwLew9TOrMnNvzJ8DZcmsgiQrxO550UB3+uFQ1e8lUp4oTJS49phpH6dqqPJeemep
 ZN+Jhz6eEtoVVZb0pNycYqEn2/Nlf/Zq6dU4+ue9foHEo32BJhDdw4+H1ZG/53anveL2
 /N6Q==
X-Gm-Message-State: ANhLgQ12/v/nBX5v/H675JW2yrRIC+MtX3dDz1QhJqUmI55spbkniQgh
 DQrel1Vigh12rwHIs7WgjjPaLv/v9VN+tjZ/jzrvEjaxKGbh+ma4eMwcmEh7MkBFmhsBSH+2lMH
 5N5LAgTHqh3qvPFw=
X-Received: by 2002:a17:906:4f07:: with SMTP id
 t7mr3658418eju.317.1583348706294; 
 Wed, 04 Mar 2020 11:05:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtd04ulm2vpNG6I4BpU8ZzhgeA6gBg08sdaJ4af3Jjr61nH1mMWMEDkbfhI2K8uaRHfVST2kQ==
X-Received: by 2002:a17:906:4f07:: with SMTP id
 t7mr3658394eju.317.1583348706043; 
 Wed, 04 Mar 2020 11:05:06 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r23sm1674677edp.15.2020.03.04.11.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 11:05:05 -0800 (PST)
Subject: Re: [PATCH] configure: Fix pkg_config --exists parameter
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Liran Alon <liran.alon@oracle.com>
References: <20200304174120.11970-1-liran.alon@oracle.com>
 <20200304174217.GI4104@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db262208-f61d-e8e5-c9e1-a87fb34f1fc3@redhat.com>
Date: Wed, 4 Mar 2020 20:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304174217.GI4104@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, Bhavesh Davda <bhavesh.davda@oracle.com>,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 6:42 PM, Dr. David Alan Gilbert wrote:
> * Liran Alon (liran.alon@oracle.com) wrote:
>> pkg_config parameter should be "--exists", not "--exist".
>> This is probably a typo.
>>
>> Fixes: 3a67848134d0 ("configure: Enable test and libs for zstd")
>> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> 
> That's the same as 20200303124925.28079-1-dplotnikov@virtuozzo.com from
> Denis yesterday.

And Alex 2 days ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg684754.html

> 
> Dave
> 
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 50c4d96e2a8c..280f3654f786 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2464,7 +2464,7 @@ fi
>>   # zstd check
>>   
>>   if test "$zstd" != "no" ; then
>> -    if $pkg_config --exist libzstd ; then
>> +    if $pkg_config --exists libzstd ; then
>>           zstd_cflags="$($pkg_config --cflags libzstd)"
>>           zstd_libs="$($pkg_config --libs libzstd)"
>>           LIBS="$zstd_libs $LIBS"
>> -- 
>> 2.20.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 


