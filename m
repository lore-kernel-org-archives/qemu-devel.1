Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E577A2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqnToGVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E577A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46qn-00033t-7N
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 14:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k46pp-0002Az-IP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:11:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k46pm-0005OG-P5
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596823871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwzY9e0x7I9yafGiPTk2uyHMq6Yp+N5y1oHlyIhf3kM=;
 b=SqnToGVZLD1exSGMo4f+wwrynzzM6p4GN41uWiSxCtI6N3nDKu0p9y7NqQIZQi44WbyjCY
 nyCrQGeXVW5y7iIyEwXHzNwhwqvaL+/MhHlI1/X5/7iJUiN4H99bQWhWPuim4Mg1P6axjf
 f/BSUpReQSpcEp2gjM97sDiywKtZxCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-W1aXT_CQMmGuKUxYCh6KUw-1; Fri, 07 Aug 2020 14:11:10 -0400
X-MC-Unique: W1aXT_CQMmGuKUxYCh6KUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07368800466;
 Fri,  7 Aug 2020 18:11:09 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E6CA5C1D3;
 Fri,  7 Aug 2020 18:11:02 +0000 (UTC)
Date: Fri, 7 Aug 2020 20:11:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 1/3] i386: Simplify CPUID_8000_001E for AMD
Message-ID: <20200807201100.5c141fe4@redhat.com>
In-Reply-To: <159681796533.9679.8403552849052625336.stgit@naples-babu.amd.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681796533.9679.8403552849052625336.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 07 Aug 2020 11:32:45 -0500
Babu Moger <babu.moger@amd.com> wrote:

> apic_id contains all the information required to build CPUID_8000_001E.
> Also remove the restriction on number bits on core_id and node_id.
> Remove all the hardcoded values and replace with generalized
> fields.
> 
> Refer the Processor Programming Reference (PPR) documentation
> available from the bugzilla Link below.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |   77 +++++++++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..c892432cae 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -388,57 +388,52 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>  {
>      X86CPUTopoIDs topo_ids = {0};
>      unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
> -    int shift;
>  
>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>  
>      *eax = cpu->apic_id;
> +
>      /*
> +     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
> +     * Read-only. Reset: 0000_XXXXh.
> +     * See Core::X86::Cpuid::ExtApicId.
> +     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
>       * CPUID_Fn8000001E_EBX
> -     * 31:16 Reserved
> -     * 15:8  Threads per core (The number of threads per core is
> -     *       Threads per core + 1)
> -     *  7:0  Core id (see bit decoding below)
> -     *       SMT:
> -     *           4:3 node id
> -     *             2 Core complex id
> -     *           1:0 Core id
> -     *       Non SMT:
> -     *           5:4 node id
> -     *             3 Core complex id
> -     *           1:0 Core id
> +     * Bits Description
> +     * 31:16 Reserved.
> +     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
> +     *      The number of threads per core is ThreadsPerCore+1.
> +     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
> +     *
> +     *  NOTE: CoreId is already part of apic_id. Just use it. We can
> +     *  use all the 8 bits to represent the core_id here.
>       */
> -    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
> -            (topo_ids.core_id);
> +    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
> +
>      /*
> +     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
> +     * Read-only. Reset: 0000_0XXXh.
> +     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
>       * CPUID_Fn8000001E_ECX
> -     * 31:11 Reserved
> -     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
> -     *  7:0  Node id (see bit decoding below)
> -     *         2  Socket id
> -     *       1:0  Node id
> +     * Bits Description
> +     * 31:11 Reserved.
> +     * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
> +     *      ValidValues:
> +     *      Value Description
> +     *      000b  1 node per processor.
> +     *      001b  2 nodes per processor.
> +     *      010b Reserved.
> +     *      011b 4 nodes per processor.
> +     *      111b-100b Reserved.
> +     *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
> +     *
> +     * NOTE: Hardware reserves 3 bits for number of nodes per processor.
> +     * But users can create more nodes than the actual hardware can
> +     * support. To genaralize we can use all the upper 8 bits for nodes.
> +     * NodeId is combination of node and socket_id which is already decoded
> +     * in apic_id. Just use it by shifting.
>       */
> -    if (nodes <= 4) {
> -        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
> -    } else {
> -        /*
> -         * Node id fix up. Actual hardware supports up to 4 nodes. But with
> -         * more than 32 cores, we may end up with more than 4 nodes.
> -         * Node id is a combination of socket id and node id. Only requirement
> -         * here is that this number should be unique accross the system.
> -         * Shift the socket id to accommodate more nodes. We dont expect both
> -         * socket id and node id to be big number at the same time. This is not
> -         * an ideal config but we need to to support it. Max nodes we can have
> -         * is 32 (255/8) with 8 cores per node and 255 max cores. We only need
> -         * 5 bits for nodes. Find the left most set bit to represent the total
> -         * number of nodes. find_last_bit returns last set bit(0 based). Left
> -         * shift(+1) the socket id to represent all the nodes.
> -         */
> -        nodes -= 1;
> -        shift = find_last_bit(&nodes, 8);
> -        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
> -               topo_ids.node_id;
> -    }
> +    *ecx = ((nodes - 1) << 8) | cpu->node_id;
>      *edx = 0;
>  }
>  
> 
> 


