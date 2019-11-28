Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49762C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040E7217C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUeYWdfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E7217C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIkp-0000rl-6Y
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaIK1-0003C9-Bz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaIJv-0002wc-DR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:50:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaIJt-0002r4-8J
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574941846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NizEGbAFAi3VhI97iMxJ2eH+YtNyfqrY8DW9gj6hGE=;
 b=aUeYWdfdDJD6UXd/kK4rN4NcdDgpL/lPzwy1xKUGebOx26vOXSq6AucCsqIUQmMRYG3D8W
 Le791DEF58ZzjqQHWA2AR45b4TWzn2+V866SJ+2cXcJ61D9OY88XgQlNxGuw4V3wGK+obh
 sZVVprMaDrhky3wjas/SO1H60e98yYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-NmoAfbIgPsWHOduzSbm03g-1; Thu, 28 Nov 2019 06:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CB580257F;
 Thu, 28 Nov 2019 11:50:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24DDB19C4F;
 Thu, 28 Nov 2019 11:50:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7C3B1138606; Thu, 28 Nov 2019 12:50:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v19 3/8] numa: Extend CLI to provide memory side cache
 information
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-4-tao3.xu@intel.com>
Date: Thu, 28 Nov 2019 12:50:36 +0100
In-Reply-To: <20191128082109.30081-4-tao3.xu@intel.com> (Tao Xu's message of
 "Thu, 28 Nov 2019 16:21:04 +0800")
