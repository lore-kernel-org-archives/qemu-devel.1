Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E0C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04F620838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1aC4AyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04F620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04gx-0006cd-VM
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j04fX-0005Fx-Mo
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j04fW-0000kG-CB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:31:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j04fV-0000j6-Qy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vz8wbWCWXlY0gWuW3MgVcaPaCa09d8KKsH0OzL8y8a4=;
 b=f1aC4AySAoj4xQzprWg8cmt7jlGIUqeSYT2rI3md57szsc6mxGF+nuBljLnaG3t2A1eGV5
 bdC9KBxG+8NxcLOkUxgbI+Ejo2lJgEqCNgVR7GSi2G0OgFoMPEBK8dwuenycPGsq979Hck
 8YKL98BmXq/lSZmepApDik2vZexRyiw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-k40kn0VKORqjrek63en4vQ-1; Fri, 07 Feb 2020 09:31:38 -0500
Received: by mail-wr1-f71.google.com with SMTP id l1so1341040wrt.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtkHZr81rvmtBj1Cpat22KAdsuT5jWjVLYgghqx79fI=;
 b=mLaAidbhbdIy1eBOT8udFK0TX0F3yllksyrl59oaucldzVnvgXuPOrqiWVfSuvxPN5
 lXwYOYYPke+B6uTvTNaT3qh2FkkvnGmdGdUYY/PufCYo1AGkVWkLkYGk5cut4ZdX36Rq
 nof83RCk2IePdcZh1nXqQkurEF+E4G8LGSHX9YzI0Yq7oDQp2CbYtdkWNiHZG+xEmAgM
 lXn6fPhei8SYlcMUuB/DNeYIyXWmLefQs9jgIt7j1bfJ7lEicMNf/LJkWakv4dIAnxMY
 q463gz8rbzn4wtgLY5qIHosz6K01hR6SSsJI2/XoMnb4QBMO5sdyh7lDCDF3RtGfo4lz
 zLsg==
X-Gm-Message-State: APjAAAUujbSdv5I3PTV5cZGoXBA0d2AAssYrpBwwEhTOQJeG6W4jSefT
 cPUYOpKd+FAkCpa8CKpIZDDLcL5IihsG52mRg7T/y9HhOMlhGluK0GiIOk0iVypxu8+RNYtGSLH
 eqz7qQb3am6LtYjQ=
X-Received: by 2002:adf:b351:: with SMTP id k17mr4947928wrd.199.1581085896768; 
 Fri, 07 Feb 2020 06:31:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLhT2wOX9AtHoZd6PuG4htpgedY1dLbQ449keb8ioxL5X/z6hNF4a8m1NNSpNqgOK0GIzq+w==
X-Received: by 2002:adf:b351:: with SMTP id k17mr4947890wrd.199.1581085896575; 
 Fri, 07 Feb 2020 06:31:36 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n1sm3531640wrw.52.2020.02.07.06.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:31:35 -0800 (PST)
Subject: Re: [PATCH v3 2/3] hw: Make MachineClass::is_default a boolean type
To: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200207130453.16666-1-philmd@redhat.com>
 <20200207130453.16666-3-philmd@redhat.com>
 <20200207091138-mutt-send-email-mst@kernel.org>
 <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60c21c90-8b29-64aa-15bd-4ba94972f344@redhat.com>
Date: Fri, 7 Feb 2020 15:31:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
Content-Language: en-US
X-MC-Unique: k40kn0VKORqjrek63en4vQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 3:22 PM, Laurent Vivier wrote:
> Le 07/02/2020 =C3=A0 15:11, Michael S. Tsirkin a =C3=A9crit=C2=A0:
>> On Fri, Feb 07, 2020 at 02:04:52PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> There's no good reason for it to be type int, change it to bool.
>>>
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>>> ---
>>> v3: new patch
>>> ---
>>>   include/hw/boards.h                      |  2 +-
>>>   hw/alpha/dp264.c                         |  2 +-
>>>   hw/cris/axis_dev88.c                     |  2 +-
>>>   hw/hppa/machine.c                        |  2 +-
>>>   hw/i386/pc_piix.c                        | 10 +++++-----
>>>   hw/lm32/lm32_boards.c                    |  2 +-
>>>   hw/m68k/mcf5208.c                        |  2 +-
>>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
>>>   hw/mips/mips_malta.c                     |  2 +-
>>>   hw/moxie/moxiesim.c                      |  2 +-
>>>   hw/nios2/10m50_devboard.c                |  2 +-
>>>   hw/openrisc/openrisc_sim.c               |  2 +-
>>>   hw/ppc/mac_oldworld.c                    |  2 +-
>>>   hw/ppc/spapr.c                           |  2 +-
>>>   hw/riscv/spike.c                         |  2 +-
>>>   hw/s390x/s390-virtio-ccw.c               |  2 +-
>>>   hw/sh4/shix.c                            |  2 +-
>>>   hw/sparc/sun4m.c                         |  2 +-
>>>   hw/sparc64/niagara.c                     |  2 +-
>>>   hw/sparc64/sun4u.c                       |  4 ++--
>>>   hw/unicore32/puv3.c                      |  2 +-
>>>   21 files changed, 26 insertions(+), 26 deletions(-)
>>>
> ...
>>> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
>>> index 5eb2d097b9..81a1748fad 100644
>>> --- a/hw/sparc64/niagara.c
>>> +++ b/hw/sparc64/niagara.c
>>> @@ -170,7 +170,7 @@ static void niagara_class_init(ObjectClass *oc, voi=
d *data)
>>>  =20
>>>       mc->desc =3D "Sun4v platform, Niagara";
>>>       mc->init =3D niagara_init;
>>> -    mc->max_cpus =3D 1; /* XXX for now */
>>> +    mc->max_cpus =3D true; /* XXX for now */
>=20
> what happened here ^^^
>=20
>>>       mc->default_boot_order =3D "c";
>>>       mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1")=
;
>>>   }
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index b7ac42f7a5..3c2c9d2eb0 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void =
*data)
>>>       mc->init =3D sun4u_init;
>>>       mc->block_default_type =3D IF_IDE;
>>>       mc->max_cpus =3D 1; /* XXX for now */
>>> -    mc->is_default =3D 1;
>>> +    mc->is_default =3D true;
>>>       mc->default_boot_order =3D "c";
>>>       mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi")=
;
>>>       mc->ignore_boot_device_suffixes =3D true;
>>> @@ -841,7 +841,7 @@ static void sun4v_class_init(ObjectClass *oc, void =
*data)
>>>       mc->desc =3D "Sun4v platform";
>>>       mc->init =3D sun4v_init;
>>>       mc->block_default_type =3D IF_IDE;
>>> -    mc->max_cpus =3D 1; /* XXX for now */
>>> +    mc->max_cpus =3D true; /* XXX for now */
>=20
> and here ^^

lol too few cases so I was lazy to use a sed regex... v4 coming soon.


