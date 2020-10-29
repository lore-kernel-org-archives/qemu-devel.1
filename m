Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A107FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1862064B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Stw3+BJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1862064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY6wU-0004Sg-E3
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY6vP-0003uu-Qy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY6vI-0001lg-AJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603974054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk/t1rrNpcfIVsxJ7w6rs1cWcgU/UYgWjcom2H8raMM=;
 b=Stw3+BJfeGulXaHj2EZ/uoO73BSD+MhkZAWlv/PnkXZcVwWmY1ZLzg4iV2nEa/O7aiqVWB
 Vlg5GBhgnVBFxfmWwFKRx9FZxKafed7mw9ZvSTul/f/aOdF39PhC2/bD6O4jQ8opF0ko+B
 WuA5kLPC2GKGjXc4KcfljMhJB+Dsnk0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-o3lZYeTEPlODuydm0jfmkw-1; Thu, 29 Oct 2020 08:20:52 -0400
X-MC-Unique: o3lZYeTEPlODuydm0jfmkw-1
Received: by mail-ej1-f69.google.com with SMTP id p6so1097246ejj.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 05:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fk/t1rrNpcfIVsxJ7w6rs1cWcgU/UYgWjcom2H8raMM=;
 b=AtQSniWESetoV23I/WSGXU3TEw7YxIK5co9VBM5ndbnSENLvyrFeI8OQ9rqlNcf/8X
 DjkEMwvspxderJYElomzVlAwqCpjCn5Ar1t2dLvlNCu403d5GhZeTotaqX77rbhI4Z4W
 rBiu0u6xna89nLP1UBnKjKpAn6kxHMvTnhjspODphPmEyDMhXj4AgAqLguRMQ3C2lRMp
 y1nU24gdgqDoZnNmTRWwx/s156e5u8V0Rxo/A3GB/hz4Fx0IzMiLl8v5XsxyGTz2DW8c
 rwuwdXEwGPzlyjVrIt688ELIbFIVJmuTKOs8mCe9LRGb3/7CcEMwjY0BAprfp+Fhcx7/
 EDJg==
X-Gm-Message-State: AOAM530B9hNd0rnasT+T/Dzi5Ih2NptkdS61Fg2Mp/pcWtwTazVZX1XS
 IqdBGF354QNAGFZ2rNzut3opBz/m8I3tJlVJ33LmJzBXIq+bf4u6cX7wX/3+PAvZNNbrixjpjh6
 7y2z/80aRJp/i9jw=
X-Received: by 2002:a17:906:728f:: with SMTP id
 b15mr1155206ejl.210.1603974051051; 
 Thu, 29 Oct 2020 05:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI3TqSjjO6LuznM1OweCJg2jOlXz6Ygi5HXFueaEwGM5oWhDGjYglxfToU73nY42Vy3HG+JA==
X-Received: by 2002:a17:906:728f:: with SMTP id
 b15mr1155191ejl.210.1603974050854; 
 Thu, 29 Oct 2020 05:20:50 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id dm8sm1427395edb.57.2020.10.29.05.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 05:20:49 -0700 (PDT)
Subject: Re: [PULL 00/30] nvme emulation patches for 5.2
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell <peter.maydell@linaro.org>
References: <20201027104932.558087-1-its@irrelevant.dk>
 <CAFEAcA8EcEfaFZYUicbL5ShA5y5sTP7hmNNX5Ot=3ZyAGnV81A@mail.gmail.com>
 <20201029115254.GA777050@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1cd6447c-66f2-df28-a3ce-94456a17fcf4@redhat.com>
Date: Thu, 29 Oct 2020 13:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029115254.GA777050@apples.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 12:52 PM, Klaus Jensen wrote:
> On Oct 29 11:39, Peter Maydell wrote:
>> On Tue, 27 Oct 2020 at 10:49, Klaus Jensen <its@irrelevant.dk> wrote:
>>>
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Hi Peter,
>>>
>>> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:
>>>
>>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/qemu-nvme.git tags/nvme-next-pull-request
>>>
>>> for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:
>>>
>>>   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)
>>>
>>> ----------------------------------------------------------------
>>> nvme emulation patches for 5.2
>>>
>>>   - lots of cleanups
>>>   - add support for scatter/gather lists
>>>   - add support for multiple namespaces (adds new nvme-ns device)
>>>   - change default pci vendor/device id
>>>   - add support for per-namespace smart log
>>
>> Hi. This tag appears to have been signed with a GPG key
>> which isn't one that's been used before for an nvme pullreq
>> and which isn't on the public GPG servers...
>>
> 
> Uhm. Keith, can we coordinate a keysigning?
> 
> Would a signature by Keith on my key be acceptable to you Peter? That
> way Keith doesn't have to create a new tag and bomb the list again.

Although list bombing isn't really a problem, if you don't modify
the patches, then you can simply post the cover (as v2) without
the patches.

You can also get your key signed and ask Peter to retry your tag,
or push a different tag and ask again, replying to this cover.

Regards,

Phil.