Message-ID: <87mucgnrsj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NmoAfbIgPsWHOduzSbm03g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> From: Liu Jingqi <jingqi.liu@intel.com>
>
> Add -numa hmat-cache option to provide Memory Side Cache Information.
> These memory attributes help to build Memory Side Cache Information
> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
> Before using hmat-cache option, enable HMAT with -machine hmat=3Don.
>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>
> Changes in v19:
>     - Add description about the machine property 'hmat' in commit
>       message (Markus)
>     - Update the QAPI comments
>     - Add a check for no memory side cache
>
> Changes in v18:
>     - Update the error message (Igor)
>
> Changes in v17:
>     - Use NumaHmatCacheOptions to replace HMAT_Cache_Info (Igor)
>     - Add check for unordered cache level input (Igor)
>
> Changes in v16:
>     - Add cross check with hmat_lb data (Igor)
>     - Drop total_levels in struct HMAT_Cache_Info (Igor)
>     - Correct the error table number (Igor)
>
> Changes in v15:
>     - Change the QAPI version tag to 5.0 (Eric)
> ---
>  hw/core/numa.c        | 86 +++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/numa.h |  5 +++
>  qapi/machine.json     | 81 +++++++++++++++++++++++++++++++++++++++-
>  qemu-options.hx       | 16 +++++++-
>  4 files changed, 184 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 2183c8df1f..664b44ad68 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -366,6 +366,79 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaH=
matLBOptions *node,
>      g_array_append_val(hmat_lb->list, lb_data);
>  }
> =20
> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> +                           Error **errp)
> +{
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> +    NodeInfo *numa_info =3D ms->numa_state->nodes;
> +    NumaHmatCacheOptions *hmat_cache =3D NULL;
> +
> +    if (node->node_id >=3D nb_numa_nodes) {
> +        error_setg(errp, "Invalid node-id=3D%" PRIu32 ", it should be le=
ss "
> +                   "than %d", node->node_id, nb_numa_nodes);
> +        return;
> +    }
> +
> +    if (numa_info[node->node_id].lb_info_provided !=3D (BIT(0) | BIT(1))=
) {
> +        error_setg(errp, "The latency and bandwidth information of "
> +                   "node-id=3D%" PRIu32 " should be provided before memo=
ry side "
> +                   "cache attributes", node->node_id);
> +        return;
> +    }
> +
> +    if (node->level >=3D HMAT_LB_LEVELS) {
> +        error_setg(errp, "Invalid level=3D%" PRIu8 ", it should be less =
than or "
> +                   "equal to %d", node->level, HMAT_LB_LEVELS - 1);
> +        return;
> +    }
> +
> +    if (!node->level && (node->assoc || node->policy || node->line)) {
> +        error_setg(errp, "Assoc and policy options should be 'none', lin=
e "
> +                   "should be 0. If cache level is 0, which means no mem=
ory "
> +                   "side cache in node-id=3D%" PRIu32, node->node_id);

Error messages should be a phrase, not a paragraph; see error_setg()'s
function comment.  I think you want something like "be 0 when cache
level is 0".

I'm not sure the error message should explain what level 0 means, but
I'm happy to defer to the NUMA maintainers there.

> +        return;
> +    }
> +
> +    assert(node->assoc < HMAT_CACHE_ASSOCIATIVITY__MAX);
> +    assert(node->policy < HMAT_CACHE_WRITE_POLICY__MAX);
> +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> +        error_setg(errp, "Duplicate configuration of the side cache for =
"
> +                   "node-id=3D%" PRIu32 " and level=3D%" PRIu8,
> +                   node->node_id, node->level);
> +        return;
> +    }
> +
> +    if ((node->level > 1) &&
> +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> +        (node->size >=3D
> +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->=
size)) {
> +        error_setg(errp, "Invalid size=3D%" PRIu64 ", the size of level=
=3D%" PRIu8
> +                   " should be less than the size(%" PRIu64 ") of "
> +                   "level=3D%" PRIu8, node->size, node->level,
> +                   ms->numa_state->hmat_cache[node->node_id]
> +                                             [node->level - 1]->size,
> +                   node->level - 1);
> +        return;
> +    }
> +
> +    if ((node->level < HMAT_LB_LEVELS - 1) &&
> +        ms->numa_state->hmat_cache[node->node_id][node->level + 1] &&
> +        (node->size <=3D
> +            ms->numa_state->hmat_cache[node->node_id][node->level + 1]->=
size)) {
> +        error_setg(errp, "Invalid size=3D%" PRIu64 ", the size of level=
=3D%" PRIu8
> +                   " should be larger than the size(%" PRIu64 ") of "
> +                   "level=3D%" PRIu8, node->size, node->level,
> +                   ms->numa_state->hmat_cache[node->node_id]
> +                                             [node->level + 1]->size,
> +                   node->level + 1);
> +        return;
> +    }
> +
> +    hmat_cache =3D g_malloc0(sizeof(*hmat_cache));
> +    memcpy(hmat_cache, node, sizeof(*hmat_cache));
> +    ms->numa_state->hmat_cache[node->node_id][node->level] =3D hmat_cach=
e;
> +}
> +
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
>  {
>      Error *err =3D NULL;
> @@ -417,6 +490,19 @@ void set_numa_options(MachineState *ms, NumaOptions =
*object, Error **errp)
>              goto end;
>          }
>          break;
> +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
> +        if (!ms->numa_state->hmat_enabled) {
> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table =
"
> +                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
> +                       "before using any of hmat specific options");
> +            return;
> +        }
> +
> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 70f93c83d7..ba693cc80b 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -91,6 +91,9 @@ struct NumaState {
> =20
>      /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
>      HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
> +
> +    /* Memory Side Cache Information Structure */
> +    NumaHmatCacheOptions *hmat_cache[MAX_NODES][HMAT_LB_LEVELS];
>  };
>  typedef struct NumaState NumaState;
> =20
> @@ -98,6 +101,8 @@ void set_numa_options(MachineState *ms, NumaOptions *o=
bject, Error **errp);
>  void parse_numa_opts(MachineState *ms);
>  void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
>                          Error **errp);
> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> +                           Error **errp);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
>  extern QemuOptsList qemu_numa_opts;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index cf9851fcd1..997e8af1b1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -428,10 +428,12 @@
>  #
>  # @hmat-lb: memory latency and bandwidth information (Since: 5.0)
>  #
> +# @hmat-cache: memory side cache information (Since: 5.0)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -447,7 +449,8 @@
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
>      'cpu': 'NumaCpuOptions',
> -    'hmat-lb': 'NumaHmatLBOptions' }}
> +    'hmat-lb': 'NumaHmatLBOptions',
> +    'hmat-cache': 'NumaHmatCacheOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -646,6 +649,80 @@
>      '*latency': 'uint64',
>      '*bandwidth': 'size' }}
> =20
> +##
> +# @HmatCacheAssociativity:
> +#
> +# Cache associativity in the Memory Side Cache Information Structure
> +# of HMAT
> +#
> +# For more information of @HmatCacheAssociativity see chapter

@HmatCacheAssociativity, see

