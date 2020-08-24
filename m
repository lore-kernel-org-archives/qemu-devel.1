Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1059206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4qDbuGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1059206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAE1Y-00024O-8p
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAE0m-00013V-Gi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAE0i-00009B-DI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598281426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTIKytunm/a2+K76EnRMoIlBsgvlTk4pOK4qKAOMmP4=;
 b=D4qDbuGsfrqsVXbU7wYeoc2hOdGcuqa9YvpsS1c0pDu+Tdxd1edZFkm1DoXGj+4Vnf52uF
 xAQuqyVZILtvqnyMARWzgXma/zepvom9qvc7CldwdwltOiucBTfTp1rOzfVfa5FwReBLVn
 PsOYhW9v+QKYCKFAoigXt4lU1LmlUUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-0xPKQKrOPACvm4a8VGdnlA-1; Mon, 24 Aug 2020 11:03:30 -0400
X-MC-Unique: 0xPKQKrOPACvm4a8VGdnlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008AB18A2255;
 Mon, 24 Aug 2020 15:03:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-186.ams2.redhat.com
 [10.36.112.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A73A5D9E2;
 Mon, 24 Aug 2020 15:03:13 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
To: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200821123007.3d390d51@redhat.com>
 <2f874496-e9a2-d52f-2c6e-0595cc3ae9cb@redhat.com>
 <20200824133541.0a5fe9a1@redhat.com>
 <CAARzgwxLVgMtUR07f5eG45hQ0W9XK1A-SQb1Kvwx2JVS848hmA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9e7d1a23-ec26-dbeb-3a84-e243f683a886@redhat.com>
Date: Mon, 24 Aug 2020 17:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAARzgwxLVgMtUR07f5eG45hQ0W9XK1A-SQb1Kvwx2JVS848hmA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/24/20 13:51, Ani Sinha wrote:
> On Mon, Aug 24, 2020 at 5:06 PM Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> On Sat, 22 Aug 2020 16:25:55 +0200
>> Laszlo Ersek <lersek@redhat.com> wrote:
>>
>>> +Marcel, Laine, Daniel
>>>
>>> On 08/21/20 12:30, Igor Mammedov wrote:
>>>> On Tue, 18 Aug 2020 23:52:23 +0200
>>>> Julia Suvorova <jusual@redhat.com> wrote:
>>>>
>>>>> PCIe native hot-plug has numerous problems with racing events and
>>>>> unpredictable guest behaviour (Windows).
>>>> Documenting these misterious problems I've asked for  in previous
>>>> review hasn't been addressed.
>>>> Pls see v1 for comments and add requested info into cover letter at
>>>> least or in a commit message.
>>>
>>> Igor, I assume you are referring to
>>>
>>>   http://mid.mail-archive.com/20200715153321.3495e62d@redhat.com
>>>
>>> and I couldn't agree more.
>>>
>>> I'd like to understand the specific motivation for this patch series.
>>>
>>> - I'm very concerned that it could regress various hotplug scenarios
>>> with at least OVMF.
>>>
>>> So minimally I'm hoping that the work is being meticulously tested with
>>> OVMF.
>>>
>>> - I don't recall testing native PCIe hot-*unplug*, but we had repeatedly
>>> tested native PCIe plug with both Linux and Windows guests, and in the
>>> end, it worked fine. (I recall working with at least Marcel on that; one
>>> historical reference I can find now is
>>> <https://bugzilla.tianocore.org/show_bug.cgi?id=75>.)
>>>
>>> I remember users confirming that native PCIe hotplug worked with
>>> assigned physical devices even (e.g. GPUs), assuming they made use of
>>> the resource reservation capability (e.g. they'd reserve large MMIO64
>>> areas during initial enumeration).
>>>
>>> - I seem to remember that we had tested hotplug on extra root bridges
>>> (PXB) too; regressing that -- per the pxb-pcie mention in the blurb,
>>> quoted below -- wouldn't be great. At least, please don't flip the big
>>> switch so soon (IIUC, there is a big switch being proposed).
>>
>> I'm suggesting to make ACPI hotplug on q35 opt-in,
>> becasue it's only Windows guests that doesn't work well with unplug.
>> Linux guests seems to be just fine with native hotplug.
>>
>>> - The documentation at "docs/pcie.txt" and "docs/pcie_pci_bridge.txt" is
>>> chock-full of hotplug references; we had spent days if not weeks for
>>> writing and reviewing those. I hope it's being evaluated how much of
>>> that is going to need an update.
>>>
>>> In particular, do we know how this work is going to affect the resource
>>> reservation capability?
>> My hunch is that should not be affected (but I will not bet on it).
>> ACPI hotplug just changes route hotplug event is delivered, and unplug
>> happens via ACPI as well. That works around drivers offlining/onlining
>> devices in rapid succession during native unplug (that's quite crude
>> justification).
>>
>> So I'd like reasons to be well documented, including what ideas were
>> tried to fix or workaround those issues (beside ACPI one), so the next
>> time we look at it we don't have to start from ground up.
>>
>>
>>> $ qemu-system-x86_64 -device pcie-root-port,\? | grep reserve
>>>   bus-reserve=<uint32>   -  (default: 4294967295)
>>>   io-reserve=<size>      -  (default: 18446744073709551615)
>>>   mem-reserve=<size>     -  (default: 18446744073709551615)
>>>   pref32-reserve=<size>  -  (default: 18446744073709551615)
>>>   pref64-reserve=<size>  -  (default: 18446744073709551615)
>>>
>>> The OVMF-side code (OvmfPkg/PciHotPlugInitDxe) was tough to write. As
>>> far as I remember, especially commit fe4049471bdf
>>> ("OvmfPkg/PciHotPlugInitDxe: translate QEMU's resource reservation
>>> hints", 2017-10-03) had taken a lot of navel-gazing. So the best answer
>>> I'm looking for here is "this series does not affect resource
>>> reservation at all".
>>>
>>> - If my message is suggesting that I'm alarmed: that's an
>>> understatement. This stuff is a mine-field. A good example is Gerd's
>>> (correct!) response "Oh no, please don't" to Igor's question in the v1
>>> thread, as to whether the piix4 IO port range could be reused:
>>>
>>>   http://mid.mail-archive.com/20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org
>>>
>>> That kind of "reuse" would have been a catastrophe, because for PCI IO
>>> port aperture, OVMF uses [0xC000..0xFFFF] on i440fx, but
>>> [0x6000..0xFFFF] on q35:
>>>
>>>   commit bba734ab4c7c9b4386d39420983bf61484f65dda
>>>   Author: Laszlo Ersek <lersek@redhat.com>
>>>   Date:   Mon May 9 22:54:36 2016 +0200
>>>
>>>       OvmfPkg/PlatformPei: provide 10 * 4KB of PCI IO Port space on Q35
>>>
>>>       This can accommodate 10 bridges (including root bridges, PCIe upstream and
>>>       downstream ports, etc -- see
>>>       <https://bugzilla.redhat.com/show_bug.cgi?id=1333238#c12> for more
>>>       details).
>>>
>>>       10 is not a whole lot, but closer to the architectural limit of 15 than
>>>       our current 4, so it can be considered a stop-gap solution until all
>>>       guests manage to migrate to virtio-1.0, and no longer need PCI IO BARs
>>>       behind PCIe downstream ports.
>>>
>>>       Cc: Gabriel Somlo <somlo@cmu.edu>
>>>       Cc: Jordan Justen <jordan.l.justen@intel.com>
>>>       Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1333238
>>>       Contributed-under: TianoCore Contribution Agreement 1.0
>>>       Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>       Reviewed-by: Jordan Justen <jordan.l.justen@intel.com>
>>>       Tested-by: Gabriel Somlo <somlo@cmu.edu>
>>>
>>> - If native PCIe hot-unplug is not working well (or at all) right now,
>>> then I guess I can't just summarily say "we had better drop this like
>>> hot potato".
>>>
>>> But then, if we are committed to *juggling* that potato, we should at
>>> least document the use case / motivation / current issues meticulously,
>>> please. Do we have a public BZ at least?
>>>
>>> - The other work, with regard to *disabling* unplug, which seems to be
>>> progressing in parallel, is similarly in need of a good explanation, in
>>> my opinion:
>>>
>>>   http://mid.mail-archive.com/20200820092157.17792-1-ani@anisinha.ca
>>>
>>> Yes, I have read Laine's long email, linked from the QEMU cover letter:
>>>
>>>   https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
>>>
>>> The whole use case "prevent guest admins from unplugging virtual
>>> devices" still doesn't make any sense to me. How is "some cloud admins
>>> don't want that" acceptable at face value, without further explanation?
>> My take on it that, Windows always exposes unplug icon, and lets VM users
>> to unplug PCI devices. Notably, user is able to click away the only NIC
>> VM was configured with.
> 
> Correct. Also sometimes the admins may not want some other PCI devices
> to be hot unpluggable such as the balloon device.
> 
>>
>> Unfortunatly the 'feature' can't be fixed on guest side,
> 
> It can be using driver hacks but they are very operating system
> specific and also needs to be applied per VM everytime they are
> powered on.
> 
> that's why
>> hypervisors implement such hack to disable ACPI hotplug. Which I guess
>> is backed by demand from users deploying Windows virtual desktops.
>>
>> PS:
>> I'd made PCI hotplug opt-in, since not everyone needs it.
>> But that ship sailed long ago.

Thank you both for explaining.

All of these use cases seems justified to me.

Given that they are basically quirks, for addressing guest OS specific
peculiarities, changing machine type defaults does not seem warranted.
In my opinion, all of these bits should be opt-in. If we need to capture
permanent recommendations, we can always document them, and/or libosinfo
can expose them machine-readably.

Thanks
Laszlo


