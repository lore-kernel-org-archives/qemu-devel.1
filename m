Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA2C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98D6214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6qMWiYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98D6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57379 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irm05-0004td-SB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irlzG-0003hf-3w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irlzF-0006UK-3t
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irlzE-0006U1-Vw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579107464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7/MbaNCMTGH7gRBF77t/X3ZDwT18E5JMckP1/lddZQ=;
 b=H6qMWiYxL66bV2b4rtz6F7B1FmTo9erhwk9Nzwgh+mYphU7hgRWFcrYaF+0hPlH8MxhEwB
 LNd9akGy+FJsDSxW+a8uVBbwqedk5KmUPzvF7cSli+evR7uBBz/kT2iQvzxHADPjAchxy7
 k8mKK0Qc70dDr28YHZ+3ZUmvJyGW6x4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-FyQmdGlGMre7309VGcnPhw-1; Wed, 15 Jan 2020 11:57:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so8253067wro.14
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 08:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m7/MbaNCMTGH7gRBF77t/X3ZDwT18E5JMckP1/lddZQ=;
 b=P88uNSkldAgOwNASSr2bcDTZJdarA0emcXx3FthL4UbxhgOCwxAHqbR9VQ4BFamSoO
 ZnGBtXhIpG7WSfr6E/E1ba+6wyBgoSlqqKApN2nhamrG+RjH5GDrltBiJVAw1YBQdjbP
 IS0p/BW5DZskis2IAlTu3SMkTWLyBlTf+Ke78LZOpfjt60KFXeEP7z/cZevEwOteWpv7
 Tf2Qa92zuRRsJBfNxii4mnJfed1pZagerQdGUJVpxrIKIj6bNP4LQ+TjwXFl0nr5qS5p
 un+BtZK/Kun0dD1BDbvNkuQIKihw8xSywmB5crqLpsAw/upodcmqpeB6JogI3Oc/YUrJ
 h5dQ==
X-Gm-Message-State: APjAAAXNnimFDUjQITwoVh8hdxnnyppAC53XFXmAr39ep1sm/Gg/Uebh
 tAJGlPM2spE66RcTD17km0gcLWw/0sjQ0b8v1npNQAUNYE9s/cjGWFRyxcDNYA1khk7QMFBSU2U
 p2HNl2qZhacsMdbU=
X-Received: by 2002:adf:f88c:: with SMTP id u12mr33723631wrp.323.1579107461948; 
 Wed, 15 Jan 2020 08:57:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhHkzJHnkPkzTQPKtFH8Dy4KKAkz5Fs1ZSHZrY4MInLhivdqWLmQiVMl18VRRj4OJQye+/Yw==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr33723611wrp.323.1579107461754; 
 Wed, 15 Jan 2020 08:57:41 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id m7sm25595844wrr.40.2020.01.15.08.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 08:57:41 -0800 (PST)
Subject: Re: [PATCH v2 02/86] machine: introduce ram-memdev property
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-3-git-send-email-imammedo@redhat.com>
 <80dae4c8-a902-4f9e-9878-95b69f9390df@redhat.com>
 <20200115173935.0a527c9a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c5def808-2f1d-c128-a3b4-ba93365aeebb@redhat.com>
Date: Wed, 15 Jan 2020 17:57:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115173935.0a527c9a@redhat.com>
Content-Language: en-US
X-MC-Unique: FyQmdGlGMre7309VGcnPhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 5:39 PM, Igor Mammedov wrote:
> On Wed, 15 Jan 2020 16:56:30 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 15/01/20 16:06, Igor Mammedov wrote:
>>>   
>>> +    object_property_add_link(obj, "ram-memdev", TYPE_MEMORY_BACKEND,
>>> +                             (Object **)&ms->ram_memdev,
>>> +                             object_property_allow_set_link,
>>> +                             OBJ_PROP_LINK_STRONG, &error_abort);
>>> +    object_property_set_description(obj, "ram-memdev",
>>> +                                    "Set RAM backend"
>>> +                                    "Valid value is ID of hostmem based backend",
>>> +                                     &error_abort);
>>> +
>>
>> Obligatory bikeshedding, why not just ram (the MachineState field can
>> remain "ram_memdev").  Or memory-backend matching the QOM type names.
> 
> I'd say it was inspired by "-numa node,memdev" option for some sort of consistency.
> But I'm fine with any other name as far as there is consensus.
> If I had to choose between 'ram' and 'memory-backend', I'd go for the later.

+1 for "memory-backend".


