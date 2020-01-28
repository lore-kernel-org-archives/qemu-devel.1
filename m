Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B4BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EAA2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IapUrr1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EAA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ2G-0007xf-7C
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwQ1F-0007Hi-Bm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwQ1E-0004Wl-Fl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:31:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwQ1E-0004WH-DD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580214660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBeo7/od99dWX5m9BUy/8m/k9vwJjwChSU6qSe/7SHk=;
 b=IapUrr1cyeDIV6FRzOqQbZVPEi7VN4631HTNQkPaNmoYPq9oNXFtcKV9SzdN5zhAZS4UBj
 KQ1pP5fB3zpzOlr7MYV8QzQ7Wifbho4Eb7Oww+pwmg4Mq9H1eLKacvj42YKEU37Q9OAiEN
 FQxYt7lqaFqRSIq9a6+CJdIqFsHI+b4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-zQft9ij7OGSiaad9p3SvpA-1; Tue, 28 Jan 2020 07:30:56 -0500
Received: by mail-wm1-f69.google.com with SMTP id a10so612590wme.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 04:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FBeo7/od99dWX5m9BUy/8m/k9vwJjwChSU6qSe/7SHk=;
 b=Z3A/lFCEQqHhqxGvh2SSz3QjhtyZ04p001DMRkVKdEODIixlvoyyinPQ+n36xccIOq
 G//puynWUSR3SqEJrAc4+kY+YT8ONJsgDkHtE2x2GhsrqkcEVLa18FnFmJbL/Rx5U3d1
 ZrbNUgCrqNyVGg9tB+Ptjsgp/3t+oiJ+nd1PY2Ig/0uV3cQDMZB8o7M2c01c7BIsAdPW
 vrXQiJrepddqsC/t89QhdCQ/aLbJIpBUF7ULjZs/NolcMK6vRj6dmhfIZtl+9pkCa9GA
 2hFoL2xoiuKVz2/BQ23PUkbcZP1ackp9xq5Sba+z5bc4JrdX3mTK2iG19KvufHkjUGjH
 8Tlg==
X-Gm-Message-State: APjAAAVDc9vzfPaKc3k31fbvPBFvXondhezwXUzzO5eJ6X1goAJptZig
 iQ21sSQUzhAYg/YEt5jCJKg3aw05OH5oVPYZd3855mtEttnCC7Xb9fECIR1Bspw9lRthBKBUCE6
 60v2boyYThVReodI=
X-Received: by 2002:a05:600c:22d2:: with SMTP id
 18mr4948828wmg.21.1580214655132; 
 Tue, 28 Jan 2020 04:30:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvQEIPkfQFuQp/3rTEh2J489q0cEh6waI0U7U7WIlFpr7kGH+QkIweLwAsMQNiqfa9qXeduQ==
X-Received: by 2002:a05:600c:22d2:: with SMTP id
 18mr4948795wmg.21.1580214654909; 
 Tue, 28 Jan 2020 04:30:54 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id e16sm25538231wrs.73.2020.01.28.04.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 04:30:54 -0800 (PST)
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
To: Kevin Wolf <kwolf@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20200123124357.124019-1-felipe@nutanix.com>
 <20200123165955.GB5021@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfb7c669-19dc-5693-8afe-1f70b61c48f3@redhat.com>
Date: Tue, 28 Jan 2020 13:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123165955.GB5021@linux.fritz.box>
Content-Language: en-US
X-MC-Unique: zQft9ij7OGSiaad9p3SvpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Jon Maloy <jmaloy@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi guys,

(Cc'ing Jon)

On 1/23/20 5:59 PM, Kevin Wolf wrote:
> Am 23.01.2020 um 13:44 hat Felipe Franciosi geschrieben:
>> When querying an iSCSI server for the provisioning status of blocks (via
>> GET LBA STATUS), Qemu only validates that the response descriptor zero's
>> LBA matches the one requested. Given the SCSI spec allows servers to
>> respond with the status of blocks beyond the end of the LUN, Qemu may
>> have its heap corrupted by clearing/setting too many bits at the end of
>> its allocmap for the LUN.
>>
>> A malicious guest in control of the iSCSI server could carefully program
>> Qemu's heap (by selectively setting the bitmap) and then smash it.
>>
>> This limits the number of bits that iscsi_co_block_status() will try to
>> update in the allocmap so it can't overflow the bitmap.
>>
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
> Thanks, applied to the block branch.

We are trying to reproduce this, do you already have some code that 
triggered this issue?

I am new to the block API, I noticed the block/blkdebug.c file with 
'blkdebug' option, is it helpful to reproduce this issue via HMP?

Any suggestion what would be the easier/quicker way to test this?

Looking for iotests examples I see tests/qemu-iotests/147 providing a 
BuiltinNBD class. Is it the recommended way to go, to mock a iSCSI server?

Thanks,

Phil.


