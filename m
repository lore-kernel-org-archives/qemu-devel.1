Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D276FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA6D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+Dz2+rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA6D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkIf-0001GE-AW
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDkCh-0000CU-Of
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDkCf-0007GG-R4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:30:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDkCf-00076k-Lf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584343825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H34ZU0m/JKEVVY37wiPpcv2n5SL6jbwHHubuCc4wqdU=;
 b=H+Dz2+rOCgqK1twYeMf/VVWf329kkUDrKyMAkkZ7wvlhcYMWI1qO3XfCADoQdevjf1N86n
 NKADZIjW4ilBtfxX1YiBtwaHDe2sCAkT+XTXNq9VPyLEEuCJVImjFr5aiI2RIBNJu+5OCa
 N9ckejRv42lfKjEla5kmhZ7zVCJ9LtM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-hUCbl-BUOwCxB4T-2-2ltA-1; Mon, 16 Mar 2020 03:30:22 -0400
X-MC-Unique: hUCbl-BUOwCxB4T-2-2ltA-1
Received: by mail-ed1-f69.google.com with SMTP id y23so14340170edt.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 00:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YYE4E5PXSbZFwrpnc4E4ZSnUSV/dPv9YcV2lt3qkmNs=;
 b=T9NsWjTNTWDzAumLygbWmC8asA+UDVQVd3y36mNMEU5Nn/l0O/Yui6oZPjBzY40S8R
 dK+zQt8d5Tgjk15kz9w0dad4OrwvdWNyY+dYJXehWUlQ1uFcEslGVtXBXQmjgNe2ar8q
 sEQYusYbMFiP6+i5tcptsp6nNQ1Xx6P2OekD+vfy09BrDxYFA3nUId+f1YAxFjJXwKhb
 v5kdz9b/8kL+rg4fgUXcOADMX0VDuT67rnpWuQ9iCVQ4exXka9DvcmYLYGbbMaZhyfS7
 7L/xWrjhEMSVY6RE5AlENpQAM5x6GKDfy8wLvA0q06tIidBz1mXTLSvP5TTBJwJT5t6N
 gskQ==
X-Gm-Message-State: ANhLgQ1SRPIVkE8unUgMB9tqKt4+0xb1sSDN4/n9NaZLoHOe8VmWcZOX
 ndy7IAaEAHkNEwSH2KaNKOJ+vTFO7tss1/MdawGTSOxpj6qzw7FeztYbZcb6WbtmnvS2Zu3mn47
 vfztm2nF+yUEwhAc=
X-Received: by 2002:a50:ab42:: with SMTP id t2mr25842906edc.333.1584343820560; 
 Mon, 16 Mar 2020 00:30:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLWN0XW2uTgmi/4AdA639VaVakPMlf0n8xufeFNhJSLEcSQeNh2sbzBApkwfQMzIhU0RTXyA==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr25842860edc.333.1584343820158; 
 Mon, 16 Mar 2020 00:30:20 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id rl28sm1082700ejb.28.2020.03.16.00.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 00:30:19 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] target/i386: Restrict X86CPUFeatureWord to X86
 targets
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-2-philmd@redhat.com>
 <CAL1e-=gWOZzFKd9OdkTRJj19NX56BcpQBz6r9RY3orsrgf9mMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d23de36-6b47-9120-f8cb-a6b122a9ed63@redhat.com>
Date: Mon, 16 Mar 2020 08:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gWOZzFKd9OdkTRJj19NX56BcpQBz6r9RY3orsrgf9mMg@mail.gmail.com>
Content-Language: en-US
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 1:29 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Move out x86-specific structures from generic machine code.
>=20
>=20
> Philippe,
>=20
> I a kind of have hard time understanding what is achieved with this=20
> patch. Is this pure code moving/reorganization? What is the logical=20
> connection between this patch and the whole series (that is about=20
> removing unneeded building for user mode)? How does this patch affect=20
> build time for user mode?

This code ends up in all linux-user binaries:

