Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7760BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDBE206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKxI+ubM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDBE206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4wF-0006Ro-7L
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD4vh-00062Y-RD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:58:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD4vf-0003fO-N6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598961502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4Rkf/wORAWLHmY/j3frMgj0ZQS1aLb7lrkWNGRvc6Y=;
 b=KKxI+ubMXSJiyiAO+WLBWGMGrBObzXB+wP3dWD7t3d75CMw5NGiyn2jF7nP7JuiJAf8R2O
 X8xqoyFXYydfLPwfig2eAHKww6Zag8grw0aGdAe/GOP0ok46Y8wYpQdXGQhwpgRRWmEVqf
 VOzu6Sdf1AzDwdU4W5zU9XhhKFP6fn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-8-8EK24HO1GAkYza0vx_9w-1; Tue, 01 Sep 2020 07:58:19 -0400
X-MC-Unique: 8-8EK24HO1GAkYza0vx_9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251EB189E604;
 Tue,  1 Sep 2020 11:58:18 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E757760BE2;
 Tue,  1 Sep 2020 11:58:13 +0000 (UTC)
Date: Tue, 1 Sep 2020 13:58:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 10/10] i386: Simplify CPUID_8000_001E for AMD
Message-ID: <20200901135811.0f71979e@imammedo-mac>
In-Reply-To: <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:43:07 -0500
Babu Moger <babu.moger@amd.com> wrote:

