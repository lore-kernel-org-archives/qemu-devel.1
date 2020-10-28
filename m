Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CC5C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09442469B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAzBNQGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09442469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhuV-0001Sy-B0
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhtQ-0000w9-6H
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhtO-0005aL-Nk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603877837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89VSdAifurFlyQUsobFcZhvG9WX4iJap4NxTYl0tMvY=;
 b=KAzBNQGahO5w6doU4H87Vt6CESr4v72RDVTsPtl6jCBOzLjuCkhvMjCmSIYvJcfrqhRdWG
 uUUuSemcJzD5YHOSftTNmUrEjIsxo5uEN8UXwjik41ENi4cl89GxPtZnKUHxBK7gudFGUs
 kA1cRCg+OO3okp1lUYyKktIZxttdNW0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-xruDIsjjP2S4LnFsDyaK0g-1; Wed, 28 Oct 2020 05:37:13 -0400
X-MC-Unique: xruDIsjjP2S4LnFsDyaK0g-1
Received: by mail-ed1-f72.google.com with SMTP id t7so1908709edt.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 02:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89VSdAifurFlyQUsobFcZhvG9WX4iJap4NxTYl0tMvY=;
 b=L666GhtdkZaczPLF0KdVBvIOFX9qeHrpYffu16kcPeL7tjuI4iOcEIduTrtioe68Hy
 qwBUEH2dvay72GUEeWDPqR810Qez2j8oQAdPdhrWULBu/3XKbdUiBx7eqW5NUkTi+azA
 dlajpcVIcTwEVaDkd6FPVK0Hn+ILd3tLTbJxtPsksUhf+eB2tM66lYr/oVj56gVU0Hd7
 8Yc8MvlGeK1A8ySYWbD3L5cEIrBkO4q6FljmryFtuwgqMbJ/pcdlIP6QrdNvwh1iU49+
 Fc0nTH75ubt+a1HoICcEwFee2cyX7U0uT4hxRi+gGrlUrGKt2/kbKL8/f8OGfGymyDsi
 tbLA==
X-Gm-Message-State: AOAM531Z4URLb9Rh3oVN9xvdwD0ApwG9NA2QCpjXb6MpqC9AvzQegWbU
 hyqHdjTnm0iMrYQ+nmOxSVQvZ2OQ3yIyrOOQhy2eiWehnOTKpdm8DmZq/LLHpMtRr2uiRCRriPv
 cWdljN2/V+fdytys=
X-Received: by 2002:a17:906:c293:: with SMTP id
 r19mr6371286ejz.63.1603877832144; 
 Wed, 28 Oct 2020 02:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyRs/eZOGK2cEw05+VCR6areGUaBVkVma/PO3pV6amOHQFCIAI27TarRl2a5777vSqdORydg==
X-Received: by 2002:a17:906:c293:: with SMTP id
 r19mr6371265ejz.63.1603877831890; 
 Wed, 28 Oct 2020 02:37:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s25sm2484178ejc.29.2020.10.28.02.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:37:11 -0700 (PDT)
Subject: Re: [PATCH v3 00/15] python: create installable package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <e1289328-d372-0eaa-7128-8cb4867ef4c0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe94bba9-b3b7-4973-7378-d3dc95e18d86@redhat.com>
Date: Wed, 28 Oct 2020 10:37:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e1289328-d372-0eaa-7128-8cb4867ef4c0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 11:08 PM, John Snow wrote:
> Ping O:-)
> 
> Looking for feedback from at least Cleber and Eduardo before I barge
> ahead and send a PR to include this on master. Additional packaging and
> versioning feedback from Dan would be nice.
> 
> (I know we have a very busy two weeks here; I will continue pinging, but
> I have every intention of merging this prior to 5.2.)

Too pythonic for me, so I'll defer that to Python experts.

It would be nice to have this in 5.2 indeed...

Regards,

Phil.


