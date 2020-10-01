Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F1C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA0D208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDl6ZSMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA0D208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Ib-0002yM-3f
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO0u5-000169-6Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO0u3-0005mi-0Z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601567634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfNVtFoS9T3pjmpwlqN32EmtdIOxeDv0f3zZYu0YFXI=;
 b=aDl6ZSMps/dJvXrLiNs4W/KjOs0cT22bPhuebdOCZWDSZ5pGcKuZAmSttrFH4zVkluidG9
 G6ec+qQyV50ztZ8Xtgob1lDyt2iIxmSOcgJqfScrlaoIW45iK4L/nFFiW4k7wCHaPS+rfS
 fcHlW7tN1Xlwezk8T9IznrnjZJbZKiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-7NfLdGhKNvuhAb7uoYSgEQ-1; Thu, 01 Oct 2020 11:53:51 -0400
X-MC-Unique: 7NfLdGhKNvuhAb7uoYSgEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C7B8D36C1;
 Thu,  1 Oct 2020 15:53:48 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E52473678;
 Thu,  1 Oct 2020 15:53:48 +0000 (UTC)
Date: Thu, 1 Oct 2020 11:53:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 3/3] target/i386: Restrict X86CPUFeatureWord to X86
 targets
Message-ID: <20201001155347.GE3717385@habkost.net>
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-4-philmd@redhat.com>
 <20201001152905.GC3717385@habkost.net>
 <27bf4922-545e-e7e5-29fa-1dd80283e41a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27bf4922-545e-e7e5-29fa-1dd80283e41a@redhat.com>
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

On Thu, Oct 01, 2020 at 05:37:26PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/1/20 5:29 PM, Eduardo Habkost wrote:
> > On Thu, Oct 01, 2020 at 04:41:52PM +0200, Philippe Mathieu-Daudé wrote:
> >> Only qemu-system-FOO and qemu-storage-daemon provide QMP
> >> monitors, therefore such declarations and definitions are
> >> irrelevant for user-mode emulation.
> >>
> >> Restricting the x86-specific commands to machine-target.json
> >> pulls less QAPI-generated code into user-mode.
> > 
> > Is this still true without "qapi: Restrict code generated for
> > user-mode"?
> 
> The correct description so far is:
> 
> "Restricting the x86-specific commands to machine-target.json
> pulls less QAPI-generated code into non-x86 targets.", as of
> this commit the X86CPURegister32 definitions are not built in
> the other ARM/S390/PPC/... targets.

This seems to have other side effects in addition to remove the
code from non-x86 targets and I don't understand why.

> 
> I still have some hope "qapi: Restrict code generated for user-mode"
> get merged some day.
> 
> > 
> > Markus, Eric: what's the difference between machine.json and
> > machine-target.json? commit 7f7b4e7abef4 ("qapi: Split
> > machine-target.json off target.json and misc.json") explains what
> > but not why.

[1]

> > 
> >>
> >> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > 
> > Why the visit_type_X86CPUFeatureWordInfoList() stub was required
> > in v3, but not in this version?
> 
> Because it is ifdef'ed out in the previous (new) patch:
> "target/i386/cpu: Restrict some of feature-words uses to system-mode".

Sorry for the confusion, I thought this patch was _before_
"Restrict some of feature-words ..".

Now, what I don't understand is: why moving the code from
machine.json to machine-target.json makes patch 2/3 necessary?
I assume the answer to the question above[1] would clarify this.

> 
> > 
> > 
> >> ---
> >>  qapi/machine-target.json | 45 ++++++++++++++++++++++++++++++++++++++++
> >>  qapi/machine.json        | 42 -------------------------------------
> >>  target/i386/cpu.c        |  2 +-
> >>  3 files changed, 46 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> >> index 698850cc78..b4d769a53b 100644
> >> --- a/qapi/machine-target.json
> >> +++ b/qapi/machine-target.json
> >> @@ -4,6 +4,51 @@
> >>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
> >>  # See the COPYING file in the top-level directory.
> >>  
> >> +##
> >> +# @X86CPURegister32:
> >> +#
> >> +# A X86 32-bit register
> >> +#
> >> +# Since: 1.5
> >> +##
> >> +{ 'enum': 'X86CPURegister32',
> >> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
> >> +  'if': 'defined(TARGET_I386)' }
> >> +
> >> +##
> >> +# @X86CPUFeatureWordInfo:
> >> +#
> >> +# Information about a X86 CPU feature word
> >> +#
> >> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
> >> +#
> >> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> >> +#                   feature word
> >> +#
> >> +# @cpuid-register: Output register containing the feature bits
> >> +#
> >> +# @features: value of output register, containing the feature bits
> >> +#
> >> +# Since: 1.5
> >> +##
> >> +{ 'struct': 'X86CPUFeatureWordInfo',
> >> +  'data': { 'cpuid-input-eax': 'int',
> >> +            '*cpuid-input-ecx': 'int',
> >> +            'cpuid-register': 'X86CPURegister32',
> >> +            'features': 'int' },
> >> +  'if': 'defined(TARGET_I386)' }
> >> +
> >> +##
> >> +# @DummyForceArrays:
> >> +#
> >> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
> >> +#
> >> +# Since: 2.5
> >> +##
> >> +{ 'struct': 'DummyForceArrays',
> >> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
> >> +  'if': 'defined(TARGET_I386)' }
> >> +
> >>  ##
> >>  # @CpuModelInfo:
> >>  #
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 756dacb06f..995e972858 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -574,48 +574,6 @@
> >>     'dst': 'uint16',
> >>     'val': 'uint8' }}
> >>  
> >> -##
> >> -# @X86CPURegister32:
> >> -#
> >> -# A X86 32-bit register
> >> -#
> >> -# Since: 1.5
> >> -##
> >> -{ 'enum': 'X86CPURegister32',
> >> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
> >> -
> >> -##
> >> -# @X86CPUFeatureWordInfo:
> >> -#
> >> -# Information about a X86 CPU feature word
> >> -#
> >> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
> >> -#
> >> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> >> -#                   feature word
> >> -#
> >> -# @cpuid-register: Output register containing the feature bits
> >> -#
> >> -# @features: value of output register, containing the feature bits
> >> -#
> >> -# Since: 1.5
> >> -##
> >> -{ 'struct': 'X86CPUFeatureWordInfo',
> >> -  'data': { 'cpuid-input-eax': 'int',
> >> -            '*cpuid-input-ecx': 'int',
> >> -            'cpuid-register': 'X86CPURegister32',
> >> -            'features': 'int' } }
> >> -
> >> -##
> >> -# @DummyForceArrays:
> >> -#
> >> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
> >> -#
> >> -# Since: 2.5
> >> -##
> >> -{ 'struct': 'DummyForceArrays',
> >> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
> >> -
> >>  ##
> >>  # @NumaCpuOptions:
> >>  #
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 9f72342506..848a65ded2 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -38,7 +38,7 @@
> >>  #include "qemu/option.h"
> >>  #include "qemu/config-file.h"
> >>  #include "qapi/error.h"
> >> -#include "qapi/qapi-visit-machine.h"
> >> +#include "qapi/qapi-visit-machine-target.h"
> >>  #include "qapi/qapi-visit-run-state.h"
> >>  #include "qapi/qmp/qdict.h"
> >>  #include "qapi/qmp/qerror.h"
> >> -- 
> >> 2.26.2
> >>
> > 
> 

-- 
Eduardo


