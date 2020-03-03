Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA18C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A35E215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqgRxQOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A35E215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93Dj-0001IO-8v
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j93D3-0000ne-EX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j93D1-0000Kh-53
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:47:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j93D1-0000K5-0r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583225241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+9zzpyZ60xDHbLLNYdjNTojEknjhVNLIs4useOpsIA=;
 b=RqgRxQObnIsOBbP3txECncO89bcs9evKPBXSC1zzMKANiGFN5KjvLsJ5N/28CETBYMSTtL
 D8UyyExns+ghMrd7wPnenfMWkZ2z8CAIqXzaKowiU7/Kh2eSUypAHztjFP6/WMxHLDRVNC
 h3BYkAcP1zwTpKkPYplfhuDDh+cVIiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-0N1oW_MBP_GgvenCrNXABg-1; Tue, 03 Mar 2020 03:47:20 -0500
X-MC-Unique: 0N1oW_MBP_GgvenCrNXABg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3EA13E2;
 Tue,  3 Mar 2020 08:47:19 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EDE327185;
 Tue,  3 Mar 2020 08:47:14 +0000 (UTC)
Date: Tue, 3 Mar 2020 09:47:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 09/16] target/i386: Cleanup and use the EPYC mode
 topology functions
Message-ID: <20200303094713.6540e759@redhat.com>
In-Reply-To: <ad7ed52b-0b7b-06e5-3a01-474b304835a4@amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161784564.48948.10610888499052239029.stgit@naples-babu.amd.com>
 <20200224095253.17fb9852@redhat.com>
 <85bb2603-115a-1df2-df5d-887faae66bbe@amd.com>
 <20200225084905.11b9731d@redhat.com>
 <ad7ed52b-0b7b-06e5-3a01-474b304835a4@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Mon, 2 Mar 2020 11:09:14 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/25/20 1:49 AM, Igor Mammedov wrote:
> > On Mon, 24 Feb 2020 11:29:37 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> On 2/24/20 2:52 AM, Igor Mammedov wrote: =20
> >>> On Thu, 13 Feb 2020 12:17:25 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>    =20
> >>>> Use the new functions from topology.h and delete the unused code. Gi=
ven the
> >>>> sockets, nodes, cores and threads, the new functions generate apic i=
d for EPYC
> >>>> mode. Removes all the hardcoded values.
> >>>>
> >>>> Signed-off-by: Babu Moger <babu.moger@amd.com>   =20
> >>>
> >>> modulo MAX() macro, looks fine to me   =20
> >>
> >> Igor, Sorry. What do you mean here? =20
> >=20
> > I meant s/MAX(topo_info->nodes_per_pkg, 1)/topo_info->nodes_per_pkg/
> >=20
> > after it's made sure that topo_info->nodes_per_pkg is always valid.
> >  =20
> Noticed that we cannot change it in all the places and assign to valid
> value 1. We need this information to know weather the system is numa
> configured in topology.h. This is similar to ms->numa_state->num_nodes.
> This value is  > 0 if system is numa configured else it is 0. I need this
> information while generating the apicid. I have added comments about it i=
n
> topology.h. Hope this is not a problem.

It should be fine as far as that's the only and best way to handle it
and it's clear from patches why it's done this way.