$ make clean mipsel-linux-user/all
$ fgrep -r X86CPURegister32
Binary file qapi/qapi-visit-machine.o matches
qapi/qapi-visit-machine.h:void visit_type_X86CPURegister32(Visitor *v,=20
const char *name, X86CPURegister32 *obj, Error **errp);
qapi/qapi-types-machine.c:const QEnumLookup X86CPURegister32_lookup =3D {
qapi/qapi-types-machine.h:typedef enum X86CPURegister32 {
qapi/qapi-types-machine.h:} X86CPURegister32;
qapi/qapi-types-machine.h:#define X86CPURegister32_str(val) \
qapi/qapi-types-machine.h:    qapi_enum_lookup(&X86CPURegister32_lookup,=20
(val))
qapi/qapi-types-machine.h:extern const QEnumLookup X86CPURegister32_lookup;
qapi/qapi-types-machine.h:    X86CPURegister32 cpuid_register;
Binary file qapi/qapi-events-machine.o matches
Binary file qapi/qapi-types-machine.o matches
qapi/qapi-doc.texi:@deftp {Enum} X86CPURegister32
qapi/qapi-doc.texi:@item @code{cpuid-register: X86CPURegister32}
qapi/qapi-visit-machine.c:void visit_type_X86CPURegister32(Visitor *v,=20
const char *name, X86CPURegister32 *obj, Error **errp)
qapi/qapi-visit-machine.c:    visit_type_enum(v, name, &value,=20
&X86CPURegister32_lookup, errp);
qapi/qapi-visit-machine.c:    visit_type_X86CPURegister32(v,=20
"cpuid-register", &obj->cpuid_register, &err);
Binary file hw/core/qdev.o matches
Binary file hw/core/cpu.o matches
Binary file libqemuutil.a matches
Binary file mipsel-linux-user/qemu-mipsel matches
             \-----------------------------------/

By restricting this structure on the x86 architecture, this is less time=20
compiling unused code on others archs, and resulting binary is smaller too.

>=20
> Sincerely,
> Aleksandar
>=20
>=20
>     Acked-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0qapi/machine-target.json=C2=A0 =C2=A0| 45 ++++++++++++++++++++=
++++++++++++++++++
>      =C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 42 -----=
------------------------------
>      =C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 =
+-
>      =C2=A0target/i386/machine-stub.c | 22 +++++++++++++++++++
>      =C2=A0target/i386/Makefile.objs=C2=A0 |=C2=A0 3 ++-
>      =C2=A05 files changed, 70 insertions(+), 44 deletions(-)
>      =C2=A0create mode 100644 target/i386/machine-stub.c
>=20
>     diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>     index f2c82949d8..fb7a4b7850 100644
>     --- a/qapi/machine-target.json
>     +++ b/qapi/machine-target.json
>     @@ -3,6 +3,51 @@
>      =C2=A0# This work is licensed under the terms of the GNU GPL, versio=
n 2
>     or later.
>      =C2=A0# See the COPYING file in the top-level directory.
>=20
>     +##
>     +# @X86CPURegister32:
>     +#
>     +# A X86 32-bit register
>     +#
>     +# Since: 1.5
>     +##
>     +{ 'enum': 'X86CPURegister32',
>     +=C2=A0 'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'E=
DI' ],
>     +=C2=A0 'if': 'defined(TARGET_I386)' }
>     +
>     +##
>     +# @X86CPUFeatureWordInfo:
>     +#
>     +# Information about a X86 CPU feature word
>     +#
>     +# @cpuid-input-eax: Input EAX value for CPUID instruction for that
>     feature word
>     +#
>     +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>     +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0feature word
>     +#
>     +# @cpuid-register: Output register containing the feature bits
>     +#
>     +# @features: value of output register, containing the feature bits
>     +#
>     +# Since: 1.5
>     +##
>     +{ 'struct': 'X86CPUFeatureWordInfo',
>     +=C2=A0 'data': { 'cpuid-input-eax': 'int',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '*cpuid-input-ecx': 'int',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'cpuid-register': 'X86CPUR=
egister32',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'features': 'int' },
>     +=C2=A0 'if': 'defined(TARGET_I386)' }
>     +
>     +##
>     +# @DummyForceArrays:
>     +#
>     +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
>     internally
>     +#
>     +# Since: 2.5
>     +##
>     +{ 'struct': 'DummyForceArrays',
>     +=C2=A0 'data': { 'unused': ['X86CPUFeatureWordInfo'] },
>     +=C2=A0 'if': 'defined(TARGET_I386)' }
>     +
>      =C2=A0##
>      =C2=A0# @CpuModelInfo:
>      =C2=A0#
>     diff --git a/qapi/machine.json b/qapi/machine.json
>     index 6c11e3cf3a..de05730704 100644
>     --- a/qapi/machine.json
>     +++ b/qapi/machine.json
>     @@ -505,48 +505,6 @@
>      =C2=A0 =C2=A0 'dst': 'uint16',
>      =C2=A0 =C2=A0 'val': 'uint8' }}
>=20
>     -##
>     -# @X86CPURegister32:
>     -#
>     -# A X86 32-bit register
>     -#
>     -# Since: 1.5
>     -##
>     -{ 'enum': 'X86CPURegister32',
>     -=C2=A0 'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'E=
DI' ] }
>     -
>     -##
>     -# @X86CPUFeatureWordInfo:
>     -#
>     -# Information about a X86 CPU feature word
>     -#
>     -# @cpuid-input-eax: Input EAX value for CPUID instruction for that
>     feature word
>     -#
>     -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>     -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0feature word
>     -#
>     -# @cpuid-register: Output register containing the feature bits
>     -#
>     -# @features: value of output register, containing the feature bits
>     -#
>     -# Since: 1.5
>     -##
>     -{ 'struct': 'X86CPUFeatureWordInfo',
>     -=C2=A0 'data': { 'cpuid-input-eax': 'int',
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '*cpuid-input-ecx': 'int',
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'cpuid-register': 'X86CPUR=
egister32',
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'features': 'int' } }
>     -
>     -##
>     -# @DummyForceArrays:
>     -#
>     -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
>     internally
>     -#
>     -# Since: 2.5
>     -##
>     -{ 'struct': 'DummyForceArrays',
>     -=C2=A0 'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
>     -
>      =C2=A0##
>      =C2=A0# @NumaCpuOptions:
>      =C2=A0#
>     diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>     index a84553e50c..0753fe4935 100644
>     --- a/target/i386/cpu.c
>     +++ b/target/i386/cpu.c
>     @@ -37,7 +37,7 @@
>      =C2=A0#include "qemu/option.h"
>      =C2=A0#include "qemu/config-file.h"
>      =C2=A0#include "qapi/error.h"
>     -#include "qapi/qapi-visit-machine.h"
>     +#include "qapi/qapi-visit-machine-target.h"
>      =C2=A0#include "qapi/qapi-visit-run-state.h"
>      =C2=A0#include "qapi/qmp/qdict.h"
>      =C2=A0#include "qapi/qmp/qerror.h"
>     diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
>     new file mode 100644
>     index 0000000000..cb301af057
>     --- /dev/null
>     +++ b/target/i386/machine-stub.c
>     @@ -0,0 +1,22 @@
>     +/*
>     + * QAPI x86 CPU features stub
>     + *
>     + * Copyright (c) 2020 Red Hat, Inc.
>     + *
>     + * Author:
>     + *=C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     + *
>     + * This work is licensed under the terms of the GNU GPL, version 2
>     or later.
>     + * See the COPYING file in the top-level directory.
>     + * SPDX-License-Identifier: GPL-2.0-or-later
>     + */
>     +
>     +#include "qemu/osdep.h"
>     +#include "qapi/error.h"
>     +#include "qapi/qapi-visit-machine-target.h"
>     +
>     +void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *na=
me,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X86CPUFe=
atureWordInfoList **obj,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp)
>     +{
>     +}
>     diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
>     index 48e0c28434..1cdfc9f50c 100644
>     --- a/target/i386/Makefile.objs
>     +++ b/target/i386/Makefile.objs
>     @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posi=
x.o
>      =C2=A0endif
>      =C2=A0obj-$(CONFIG_HVF) +=3D hvf/
>      =C2=A0obj-$(CONFIG_WHPX) +=3D whpx-all.o
>     -endif
>     +endif # CONFIG_SOFTMMU
>      =C2=A0obj-$(CONFIG_SEV) +=3D sev.o
>      =C2=A0obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
>     +obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o
>     --=20
>     2.21.1
>=20
>=20


