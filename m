Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C7C43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B8E2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8np/Ldf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B8E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNRU-00048w-SK
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKNQm-0003dY-0p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKNQi-0001z1-4E
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600700914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bmhxhc8lZTOt2GzR/XMI8/N6RMybIhhbwBKrSQxAYm0=;
 b=e8np/Ldfulk275ddXzwTQARRRXVDgIu5IENrWWIKDzylnNVawBS/GRkmz0hVEzwWXY2ql1
 HIWaeVJp8YFNyirQApPZG/54GSsRG9fc0060KrtD9QInycX4yPE97CsCOvaSHYS1B1HAg9
 kO/iLMskHx3HMJznqQBEFdoknsry3gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-4d8oFvIaMUeDwb46cMJcbA-1; Mon, 21 Sep 2020 11:08:30 -0400
X-MC-Unique: 4d8oFvIaMUeDwb46cMJcbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F3C425CB;
 Mon, 21 Sep 2020 15:08:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F30C55765;
 Mon, 21 Sep 2020 15:08:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 831011132E9A; Mon, 21 Sep 2020 17:08:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org>
 <874knra5fk.fsf@dusky.pond.sub.org>
 <6384105c-65ca-60f8-4fa0-afd2e46b144a@redhat.com>
 <87pn6f48xx.fsf@dusky.pond.sub.org> <20200921122400.GI3221@work-vm>
 <e88a8f34-ec08-f6b1-05b6-d91c447ee1ed@redhat.com>
Date: Mon, 21 Sep 2020 17:08:27 +0200
In-Reply-To: <e88a8f34-ec08-f6b1-05b6-d91c447ee1ed@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 21 Sep 2020 16:23:17
 +0200")
Message-ID: <87363byxp0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/21/20 2:24 PM, Dr. David Alan Gilbert wrote:
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com> writes:
>>>
>>>> +Paolo & Kevin.
>>>>
>>>> On 9/21/20 10:40 AM, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org> writes:
>>>>>
>>>>>> As it is legal to WRITE/ERASE the address/block 0,
>>>>>> change the value of this definition to an illegal
>>>>>> address: UINT32_MAX.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
>>>>>> ---
>>>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>>
>>>>>> Same problem I had with the pflash device last year...
>>>>>> This break migration :(
>>>>>> What is the best way to do this?
>>>>>
>>>>> Remind me: did we solve the problem with pflash, and if yes, how?
>>>>
>>>> No we can't. The best I could do is add a comment and as this
>>>> is not fixable. See commit aba53a12bd5: ("hw/block/pflash_cfi01:
>>>> Document use of non-CFI compliant command '0x00'").
>>>>
>>>> I now consider the device in maintenance-only
>>>> mode and won't add any new features.
>>>>
>>>> I started working on a new implementation, hoping it can be a
>>>> drop in replacement. Laszlo still has hope that QEMU pflash
>>>> device will support sector locking so firmware developers could
>>>> test upgrading fw in VMs.
>>>>
>>>> Back to the SDcard, it might be less critical, so a migration
>>>> breaking change might be acceptable. I'm only aware of Paolo
>>>> and Kevin using this device for testing. Not sure of its
>>>> importance in production.
>>>
>>> Neither am I.
>>>
>>> Which machine types include this device by default?
>>=20
>> To me it looks like it's some of the ARM boards.
>
> My worry is TYPE_PCI_SDHCI ("sdhci-pci"):
>
>     k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
>     k->device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI;
>     k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>
> config SDHCI_PCI
>     bool
>     default y if PCI_DEVICES

Ah, now I remember.  Not the first time I wished it wouldn't exist...

>>> How can a non-default device be added, and to which machine types?
>>>
>>> I gather the fix changes device state incompatibly.  Always, or only in
>>> certain states?

I think we need to answer this question.

>>>                  I'm asking because if device state remains compatible
>>> most of the time, we might be able use subsection trickery to keep
>>> migration working most of the time.  Has been done before, I think.


