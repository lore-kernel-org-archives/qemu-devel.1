Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137D4207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baSbnwHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D4207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTLm-0004tT-A1
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdTKu-00041v-81
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:45:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdTKs-0006Pg-SZ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590475512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvgGktSiesJJCrfZkmYnSs6aL5wOIBi+RgDGo65run8=;
 b=baSbnwHCbMxZs3+nt7rotRqTc9J/3/WzlUXYESI865s207zVWTrGoSpV2yGNLCrYgIpUJC
 YpizzjrKN1rb2JotVXY7UChbC0XtaknvF5Ge8WkzeADZufkU50yRVNK8V7v7TaxOE4D4AH
 zzCKOtpVEiNJwtDbPmf9dLN2dHDr8qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-pMepmNAKNZKKWwOebGZHVA-1; Tue, 26 May 2020 02:45:11 -0400
X-MC-Unique: pMepmNAKNZKKWwOebGZHVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAF9C100CD01;
 Tue, 26 May 2020 06:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECFEA19D7E;
 Tue, 26 May 2020 06:45:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77B25113864A; Tue, 26 May 2020 08:45:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 1/9] target/i386: Restrict X86CPUFeatureWord to X86
 targets
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-2-philmd@redhat.com>
Date: Tue, 26 May 2020 08:45:00 +0200
In-Reply-To: <20200525150640.30879-2-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 25 May 2020 17:06:32
 +0200")
Message-ID: <87o8qb8aab.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael
 S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Move out x86-specific structures from generic machine code.
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json          | 42 -----------------------------------
>  target/i386/cpu.c          |  2 +-
>  target/i386/machine-stub.c | 22 +++++++++++++++++++
>  target/i386/Makefile.objs  |  3 ++-
>  5 files changed, 70 insertions(+), 44 deletions(-)
>  create mode 100644 target/i386/machine-stub.c
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f2c82949d8..fb7a4b7850 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -3,6 +3,51 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>  # See the COPYING file in the top-level directory.
> =20
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
>  ##
>  # @CpuModelInfo:
>  #
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ff7b5032e3..1fe31d374c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -511,48 +511,6 @@
>     'dst': 'uint16',
>     'val': 'uint8' }}
> =20
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
>  ##
>  # @NumaCpuOptions:
>  #
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7a4a8e3847..832498c723 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -37,7 +37,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-machine-target.h"
>  #include "qapi/qapi-visit-run-state.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
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

Unusual indentation.

> +{
> +}

Two kinds of stubs: stubs that can get called, and stubs that exist only
to satisfy the linker.  Which kind is this one?

> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 48e0c28434..1cdfc9f50c 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
>  endif
>  obj-$(CONFIG_HVF) +=3D hvf/
>  obj-$(CONFIG_WHPX) +=3D whpx-all.o
> -endif
> +endif # CONFIG_SOFTMMU
>  obj-$(CONFIG_SEV) +=3D sev.o
>  obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
> +obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o

Suggest

   ifeq ($(CONFIG_SOFTMMU),y)
   ...
   else
   obj-y +=3D machine-stub.o
   endif

Matter of taste.


