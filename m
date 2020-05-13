Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9478DC2D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C48A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfxIXudb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C48A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYgzD-0006ev-Gz
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 22:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYgyR-0006GG-13
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:18:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYgyP-0008JG-Q9
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589336296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9B4e0Li6DXy6xnOAaI4nc5maIyx6g7r0Lqysj9CUE84=;
 b=PfxIXudboUCcBOz49yM414Qc1KYCrTQ2TMuE11si2s1bAUeAMIg2cnkeMD0KFVbSRES/vC
 RDM2FElGT0l6iCmg7zPjHMt1zSypJHPOIjye/HcpoBBsN8jS0daIkwwGXPurzzGx2bXP5y
 zJ1wNNeNpI8kyuvhV8UxcP7waB/AxGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-ViHxsKrbNbmbxcppSFuoYQ-1; Tue, 12 May 2020 22:18:14 -0400
X-MC-Unique: ViHxsKrbNbmbxcppSFuoYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE6280B70B;
 Wed, 13 May 2020 02:18:13 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49CF66E6E8;
 Wed, 13 May 2020 02:18:10 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
 <20200424152722.GA14573@ls3530.fritz.box>
 <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
 <CAFEAcA-vJXRcjNPnyB5t4UOrmH5wnUoZsx-JAwDYNavQ_L64XQ@mail.gmail.com>
 <24b9c9a3-a0b6-2d9b-eade-dbc43bd71ff4@redhat.com>
 <ed40763d-93c7-643d-51aa-4b36396c7c58@amsat.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <de204d63-b0ba-907d-249a-0e23c9f2870f@redhat.com>
Date: Wed, 13 May 2020 10:18:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ed40763d-93c7-643d-51aa-4b36396c7c58@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 21:16:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/12 下午3:13, Philippe Mathieu-Daudé wrote:
> Hi Jason,
>
> On 4/27/20 5:32 AM, Jason Wang wrote:
>> On 2020/4/26 下午3:57, Peter Maydell wrote:
>>> On Sun, 26 Apr 2020 at 03:50, Jason Wang<jasowang@redhat.com>  wrote:
>>>
>>>> Looks good to me.
>>>>
>>>> Would you please send a formal patch and cc Peter.
>>>>
>>>> Consider we are about to release 5.0, it's better for him to apply the
>>>> patch directly.
>>> I am not applying any further patches for 5.0 unless they come
>>> with an attached rock-solid justification for why we should
>>> delay the release again for them.
>>>
>>> thanks
>>> -- PMM
>>
>>
>> Ok.
>>
>> I will queue that patch for 5.1.
>
> Can you queue patches #1 and #2?


Queued.

Thanks


>
>>
>> Thanks
>>
>>
>>>
>>
>>
>


