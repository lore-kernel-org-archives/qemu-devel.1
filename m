Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67CC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE32207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyWQD+35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE32207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEg2-0006Ce-W1
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJEfA-0005Ms-KY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJEf9-0007v3-1M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:02:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJEf8-0007uQ-Tk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585652550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbbkOsu+exFvpifRc2J1095cEQVkKZ9j2m0lC44C0Gg=;
 b=RyWQD+35DkIXydyh60bvmv8Y6PR9oo5VOA1sVV+N5pFJYV6RMfi7boJ9LCTbnvVhF0OZ+K
 UtwuuatL4+oS78P8/dqhqUNCH1ij03G9zAwwxhSDbEsO9Ykoh6WqfHycSrrX7rN5zQmlFo
 ZeSmrEYXphWL95WTxfLOpu3V6LOwnyw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-II3X3Lk9OYaDqtcG4itnUQ-1; Tue, 31 Mar 2020 07:02:23 -0400
X-MC-Unique: II3X3Lk9OYaDqtcG4itnUQ-1
Received: by mail-ed1-f71.google.com with SMTP id ce13so18225314edb.11
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fWjKK+0LtiAvuo5McjzUcvq5EVsIm+tvRnBrw6Rt+Qc=;
 b=sfcQKQIqYCQMshkXyQBHyIhh5CtZUK0tV5uBsZazQuhGlhjb3VSXGQd4sjMCw01O+G
 lnrTv7kPqsr85Qc0luxkqTuORyKPsAzjFRAhwZu5hjSL8Ddb5XXjx41o9RGNPVVpnH7p
 etV8gzKloKBp617KSltFiXN1xY4il4yUInBFZ4HlkKGR7WzpxQwsyy6TaZtAOpdf8Bri
 FwdAs3MXpX+BDkAfd1myoDWV8BlK0u2rz8/Dj/mij/QXz0yddCfE+s+MPmEx9249fB3g
 0Q6jHlThAA4BHNY2QSi41oWEgrpPUC9cVUrwl5mFz15asSbdRndgYODxbUAqDD9p2qcl
 qeBg==
X-Gm-Message-State: ANhLgQ22ExPXHpG40IwuvHMhlbSL/k42PTqgsMfioVYcFrxXyqOqTr7a
 e42o3FRDexc8Gb1AmxXfjL3Ry5CnEP+0tC0Vl/HsAmsZPeqkdPVJJQX1fGjhYlerws9KOT42V+t
 cAYoLB8CEX3vC2Rg=
X-Received: by 2002:a50:9e45:: with SMTP id z63mr15414070ede.338.1585652542682; 
 Tue, 31 Mar 2020 04:02:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsoC1mmgGxIf3L573dTRo7B7Fm2Jlv0NZGID5sOXNDrCDFiOi45m4oCxuGDeCgqzYgoM712cg==
X-Received: by 2002:a50:9e45:: with SMTP id z63mr15414034ede.338.1585652542416; 
 Tue, 31 Mar 2020 04:02:22 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id rp7sm2089079ejb.83.2020.03.31.04.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 04:02:21 -0700 (PDT)
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
To: Cameron Esfahani <dirty@apple.com>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad609899-d544-f660-6784-5fe5cdc2bf21@redhat.com>
Date: Tue, 31 Mar 2020 13:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Robert Mustacchi <rm@fingolfin.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 11:57 AM, Cameron Esfahani wrote:
> Philippe -
>  From what I've seen, access size has nothing to do with alignment.

Yes, I was wondering if you were using unaligned accesses.

I *think* the correct fix is in the "memory: Support unaligned accesses=20
on aligned-only models" patch from Andrew Jeffery:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html

>=20
> What the code in access_with_adjusted_size() will do is make sure that "s=
ize" is >=3D min_access_size and <=3D max_access_size.
>=20
> So reading 2-bytes from address 2 turns into reading 4-bytes from address=
 2: xhci_cap_read() is called with reg 2, size 4.
>=20
> But, due to the fact our change to support reg 2 only returns back 2-byte=
s, and how the loops work in access_with_adjusted_size(), we only call xhci=
_cap_read() once.
>=20
> It seems like we should also change impl.min_access_size for xhci_cap_ops=
 to be 2.
>=20
> But, after that, to support people doing strange things like reading trad=
itionally 4-byte values as 2 2-byte values, we probably need to change xhci=
_cap_read() to handle every memory range in steps of 2-bytes.
>=20
> But I'll defer to Gerd on this...
>=20
> Cameron Esfahani
> dirty@apple.com
>=20
> "Americans are very skilled at creating a custom meaning from something t=
hat's mass-produced."
>=20
> Ann Powers
>=20
>=20
>> On Mar 31, 2020, at 12:52 AM, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> On 3/30/20 11:44 PM, Cameron Esfahani via wrote:
>>> macOS will read HCIVERSION separate from CAPLENGTH.  Add a distinct
>>> handler for that register.
>>
>> Apparently a fix for https://bugs.launchpad.net/qemu/+bug/1693050.
>>
>>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>>> ---
>>>   hw/usb/hcd-xhci.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>> index b330e36fe6..061f8438de 100644
>>> --- a/hw/usb/hcd-xhci.c
>>> +++ b/hw/usb/hcd-xhci.c
>>> @@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr r=
eg, unsigned size)
>>>       case 0x00: /* HCIVERSION, CAPLENGTH */
>>>           ret =3D 0x01000000 | LEN_CAP;
>>>           break;
>>> +    case 0x02: /* HCIVERSION */
>>> +        ret =3D 0x0100;
>>> +        break;
>>
>> But we have:
>>
>> static const MemoryRegionOps xhci_cap_ops =3D {
>>     .read =3D xhci_cap_read,
>>     .write =3D xhci_cap_write,
>>     .valid.min_access_size =3D 1,
>>     .valid.max_access_size =3D 4,
>>     .impl.min_access_size =3D 4,
>>     .impl.max_access_size =3D 4,
>>     .endianness =3D DEVICE_LITTLE_ENDIAN,
>> };
>>
>> IIUC ".impl.min_access_size =3D 4" means the case 'reg =3D=3D 2' can not=
 happen. It seems we have a bug in memory.c elsewhere.
>>
>> How can we reproduce?
>>
>> If not easy, can you share the backtrace of:
>>
>> -- >8 --
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index b330e36fe6..d021129f3f 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -2735,6 +2735,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr re=
g, unsigned size)
>>      XHCIState *xhci =3D ptr;
>>      uint32_t ret;
>>
>> +    assert(reg !=3D 2);
>>      switch (reg) {
>>      case 0x00: /* HCIVERSION, CAPLENGTH */
>>          ret =3D 0x01000000 | LEN_CAP;
>> ---
>>
>>>       case 0x04: /* HCSPARAMS 1 */
>>>           ret =3D ((xhci->numports_2+xhci->numports_3)<<24)
>>>               | (xhci->numintrs<<8) | xhci->numslots;
>=20


