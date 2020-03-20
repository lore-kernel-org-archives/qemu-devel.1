Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA8CC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7656F20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO2VHMDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7656F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGCQ-0003oP-Lu
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFGBh-0003MW-5I
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFGBf-0005mJ-S5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:51:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFGBf-0005m3-Nn
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584705098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQMOrRJyoQIpWQDVegLoR46epfwgsCUnTwyjzQAgY7Q=;
 b=HO2VHMDn4ec69gQUqBDEx7DY/Gj+/OdiBzJs21kD1x162obNn9SWDidh8dMdqK2cbbq2eA
 3n+Xfkac0OnWkC8IIwOnLe7KL13qTcBznCpDEOnj+ZQYJ/FmKczbH4usxN9pZiW4jR5Ro8
 c7ZkLZRkOBFx8/YdjyLbSje0qy4c3Gc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-jWD76qQ8N--iT4Y4gterDg-1; Fri, 20 Mar 2020 07:51:37 -0400
X-MC-Unique: jWD76qQ8N--iT4Y4gterDg-1
Received: by mail-wr1-f71.google.com with SMTP id p2so2516020wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQMOrRJyoQIpWQDVegLoR46epfwgsCUnTwyjzQAgY7Q=;
 b=nvnpOdPdElNQcu9jqYLhGY0aLMmgyloExX86AtTkog82YzzM72IB4mGVgvoQ+uLakq
 4Fg/HgIE2inVPET9RxG7Bgn0LtabH1kpGS0+x7kFd9ne18lM6CV+j0oq/aRStHe7fZWq
 Hzuok2Yy1AYlak/jjXH/lDCOCo3p08P9NO3guRpDosKqBeERKtbjyFk/yZhBbVSl4UFP
 UPDxrROSOTgdnGRxYCt8iXPjM1QzwljI7WESner769q0c9renXaF734OjCDf7YccL8vc
 /W4tXIgvzU8e7QkC0DS6MC7oUU0EaPJfBNkijLHXRGx9kN38GwBx1Z3txJgTT11c9BmP
 IpAg==
X-Gm-Message-State: ANhLgQ0ba6i0E0Z0YQjYP/3NpS044EZ2kZvD2jr4Q8+nVvIARG9TvGgI
 FzSJYLizY56WoK/4CyPGhGrzXA5wgrVi4i+oXyOzymNR3CE8HPlbB5V9v+EjbSuuhsHDCR6LfYs
 bQlAV5NCJEYgG9js=
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr11102404wrx.166.1584705096090; 
 Fri, 20 Mar 2020 04:51:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsr+Xm/dUwMauBDO/5KmxjX1poi86JMHMPkIZaYnp8Q3mH9HLdt6hyL0KjD5mX5Wn3Y6NSniQ==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr11102372wrx.166.1584705095859; 
 Fri, 20 Mar 2020 04:51:35 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id g2sm8335330wrs.42.2020.03.20.04.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 04:51:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] add new options to set smbios type 4 fields
To: Heyi Guo <guoheyi@huawei.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
 <20200319154626.551a7852@redhat.com>
 <8ae04ed2-e81b-0aa6-f313-0be9bfd93c04@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e6715fd-c86e-0612-4906-1f13d7c11d4b@redhat.com>
Date: Fri, 20 Mar 2020 12:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8ae04ed2-e81b-0aa6-f313-0be9bfd93c04@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 wanghaibin.wang@huawei.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 02:29, Heyi Guo wrote:
> 
> On 2020/3/19 22:46, Igor Mammedov wrote:
>> On Wed, 18 Mar 2020 14:48:18 +0800
>> Heyi Guo <guoheyi@huawei.com> wrote:
>>
>>> Common VM users sometimes care about CPU speed, so we add two new
>>> options to allow VM vendors to present CPU speed to their users.
>>> Normally these information can be fetched from host smbios.
>> it's probably too late for this series due to soft-freeze,
>> pls repost once 5.0 is released
> 
> Ah, I didn't pay enough attention to the merge window.
> 
> When will the soft-freeze be ended? Will it be announced in the mailing
> list?

You can repost about one month from now.  Thanks!

Paolo


