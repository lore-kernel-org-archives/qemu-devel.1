Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E49C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A52208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN/9D6wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A52208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Xv-0002CG-LP
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW0Wm-0000kj-R8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW0Wk-0006Id-3G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603472811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpCAKh1qFEsDfC8aXXPIYzwiPvsP8lHIWiE82QJ/Hgg=;
 b=YN/9D6wyUZn8LrCRZ9Fbtx833ybdwQvr1MZUkzFPq2r5eGybhxIr1PdysWEWOL51mRdSg4
 f9VNeUu8Yd6tx+fGz/wNJKjBfYOGZjwD8uanykBGHruNA85GAU0IxWulsFkJgqryi09X/J
 pgbQAa0wAmHjeBFYS9s8u1Mog1rON+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Ex83D_faOOWEUt9QCshquQ-1; Fri, 23 Oct 2020 13:06:47 -0400
X-MC-Unique: Ex83D_faOOWEUt9QCshquQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83B438797E2;
 Fri, 23 Oct 2020 17:06:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6EDC55795;
 Fri, 23 Oct 2020 17:06:44 +0000 (UTC)
Date: Fri, 23 Oct 2020 19:06:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH] cpus: verify that number of created cpus do not exceed
 smp params
Message-ID: <20201023190643.06db22f7@redhat.com>
In-Reply-To: <160343848141.8350.10469322440262034340.stgit@pasha-ThinkPad-X280>
References: <160343848141.8350.10469322440262034340.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: pbonzini@redhat.com, David Gibson <dgibson@redhat.com>,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 10:34:41 +0300
Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> wrote:

> Machine definitions may miss some vCPU-related parameters.
> E.g., xlnx-versal-virt missed min_cpus and it was set to 1 by default.
> This allowed using -smp 1 command line argument. But the machine
> still created 2 vCPUs and passed all checks.
> This patch adds one more check that does not allow creating
> extra cpus that exceed the values specified in machine/smp.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>  0 files changed
> 
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 47cceddd80..da74794e09 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -603,6 +603,11 @@ void qemu_init_vcpu(CPUState *cpu)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>  
> +    if (cpu->cpu_index >= ms->smp.cpus) {
looks like for such machines we need MachineClass:min_cpus + setting it in affected machines
and corresponding check in smp_parse(), instead of terminating from qemu_init_vcpu();


> +        fprintf(stderr, "Machine definition error: trying to create too many CPUs\n");
> +        exit(1);
> +    }
> +
>      cpu->nr_cores = ms->smp.cores;
>      cpu->nr_threads =  ms->smp.threads;
>      cpu->stopped = true;
> 
> 


