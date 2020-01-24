Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C0CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43252072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyfOoO+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43252072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzFS-0003G2-Vm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuzEc-0002Z7-4K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuzEa-0005xn-04
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:42:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuzEZ-0005xP-RG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEG/fZoW1Urma7aRFs93gBrQ31zsS1GSoUOUGn89d3U=;
 b=VyfOoO+ZO32i2UthzOj9XQgBibXrIwxoLswGZPaHYKGXK/Xv/d4IJJ73EBm2mhILQTYVOb
 W6VQi8MA4WyaCTfMuU5d2Ld275Wj6+a1U0s5rGE+DJxH17pDXq9Vgo4nXS5X/2CncCzqvf
 ckJHnKMk0XuRKEl1T8R9VxDtkayk4bc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Wtj3MfgpNeuB6L_VhdCKsg-1; Fri, 24 Jan 2020 08:42:49 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so704609wmk.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 05:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4HYxYIO1KLE1cruK3O0fY4eIxCcaMAkNbKK6LL47eDA=;
 b=j8bEqnTwdlYX1NZXe95NkjSTUnFtQ/syIKLmCCbe5+hNxX3gve3sPhE3S8A+hEeOPO
 0r1g8nx1xJEscE2TZ43OkNf5gV77i4la02Vky+PtZrl83OgWsxsF9nUtabSMcgkFxI83
 HAORAGjOeRI1ZYS46Wu3PbWrB8r+iPalhcwOYzFT6eLVaqkxKIGpf2+pricf7mH27itZ
 BYCzuV2vSdLEH6BP1DMRe/5t8FmXsSr1wQVoqrkLTF51zHfnzA8mUSYmISm0YViLwf6c
 9qhdtfdioMyDEe8ZjU5l8JfVeDgJMZOpwjMVxFF14mWk7aznv6/Tn3md6MgzFlOUxejB
 lzPg==
X-Gm-Message-State: APjAAAWpjeWgOASijWGNS6WQO/1PjQAmUi4Ecb9Nyfl3IuWEf4sC+2rE
 3swHKpEtHzW4HUSgjim7mxdPOBzM2gFlrbldVInD93onpko3bOFG82CsgL2HqK4mgm9/9lYitt9
 anDoOgzhsb2y4L3g=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr4488062wro.202.1579873368426; 
 Fri, 24 Jan 2020 05:42:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/x2wKcuKRzV7LYcrcEMASTLjFlq0FZq/TxrwKjrK839+5CoUH+cmBOrrHRY7AOySqBdE02g==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr4488034wro.202.1579873368192; 
 Fri, 24 Jan 2020 05:42:48 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z133sm7032645wmb.7.2020.01.24.05.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 05:42:47 -0800 (PST)
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
To: Kevin Wolf <kwolf@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
 <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
 <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
 <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
 <20200124133919.GD4732@dhcp-200-226.str.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6a7238c-1da2-6447-5eb6-8e0b729f239c@redhat.com>
Date: Fri, 24 Jan 2020 14:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124133919.GD4732@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-MC-Unique: Wtj3MfgpNeuB6L_VhdCKsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 2:39 PM, Kevin Wolf wrote:
> Am 24.01.2020 um 11:48 hat Felipe Franciosi geschrieben:
>>> On Jan 24, 2020, at 10:04 AM, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>> On 1/23/20 11:58 PM, Peter Lieven wrote:
>>>>> Am 23.01.2020 um 22:29 schrieb Felipe Franciosi <felipe@nutanix.com>:
>>>>>> On Jan 23, 2020, at 5:46 PM, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>>>>> On 1/23/20 1:44 PM, Felipe Franciosi wrote:
>>>>>>> When querying an iSCSI server for the provisioning status of blocks=
 (via
>>>>>>> GET LBA STATUS), Qemu only validates that the response descriptor z=
ero's
>>>>>>> LBA matches the one requested. Given the SCSI spec allows servers t=
o
>>>>>>> respond with the status of blocks beyond the end of the LUN, Qemu m=
ay
>>>>>>> have its heap corrupted by clearing/setting too many bits at the en=
d of
>>>>>>> its allocmap for the LUN.
>>>>>>> A malicious guest in control of the iSCSI server could carefully pr=
ogram
>>>>>>> Qemu's heap (by selectively setting the bitmap) and then smash it.
>>>>>>> This limits the number of bits that iscsi_co_block_status() will tr=
y to
>>>>>>> update in the allocmap so it can't overflow the bitmap.
>>>>>>
>>>>>> Please add:
>>>>>>
>>>>>> Fixes: CVE-2020-1711 (title of CVE if possible)
>>>>>
>>>>> I wasn't sure we had one yet. Kevin: can you do the needful in your b=
ranch?
>=20
> I added the CVE number, though I don't have a title.

Thanks.


[...]
>>> The description starts with "A malicious guest in control of the
>>> iSCSI server ..." so asserting (and killing the VM) doesn't seem
>>> correct...
>=20
> assert() isn't an error check, but it means that we deem it impossible
> for the assertion to fail. This would be the case because we fixed (in
> this patch) the only code path that we think could cause the problem.
>=20
> We would only add it to find other buggy code paths that we missed or
> that are added later.
>=20
>> Correct. That's why I would have the proper checks (or "trim"s) closer
>> to where they were issued to fail sooner. What I meant is that if a
>> guest issues any operation that spans past the end of the drive, then
>> the operation stops there and an error is returned accordingly.
>=20
> Guests can't issue operations that span past the end of the drive. They
> would return an error befor the iscsi driver is even called.
>=20
> The only reason why we get such a request here is because of an internal
> call with BDRV_REQUEST_MAX_BYTES. Maybe this should actually be changed
> into MIN(BDRV_REQUEST_MAX_BYTES, bs->total_sectors * BDRV_SECTOR_SIZE),
> and then iscsi_co_block_status() could assert that the request doesn't
> span past the end of the drive.
>=20
>> This means nothing should ever try to touch these bitmaps out of
>> bounds. Nevertheless, and further to that, assert()s can be used
>> closer to where the bitmap is touched to catch programming errors.
>>
>>> I suppose the iSCSI protocol has some error to return for invalid
>>> requests.
>>
>> Which invalid you are referring to? From the initiator or the target?
>> AFAICT the problem is that the SCSI SPEC doesn't limit a target to
>> respond provisioning status past the (current) end of the LUN (either
>> because this was not deemed important to stress, was forgotten, or is
>> intentionally allowed).
>=20
> In any case, we don't get an invalid request here. We are who made the
> request. It's an unexpected response that we got.
>=20
>>> Also shouldn't we report some warning in case of such invalid
>>> request? So the management side can look at the 'malicious iSCSI
>>> server'?
>>
>> I think having the option to do so is a good idea. There are two cases
>> I can think of that you run into a "malicious" storage server:
>> 1) Someone hacked your storage server
>> 2) Your control plane allows your compute to connect to a user
>> provided storage service
>>
>> Thinking as an admin, if I only allow storage servers I provide, then
>> I want to see such warnings. If I let people point the VMM to dodgy
>> servers, then I probably don't want the log spam.
>=20
> For this reason, we generally don't log things for failed I/O requests.
> If we wanted to introduce it, we'd better find a way to do so
> consistently everywhere and not just in a single place with a one-off
> option.

I'm just suggesting to use error_report().


