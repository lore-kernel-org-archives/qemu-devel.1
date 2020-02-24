Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DAC11D30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7629A20838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtsekrVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7629A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6H8W-0002fd-Fm
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6H74-0000x9-Rm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6H73-0004NV-39
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:01:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6H72-0004M0-Pk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582563703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REaGn/Bf8mTXDWPl9OfzpIYoI3Q35VS6vhE4aTOOPdk=;
 b=QtsekrVHr3Q9HixjQX/ZoLgeVu76HY2TDazyEI2aY5IyX+2LCIl2TB2d8OLEW+ZCFbaKci
 ibJgQgYDBZVXiGiNWgs7fIh8x/sTib7R7WlvwQ5kJ1XpvOBlQe173YJLI8G66kuJ89tgx3
 Emcx14rh5Nyzxw6PvZ9+fhoNrH/noq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-YTAvWCz-PyiGWcrQ9lmKbQ-1; Mon, 24 Feb 2020 12:01:41 -0500
X-MC-Unique: YTAvWCz-PyiGWcrQ9lmKbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6A4DBB3;
 Mon, 24 Feb 2020 17:01:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E85490080;
 Mon, 24 Feb 2020 17:01:34 +0000 (UTC)
Date: Mon, 24 Feb 2020 18:01:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 10/16] hw/i386: Introduce apicid functions inside
 X86MachineState
Message-ID: <20200224180133.3a3bdf4c@redhat.com>
In-Reply-To: <158161785243.48948.11368379114010493667.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161785243.48948.11368379114010493667.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 12:17:32 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Introduce model specific apicid functions inside X86MachineState.
> These functions will be loaded from X86CPUDefinition.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/x86.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 38c2d27910..75c2462770 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -79,6 +79,15 @@ typedef struct {
>      uint16_t boot_cpus;
>      unsigned smp_dies;
>  
> +    /* Apic id specific handlers */
> +    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
> +                                    unsigned cpu_index);
> +    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
> +                                 X86CPUTopoIDs *topo_ids);
> +    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
> +                                      const X86CPUTopoIDs *topo_ids);
> +    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
> +
>      /*
>       * Address space used by IOAPIC device. All IOAPIC interrupts
>       * will be translated to MSI messages in the address space.
> 
> 

Suggest to move defaults into this patch as well. i.e.
move parts that replace direct calls with hooks from 12/16
and set default hooks (i.e. non EPYC ones) in x86's machine_class_init().

This way It's immediately obvious what you are changing and then
followup EPYC related patch won't be cluttered by non related defaults
conversion.


