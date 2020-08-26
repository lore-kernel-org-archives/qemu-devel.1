Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0407C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9BF206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGjGo5mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9BF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuPt-0007k0-VI
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAuOe-0006k8-1C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAuOa-0004Np-8s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598444354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VpuTWqdhuPROiUUsZwceVGelDeoDUBTlOVC+1VyrPM=;
 b=CGjGo5mot6Ys4/XCTxVMtI6h0Rnn0H8q4UnvjN1ISsBd8azMqKiKJ5QMzhsdF+UAR454Kd
 cu7Px8tFq0KqqwRsLvQ6+Z++1yQsp9z8RaMxeCFAOtKmlykQaTDnZy0rkZEde7IgdbFJdo
 uPwIg9t6o2zY/Bp3XwrFLPls6aGRHg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-kA7xbJtGOEaV04vWphsjXw-1; Wed, 26 Aug 2020 08:19:12 -0400
X-MC-Unique: kA7xbJtGOEaV04vWphsjXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2AA1074648;
 Wed, 26 Aug 2020 12:19:11 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17E175D9E4;
 Wed, 26 Aug 2020 12:19:06 +0000 (UTC)
Date: Wed, 26 Aug 2020 14:19:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 8/8] i386: Simplify CPUID_8000_001E for AMD
Message-ID: <20200826141905.368b54dd@redhat.com>
In-Reply-To: <159804798946.39954.6416009204638021915.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <159804798946.39954.6416009204638021915.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 17:13:09 -0500
Babu Moger <babu.moger@amd.com> wrote:

> apic_id contains all the information required to build
> CPUID_8000_001E. core_id and node_id is already part of
> apic_id generated by x86_topo_ids_from_apicid_epyc.
> Also remove the restriction on number bits on core_id and
> node_id.
> 
> Remove all the hardcoded values and replace with generalized
> fields.
> 
> Refer the Processor Programming Reference (PPR) documentation
> available from the bugzilla Link below.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |   81 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 37 insertions(+), 44 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b29686220e..bea2822923 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -385,58 +385,51 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
>      X86CPUTopoIDs topo_ids = {0};
> -    unsigned long dies = topo_info->dies_per_pkg;
> -    int shift;
>  
>      x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
>  
>      *eax = cpu->apic_id;
> +
>      /*
> -     * CPUID_Fn8000001E_EBX
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
> +     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
> +     * Read-only. Reset: 0000_XXXXh.
> +     * See Core::X86::Cpuid::ExtApicId.
> +     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
> +     * Bits Description
> +     * 31:16 Reserved.
> +     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
> +     *      The number of threads per core is ThreadsPerCore+1.
> +     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
> +     *
> +     *  NOTE: CoreId is already part of apic_id. Just use it. We can
> +     *  use all the 8 bits to represent the core_id here.
>       */
> -    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.die_id << 3) |
> -            (topo_ids.core_id);
> +    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
> +
>      /*
> -     * CPUID_Fn8000001E_ECX
> -     * 31:11 Reserved
> -     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
> -     *  7:0  Node id (see bit decoding below)
> -     *         2  Socket id
> -     *       1:0  Node id
> +     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
> +     * Read-only. Reset: 0000_0XXXh.
> +     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
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
> -    if (dies <= 4) {
> -        *ecx = ((dies - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.die_id;
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
> -        dies -= 1;
> -        shift = find_last_bit(&dies, 8);
> -        *ecx = (dies << 8) | (topo_ids.pkg_id << (shift + 1)) |
> -               topo_ids.die_id;
> -    }
> +    *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
> +           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);

I'd prefer approach used in "[PATCH v4 1/3] i386: Simplify CPUID_8000_001E for AMD"
that way numa node id in this leaf will aways be consistent with -numa CLI.
 


>      *edx = 0;
>  }
>  
> 
> 


