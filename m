Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D82C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B92320758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJn9WdWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B92320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDMLo-0007mO-BW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 02:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDMKw-00071i-4d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:33:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDMKt-0006Ek-9s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599028412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0J0WkmLr5SEdi+95ixuh3jCCjXpeL/NdGnEZ1QAjWY=;
 b=XJn9WdWpH0aRoTjoRGetKGAU/GqCWkY8ADNQps73RzKG2MmLLkiPuuUbmjZSC6wk84xIuM
 pS87ivqNURbHIBuJ3oYb+VqvQUVYkeZ/HbkOvpO3hbB4TeVQfDHXrD73q9xMThezqdXDoM
 SiQyqF2EFXkHIt4kG0wJwYYbSy+xFAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-rHvl-StSPEqdSNCOD3keWg-1; Wed, 02 Sep 2020 02:33:30 -0400
X-MC-Unique: rHvl-StSPEqdSNCOD3keWg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08289425D1;
 Wed,  2 Sep 2020 06:33:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B05BC10023A7;
 Wed,  2 Sep 2020 06:33:25 +0000 (UTC)
Subject: Re: [PATCH 1/2] cpus: Do not dump CPU state when calling hw_error()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cae3f7a9-eef7-3efa-5968-7bf2de0d2b22@redhat.com>
Date: Wed, 2 Sep 2020 08:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901112323.94969-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> We already have cpu_abort() to dump CPU states and abort.
> 
> Restrict hw_error() to peripheral errors, hoping we can completely
> remove it by proper functions from "error-report.h" in the future.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>

IIRC I rather suggested to rename the function to "cpu_hw_error" and
only use it for real CPU problems...
But I think your approach here is fine as well. Please replace the
"Suggested-by" with "Reviewed-by" now :-)

 Thomas


> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  softmmu/cpus.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899abb..c96a04d7f18 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -913,16 +913,11 @@ static void stop_tcg_kick_timer(void)
>  void hw_error(const char *fmt, ...)
>  {
>      va_list ap;
> -    CPUState *cpu;
>  
>      va_start(ap, fmt);
>      fprintf(stderr, "qemu: hardware error: ");
>      vfprintf(stderr, fmt, ap);
>      fprintf(stderr, "\n");
> -    CPU_FOREACH(cpu) {
> -        fprintf(stderr, "CPU #%d:\n", cpu->cpu_index);
> -        cpu_dump_state(cpu, stderr, CPU_DUMP_FPU);
> -    }

You could argue that cpu_abort() only prints the state of one CPU and
not of all. But I doubt that dumping the state of *all* CPUs is really
helpful in any of the contexts where hw_error() is used. So I think it's
fine to remove this CPU_FOREACH loop here.

>      va_end(ap);
>      abort();
>  }
> 


