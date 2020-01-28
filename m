Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81670C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5F72064C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig2tDdxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5F72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ5B-000220-KJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwQ4Q-0001K7-EA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwQ4P-0007St-En
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:34:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwQ4P-0007SX-Bd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580214856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYrr1r5HScc8LjsIpP5plCEtmmtVdUjtmM5ZorajYj4=;
 b=Ig2tDdxJa+I/Utn5vXAFJWRtw+t7coZKleTGKVPSmWEPbBUntJi5ABWAFAiBPUUX2HTMAV
 C57NfuW4Ip3OJfe2GvjHQBo5jeA66hnt7um5XrDPhKOFViCyKU+/VKvjQ8zZv9mE4kgym5
 RjUW1Lb6zes6m527qmzUMCs3/8npKTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-f3jAmo7PMRKPlP2m-0SE3A-1; Tue, 28 Jan 2020 07:34:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5310E800D48;
 Tue, 28 Jan 2020 12:34:12 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A6286E0E;
 Tue, 28 Jan 2020 12:34:09 +0000 (UTC)
Subject: Re: [question] hw/arm/virt: about the default gic-version in
 accelerated mode
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
 <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
 <20200128122915.ehzgj5kpmsw5azap@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e0b73504-b37a-cc57-3c3f-b9872dd1e16c@redhat.com>
Date: Tue, 28 Jan 2020 13:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200128122915.ehzgj5kpmsw5azap@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: f3jAmo7PMRKPlP2m-0SE3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu list <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 1/28/20 1:29 PM, Andrew Jones wrote:
> On Tue, Jan 28, 2020 at 10:52:50AM +0000, Peter Maydell wrote:
>> On Tue, 28 Jan 2020 at 10:47, Auger Eric <eric.auger@redhat.com> wrote:
>>> When arm virt machine is run in accelerated mode with "-cpu host
>>> -machine virt", the default gic version is 2.
>>>
>>> I understand the rationale with TCG where we don't have MSI ITS
>>> emulation along with GICv3 so we need to choose GICv2 to get GICv2M
>>> functionality.
>>>
>>> However in KVM mode, I would have expected to see the host GIC probed to
>>> set the same version on guest. Indeed most of our HW now have GICv3
>>> without GICv2 compat mode so our default values lead to weird traces:
>>>
>>> "
>>> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
>>> qemu-system-aarch64: failed to set irq for PMU
>>> "
>>>
>>> I would like to propose a patch to improve those errors and also suggest
>>> a hint. But I also wanted to know whether you would accept to change the
>>> default value with KVM and choose the host version instead of 2. For TCG
>>> we would keep v2.
>>
>> As with the -cpu option, the default is there for command
>> line backward compatibility primarily. Even if we had
>> better support for MSI ITS emulation we'd still leave
>> the default at GICv2.
>>
>> If you want "do the best you can, regardless of accelerator"
>> that is "-cpu max -machine gic-version=max".
>>
> 
> There is a case where we can probe without breaking backward
> compatibility. That case is kvm-enabled and no gic-version
> specified. The reason it would be safe to probe the GIC version
> is because unless the host was a gicv2 host, then that command
> line wouldn't have worked anyway.
Except if the host GICv3 has a GICv2 compat (which is pretty unlikely)?

Eric

 And, if it is a gicv2 host,
> then the probing will come to the same conclusion as the
> default and nothing will have changed.
> 
> Thanks,
> drew
> 
> 


