Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8AC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1482067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnRw0hBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1482067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJVg-00024p-4E
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJV1-0001Zr-EZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJUu-0008P2-Be
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:35:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJUu-0008Oo-7r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583764511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpHBqZNuTpHwTS8QH8stCfWwbq5/YFkertNdJpsVzAk=;
 b=YnRw0hBPdBpHb93g9NzHni9fgmMb2MXYoXZ/lLb+OX9P4alIpFmaaXaKdJYq6blu2j/Gvj
 bnKzuB+bvcJXVQyAKE7hlUzrN2KmzDrH/eEHZHBla2/bUu4CEd/h11ckAgEm1ibecMCaEu
 iaNT98OyV9Y3xUZW8v/pKRBKFNUEQ9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-2GHBcgYFNgKKF4-x0E2gWQ-1; Mon, 09 Mar 2020 10:35:07 -0400
X-MC-Unique: 2GHBcgYFNgKKF4-x0E2gWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876B1107ACC9;
 Mon,  9 Mar 2020 14:35:05 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 220645C290;
 Mon,  9 Mar 2020 14:34:54 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:34:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 10/16] hw/i386: Introduce apicid functions inside
 X86MachineState
Message-ID: <20200309153452.19fd9491@Igors-MacBook-Pro>
In-Reply-To: <158326547677.40452.8049125270383618696.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326547677.40452.8049125270383618696.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On Tue, 03 Mar 2020 13:57:56 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Introduce model specific apicid functions inside X86MachineState.
> These functions will be loaded from X86CPUDefinition.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  hw/i386/x86.c         |    5 +++++
>  include/hw/i386/x86.h |    9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 929b80c9c7..15b7815bb0 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -911,6 +911,11 @@ static void x86_machine_initfn(Object *obj)
>      x86ms->smm = ON_OFF_AUTO_AUTO;
>      x86ms->max_ram_below_4g = 0; /* use default */
>      x86ms->smp_dies = 1;
> +
> +    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
> +    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
> +    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
> +    x86ms->apicid_pkg_offset = apicid_pkg_offset;
>  }
>  
>  static void x86_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 22babcb3bb..2643b57629 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -65,6 +65,15 @@ typedef struct {
>  
>      OnOffAuto smm;
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


