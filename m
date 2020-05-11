Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47000C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAE4206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxNF2/97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAE4206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2Rp-0006o2-4e
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY2Qh-0005yX-6L
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:00:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY2QN-0006NW-PF
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589180426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biH8YNSY5AFF2bCUNWL7tyUSN3jdTXU1eE6KDObJPfQ=;
 b=YxNF2/97nUtdWyaPo5nK0SS2r9ucFJjuT9cjjl41fiUA8jeLUflXyFT1NgLcN1lY7VWu34
 qnUVe/I7b2VtMoJpDh2krKXRXK2RRBVMVLCOPdlKugr6AApuW0nWTLhY13/iA43E9cVHFd
 dQuD3Y+L5zJ9KD67lC1TAWbgE5FEiRM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-_OSjcZ1WMw-EdCDXuB4BKA-1; Mon, 11 May 2020 03:00:22 -0400
X-MC-Unique: _OSjcZ1WMw-EdCDXuB4BKA-1
Received: by mail-wr1-f69.google.com with SMTP id o6so4811052wrn.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=biH8YNSY5AFF2bCUNWL7tyUSN3jdTXU1eE6KDObJPfQ=;
 b=PNEFsen/Ftd2V3F/yUWm5wcZUha7fJo7CFomuPbywfMeStTZJWHUAhdXHvWykSt2rF
 H1KN7wf8sBujvvKdFjui36+yLaPfQeZXtygRwcUBRCRfchord34pC6IG2yLCVwUqUaX4
 KZRZ8X9pk2dfF6x8p5pJXhGFd2fuFAs9+9jzI+Zf3eJPQJcwlntk7i43EkJXjEe/ndqr
 1uk3NiR/CiNWrJAilvroZO3jpzO6wpb0Y1y0F0V0WfRl9g+g1GVcGsxQWDK+N9BF1ZZN
 Ny9ZiFU4NMHr3Txqs99a33yovnHTEBQMQMPa5XaCKfvKC1F8sbzUBdsVas1YltpiAqIk
 zGrQ==
X-Gm-Message-State: AGi0PubzXHWBSwWMRZb7L6dJofDJ+DNuLEn04p4WrzSOxl0qNPPsdcFE
 pHOFO9INg0wBGXuDB393EtMInZwEivp1MlZyzTsPIG0nPTylFqAZ7HrVDt86bJZXXcdx+a70VhR
 AeJVsfUcb6kWadKU=
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr6586598wrw.425.1589180421284; 
 Mon, 11 May 2020 00:00:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypLiHwg8skyD810GllbsrvPhet8QYGrkmbuCsSyCNzv0TkF0W2DerVlkRX6Xq83uD87Rw7cQag==
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr6586564wrw.425.1589180421045; 
 Mon, 11 May 2020 00:00:21 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f123sm12083706wmf.44.2020.05.11.00.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 00:00:20 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] nvme: refactoring and cleanups
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200505054840.186586-1-its@irrelevant.dk>
 <20200511062513.3axdfcmr4izulv5x@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <095f3c9b-5b32-7a88-03e9-ca993ca3f3c9@redhat.com>
Date: Mon, 11 May 2020 09:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511062513.3axdfcmr4izulv5x@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 5/11/20 8:25 AM, Klaus Jensen wrote:
> On May  5 07:48, Klaus Jensen wrote:
>> From: Klaus Jensen <k.jensen@samsung.com>
>>
>> Changes since v5
>> ~~~~~~~~~~~~~~~~
>> No functional changes, just updated Reviewed-by tags. Also, I screwed up
>> the CC list when sending v4.
>>
>> Philippe and Keith, please add a Reviewed-by to
>>
>>    * "nvme: factor out pmr setup" and
>>    * "do cmb/pmr init as part of pci init"
>>
>> since the first one was added and the second one was changed in v4 when
>> rebasing on Kevins block-next tree which had the PMR work that was not
>> in master at the time.
>>
>> With those in place, it should be ready for Kevin to merge.
>>
>   
> Gentle ping on this.
> 
> Also, please see the two patches in "[PATCH 0/2] hw/block/nvme: fixes
> for interrupt behavior". I think they should go in preparation to this
> series.

I was going to ping Kevin last week, but then read your comment on pach 
#7 "nvme: add max_ioqpairs device parameter", so I interpreted you would 
respin.
Now it is clearer, applying in the following order you don't need to 
respin, right?

- [PATCH 0/2] hw/block/nvme: fixes for interrupt behavior"
- [PATCH v5 00/18] nvme: refactoring and cleanups