> +# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
> +#
> +# @none: None (no memory side cache in this proximity domain,
> +#              or cache associativity unknown)
> +#
> +# @direct: Direct Mapped
> +#
> +# @complex: Complex Cache Indexing (implementation specific)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatCacheAssociativity',
> +  'data': [ 'none', 'direct', 'complex' ] }
> +
> +##
> +# @HmatCacheWritePolicy:
> +#
> +# Cache write policy in the Memory Side Cache Information Structure
> +# of HMAT
> +#
> +# For more information of @HmatCacheWritePolicy see chapter

@HmatCacheWritePolicy, see

> +# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
> +#
> +# @none: None (no memory side cache in this proximity domain,
> +#              or cache write policy unknown)
> +#
> +# @write-back: Write Back (WB)
> +#
> +# @write-through: Write Through (WT)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatCacheWritePolicy',
> +  'data': [ 'none', 'write-back', 'write-through' ] }
> +
> +##
> +# @NumaHmatCacheOptions:
> +#
> +# Set the memory side cache information for a given memory domain.
> +#
> +# For more information of @NumaHmatCacheOptions see chapter

@NumaHmatCacheOptions, see

> +# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
> +#
> +# @node-id: the memory proximity domain to which the memory belongs.
> +#
> +# @size: the size of memory side cache in bytes.
> +#
> +# @level: the cache level described in this structure.
> +#
> +# @assoc: the cache associativity,
> +#         none/direct-mapped/complex(complex cache indexing).

QAPI tends to spell out things, i.e. @associativity instead of @assoc.
We're not 100% consistent, though.

> +#
> +# @policy: the write policy, none/write-back/write-through.
> +#
> +# @line: the cache Line size in bytes.
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'NumaHmatCacheOptions',
> +  'data': {
> +   'node-id': 'uint32',
> +   'size': 'size',
> +   'level': 'uint8',
> +   'assoc': 'HmatCacheAssociativity',
> +   'policy': 'HmatCacheWritePolicy',
> +   'line': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 23303fc7d7..449829ef15 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -169,7 +169,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
>      "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> -    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n"
> +    "-numa hmat-cache,node-id=3Dnode,size=3Dsize,level=3Dlevel[,assoc=3D=
none|direct|complex][,policy=3Dnone|write-back|write-through][,line=3Dsize]=
\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
> @@ -177,6 +178,7 @@ STEXI
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
>  @itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarch=
y=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
> +@itemx -numa hmat-cache,node-id=3D@var{node},size=3D@var{size},level=3D@=
var{level}[,assoc=3D@var{str}][,policy=3D@var{str}][,line=3D@var{size}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> @@ -281,11 +283,19 @@ And if input bandwidth value without any unit, the =
unit will be byte per second.
>  Note that if latency or bandwidth value is 0, means the corresponding la=
tency or
>  bandwidth information is not provided.
> =20
> +In @samp{hmat-cache} option, @var{node-id} is the NUMA-id of the memory =
belongs.
> +@var{size} is the size of memory side cache in bytes. @var{level} is the=
 cache
> +level described in this structure. @var{assoc} is the cache associativit=
y,
> +the possible value is 'none/direct(direct-mapped)/complex(complex cache =
indexing)'.
> +@var{policy} is the write policy. @var{line} is the cache Line size in b=
ytes.
> +
>  For example, the following options describe 2 NUMA nodes. Node 0 has 2 c=
pus and
>  a ram, node 1 has only a ram. The processors in node 0 access memory in =
node
>  0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
>  The processors in NUMA node 0 access memory in NUMA node 1 with access-l=
atency 10
>  nanoseconds, access-bandwidth is 100 MB/s.
> +And for memory side cache information, NUMA node 0 and 1 both have 1 lev=
el memory
> +cache, size is 10KB, policy is write-back, the cache Line size is 8 byte=
s:
>  @example
>  -machine hmat=3Don \
>  -m 2G \
> @@ -299,7 +309,9 @@ nanoseconds, access-bandwidth is 100 MB/s.
>  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D5 \
>  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D200M \
>  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D10 \
> --numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M \
> +-numa hmat-cache,node-id=3D0,size=3D10K,level=3D1,assoc=3Ddirect,policy=
=3Dwrite-back,line=3D8 \
> +-numa hmat-cache,node-id=3D1,size=3D10K,level=3D1,assoc=3Ddirect,policy=
=3Dwrite-back,line=3D8
>  @end example
> =20
>  ETEXI


