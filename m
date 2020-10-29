Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6ECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45C7206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrYv6uOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C7206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3vr-00085t-HM
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY3vD-0007bn-A5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY3vA-0005NB-21
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603962515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLxq/296Bg/gKMD2hLmVotR4i2TCSyUfBODqakNeFvw=;
 b=VrYv6uOUnxM5L0f0w3slCjJ1OqixQdi7c+FvUkbzgsdjhFEf4exu9TAljqMVGh3ihvVYdw
 5+pEZMV9TdK9C2rnXYPF+77qWXFdwyqcIJNPHs+oagrcgvJ95sznAMcZDrBVP2Ji8lvAze
 XyQW/g8YGL9fXnW8lXK4cx578dFK9b8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-QGlqwB6aMMq8swNwPGn9Hg-1; Thu, 29 Oct 2020 05:08:33 -0400
X-MC-Unique: QGlqwB6aMMq8swNwPGn9Hg-1
Received: by mail-ed1-f72.google.com with SMTP id 28so913729edv.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OLxq/296Bg/gKMD2hLmVotR4i2TCSyUfBODqakNeFvw=;
 b=WGEHlaAhMyv06DKBJXrFR/IThlxFgNl5NbsWD20UHyo03V3MVtfojDeY/wlO2D9Nme
 6YSecXQTm7m7IyYnX30NJLCzyOcvhpIQK3r05fzIcp0L1sel90RqPcf83tm511qMehTU
 wSkoW81OShYAFu/os/eaCbJjLuuHJkZ9C6QzIcP2+l0Go4hhKbYaN3wc6ztnjep9WHlr
 sMAWQsFTmLmRC9D9l552MJi6t80DzoERSh028kaBDjuL1hjcuuIIHfVvtEzbUBF9dCtp
 WQfxQrUCgb6QYiShgZJQJ9nrMSh+0qEypI+wbKQReoHFAlwuOb/ZV8k9sqL4w/kkPYiA
 2y1A==
X-Gm-Message-State: AOAM532eVQiu8BsfbgnfNuKsS4K527TAd5sutfqllNZbo+Sp2XcYRewW
 1isd/knh3pd9mquHPKpvpTSI9Z/ZaZyI3Ce7/2DItdbO1W4SALjUPxRxEAYYUf7b5rL5HBqJJ10
 wbQVVbAmt2DOgsxE=
X-Received: by 2002:aa7:dcd6:: with SMTP id w22mr2871703edu.378.1603962511632; 
 Thu, 29 Oct 2020 02:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQbP6E/qAP6ylU8fAyhMoLEo6jlQZoOtBDeaCY002XNCzND/P6PszEA74/egnmnV7qwM7yQQ==
X-Received: by 2002:aa7:dcd6:: with SMTP id w22mr2871683edu.378.1603962511442; 
 Thu, 29 Oct 2020 02:08:31 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id p3sm1117210edy.38.2020.10.29.02.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 02:08:30 -0700 (PDT)
Subject: Re: [PATCH 00/25] block/nvme: Fix Aarch64 host
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <9f299973-36c6-6e82-7dfd-aa6eb7b80b63@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a3617970-65ba-73b3-fbac-52d6f0fa9f56@redhat.com>
Date: Thu, 29 Oct 2020 10:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9f299973-36c6-6e82-7dfd-aa6eb7b80b63@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 7:10 PM, Auger Eric wrote:
> Hi Philippe,
> 
> On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
>> Add a bit of tracing, clean around to finally fix few bugs.
>> In particular, restore NVMe on Aarch64 host.
>>
>> Eric Auger (4):
>>   block/nvme: Change size and alignment of IDENTIFY response buffer
>>   block/nvme: Change size and alignment of queue
>>   block/nvme: Change size and alignment of prp_list_pages
>>   block/nvme: Align iov's va and size on host page size>
>> Philippe Mathieu-Daudé (21):
>>   MAINTAINERS: Cover 'block/nvme.h' file
>>   block/nvme: Use hex format to display offset in trace events
>>   block/nvme: Report warning with warn_report()
>>   block/nvme: Trace controller capabilities
>>   block/nvme: Trace nvme_poll_queue() per queue
>>   block/nvme: Improve nvme_free_req_queue_wait() trace information
>>   block/nvme: Trace queue pair creation/deletion
>>   block/nvme: Simplify device reset
>>   block/nvme: Move definitions before structure declarations
>>   block/nvme: Use unsigned integer for queue counter/size
>>   block/nvme: Make nvme_identify() return boolean indicating error
>>   block/nvme: Make nvme_init_queue() return boolean indicating error
>>   block/nvme: Introduce Completion Queue definitions
>>   block/nvme: Use definitions instead of magic values in add_io_queue()
>>   block/nvme: Correctly initialize Admin Queue Attributes
>>   block/nvme: Simplify ADMIN queue access
>>   block/nvme: Simplify nvme_cmd_sync()
>>   block/nvme: Pass AioContext argument to nvme_add_io_queue()
>>   block/nvme: Set request_alignment at initialization
>>   block/nvme: Correct minimum device page size
>>   block/nvme: Fix use of write-only doorbells page on Aarch64 arch
>>
>>  include/block/nvme.h |  17 ++--
>>  block/nvme.c         | 208 ++++++++++++++++++++++++-------------------
>>  MAINTAINERS          |   2 +
>>  block/trace-events   |  30 ++++---
>>  4 files changed, 148 insertions(+), 109 deletions(-)
>>
> 
> I have tested the series on ARM with both 4kB and 64kB pages and it
> works for me.
> 
> Feel free to add:
> Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Phil.


