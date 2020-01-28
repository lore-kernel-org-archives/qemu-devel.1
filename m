Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD169C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFFD24683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA3Woqqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFFD24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTlk-0001Rj-Oo
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwTk8-0008MD-Bp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwTk6-0003sf-M1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwTk6-0003sL-HV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580228973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e032N0zxF8tWpetCJKuDj40pVQJDqs5UqbuaRrX3BI=;
 b=DA3WoqqgK8qnjcbPI/sN45aFOKDONRmzs2uVRs2o2x0l6EprfQ8zYoJ9VycEN9jxfMsgCH
 WrfZqMi1P2P6c5bUhbWCMGW2yFVA4bvJF72qPn3bXdAcQtjuts+81DXfSXfqW+lbmC5EPQ
 BcFR9VB9q1JbjcP9K1yXS65PO97kI7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-YZR1c61XP0OBeq0yPp051w-1; Tue, 28 Jan 2020 11:29:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F3ED10BAD7C;
 Tue, 28 Jan 2020 16:29:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF3F86E22;
 Tue, 28 Jan 2020 16:29:21 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:29:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200128172919.4ecb5896@redhat.com>
In-Reply-To: <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YZR1c61XP0OBeq0yPp051w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Dec 2019 18:37:42 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Add a new function init_apicid_fn in MachineClass to initialize the mode
> specific handlers to decode the apic ids.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/boards.h |    1 +
>  vl.c                |    3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index d4fab218e6..ce5aa365cb 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -238,6 +238,7 @@ struct MachineClass {
>                                                           unsigned cpu_index);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> +    void (*init_apicid_fn)(MachineState *ms);
it's x86 specific, so why it wasn put into PCMachineClass?


>  };
>  
>  /**
> diff --git a/vl.c b/vl.c
> index a42c24a77f..b6af604e11 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
>      current_machine->cpu_type = machine_class->default_cpu_type;
>      if (cpu_option) {
>          current_machine->cpu_type = parse_cpu_option(cpu_option);
> +        if (machine_class->init_apicid_fn) {
> +            machine_class->init_apicid_fn(current_machine);
> +        }
>      }
>      parse_numa_opts(current_machine);
>  
> 
> 


