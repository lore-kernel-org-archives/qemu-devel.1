Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E9C2D0EF
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E61B2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YM08QKdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E61B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxC7-0003gu-Lu
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIxA3-0001EV-JS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIxA1-0006lg-Cy
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:21:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIxA1-0006lC-98
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+omyROmdHfnkTAOx9RIP7ynC/Ydzm/9FJPPDkBV2TI=;
 b=YM08QKdIAHheI9Vi5FphYb18/EFz9cmDRt2pi6v1CyXLSiXJV8wTzps0brsTh8ALLNimqe
 /FpEG0MSbFXHnTgjGfIhUU43kFodoXdkNDY2WcLKdWoR84UKc5JvChKnyPCfoEd0tjWSdO
 vbFa1ieMRH0CzboTar+ge0ByiNq0HTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-9o22zyl4Om2x33AYi5yq4A-1; Mon, 30 Mar 2020 12:21:03 -0400
X-MC-Unique: 9o22zyl4Om2x33AYi5yq4A-1
Received: by mail-wr1-f71.google.com with SMTP id e10so11641788wrm.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1vwOwwMgEKNaU8XJpTGrUidaroBgwI0S525mFxGv9Hg=;
 b=JWliQocXgTQ5OvH1NjuGL8of/JYyLp7UJ9dPFoQYhVM3/8zJqEEh6llyHUL5O7rCAk
 AP3nKPfjCozLnUy5l4VkHi+9uGcw0ihca/YdujjBdzx0/2/zyJXRsjWfaMShJ0NJqLp0
 ClYTQgPLdvTit0+tANsfE9U29ibd1uGckaorBxx8Gwy5PS1EOJYTEpfMHDZF1UM501Mg
 ZasPCH9/fWsTzrECziynqJU+0dAXjDyWUZKZe8tEDDAmM92BFNE9I70hOuCEkJDjTOLf
 XgduY8QYynfiouMRoSJMziO6oCrhvxqb/8lNA3PsC/j94W43wgQeBw/wdlj38iHfirJW
 m/lw==
X-Gm-Message-State: ANhLgQ16R+UdLRwTuOpe1aw+VZcjROh0+8GMIS8Zd/HmHlsWT0zpZE8W
 tXumpmUkyqWMn/iUt5rQQkc97m9drGujwfCnOEbFm25vdPjUagYebD7NSzh4W7xAPWBz2ac6N3l
 0+TXJdkBbhLg0CUg=
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr48406wmt.171.1585585262551;
 Mon, 30 Mar 2020 09:21:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFkOfz38UtKS23BkuaLdvnukd9qLyQgNKm84fF9dhS6PAm5vbv/Pa5zaLMBVxwGRZAOh/fnQ==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr48384wmt.171.1585585262309;
 Mon, 30 Mar 2020 09:21:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u13sm22953962wru.88.2020.03.30.09.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 09:21:01 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
Date: Mon, 30 Mar 2020 18:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Jon Doron <arilou@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 6:08 PM, Peter Maydell wrote:
> On Mon, 30 Mar 2020 at 16:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>
>> Since commit 3f940dc98, we added support for vAttach packet
>> to select a particular thread/cpu/core. However when using
>> the GDB physical memory mode, it is not clear which CPU
>> address space is used.
>> Since the CPU address space is stored in CPUState::as, use
>> address_space_rw() instead of cpu_physical_memory_rw().
>>
>> Fixes: ab4752ec8d9
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   gdbstub.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 013fb1ac0f..3baaef50e3 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *cp=
u, target_ulong addr,
>>
>>   #ifndef CONFIG_USER_ONLY
>>       if (phy_memory_mode) {
>> -        if (is_write) {
>> -            cpu_physical_memory_write(addr, buf, len);
>> -        } else {
>> -            cpu_physical_memory_read(addr, buf, len);
>> -        }
>> +        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
>> +                         buf, len, is_write);
>>           return 0;
>=20
> There's an argument here for using
>     int asidx =3D cpu_asidx_from_attrs(cpu, MEMTXATTRS_UNSPECIFIED);
>     AddressSpace *as =3D cpu_get_address_space(cpu, asidx);
>=20
> though it will effectively boil down to the same thing in the end
> as there's no way for the gdbstub to specify whether it wanted
> eg the Arm secure or non-secure physical address space.

https://static.docs.arm.com/ihi0074/a/debug_interface_v6_0_architecture_spe=
cification_IHI0074A.pdf

* Configuration of hypervisor noninvasive debug.

This field can have one of the following values:

- 0b00
Separate controls for hypervisor noninvasive debug are not implemented,=20
or no hypervisor is implemented. For ARMv7 PEs that implement the=20
Virtualization Extensions, and for ARMv8 PEs that implement EL2, if=20
separate controls for hypervisor debug visibility are not implemented,=20
the hypervisor debug visibility is indicated by the relevant Non-secure=20
debug visibility fields NSNID and NSID.

OK so for ARM "noninvasive debug is not implemented" and we would use=20
the core secure address space?

Instead of MEMTXATTRS_UNSPECIFIED I should use a crafted MemTxAttrs with=20
.secure =3D 1, .unspecified =3D 1? The idea of this command is to use the=
=20
CPU AS but not the MMU/MPU, maybe it doesn't make sense...


