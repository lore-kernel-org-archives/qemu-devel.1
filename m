Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4672D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfXma7Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4672D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRJm-0005od-Gu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwRJA-0005KS-UK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwRJ9-0001TM-85
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:53:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwRJ9-0001Sx-4G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580219614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGes1y/lHnSO1YVFn+bnS9SeDLmoV+B2H1XAU0fwmQc=;
 b=UfXma7Tt+vXHbw25gKoEdTrEs1kS7alXMIlipnLriCw+DpM311sdXbdGxG1Wa+jPSVe9JE
 lR09IK2d4ZGbena895n+vVjO19mRN+/qbb8tVOvOP0JkRNWU923/iQoI9Uw7sWQzyRwfMH
 GgpcFSyO9aFAcqv8o6V68WL0xRhBtJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-tsuBPZFQOROyCrQLfoMA1g-1; Tue, 28 Jan 2020 08:53:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F9985EE6D;
 Tue, 28 Jan 2020 13:53:31 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B48E8702F;
 Tue, 28 Jan 2020 13:53:29 +0000 (UTC)
Subject: Re: [question] hw/arm/virt: about the default gic-version in
 accelerated mode
To: Andrew Jones <drjones@redhat.com>
References: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
 <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
 <20200128122915.ehzgj5kpmsw5azap@kamzik.brq.redhat.com>
 <e0b73504-b37a-cc57-3c3f-b9872dd1e16c@redhat.com>
 <20200128124143.cmbl3po2uvhsgd23@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <79e4dc6e-1136-039d-8212-738111c738d9@redhat.com>
Date: Tue, 28 Jan 2020 14:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200128124143.cmbl3po2uvhsgd23@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: tsuBPZFQOROyCrQLfoMA1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu list <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 1/28/20 1:41 PM, Andrew Jones wrote:
> On Tue, Jan 28, 2020 at 01:34:06PM +0100, Auger Eric wrote:
>> Hi Drew,
>>
>> On 1/28/20 1:29 PM, Andrew Jones wrote:
>>> On Tue, Jan 28, 2020 at 10:52:50AM +0000, Peter Maydell wrote:
>>>> On Tue, 28 Jan 2020 at 10:47, Auger Eric <eric.auger@redhat.com> wrote:
>>>>> When arm virt machine is run in accelerated mode with "-cpu host
>>>>> -machine virt", the default gic version is 2.
>>>>>
>>>>> I understand the rationale with TCG where we don't have MSI ITS
>>>>> emulation along with GICv3 so we need to choose GICv2 to get GICv2M
>>>>> functionality.
>>>>>
>>>>> However in KVM mode, I would have expected to see the host GIC probed to
>>>>> set the same version on guest. Indeed most of our HW now have GICv3
>>>>> without GICv2 compat mode so our default values lead to weird traces:
>>>>>
>>>>> "
>>>>> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
>>>>> qemu-system-aarch64: failed to set irq for PMU
>>>>> "
>>>>>
>>>>> I would like to propose a patch to improve those errors and also suggest
>>>>> a hint. But I also wanted to know whether you would accept to change the
>>>>> default value with KVM and choose the host version instead of 2. For TCG
>>>>> we would keep v2.
>>>>
>>>> As with the -cpu option, the default is there for command
>>>> line backward compatibility primarily. Even if we had
>>>> better support for MSI ITS emulation we'd still leave
>>>> the default at GICv2.
>>>>
>>>> If you want "do the best you can, regardless of accelerator"
>>>> that is "-cpu max -machine gic-version=max".
>>>>
>>>
>>> There is a case where we can probe without breaking backward
>>> compatibility. That case is kvm-enabled and no gic-version
>>> specified. The reason it would be safe to probe the GIC version
>>> is because unless the host was a gicv2 host, then that command
>>> line wouldn't have worked anyway.
>> Except if the host GICv3 has a GICv2 compat (which is pretty unlikely)?
> 
> Is there a way to probe that? If so, and the setting up of gicv2 on
> a gicv3 host with the gicv2-compat is the same as setting up gicv2,
> then we can just choose gicv2 to keep the command line compatibility.
I think that if the host GICv3 is GICv2 compatible then you can create
both a KVM_DEV_TYPE_ARM_VGIC_V2 device and a KVM_DEV_TYPE_ARM_VGIC_V3
device. Otherwise you can only create a KVM_DEV_TYPE_ARM_VGIC_V3 KVM device.

Thanks

Eric

> 
> Thanks,
> drew
> 
> 


