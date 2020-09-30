Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74DC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FF9207C3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMQyAQ0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FF9207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfls-0002v5-3s
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfkb-0002Og-7p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfkY-0001Zt-NT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:18:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ousNwvOHh0vtGsz7RtInPqfQ2QDyLCnfngQbICHxv38=;
 b=XMQyAQ0lKkctL40mBOZ8aNKy158tScsAOHdlTF3zvLt9TIGnMTvlNqq4iz2AN+ye/QZCPB
 WqukblWYvRedxSvP/QRXTaboKCLPdBZBLYI+jX7PInxyRf+upfe0d8RxCfWyIWuAy5m/k4
 m1wngXxKOVbYrxMBkqoyFkyWAA1J1EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-QbCCTrDTNZKYE_7Vz83Lfg-1; Wed, 30 Sep 2020 13:18:35 -0400
X-MC-Unique: QbCCTrDTNZKYE_7Vz83Lfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 688371074663;
 Wed, 30 Sep 2020 17:18:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18DC381C40;
 Wed, 30 Sep 2020 17:18:34 +0000 (UTC)
Date: Wed, 30 Sep 2020 13:18:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 10/11] target/i386: Restrict X86CPUFeatureWord to X86
 targets
Message-ID: <20200930171833.GS3717385@habkost.net>
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930164949.1425294-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930164949.1425294-11-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 06:49:48PM +0200, Philippe Mathieu-Daudé wrote:
> Only qemu-system-FOO and qemu-storage-daemon provide QMP
> monitors, therefore such declarations and definitions are
> irrelevant for user-mode emulation.
> 
> Restricting the x86-specific commands to machine-target.json
> pulls less QAPI-generated code into user-mode.
> 
> Add a stub to satisfy linking in user-mode:
> 
>   /usr/bin/ld: libqemu-i386-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_get_feature_words':
>   target/i386/cpu.c:4643: undefined reference to `visit_type_X86CPUFeatureWordInfoList'
>   collect2: error: ld returned 1 exit status
>   make: *** [Makefile.ninja:1125: qemu-i386] Error 1
> 

If you don't want the QAPI definitions in user mode, there's no
reason to register the properties in user mode.  Wrapping #ifdef
around "feature-words" and "filtered-features" registration would
be simpler than adding a stub.

> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3: Reworded + Meson rebase
> ---
>  qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json          | 42 -----------------------------------
>  target/i386/cpu.c          |  2 +-
>  target/i386/feature-stub.c | 23 +++++++++++++++++++
>  target/i386/meson.build    |  1 +
>  5 files changed, 70 insertions(+), 43 deletions(-)
>  create mode 100644 target/i386/feature-stub.c
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 698850cc78..b4d769a53b 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -4,6 +4,51 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
>  
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
> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
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
> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
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
> index 72f014bb5b..cb878acdac 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -544,48 +544,6 @@
>     'dst': 'uint16',
>     'val': 'uint8' }}
>  
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
> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
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
> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
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
> index 3ffd877dd5..d45fa217cc 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -38,7 +38,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-machine-target.h"
>  #include "qapi/qapi-visit-run-state.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/target/i386/feature-stub.c b/target/i386/feature-stub.c
> new file mode 100644
> index 0000000000..787c3c7fa1
> --- /dev/null
> +++ b/target/i386/feature-stub.c
> @@ -0,0 +1,23 @@
> +/*
> + * QAPI x86 CPU features stub
> + *
> + * Copyright (c) 2020 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-machine-target.h"
> +
> +bool visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
> +                                          X86CPUFeatureWordInfoList **obj,
> +                                          Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/i386/meson.build b/target/i386/meson.build
> index e0b71ade56..0c5d9e6caf 100644
> --- a/target/i386/meson.build
> +++ b/target/i386/meson.build
> @@ -5,6 +5,7 @@ i386_ss.add(files(
>    'helper.c',
>    'xsave_helper.c',
>  ))
> +i386_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('feature-stub.c'))
>  i386_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'bpt_helper.c',
>    'cc_helper.c',
> -- 
> 2.26.2
> 
> 

-- 
Eduardo


