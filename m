Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C71E206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g94TaxJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6Cs-0003k8-Kw
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL69r-00014J-4D
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:54:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL69m-00081E-7a
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600872844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ro5t1jCGdDB36UmHSm5D5f/N7RXFA4qSkHw3W7QM1Q4=;
 b=g94TaxJOEbsNR+fDnwadfrCyHgRZ+xUZYwSmRFS+xA51nhJxzatt8zGNvwdq7ZaUcr5kJk
 9ze88mn0Pjq9VhRpWSgEZCX7tNWQRnVs9FrRYzHEVEgBUzoS8HKyZcRk1+rhyMRuVnuCIt
 xIP3z9S/Cs915fN1ClH7LDQTJfprfuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-lZAW9pQDP8SmEuZO0Dlm8w-1; Wed, 23 Sep 2020 10:54:03 -0400
X-MC-Unique: lZAW9pQDP8SmEuZO0Dlm8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 610D510BBEC8;
 Wed, 23 Sep 2020 14:54:01 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20DE07368B;
 Wed, 23 Sep 2020 14:53:59 +0000 (UTC)
Subject: Re: [PATCH 3/7] hw/ide/core: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-4-f4bug@amsat.org>
 <20200817111745.GG11402@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <2347d8f7-5632-f7a4-6b81-bee179241da4@redhat.com>
Date: Wed, 23 Sep 2020 10:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817111745.GG11402@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 08:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:17 AM, Kevin Wolf wrote:
> Am 14.08.2020 um 10:28 hat Philippe Mathieu-Daudé geschrieben:
>> Use self-explicit definitions instead of magic '512' value.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> BDRV_SECTOR_SIZE is the arbitrary unit in which some block layer
> functions and variables work (such as bs->total_sectors). It happens to
> be 512.
> 
> IDE disks have a sector size, too. Actually, two of them, a physical and
> a logical one. The more important one is the logical one. We happen to
> emulate only IDE devices for which the logical block size is 512 bytes
> (ide_dev_initfn() errors out otherwise).
> 
> But just because two constants both happen to be 512 in practice, they
> are not the same thing.
> 
> So if we want to replace all magic 512 values, we should probably
> introduce a new IDE_SECTOR_SIZE and then decide case by case whether
> IDE_SECTOR_SIZE or BDRV_SECTOR_SIZE is meant. I think most (if not all)
> of the places you converted in this patch need to be IDE_SECTOR_SIZE.
> 
> Kevin
> 

I didn't audit the other patches, but be mindful of the distinction that 
Kevin is pointing out.

Luckily, I think we're low risk for deciding to change the 
BDRV_SECTOR_SIZE default any time soon, so it probably won't matter in 
the near future ...

--js


