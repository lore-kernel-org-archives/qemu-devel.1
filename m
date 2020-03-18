Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A07C5ACD8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8282D2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V95l38KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEU2k-00076Z-LI
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEU1L-0005sY-Bf
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEU1J-0002fB-Uv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEU1J-0002c2-Qh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584519945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psyg4c2Nyi6VqoNk+L9os4oEemW/tiUi6p3RNxRD324=;
 b=V95l38KFYnhSy1gXemvCrANMJ1zVM8lWFj+/OSOtfkJcWs1u8zxA+MG49+pVXDYZsbXTfj
 z8YKEMGZqh+Nvc83xqRHZHJ1dgJ59Z80sxayX1RpJbm+edaCqfxT4RPQXJe+WdK7ljXKYu
 xNyDVrcuVBx3pD7rvjXp3u624W6FFxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-BQLhOjlBPPW1d7qNlg6GsQ-1; Wed, 18 Mar 2020 04:25:42 -0400
X-MC-Unique: BQLhOjlBPPW1d7qNlg6GsQ-1
Received: by mail-wm1-f70.google.com with SMTP id i24so734065wml.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G6eeks7kjVBZkGRfhANObNK/Wz9WipzHmvuP8lv1644=;
 b=ijSlDSgfu8itfgA+NykBwY/qOyah8sGAg123fkt++wKmXOkpnBc+AyvF5qeFibLxlh
 gQODDzNkJa7A2uWX4QrpNOZxfke2tRDl10ydcbixApkYDihcvQvCutmWHC9ER5gLkqIO
 tLyrGREP/RVYjtyVr9XiCB7Bu1DmCT56I3ipbD4GiRFQTgiH+U9N9YTwyx9aXZFOIoAA
 TLawqFmVtpoGnf1RYel1c6B+rbnd4PhDX2EZJn7Zh3dtwDTxgDVw/0WT4FI7D8lKR65e
 yTP0oyyRL/yJ7EcdnzOfF1nKGApdzmqtjxPGxK5enHqcx4hz1+kRQZRBeViva3QlWPJi
 RYnQ==
X-Gm-Message-State: ANhLgQ0zsXhwW79Ikk3BHZsPolEZ7Ep2D7gE/80dtR/wZMUvPrgv8MUM
 pW+u5a3gq2jrnNN3JPE8AYwj8UK6C/D5Pfy0UWuE3wKB8Cgj2KoHhYgj2xYwgXupZtAZZGm8Efi
 RiWkB7hP2Mcji6kA=
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4099695wru.127.1584519940884; 
 Wed, 18 Mar 2020 01:25:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvlym7VSB1bvo+XXQGGBveHKLPW+favDw3B4JH0Fulr65z6/H9ycWIx2RjME5GhBko4yciAnw==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4099652wru.127.1584519940520; 
 Wed, 18 Mar 2020 01:25:40 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s22sm2765274wmc.16.2020.03.18.01.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:25:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] target/i386: Restrict X86CPUFeatureWord to X86
 targets
To: qemu-devel@nongnu.org
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6379e738-7ac2-ed8e-7f43-77b454bcfea0@redhat.com>
Date: Wed, 18 Mar 2020 09:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316000348.29692-2-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

On 3/16/20 1:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Move out x86-specific structures from generic machine code.

If you have to respin "x86 and machine queue" please consider including=20
this patch :)

>=20
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>   qapi/machine.json          | 42 -----------------------------------
>   target/i386/cpu.c          |  2 +-
>   target/i386/machine-stub.c | 22 +++++++++++++++++++
>   target/i386/Makefile.objs  |  3 ++-
>   5 files changed, 70 insertions(+), 44 deletions(-)
>   create mode 100644 target/i386/machine-stub.c
>=20
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f2c82949d8..fb7a4b7850 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -3,6 +3,51 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   # See the COPYING file in the top-level directory.
>  =20
> +##
> +# @X86CPURegister32:
> +#
> +# A X86 32-bit register
> +#
> +# Since: 1.5
> +##
> +{ 'enum': 'X86CPURegister32',
> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
> +  'if': 'defined(TARGET_I386)' }
> +
> +##
> +# @X86CPUFeatureWordInfo:
> +#
> +# Information about a X86 CPU feature word
> +#
> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that featu=
re word
> +#
> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> +#                   feature word
> +#
> +# @cpuid-register: Output register containing the feature bits
> +#
> +# @features: value of output register, containing the feature bits
> +#
> +# Since: 1.5
> +##
> +{ 'struct': 'X86CPUFeatureWordInfo',
> +  'data': { 'cpuid-input-eax': 'int',
> +            '*cpuid-input-ecx': 'int',
> +            'cpuid-register': 'X86CPURegister32',
> +            'features': 'int' },
> +  'if': 'defined(TARGET_I386)' }
> +
> +##
> +# @DummyForceArrays:
> +#
> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internal=
ly
> +#
> +# Since: 2.5
> +##
> +{ 'struct': 'DummyForceArrays',
> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
> +  'if': 'defined(TARGET_I386)' }
> +
>   ##
>   # @CpuModelInfo:
>   #
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..de05730704 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -505,48 +505,6 @@
>      'dst': 'uint16',
>      'val': 'uint8' }}
>  =20
> -##
> -# @X86CPURegister32:
> -#
> -# A X86 32-bit register
> -#
> -# Since: 1.5
> -##
> -{ 'enum': 'X86CPURegister32',
> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
> -
> -##
> -# @X86CPUFeatureWordInfo:
> -#
> -# Information about a X86 CPU feature word
> -#
> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that featu=
re word
> -#
> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> -#                   feature word
> -#
> -# @cpuid-register: Output register containing the feature bits
> -#
> -# @features: value of output register, containing the feature bits
> -#
> -# Since: 1.5
> -##
> -{ 'struct': 'X86CPUFeatureWordInfo',
> -  'data': { 'cpuid-input-eax': 'int',
> -            '*cpuid-input-ecx': 'int',
> -            'cpuid-register': 'X86CPURegister32',
> -            'features': 'int' } }
> -
> -##
> -# @DummyForceArrays:
> -#
> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internal=
ly
> -#
> -# Since: 2.5
> -##
> -{ 'struct': 'DummyForceArrays',
> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
> -
>   ##
>   # @NumaCpuOptions:
>   #
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a84553e50c..0753fe4935 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -37,7 +37,7 @@
>   #include "qemu/option.h"
>   #include "qemu/config-file.h"
>   #include "qapi/error.h"
> -#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-machine-target.h"
>   #include "qapi/qapi-visit-run-state.h"
>   #include "qapi/qmp/qdict.h"
>   #include "qapi/qmp/qerror.h"
> diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
> new file mode 100644
> index 0000000000..cb301af057
> --- /dev/null
> +++ b/target/i386/machine-stub.c
> @@ -0,0 +1,22 @@
> +/*
> + * QAPI x86 CPU features stub
> + *
> + * Copyright (c) 2020 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-machine-target.h"
> +
> +void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
> +                                      X86CPUFeatureWordInfoList **obj,
> +                                      Error **errp)
> +{
> +}
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 48e0c28434..1cdfc9f50c 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
>   endif
>   obj-$(CONFIG_HVF) +=3D hvf/
>   obj-$(CONFIG_WHPX) +=3D whpx-all.o
> -endif
> +endif # CONFIG_SOFTMMU
>   obj-$(CONFIG_SEV) +=3D sev.o
>   obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
> +obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o
>=20


