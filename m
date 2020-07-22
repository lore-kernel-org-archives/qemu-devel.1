Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D38C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E19D206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wrfbb67h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E19D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy5Q7-0006q0-VC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 23:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy5PZ-0006Pf-J3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:27:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy5PX-00019A-M2
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595388434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDGjRndFwv6Q1HT+GwFLs0ltv3RJCb3lHWQYsrVQxiI=;
 b=Wrfbb67h9LZVEPWoH7hrvKVcgTjcdfD0ic6FMBZYBl0Zy5sr0c7FSQ4ckVOsUyPQ7Cvjhu
 dmcYI2nWugn2KeW44loYJCJ5eMX8mGka/giIp8j6lmP6rJifa5ODPTJ7ZJpHpTzgij3Llf
 htCDZkKWjCahaHvTJ0+4opBX6hIwXUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-97iLTKrCOb-mwasgird97w-1; Tue, 21 Jul 2020 23:27:12 -0400
X-MC-Unique: 97iLTKrCOb-mwasgird97w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0630100AA21;
 Wed, 22 Jul 2020 03:27:11 +0000 (UTC)
Received: from [10.72.13.156] (ovpn-13-156.pek2.redhat.com [10.72.13.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED6CB2B4DA;
 Wed, 22 Jul 2020 03:27:07 +0000 (UTC)
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Li Qiang <liq3ea@gmail.com>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
 <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
 <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
 <CAKXe6SJvrTx=X2kQk6cKOwHczzTM0nocCj22m1eQaNtw-9yOuQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ed905a22-d5bb-7aef-a98c-6897f721b8ea@redhat.com>
Date: Wed, 22 Jul 2020 11:27:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJvrTx=X2kQk6cKOwHczzTM0nocCj22m1eQaNtw-9yOuQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/21 下午9:46, Li Qiang wrote:
> Jason Wang <jasowang@redhat.com> 于2020年7月21日周二 下午9:21写道：
>>
>> On 2020/7/21 下午8:31, Peter Maydell wrote:
>>> On Wed, 15 Jul 2020 at 09:36, Jason Wang <jasowang@redhat.com> wrote:
>>>> I think the point is to make DMA to MMIO work as real hardware.
>>> I wouldn't care to give a 100% guarantee that asking a real
>>> h/w device to DMA to itself didn't cause it to misbehave :-)
>>> It's more likely to happen-to-work because the DMA engine bit
>>> of a real h/w device is going to be decoupled somewhat from
>>> the respond-to-memory-transactions-for-registers logic, but
>>> it probably wasn't something the designers were actively
>>> thinking about either...
>>
>> I think some device want such peer to peer transactions:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/pci/p2pdma.rst
>>
>>
>>>> For
>>>> e1000e and other networking devices we need make sure such DMA doesn't
>>>> break anything.
>>> Yeah, this is the interesting part for QEMU. How should we
>>> structure devices that do DMA so that we can be sure that
>>> the device emulation at least doesn't crash? We could have
>>> a rule that all devices that do DMA must always postpone
>>> all of that DMA to a bottom-half, but that's a lot of
>>> refactoring of a lot of device code...
>>
>> It looks to me the issue happens only for device with loopback
> IMO I think this is not related-loopback.
>
> It happens when the guest write the MMIO address to the device's
> DMA-related registers.
> The one we see UAF occurs in loopback device because the same
> structure uses in re-entry.
> But we can't say there are no issue for non-loopback device.


Yes.


>> Simply git grep loopback in hw/net tells me we probably need only to
>> audit dp8393x and rtl8139.
>>
>> Qiang, want to help to audit those devices?
> No problem. Once I finish the e1000e patch I will try to audit those and
> also try to audit some no-loopback device re-entry issue.


Thanks.


>
> Thanks,
> Li Qiang
>
>> Thanks
>>
>>
>>> thanks
>>> -- PMM
>>>


