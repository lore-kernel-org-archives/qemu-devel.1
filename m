Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE04C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372E320733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbz3un5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372E320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1609-0002bM-7C
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j15zW-0001YY-8r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j15zV-0003e9-7v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:08:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j15zV-0003do-52
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581329312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEwOIU5Knq6SawMhFxJo/HE+63XcAfDlm1ZnWDPhA4s=;
 b=Kbz3un5a38p0KWcNCeW1Su4RJ+bm93tzEa84Lik1GWQBT9PJAvrtS4hw8A8Npy5deI+559
 NzyAO7Yy/YEHiT/VNG3yydJiKGOjnYIMh62NKXdYqlNOkK591fdhB/aZmy96efG8gokifD
 psu0/9tKvJfusaXj6bewbcbYY3a9tJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-OuCktb6iOweb4CGr8N2QFQ-1; Mon, 10 Feb 2020 05:08:28 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so4743760wrp.8
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 02:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Ul9+bFbs4YFu9JtS6vW944J+gWMQesivcq7ADHTFdg=;
 b=tdpaYZph7ppbs1fTTsQxWauniPeo0zzK/hia1CArhpYgDD68Ev6sela2tRCvokZ/VX
 OmYfkChrejVxL7v9IkrG8X+QlC8H5V8nztliJYQ2Nsx1lz8mcH8mQ3rtlgdsXVqbkojh
 gvFMKg3mvBDfJ8LlUgQmH70fSPJ3aXn1GCWDKNQPM8sWZmf5X0hLaPddM6IokAhG+sez
 5HFcdK3X9mwHRj6T8V9aBRS3lzNbyJ7GWwClE3ytvdaOSgGpzc5pjKlV7anGws2hmj1R
 UKXd0RT6BEvp7dw/jVgwcDx2g4rX4h4b3N5UdyiTjHfvZcn1+OzyZ64iXytwxnKjmwjy
 VPQw==
X-Gm-Message-State: APjAAAVT8WxMizpHA2mM7cDizB7yNotG03SU7BRGu8+pATYeSUaBGqhm
 CiLguiAHkuQQR8RjRhqgLk7DPPAJiucXOLgWP5M2JlOworcNXHgRJSt+0y480Z/vkH0dYWXtYVD
 l63nSRXHdwPyFwIA=
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr14580603wmc.15.1581329307714; 
 Mon, 10 Feb 2020 02:08:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzemucSh+LJEgGRApO0q2hZLXGUqIUUyrnPIjVxUOYQ08fnpizbAEBzS/n1i6tuXyyYaVE/+Q==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr14580564wmc.15.1581329307495; 
 Mon, 10 Feb 2020 02:08:27 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y139sm15275033wmd.24.2020.02.10.02.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 02:08:26 -0800 (PST)
Subject: Re: Tricore default machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
 <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
Date: Mon, 10 Feb 2020 11:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
Content-Language: en-US
X-MC-Unique: OuCktb6iOweb4CGr8N2QFQ-1
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 10:35 AM, Thomas Huth wrote:
> On 07/02/2020 17.19, Philippe Mathieu-Daud=C3=A9 wrote:
>> The MachineClass is already zeroed on creation.
>>
>> Note: The code setting is_default=3D0 in hw/i386/pc_piix.c is
>>        different (related to compat options). When adding a
>>        new versioned machine, we want it to be the new default,
>>        so we have to mark the previous one as not default.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v3: new patch
>> ---
>>   hw/lm32/lm32_boards.c               | 1 -
>>   hw/lm32/milkymist.c                 | 1 -
>>   hw/m68k/q800.c                      | 1 -
>>   hw/microblaze/petalogix_ml605_mmu.c | 1 -
>>   hw/tricore/tricore_testboard.c      | 1 -
>>   5 files changed, 5 deletions(-)
> [...]
>> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboa=
rd.c
>> index 20c9ccb3ce..8ec2b5bddd 100644
>> --- a/hw/tricore/tricore_testboard.c
>> +++ b/hw/tricore/tricore_testboard.c
>> @@ -105,7 +105,6 @@ static void ttb_machine_init(MachineClass *mc)
>>   {
>>       mc->desc =3D "a minimal TriCore board";
>>       mc->init =3D tricoreboard_init;
>> -    mc->is_default =3D 0;
>>       mc->default_cpu_type =3D TRICORE_CPU_TYPE_NAME("tc1796");
>>   }
>=20
> I wonder whether we should simply make that machine the default for
> qemu-system-tricore? There is only one machine here, and not having a
> default machine always causes some headaches in the tests...
> (see e.g. tests/qemu-iotests/check for example)

Or make it generic? If a architecture has a single machine, use it by=20
default?


