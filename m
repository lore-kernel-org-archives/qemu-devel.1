Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A47206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpsr7kvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A47206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MEd-0000Tc-Tb
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8ME8-0008U0-IA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:25:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8ME6-0000d2-Hp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597836352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLSYFfOjnlLixPdAbK7cSPdye0Zf1xtkLbd2Hv6WocE=;
 b=Bpsr7kvDP5tgzby9QuS6XRPr8p+tBBSyHKdWzvSnN0i2Di/xT6VLw+kQD9bVPd7JeAucym
 FIJ7Ak+493s0bp4EVCfzbfKpvJHSSWM9bgd57pKpquSDLBEseuMuEPGefJ+PoVF0KpWyZf
 +OdeHDuag1YKZWqPpRp5fgnDIw4Wauc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-qe2EaDNpMyC-h_7JM_wNhw-1; Wed, 19 Aug 2020 07:25:49 -0400
X-MC-Unique: qe2EaDNpMyC-h_7JM_wNhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C73580EF9B;
 Wed, 19 Aug 2020 11:25:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D157C59;
 Wed, 19 Aug 2020 11:25:39 +0000 (UTC)
Date: Wed, 19 Aug 2020 13:25:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 2/3] hw/i386: Update the EPYC topology to use
 socket/dies/core/thread model
Message-ID: <20200819132538.1173e444@redhat.com>
In-Reply-To: <159744117377.39197.9319853595178174798.stgit@naples-babu.amd.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
 <159744117377.39197.9319853595178174798.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 16:39:33 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Update the EPYC topology to use socket/dies/core/thread model. The EPYC
> model does not use the smp dies to build the topology. Instead, it uses
> numa nodes to build the topology. Internally both are similar concept
> which divides the cores on L3 boundary. Combining both into one terminology
> makes it simple to program.
> 
> Add a new check to error out when smp dies are not provided when EPYC
> model is numa configured. Next task is to remove node_id, nr_nodes and
> nodes_per_pkg from EPYC topology which will be done in next patch.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/x86.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 67bee1bcb8..e90c42d2fc 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -138,6 +138,14 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>  
>      /* Check for apicid encoding */
>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> +        if ((ms->numa_state->num_nodes > 0) &&

> +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
this case is gated by (ms->numa_state->num_nodes > 0) so it won't work in case
 -smp dies=>1 but there is no -numa options at all

we need to error out and ask to provide numa nodes corresponding to
   (ms->numa_state->num_nodes == 0) && (ms->smp.sockets * x86ms->smp_dies)

or better alternative would be to enable autonuma when EPYC cpu is enabled,
that will insure that this patch will work even if user hasn't specified -numa option,
since it will create a single numa node automatically.

The later will take care of (-smp 1,dies=1) case, which is broken due to
lack of explicit -numa we end up with CPU_UNSET_NUMA_NODE_ID in CPUID_Fn8000001E_ECX.

> +            error_setg(&error_fatal, "Numa configuration here requires smp "
> +                       "'dies' parameter. Configure the cpu topology properly "
> +                       "with max_cpus = sockets * dies * cores * threads. Dies"
> +                       " is equivalent to number of numa nodes in a socket.");
> +            return;
> +        }
>          x86_set_epyc_topo_handlers(ms);
>      }
>  
> 


