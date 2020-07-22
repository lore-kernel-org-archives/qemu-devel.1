Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A13C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA430206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjNhmtQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA430206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy5P4-0005xV-40
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 23:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy5O9-0005CO-IX
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:25:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy5O6-0000nk-RB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 23:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595388344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uff2t9rNsye6wexnhA4czHYRNXIpsm69+ZlAvhmnuQ=;
 b=IjNhmtQk5mHmk6zZn8owbchYm9YU8f8AE/I/CSdX3BtFvameyCrn1KiechxYwCSUB4+3Eq
 Q1G6IpcJAlMoa+uJEQtcBPBYpKJhfmrch17+5Yinfq6svqKwCJ68KRBHsYi/7hE2llTc5U
 PtI0LqVMYAP4fgampZjofpny0drC15E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-oEkaFJuvPD-qRuTLjgUIxg-1; Tue, 21 Jul 2020 23:25:41 -0400
X-MC-Unique: oEkaFJuvPD-qRuTLjgUIxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8891800C64;
 Wed, 22 Jul 2020 03:25:39 +0000 (UTC)
Received: from [10.72.13.156] (ovpn-13-156.pek2.redhat.com [10.72.13.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD7E69317;
 Wed, 22 Jul 2020 03:25:34 +0000 (UTC)
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Peter Maydell <peter.maydell@linaro.org>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
 <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
 <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
 <CAFEAcA8ECKgRanHLiFZMDS3fd77ASBkba2nfv+iwnjgSLWnbPw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16092892-9055-1ed9-ea0d-bb2794bb2e6a@redhat.com>
Date: Wed, 22 Jul 2020 11:25:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ECKgRanHLiFZMDS3fd77ASBkba2nfv+iwnjgSLWnbPw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Bug 1886362 <1886362@bugs.launchpad.net>, Li Qiang <liq3ea@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/21 下午9:44, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 14:21, Jason Wang <jasowang@redhat.com> wrote:
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
>> I think some device want such peer to peer transactions:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/pci/p2pdma.rst
> That's a device DMAing to another device, not DMAing to *itself*
> (device-to-another-device DMA should work fine in QEMU). And only
> a very few devices will ever be sensible targets of the DMA --
> basically things like nvme that have a looks-like-memory area,
> or special cases like doorbell registers.


Well, my understanding is:

- it's not about whether or not we have an actual device that can do DMA 
into itself but whether it's allowed by PCI spec
- it's not really matter whether or not it tries to DMA into itself. 
Devices could be taught to DMA into each other's RX:

e1000e(1) RX DMA to e1000e(2) MMIO (RX)
e1000e(2) RX DMA to e1000e(1) RX

So we get re-reentrancy again.


>
>>> Yeah, this is the interesting part for QEMU. How should we
>>> structure devices that do DMA so that we can be sure that
>>> the device emulation at least doesn't crash? We could have
>>> a rule that all devices that do DMA must always postpone
>>> all of that DMA to a bottom-half, but that's a lot of
>>> refactoring of a lot of device code...
>>
>> It looks to me the issue happens only for device with loopback
> I think in principle we have a problem for any device that
> (a) has memory mapped registers and (b) does DMA reads
> whose address is guest-controlled. Loopback isn't a
> requirement -- if the guest programs, say, an RX descriptor
> base address to point at the device's own registers, you
> get exactly the same kind of unexpected-reentrancy.


Right, so about the solution, instead of refactoring DMA I wonder we can 
simply detect and fail the RX by device itself.

Thanks


>
> thanks
> -- PMM
>