> >=20
> > (I believe I've commented on that somewhere. Series isn't split nicely,
> > so I've ended up applying it all and then reviewing so comments might
> > look out of the place sometimes, hopefully next revision will be easier
> > to review)
> >  =20
> >>>    =20
> >>>> ---
> >>>>  target/i386/cpu.c |  162 +++++++++++-------------------------------=
-----------
> >>>>  1 file changed, 35 insertions(+), 127 deletions(-)
> >>>>
> >>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >>>> index 5d6edfd09b..19675eb696 100644
> >>>> --- a/target/i386/cpu.c
> >>>> +++ b/target/i386/cpu.c
> >>>> @@ -338,68 +338,15 @@ static void encode_cache_cpuid80000006(CPUCach=
eInfo *l2,
> >>>>      }
> >>>>  }
> >>>> =20
> >>>> -/*
> >>>> - * Definitions used for building CPUID Leaf 0x8000001D and 0x800000=
1E
> >>>> - * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manu=
al Volume 3.
> >>>> - * Define the constants to build the cpu topology. Right now, TOPOE=
XT
> >>>> - * feature is enabled only on EPYC. So, these constants are based o=
n
> >>>> - * EPYC supported configurations. We may need to handle the cases i=
f
> >>>> - * these values change in future.
> >>>> - */
> >>>> -/* Maximum core complexes in a node */
> >>>> -#define MAX_CCX 2
> >>>> -/* Maximum cores in a core complex */
> >>>> -#define MAX_CORES_IN_CCX 4
> >>>> -/* Maximum cores in a node */
> >>>> -#define MAX_CORES_IN_NODE 8
> >>>> -/* Maximum nodes in a socket */
> >>>> -#define MAX_NODES_PER_SOCKET 4
> >>>> -
> >>>> -/*
> >>>> - * Figure out the number of nodes required to build this config.
> >>>> - * Max cores in a node is 8
> >>>> - */
> >>>> -static int nodes_in_socket(int nr_cores)
> >>>> -{
> >>>> -    int nodes;
> >>>> -
> >>>> -    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
> >>>> -
> >>>> -   /* Hardware does not support config with 3 nodes, return 4 in th=
at case */
> >>>> -    return (nodes =3D=3D 3) ? 4 : nodes;
> >>>> -}
> >>>> -
> >>>> -/*
> >>>> - * Decide the number of cores in a core complex with the given nr_c=
ores using
> >>>> - * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_=
NODE and
> >>>> - * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
> >>>> - * L3 cache is shared across all cores in a core complex. So, this =
will also
> >>>> - * tell us how many cores are sharing the L3 cache.
> >>>> - */
> >>>> -static int cores_in_core_complex(int nr_cores)
> >>>> -{
> >>>> -    int nodes;
> >>>> -
> >>>> -    /* Check if we can fit all the cores in one core complex */
> >>>> -    if (nr_cores <=3D MAX_CORES_IN_CCX) {
> >>>> -        return nr_cores;
> >>>> -    }
> >>>> -    /* Get the number of nodes required to build this config */
> >>>> -    nodes =3D nodes_in_socket(nr_cores);
> >>>> -
> >>>> -    /*
> >>>> -     * Divide the cores accros all the core complexes
> >>>> -     * Return rounded up value
> >>>> -     */
> >>>> -    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
> >>>> -}
> >>>> -
> >>>>  /* Encode cache info for CPUID[8000001D] */
> >>>> -static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUStat=
e *cs,
> >>>> -                                uint32_t *eax, uint32_t *ebx,
> >>>> -                                uint32_t *ecx, uint32_t *edx)
> >>>> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >>>> +                                       X86CPUTopoInfo *topo_info,
> >>>> +                                       uint32_t *eax, uint32_t *ebx=
,
> >>>> +                                       uint32_t *ecx, uint32_t *edx=
)
> >>>>  {
> >>>>      uint32_t l3_cores;
> >>>> +    unsigned nodes =3D MAX(topo_info->nodes_per_pkg, 1);
> >>>> +
> >>>>      assert(cache->size =3D=3D cache->line_size * cache->associativi=
ty *
> >>>>                            cache->partitions * cache->sets);
> >>>> =20
> >>>> @@ -408,10 +355,13 @@ static void encode_cache_cpuid8000001d(CPUCach=
eInfo *cache, CPUState *cs,
> >>>> =20
> >>>>      /* L3 is shared among multiple cores */
> >>>>      if (cache->level =3D=3D 3) {
> >>>> -        l3_cores =3D cores_in_core_complex(cs->nr_cores);
> >>>> -        *eax |=3D ((l3_cores * cs->nr_threads) - 1) << 14;
> >>>> +        l3_cores =3D DIV_ROUND_UP((topo_info->dies_per_pkg *
> >>>> +                                 topo_info->cores_per_die *
> >>>> +                                 topo_info->threads_per_core),
> >>>> +                                 nodes);
> >>>> +        *eax |=3D (l3_cores - 1) << 14;
> >>>>      } else {
> >>>> -        *eax |=3D ((cs->nr_threads - 1) << 14);
> >>>> +        *eax |=3D ((topo_info->threads_per_core - 1) << 14);
> >>>>      }
> >>>> =20
> >>>>      assert(cache->line_size > 0);
> >>>> @@ -431,55 +381,17 @@ static void encode_cache_cpuid8000001d(CPUCach=
eInfo *cache, CPUState *cs,
> >>>>             (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
> >>>>  }
> >>>> =20
> >>>> -/* Data structure to hold the configuration info for a given core i=
ndex */
> >>>> -struct core_topology {
> >>>> -    /* core complex id of the current core index */
> >>>> -    int ccx_id;
> >>>> -    /*
> >>>> -     * Adjusted core index for this core in the topology
> >>>> -     * This can be 0,1,2,3 with max 4 cores in a core complex
> >>>> -     */
> >>>> -    int core_id;
> >>>> -    /* Node id for this core index */
> >>>> -    int node_id;
> >>>> -    /* Number of nodes in this config */
> >>>> -    int num_nodes;
> >>>> -};
> >>>> -
> >>>> -/*
> >>>> - * Build the configuration closely match the EPYC hardware. Using t=
he EPYC
> >>>> - * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CO=
RES_IN_NODE)
> >>>> - * right now. This could change in future.
> >>>> - * nr_cores : Total number of cores in the config
> >>>> - * core_id  : Core index of the current CPU
> >>>> - * topo     : Data structure to hold all the config info for this c=
ore index
> >>>> - */
> >>>> -static void build_core_topology(int nr_cores, int core_id,
> >>>> -                                struct core_topology *topo)
> >>>> -{
> >>>> -    int nodes, cores_in_ccx;
> >>>> -
> >>>> -    /* First get the number of nodes required */
> >>>> -    nodes =3D nodes_in_socket(nr_cores);
> >>>> -
> >>>> -    cores_in_ccx =3D cores_in_core_complex(nr_cores);
> >>>> -
> >>>> -    topo->node_id =3D core_id / (cores_in_ccx * MAX_CCX);
> >>>> -    topo->ccx_id =3D (core_id % (cores_in_ccx * MAX_CCX)) / cores_i=
n_ccx;
> >>>> -    topo->core_id =3D core_id % cores_in_ccx;
> >>>> -    topo->num_nodes =3D nodes;
> >>>> -}
> >>>> -
> >>>>  /* Encode cache info for CPUID[8000001E] */
> >>>> -static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
> >>>> +static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X8=
6CPU *cpu,
> >>>>                                         uint32_t *eax, uint32_t *ebx=
,
> >>>>                                         uint32_t *ecx, uint32_t *edx=
)
> >>>>  {
> >>>> -    struct core_topology topo =3D {0};
> >>>> -    unsigned long nodes;
> >>>> +    X86CPUTopoIDs topo_ids =3D {0};
> >>>> +    unsigned long nodes =3D MAX(topo_info->nodes_per_pkg, 1);
> >>>>      int shift;
> >>>> =20
> >>>> -    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
> >>>> +    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_id=
s);
> >>>> +
> >>>>      *eax =3D cpu->apic_id;
> >>>>      /*
> >>>>       * CPUID_Fn8000001E_EBX
> >>>> @@ -496,12 +408,8 @@ static void encode_topo_cpuid8000001e(CPUState =
*cs, X86CPU *cpu,
> >>>>       *             3 Core complex id
> >>>>       *           1:0 Core id
> >>>>       */
> >>>> -    if (cs->nr_threads - 1) {
> >>>> -        *ebx =3D ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) =
|
> >>>> -                (topo.ccx_id << 2) | topo.core_id;
> >>>> -    } else {
> >>>> -        *ebx =3D (topo.node_id << 4) | (topo.ccx_id << 3) | topo.co=
re_id;
> >>>> -    }
> >>>> +    *ebx =3D ((topo_info->threads_per_core - 1) << 8) | (topo_ids.n=
ode_id << 3) |
> >>>> +            (topo_ids.core_id);
> >>>>      /*
> >>>>       * CPUID_Fn8000001E_ECX
> >>>>       * 31:11 Reserved
> >>>> @@ -510,9 +418,9 @@ static void encode_topo_cpuid8000001e(CPUState *=
cs, X86CPU *cpu,
> >>>>       *         2  Socket id
> >>>>       *       1:0  Node id
> >>>>       */
> >>>> -    if (topo.num_nodes <=3D 4) {
> >>>> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2=
) |
> >>>> -                topo.node_id;
> >>>> +
> >>>> +    if (nodes <=3D 4) {
> >>>> +        *ecx =3D ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo=
_ids.node_id;
> >>>>      } else {
> >>>>          /*
> >>>>           * Node id fix up. Actual hardware supports up to 4 nodes. =
But with
> >>>> @@ -527,10 +435,10 @@ static void encode_topo_cpuid8000001e(CPUState=
 *cs, X86CPU *cpu,
> >>>>           * number of nodes. find_last_bit returns last set bit(0 ba=
sed). Left
> >>>>           * shift(+1) the socket id to represent all the nodes.
> >>>>           */
> >>>> -        nodes =3D topo.num_nodes - 1;
> >>>> +        nodes -=3D 1;
> >>>>          shift =3D find_last_bit(&nodes, 8);
> >>>> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (=
shift + 1)) |
> >>>> -                topo.node_id;
> >>>> +        *ecx =3D (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
> >>>> +               topo_ids.node_id;
> >>>>      }
> >>>>      *edx =3D 0;
> >>>>  }
> >>>> @@ -5318,6 +5226,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t =
index, uint32_t count,
> >>>>      uint32_t signature[3];
> >>>>      X86CPUTopoInfo topo_info;
> >>>> =20
> >>>> +    topo_info.nodes_per_pkg =3D env->nr_nodes;
> >>>>      topo_info.dies_per_pkg =3D env->nr_dies;
> >>>>      topo_info.cores_per_die =3D cs->nr_cores;
> >>>>      topo_info.threads_per_core =3D cs->nr_threads;
> >>>> @@ -5737,20 +5646,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_=
t index, uint32_t count,
> >>>>          }
> >>>>          switch (count) {
> >>>>          case 0: /* L1 dcache info */
> >>>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cach=
e, cs,
> >>>> -                                       eax, ebx, ecx, edx);
> >>>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cach=
e,
> >>>> +                                       &topo_info, eax, ebx, ecx, e=
dx);
> >>>>              break;
> >>>>          case 1: /* L1 icache info */
> >>>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cach=
e, cs,
> >>>> -                                       eax, ebx, ecx, edx);
> >>>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cach=
e,
> >>>> +                                       &topo_info, eax, ebx, ecx, e=
dx);
> >>>>              break;
> >>>>          case 2: /* L2 cache info */
> >>>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache=
, cs,
> >>>> -                                       eax, ebx, ecx, edx);
> >>>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache=
,
> >>>> +                                       &topo_info, eax, ebx, ecx, e=
dx);
> >>>>              break;
> >>>>          case 3: /* L3 cache info */
> >>>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache=
, cs,
> >>>> -                                       eax, ebx, ecx, edx);
> >>>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache=
,
> >>>> +                                       &topo_info, eax, ebx, ecx, e=
dx);
> >>>>              break;
> >>>>          default: /* end of info */
> >>>>              *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
> >>>> @@ -5759,8 +5668,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t =
index, uint32_t count,
> >>>>          break;
> >>>>      case 0x8000001E:
> >>>>          assert(cpu->core_id <=3D 255);
> >>>> -        encode_topo_cpuid8000001e(cs, cpu,
> >>>> -                                  eax, ebx, ecx, edx);
> >>>> +        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, e=
dx);
> >>>>          break;
> >>>>      case 0xC0000000:
> >>>>          *eax =3D env->cpuid_xlevel2;
> >>>>   =20
> >>>    =20
> >> =20
> >  =20
>=20


