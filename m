Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98258C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E1020753
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRO63S3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E1020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEcA1-0002dJ-KX
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEc8w-0001Xa-Bu
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEc8v-0004k8-5J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:06:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEc8v-0004jk-1N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584551168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOdligpI8raDYuplF2SsbgL2EbT0ONiMgo3ex+vRpuI=;
 b=YRO63S3em54G1SP5rO9ieinzlEqvnwgIlgUFyLF1187+AQKXbE6sjFwonipdiwdNnBe71q
 bThRtqt+pCjOyPJbA3LdWNShD34XweoYVa0QFYhqxFbXbnQMD85okASItGMutsyjs3Vf/X
 +IWW+iLf57OgmcAJUgbMmvNQASk529w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-vOkmfwbONKGx90Wilf3ADw-1; Wed, 18 Mar 2020 13:06:07 -0400
X-MC-Unique: vOkmfwbONKGx90Wilf3ADw-1
Received: by mail-wm1-f69.google.com with SMTP id n188so1382412wmf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2/QFzJlGahtOzZSKA6+ZWBUStTvAIrwL0p2Ez13DXCs=;
 b=JR1pb3gZqq6HtpsOa+hH3zBiySzttSx9BJ+iurC/PX0vpU582WhAQ+1PQXQ9Ci28iI
 5TLTNdBJVYrl2cXagtJJq8uzKGXPjMEJ/cmyJngQ6tUBZSGmdN5QdsKNQq2CkZUeaFWq
 hdqMuZO3WL4vKtMJU0axb1+qKIBHiewzm/T9ezqjfYeC58e9zEgwPwSSMnIwMmLk0aj1
 dNk2oZbkEDg8wcLRrd0IfXb+Wu5lhz90m6IP9Bdr32Jn/6utnqSbAqvH4DvF9/hrCWE4
 BLZ9Hsg3KfqnMgYz6Hw5yqV5HM/XQz6mYy7gFtxbMmpFxnb151Bv2Ynzgp8iH/qBG6/i
 CTBg==
X-Gm-Message-State: ANhLgQ3W+kbK9w9G56qwrfK3vqNTo3Qw9SlJh5wdDYMn9SYDEBN0IbI3
 dQplAUcmlmGSEWwXoHpHoseMhxqM1LHwLLZy+IqSCIwj+p9dqcx3Be4BL8NQesAW3837xgt0bFj
 7VUu5wBSQ2FOlAzc=
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr6104431wmd.1.1584551163813;
 Wed, 18 Mar 2020 10:06:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtTQVPUynPIQbIsgASk8iPXD/wlM+aX6owsfp8m0EnkOG0r8NtqE62Ifojhx8+NgcEqptDTxg==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr6104407wmd.1.1584551163618;
 Wed, 18 Mar 2020 10:06:03 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id y8sm4394637wrr.16.2020.03.18.10.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 10:06:03 -0700 (PDT)
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
To: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
 <20200317201153.GB233068@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
Date: Wed, 18 Mar 2020 18:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317201153.GB233068@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 9:11 PM, Peter Xu wrote:
> On Tue, Mar 17, 2020 at 03:02:57PM -0500, Eric Blake wrote:
>> On 3/17/20 2:59 PM, Peter Xu wrote:
>>> Sometimes it would be good to be able to read the pin number along
>>> with the IRQ number allocated.  Since we'll dump the IRQ number, no
>>> reason to not dump the pin information.  For example, the vfio-pci
>>> device will overwrite the pin with the hardware pin number.  It would
>>> be nice to know the pin number of one assigned device from QMP/HMP.
>>>
>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> CC: Alex Williamson <alex.williamson@redhat.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> CC: Julia Suvorova <jusual@redhat.com>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>
>>> This helped me to debug an IRQ sharing issue, so may good to have it
>>> in master too.
>>
>> We're right at soft freeze.
>>
>>
>>> +++ b/qapi/misc.json
>>> @@ -403,6 +403,8 @@
>>>    #
>>>    # @irq: if an IRQ is assigned to the device, the IRQ number
>>>    #
>>> +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
>>> +#
>>
>> But if we really do want it in 5.0, this needs a tweak.  Does the delay
>> hurt?
>=20
> No it won't; it's something good to have only.  I'll let the
> maintainers to decide...
>=20
>>
>> Naming convention: We prefer  unless there is a consistency
>> issue....
>>
>>>    # @qdev_id: the device name of the PCI device
>>>    #
>>>    # @pci_bridge: if the device is a PCI bridge, the bridge information
>>> @@ -417,8 +419,8 @@
>>>    { 'struct': 'PciDeviceInfo',
>>>      'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
>>>               'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
>>> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeI=
nfo',
>>> -           'regions': ['PciMemoryRegion']} }
>>> +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
>>> +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegio=
n'] }}
>>
>> and the pre-existing pci_bridge is indeed the consistency issue.
>=20
> Yeh, actually every key in this struct. :)

Using 'irq-pin':
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Thanks,
>=20


