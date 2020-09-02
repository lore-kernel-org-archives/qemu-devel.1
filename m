Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D8C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC5E20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCx3O4E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC5E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDMQN-0001IS-Ar
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 02:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDMOv-0000nJ-AU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:37:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDMOq-0006oO-Qw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599028659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhUX7IAR1dMwHAc63LDQ/QXUzSxjhCFOGyJkl2QOAIY=;
 b=iCx3O4E+/7ajTRrTeeZYAhdPUwPd9QgqGHqk/v3eMuEmN2mJ22mZHGtmzjr3GswKXcUTs8
 UaWn45mgZq1dlLD5Y4ulkoZp4ksuwSCNuicD4alZKSMdHPQnwbFNpzkKwxUYfB9s0o6pUz
 BJyO0nfLkVE/fl8DXWDq/WY27aKJNIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-uRt6VcirNs2fXJWYbH_3Ig-1; Wed, 02 Sep 2020 02:37:37 -0400
X-MC-Unique: uRt6VcirNs2fXJWYbH_3Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD3D5801ADE;
 Wed,  2 Sep 2020 06:37:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C7A57B90A;
 Wed,  2 Sep 2020 06:37:35 +0000 (UTC)
Subject: Re: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
Date: Wed, 2 Sep 2020 08:37:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901112323.94969-3-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 13.23, Philippe Mathieu-Daudé wrote:
> As hw_error() is unrelated to CPU error - for which we have
> cpu_abort() - move it out of cpus.c, under the hw/ directory.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Couldn't find better file/name to put it in...
> ---
>  hw/core/error.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  softmmu/cpus.c      | 12 ------------
>  hw/core/meson.build |  1 +
>  3 files changed, 39 insertions(+), 12 deletions(-)
>  create mode 100644 hw/core/error.c
> 
> diff --git a/hw/core/error.c b/hw/core/error.c
> new file mode 100644
> index 00000000000..5a783c82dff
> --- /dev/null
> +++ b/hw/core/error.c
> @@ -0,0 +1,38 @@
> +/*
> + * Peripheral error reporting
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +
> +void hw_error(const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    fprintf(stderr, "qemu: hardware error: ");
> +    vfprintf(stderr, fmt, ap);
> +    fprintf(stderr, "\n");
> +    va_end(ap);
> +    abort();
> +}
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index c96a04d7f18..eca57c76c9b 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -59,7 +59,6 @@
>  #include "sysemu/replay.h"
>  #include "sysemu/runstate.h"
>  #include "hw/boards.h"
> -#include "hw/hw.h"
>  
>  #include "sysemu/cpu-throttle.h"
>  
> @@ -910,17 +909,6 @@ static void stop_tcg_kick_timer(void)
>  }
>  
>  /***********************************************************/
> -void hw_error(const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    fprintf(stderr, "qemu: hardware error: ");
> -    vfprintf(stderr, fmt, ap);
> -    fprintf(stderr, "\n");
> -    va_end(ap);
> -    abort();
> -}
>  
>  void cpu_synchronize_all_states(void)
>  {
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index fc91f980758..99466dc93fd 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -1,6 +1,7 @@
>  # core qdev-related obj files, also used by *-user and unit tests
>  hwcore_files = files(
>    'bus.c',
> +  'error.c',
>    'fw-path-provider.c',
>    'hotplug.c',
>    'qdev-properties.c',
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

Alternative ideas:

- Move the function as "static inline" into the header file
  instead - it's not so big, so an inline function should be
  ok here.

- Add a big fat warning comment to the header that this
  function should not be used for new code anymore.

 Thomas


