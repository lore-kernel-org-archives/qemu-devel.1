Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BB8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1706B2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxuuXC0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1706B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZiBq-0002HH-7U
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 16:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZiB3-0001jx-Iv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZiAw-0004qd-S0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:15:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZiAw-0004md-Em
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574802908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YyUIZeK4biydVPiptQWVg/88s4LW02PsbnOjjQqTMc=;
 b=TxuuXC0Uefc5+aW4vFYfSiYQZ5ExWScFdEXfqTgJVePvh6j4T/NP88yNER/6SpYe9KmQ0+
 lTL+1+uPoQ8KZe4F0ljlMeJEEOMtSRjve/WixPqsGOKBKRrSD4Kpve8msqT+6NBjq/5Vjy
 NyvX2yO8ZbcWlCNMLFYrDiMFMiba/1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-AVbdrKMDP12cnDRB8UrfYg-1; Tue, 26 Nov 2019 16:15:06 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so7181096wrq.12
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 13:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hpv8iDJUANrjvXKy5ax/leYDPh44QlEsHbAcdEXsb+c=;
 b=tXuyGCOMWl8r9CIGCM/c4aUhPYkqZrIIyeUP+LtTXMRXS2WPsXVr2n/n7a1P1Mjogm
 +5FvzHxCn7Kquk6/TsFWTp6foATV1dELb4P3adAwtZf4rgmWMk80Ks0EI//9Hql5uJoM
 zviCjVuuk4T3FVxyHzQ1lvrwvTgipTDQK66ouP/uVQQ1OXUKfC0wRX+PbYz/K5NHQik9
 0WW28lkXNqTYNv7H0DohqZs0IMWON7rEHjHFrnrJ9IY3Mkp0zpWxcmOBE/Iu+DFc0Txz
 zIcS0rWsiq6ruH2sjYfZpbRKNTTgE+Ocn+Aw6LXFwO+btgQGHu8AI32KM7RV12kmERhF
 UF4A==
X-Gm-Message-State: APjAAAXJyvFn5kaWfsSybnMcgtfUWullr7T+WsKStzdwzuCCgBMV84IA
 xY5AOwn37LQQGA9qqO68vphIqgzEr6irzTiux/6ALY/2On+94NPyk3wV5ullw9l4rzF/gKvyKp6
 ZhQ0eqCTfX/NqjMY=
X-Received: by 2002:adf:f0c4:: with SMTP id x4mr37580329wro.217.1574802905303; 
 Tue, 26 Nov 2019 13:15:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYAvUlasq6lOQBiEbiJUS6CiryEJDhkbYPg9jxP8Mr7tTkVjkn2ttn2C3wu5iVezEgopuldw==
X-Received: by 2002:adf:f0c4:: with SMTP id x4mr37580303wro.217.1574802905007; 
 Tue, 26 Nov 2019 13:15:05 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w4sm4556843wmk.29.2019.11.26.13.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 13:15:04 -0800 (PST)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=h69CVmS6Rpm_CNet836BLSxTPQsXmP1Ur4tVL-0uryOw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <744f91e0-858b-3752-942d-f3d552691fd5@redhat.com>
Date: Tue, 26 Nov 2019 22:15:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h69CVmS6Rpm_CNet836BLSxTPQsXmP1Ur4tVL-0uryOw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: AVbdrKMDP12cnDRB8UrfYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 11/26/19 9:46 PM, Aleksandar Markovic wrote:
> On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>> logical change was in 2005 (9542611a6). After we can count 164
>> maintenance commits (QEMU API changes) with the exception of
>> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>>
>> This machine was introduced as a proof of concept to run a MIPS
>> CPU. 2 years later, the Malta machine was add (commit 5856de80)
>> modeling a real platform.
>>
>> Note also this machine has no specification except 5 lines in
>> the header of this file:
>>
>>   * emulates a simple machine with ISA-like bus.
>>   * ISA IO space mapped to the 0x14000000 (PHYS) and
>>   * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>>   * All peripherial devices are attached to this "bus" with
>>   * the standard PC ISA addresses.
>>
>> It is time to deprecate this obsolete machine. Users are
>> recommended to use the Malta board, which hardware is well
>> documented.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>=20
> Philippe,
>=20
> I see you added "libvir-list" in "cc". Was it a mistake, or there was
> some purpose?

I don't pick the series recipient manually, I send my series with=20
git-publish. Here it used the default QEMU profile.

All profiles call git-sendmail with the cc-cmd set to the=20
get_maintainer.pl script:

$ cat .gitpublish
#
# Common git-publish profiles that can be used to send patches to QEMU=20
upstream.
#
# See https://github.com/stefanha/git-publish for more information
#
[gitpublishprofile "default"]
base =3D master
to =3D qemu-devel@nongnu.org
cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit=20
--nogit-fallback 2>/dev/null

Having a closer look, libvir-list list was Cc'ed because it is listed as=20
reviewer of the qemu-deprecated.texi file, which was modified.

./scripts/get_maintainer.pl -f qemu-deprecated.texi
libvir-list@redhat.com (reviewer:Incompatible changes)
qemu-devel@nongnu.org (open list:All patches CC here)

>>   qemu-deprecated.texi | 5 +++++
>>   hw/mips/mips_r4k.c   | 1 +
>>   MAINTAINERS          | 2 +-
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 4b4b7425ac..05265b43c8 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should =
use 'scsi-hd' or
>>
>>   @section System emulator machines
>>
>> +@subsection mips r4k platform (since 4.2)
>> +
>> +This machine type is very old and unmaintained. Users should use the 'm=
alta'
>> +machine type instead.
>> +
>>   @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>>
>>   These machine types are very old and likely can not be used for live m=
igration
>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>> index 70024235ae..0b79ad26cb 100644
>> --- a/hw/mips/mips_r4k.c
>> +++ b/hw/mips/mips_r4k.c
>> @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>>
>>   static void mips_machine_init(MachineClass *mc)
>>   {
>> +    mc->deprecation_reason =3D "use malta machine type instead";
>>       mc->desc =3D "mips r4k platform";
>>       mc->init =3D mips_r4k_init;
>>       mc->block_default_type =3D IF_IDE;
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5e5e3e52d6..3b3a88e264 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>>   R4000
>>   M: Aurelien Jarno <aurelien@aurel32.net>
>>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> -S: Maintained
>> +S: Obsolete
>>   F: hw/mips/mips_r4k.c
>>
>>   Fulong 2E
>> --
>> 2.21.0
>>
>>
>=20