> apic_id contains all the information required to build
> CPUID_8000_001E. core_id and node_id is already part of
> apic_id generated by x86_topo_ids_from_apicid.
>=20
> Also remove the restriction on number bits on core_id and
> node_id.
>=20
> Remove all the hardcoded values and replace with generalized
> fields.
>=20
> Refer the Processor Programming Reference (PPR) documentation
> available from the bugzilla Link below.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |  195 ++++++++++++-----------------------------------=
------
>  1 file changed, 45 insertions(+), 150 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d434c8545a..ada9ec8f3a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -338,62 +338,6 @@ static void encode_cache_cpuid80000006(CPUCacheInfo =
*l2,
>      }
>  }
> =20
> -/*
> - * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
> - * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual Vo=
lume 3.
> - * Define the constants to build the cpu topology. Right now, TOPOEXT
> - * feature is enabled only on EPYC. So, these constants are based on
> - * EPYC supported configurations. We may need to handle the cases if
> - * these values change in future.
> - */
> -/* Maximum core complexes in a node */
> -#define MAX_CCX 2
> -/* Maximum cores in a core complex */
> -#define MAX_CORES_IN_CCX 4
> -/* Maximum cores in a node */
> -#define MAX_CORES_IN_NODE 8
> -/* Maximum nodes in a socket */
> -#define MAX_NODES_PER_SOCKET 4
> -
> -/*
> - * Figure out the number of nodes required to build this config.
> - * Max cores in a node is 8
> - */
> -static int nodes_in_socket(int nr_cores)
> -{
> -    int nodes;
> -
> -    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
> -
> -   /* Hardware does not support config with 3 nodes, return 4 in that ca=
se */
> -    return (nodes =3D=3D 3) ? 4 : nodes;
> -}
> -
> -/*
> - * Decide the number of cores in a core complex with the given nr_cores =
using
> - * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE =
and
> - * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
> - * L3 cache is shared across all cores in a core complex. So, this will =
also
> - * tell us how many cores are sharing the L3 cache.
> - */
> -static int cores_in_core_complex(int nr_cores)
> -{
> -    int nodes;
> -
> -    /* Check if we can fit all the cores in one core complex */
> -    if (nr_cores <=3D MAX_CORES_IN_CCX) {
> -        return nr_cores;
> -    }
> -    /* Get the number of nodes required to build this config */
> -    nodes =3D nodes_in_socket(nr_cores);
> -
> -    /*
> -     * Divide the cores accros all the core complexes
> -     * Return rounded up value
> -     */
> -    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
> -}
> -
>  /* Encode cache info for CPUID[8000001D] */
>  static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                         X86CPUTopoInfo *topo_info,
> @@ -434,107 +378,58 @@ static void encode_cache_cpuid8000001d(CPUCacheInf=
o *cache,
>             (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
>  }
> =20
> -/* Data structure to hold the configuration info for a given core index =
*/
> -struct core_topology {
> -    /* core complex id of the current core index */
> -    int ccx_id;
> -    /*
> -     * Adjusted core index for this core in the topology
> -     * This can be 0,1,2,3 with max 4 cores in a core complex
> -     */
> -    int core_id;
> -    /* Node id for this core index */
> -    int node_id;
> -    /* Number of nodes in this config */
> -    int num_nodes;
> -};
> -
> -/*
> - * Build the configuration closely match the EPYC hardware. Using the EP=
YC
> - * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_I=
N_NODE)
> - * right now. This could change in future.
> - * nr_cores : Total number of cores in the config
> - * core_id  : Core index of the current CPU
> - * topo     : Data structure to hold all the config info for this core i=
ndex
> - */
> -static void build_core_topology(int nr_cores, int core_id,
> -                                struct core_topology *topo)
> -{
> -    int nodes, cores_in_ccx;
> -
> -    /* First get the number of nodes required */
> -    nodes =3D nodes_in_socket(nr_cores);
> -
> -    cores_in_ccx =3D cores_in_core_complex(nr_cores);
> -
> -    topo->node_id =3D core_id / (cores_in_ccx * MAX_CCX);
> -    topo->ccx_id =3D (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx=
;
> -    topo->core_id =3D core_id % cores_in_ccx;
> -    topo->num_nodes =3D nodes;
> -}
> -
>  /* Encode cache info for CPUID[8000001E] */
> -static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
> -                                       uint32_t *eax, uint32_t *ebx,
> -                                       uint32_t *ecx, uint32_t *edx)
> +static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_=
info,
> +                                      uint32_t *eax, uint32_t *ebx,
> +                                      uint32_t *ecx, uint32_t *edx)
>  {
> -    struct core_topology topo =3D {0};
> -    unsigned long nodes;
> -    int shift;
> +    X86CPUTopoIDs topo_ids;
> +
> +    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
> =20
> -    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
>      *eax =3D cpu->apic_id;
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
> -    if (cs->nr_threads - 1) {
> -        *ebx =3D ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
> -                (topo.ccx_id << 2) | topo.core_id;
> -    } else {
> -        *ebx =3D (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id=
;
> -    }
> +    *ebx =3D ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_i=
d & 0xFF);
> +
>      /*
> -     * CPUID_Fn8000001E_ECX
> -     * 31:11 Reserved
> -     * 10:8  Nodes per processor (Nodes per processor is number of nodes=
 + 1)
> -     *  7:0  Node id (see bit decoding below)
> -     *         2  Socket id
> -     *       1:0  Node id
> +     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
> +     * Read-only. Reset: 0000_0XXXh.
> +     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
> +     * Bits Description
> +     * 31:11 Reserved.
> +     * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXX=
b.
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
> +     * NodeId is combination of node and socket_id which is already deco=
ded
> +     * in apic_id. Just use it by shifting.
>       */
> -    if (topo.num_nodes <=3D 4) {
> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
> -                topo.node_id;
> -    } else {
> -        /*
> -         * Node id fix up. Actual hardware supports up to 4 nodes. But w=
ith
> -         * more than 32 cores, we may end up with more than 4 nodes.
> -         * Node id is a combination of socket id and node id. Only requi=
rement
> -         * here is that this number should be unique accross the system.
> -         * Shift the socket id to accommodate more nodes. We dont expect=
 both
> -         * socket id and node id to be big number at the same time. This=
 is not
> -         * an ideal config but we need to to support it. Max nodes we ca=
n have
> -         * is 32 (255/8) with 8 cores per node and 255 max cores. We onl=
y need
> -         * 5 bits for nodes. Find the left most set bit to represent the=
 total
> -         * number of nodes. find_last_bit returns last set bit(0 based).=
 Left
> -         * shift(+1) the socket id to represent all the nodes.
> -         */
> -        nodes =3D topo.num_nodes - 1;
> -        shift =3D find_last_bit(&nodes, 8);
> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift=
 + 1)) |
> -                topo.node_id;
> -    }
> +    *ecx =3D ((topo_info->dies_per_pkg - 1) << 8) |
> +           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
> +
>      *edx =3D 0;
>  }
> =20
> @@ -6019,7 +5914,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>          break;
>      case 0x8000001E:
>          assert(cpu->core_id <=3D 255);
> -        encode_topo_cpuid8000001e(cs, cpu,
> +        encode_topo_cpuid8000001e(cpu, &topo_info,
>                                    eax, ebx, ecx, edx);
>          break;
>      case 0xC0000000:
>=20
>=20


