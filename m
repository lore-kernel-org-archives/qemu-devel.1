Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F3C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EBC2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhIMYKwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EBC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0YZ-0000No-VN
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO0WB-0006Wb-Bm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO0W9-0001ly-8C
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601566152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5pHWvDCyABD6d0YVAKEAIJ46zXaao01/+3Oj0tCg7w=;
 b=MhIMYKwh6MPGoK1c7cI+9AjGISqHOdcrluWCHgm0Es19uiNfqYmtbWgJg72nbzaprm68Li
 bRYqHo7xGvO24L+gO/bQUdPjslH6XmsRPYvJfsWdA/PH0XQV5E6fXHw53UcBBXZ3icukZ7
 czhJOA7n34fOQ7Qt+5segq1nPqv6iwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-sNuLgNiQMQu4IYVGAAYutg-1; Thu, 01 Oct 2020 11:29:09 -0400
X-MC-Unique: sNuLgNiQMQu4IYVGAAYutg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B75BD1029D20;
 Thu,  1 Oct 2020 15:29:07 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7C21001901;
 Thu,  1 Oct 2020 15:29:05 +0000 (UTC)
Date: Thu, 1 Oct 2020 11:29:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 3/3] target/i386: Restrict X86CPUFeatureWord to X86
 targets
Message-ID: <20201001152905.GC3717385@habkost.net>
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001144152.1555659-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 04:41:52PM +0200, Philippe Mathieu-Daudé wrote:
> Only qemu-system-FOO and qemu-storage-daemon provide QMP
> monitors, therefore such declarations and definitions are
> irrelevant for user-mode emulation.
> 
> Restricting the x86-specific commands to machine-target.json
> pulls less QAPI-generated code into user-mode.

Is this still true without "qapi: Restrict code generated for
user-mode"?

Markus, Eric: what's the difference between machine.json and
machine-target.json? commit 7f7b4e7abef4 ("qapi: Split
machine-target.json off target.json and misc.json") explains what
but not why.

> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Why the visit_type_X86CPUFeatureWordInfoList() stub was required
in v3, but not in this version?


> ---
>  qapi/machine-target.json | 45 ++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json        | 42 -------------------------------------
>  target/i386/cpu.c        |  2 +-
>  3 files changed, 46 insertions(+), 43 deletions(-)
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
> index 756dacb06f..995e972858 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -574,48 +574,6 @@
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
> index 9f72342506..848a65ded2 100644
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
> -- 
> 2.26.2
> 

-- 
Eduardo


