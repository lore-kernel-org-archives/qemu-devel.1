Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF11C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B781208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWdzxB2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B781208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaL5f-0003Ik-5r
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iaKIo-0001e2-Mc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iaKIe-0000S7-7w
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:57:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iaKIa-0008TU-8k
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574949449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6z9y+MQMPTcM3B7umrC0IvrNTds2+d9cZDf10oJ+oS0=;
 b=UWdzxB2d+3yakKL+A3HtUO34O6xqA8dIK7Qr9FsZsFDs36ic99+ZYfar4Vfc+Ri8chn/Qn
 gRu2wpm7f86W7+/0jfogVBz0NF++vkVaDR5aJSCwZRBoDs1dCDc7J1tcF1nqkGqdvRzd2c
 aYSdrubGZmUFkmcdVcLniCT/UOvS5vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-iQwRTX3YO_ySrxZEQE_dAQ-1; Thu, 28 Nov 2019 08:57:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 495618017D9;
 Thu, 28 Nov 2019 13:57:24 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1254F5C1B0;
 Thu, 28 Nov 2019 13:57:15 +0000 (UTC)
Date: Thu, 28 Nov 2019 14:57:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v19 3/8] numa: Extend CLI to provide memory side cache
 information
Message-ID: <20191128145714.1be7ede8@redhat.com>
In-Reply-To: <87mucgnrsj.fsf@dusky.pond.sub.org>
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-4-tao3.xu@intel.com>
 <87mucgnrsj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iQwRTX3YO_ySrxZEQE_dAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 jonathan.cameron@huawei.com, sw@weilnetz.de, Tao Xu <tao3.xu@intel.com>,
 fan.du@intel.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 12:50:36 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Tao Xu <tao3.xu@intel.com> writes:
> 
> > From: Liu Jingqi <jingqi.liu@intel.com>
> >
> > Add -numa hmat-cache option to provide Memory Side Cache Information.
> > These memory attributes help to build Memory Side Cache Information
> > Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
> > Before using hmat-cache option, enable HMAT with -machine hmat=on.
> >
> > Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > ---
> >
> > Changes in v19:
> >     - Add description about the machine property 'hmat' in commit
> >       message (Markus)
> >     - Update the QAPI comments
> >     - Add a check for no memory side cache
> >
> > Changes in v18:
> >     - Update the error message (Igor)
> >
> > Changes in v17:
> >     - Use NumaHmatCacheOptions to replace HMAT_Cache_Info (Igor)
> >     - Add check for unordered cache level input (Igor)
> >
> > Changes in v16:
> >     - Add cross check with hmat_lb data (Igor)
> >     - Drop total_levels in struct HMAT_Cache_Info (Igor)
> >     - Correct the error table number (Igor)
> >
> > Changes in v15:
> >     - Change the QAPI version tag to 5.0 (Eric)
> > ---
> >  hw/core/numa.c        | 86 +++++++++++++++++++++++++++++++++++++++++++
> >  include/sysemu/numa.h |  5 +++
> >  qapi/machine.json     | 81 +++++++++++++++++++++++++++++++++++++++-
> >  qemu-options.hx       | 16 +++++++-
> >  4 files changed, 184 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > index 2183c8df1f..664b44ad68 100644
> > --- a/hw/core/numa.c
> > +++ b/hw/core/numa.c
> > @@ -366,6 +366,79 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
> >      g_array_append_val(hmat_lb->list, lb_data);
> >  }
> >  
> > +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> > +                           Error **errp)
> > +{
> > +    int nb_numa_nodes = ms->numa_state->num_nodes;
> > +    NodeInfo *numa_info = ms->numa_state->nodes;
> > +    NumaHmatCacheOptions *hmat_cache = NULL;
> > +
> > +    if (node->node_id >= nb_numa_nodes) {
> > +        error_setg(errp, "Invalid node-id=%" PRIu32 ", it should be less "
> > +                   "than %d", node->node_id, nb_numa_nodes);
> > +        return;
> > +    }
> > +
> > +    if (numa_info[node->node_id].lb_info_provided != (BIT(0) | BIT(1))) {
> > +        error_setg(errp, "The latency and bandwidth information of "
> > +                   "node-id=%" PRIu32 " should be provided before memory side "
> > +                   "cache attributes", node->node_id);
> > +        return;
> > +    }
> > +
> > +    if (node->level >= HMAT_LB_LEVELS) {
> > +        error_setg(errp, "Invalid level=%" PRIu8 ", it should be less than or "
> > +                   "equal to %d", node->level, HMAT_LB_LEVELS - 1);
> > +        return;
> > +    }
> > +
> > +    if (!node->level && (node->assoc || node->policy || node->line)) {
> > +        error_setg(errp, "Assoc and policy options should be 'none', line "
> > +                   "should be 0. If cache level is 0, which means no memory "
> > +                   "side cache in node-id=%" PRIu32, node->node_id);


Do we have to describe node->level == 0 in side-cache table
(spec isn't clear on this usecase)?

Can we just tell user that "RAM (level 0) should not be used with
'hmat-cache' option?

  
> 
> Error messages should be a phrase, not a paragraph; see error_setg()'s
> function comment.  I think you want something like "be 0 when cache
> level is 0".
> 
> I'm not sure the error message should explain what level 0 means, but
> I'm happy to defer to the NUMA maintainers there.
> 
> > +        return;
> > +    }
> > +
> > +    assert(node->assoc < HMAT_CACHE_ASSOCIATIVITY__MAX);
> > +    assert(node->policy < HMAT_CACHE_WRITE_POLICY__MAX);
> > +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> > +        error_setg(errp, "Duplicate configuration of the side cache for "
> > +                   "node-id=%" PRIu32 " and level=%" PRIu8,
> > +                   node->node_id, node->level);
> > +        return;
> > +    }
> > +
> > +    if ((node->level > 1) &&
> > +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> > +        (node->size >=
> > +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
> > +        error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
> > +                   " should be less than the size(%" PRIu64 ") of "
> > +                   "level=%" PRIu8, node->size, node->level,
> > +                   ms->numa_state->hmat_cache[node->node_id]
> > +                                             [node->level - 1]->size,
> > +                   node->level - 1);
> > +        return;
> > +    }
> > +
> > +    if ((node->level < HMAT_LB_LEVELS - 1) &&
> > +        ms->numa_state->hmat_cache[node->node_id][node->level + 1] &&
> > +        (node->size <=
> > +            ms->numa_state->hmat_cache[node->node_id][node->level + 1]->size)) {
> > +        error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
> > +                   " should be larger than the size(%" PRIu64 ") of "
> > +                   "level=%" PRIu8, node->size, node->level,
> > +                   ms->numa_state->hmat_cache[node->node_id]
> > +                                             [node->level + 1]->size,
> > +                   node->level + 1);
> > +        return;
> > +    }
> > +
> > +    hmat_cache = g_malloc0(sizeof(*hmat_cache));
> > +    memcpy(hmat_cache, node, sizeof(*hmat_cache));
> > +    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
> > +}
> > +
> >  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
> >  {
> >      Error *err = NULL;
> > @@ -417,6 +490,19 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
> >              goto end;
> >          }
> >          break;
> > +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
> > +        if (!ms->numa_state->hmat_enabled) {
> > +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
> > +                       "(HMAT) is disabled, enable it with -machine hmat=on "
> > +                       "before using any of hmat specific options");
> > +            return;
> > +        }
> > +
> > +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
> > +        if (err) {
> > +            goto end;
> > +        }
> > +        break;
> >      default:
> >          abort();
> >      }
> > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > index 70f93c83d7..ba693cc80b 100644
> > --- a/include/sysemu/numa.h
> > +++ b/include/sysemu/numa.h
> > @@ -91,6 +91,9 @@ struct NumaState {
> >  
> >      /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
> >      HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
> > +
> > +    /* Memory Side Cache Information Structure */
> > +    NumaHmatCacheOptions *hmat_cache[MAX_NODES][HMAT_LB_LEVELS];
> >  };
> >  typedef struct NumaState NumaState;
> >  
> > @@ -98,6 +101,8 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
> >  void parse_numa_opts(MachineState *ms);
> >  void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
> >                          Error **errp);
> > +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> > +                           Error **errp);
> >  void numa_complete_configuration(MachineState *ms);
> >  void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
> >  extern QemuOptsList qemu_numa_opts;
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index cf9851fcd1..997e8af1b1 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -428,10 +428,12 @@
> >  #
> >  # @hmat-lb: memory latency and bandwidth information (Since: 5.0)
> >  #
> > +# @hmat-cache: memory side cache information (Since: 5.0)
> > +#
> >  # Since: 2.1
> >  ##
> >  { 'enum': 'NumaOptionsType',
> > -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> > +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
> >  
> >  ##
> >  # @NumaOptions:
> > @@ -447,7 +449,8 @@
> >      'node': 'NumaNodeOptions',
> >      'dist': 'NumaDistOptions',
> >      'cpu': 'NumaCpuOptions',
> > -    'hmat-lb': 'NumaHmatLBOptions' }}
> > +    'hmat-lb': 'NumaHmatLBOptions',
> > +    'hmat-cache': 'NumaHmatCacheOptions' }}
> >  
> >  ##
> >  # @NumaNodeOptions:
> > @@ -646,6 +649,80 @@
> >      '*latency': 'uint64',
> >      '*bandwidth': 'size' }}
> >  
> > +##
> > +# @HmatCacheAssociativity:
> > +#
> > +# Cache associativity in the Memory Side Cache Information Structure
> > +# of HMAT
> > +#
> > +# For more information of @HmatCacheAssociativity see chapter  
> 
> @HmatCacheAssociativity, see
> 
> > +# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
> > +#
> > +# @none: None (no memory side cache in this proximity domain,
> > +#              or cache associativity unknown)
> > +#
> > +# @direct: Direct Mapped
> > +#
> > +# @complex: Complex Cache Indexing (implementation specific)
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'enum': 'HmatCacheAssociativity',
> > +  'data': [ 'none', 'direct', 'complex' ] }
> > +
> > +##
> > +# @HmatCacheWritePolicy:
> > +#
> > +# Cache write policy in the Memory Side Cache Information Structure
> > +# of HMAT
> > +#
> > +# For more information of @HmatCacheWritePolicy see chapter  
> 
> @HmatCacheWritePolicy, see
> 
> > +# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
> > +#
> > +# @none: None (no memory side cache in this proximity domain,
> > +#              or cache write policy unknown)
> > +#
> > +# @write-back: Write Back (WB)
> > +#
> > +# @write-through: Write Through (WT)
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'enum': 'HmatCacheWritePolicy',
> > +  'data': [ 'none', 'write-back', 'write-through' ] }
> > +
> > +##
> > +# @NumaHmatCacheOptions:
> > +#
> > +# Set the memory side cache information for a given memory domain.
> > +#
> > +# For more information of @NumaHmatCacheOptions see chapter  
> 
> @NumaHmatCacheOptions, see
> 
> > +# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
> > +#
> > +# @node-id: the memory proximity domain to which the memory belongs.
> > +#
> > +# @size: the size of memory side cache in bytes.
> > +#
> > +# @level: the cache level described in this structure.
> > +#
> > +# @assoc: the cache associativity,
> > +#         none/direct-mapped/complex(complex cache indexing).  
> 
> QAPI tends to spell out things, i.e. @associativity instead of @assoc.
> We're not 100% consistent, though.
> 
> > +#
> > +# @policy: the write policy, none/write-back/write-through.
> > +#
> > +# @line: the cache Line size in bytes.
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'struct': 'NumaHmatCacheOptions',
> > +  'data': {
> > +   'node-id': 'uint32',
> > +   'size': 'size',
> > +   'level': 'uint8',
> > +   'assoc': 'HmatCacheAssociativity',
> > +   'policy': 'HmatCacheWritePolicy',
> > +   'line': 'uint16' }}
> > +
> >  ##
> >  # @HostMemPolicy:
> >  #
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 23303fc7d7..449829ef15 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -169,7 +169,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> >      "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> >      "-numa dist,src=source,dst=destination,val=distance\n"
> >      "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
> > -    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n",
> > +    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
> > +    "-numa hmat-cache,node-id=node,size=size,level=level[,assoc=none|direct|complex][,policy=none|write-back|write-through][,line=size]\n",
> >      QEMU_ARCH_ALL)
> >  STEXI
> >  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
> > @@ -177,6 +178,7 @@ STEXI
> >  @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
> >  @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
> >  @itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{hierarchy},data-type=@var{tpye}[,latency=@var{lat}][,bandwidth=@var{bw}]
> > +@itemx -numa hmat-cache,node-id=@var{node},size=@var{size},level=@var{level}[,assoc=@var{str}][,policy=@var{str}][,line=@var{size}]
> >  @findex -numa
> >  Define a NUMA node and assign RAM and VCPUs to it.
> >  Set the NUMA distance from a source node to a destination node.
> > @@ -281,11 +283,19 @@ And if input bandwidth value without any unit, the unit will be byte per second.
> >  Note that if latency or bandwidth value is 0, means the corresponding latency or
> >  bandwidth information is not provided.
> >  
> > +In @samp{hmat-cache} option, @var{node-id} is the NUMA-id of the memory belongs.
> > +@var{size} is the size of memory side cache in bytes. @var{level} is the cache
> > +level described in this structure. @var{assoc} is the cache associativity,
> > +the possible value is 'none/direct(direct-mapped)/complex(complex cache indexing)'.
> > +@var{policy} is the write policy. @var{line} is the cache Line size in bytes.
> > +
> >  For example, the following options describe 2 NUMA nodes. Node 0 has 2 cpus and
> >  a ram, node 1 has only a ram. The processors in node 0 access memory in node
> >  0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
> >  The processors in NUMA node 0 access memory in NUMA node 1 with access-latency 10
> >  nanoseconds, access-bandwidth is 100 MB/s.
> > +And for memory side cache information, NUMA node 0 and 1 both have 1 level memory
> > +cache, size is 10KB, policy is write-back, the cache Line size is 8 bytes:
> >  @example
> >  -machine hmat=on \
> >  -m 2G \
> > @@ -299,7 +309,9 @@ nanoseconds, access-bandwidth is 100 MB/s.
> >  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5 \
> >  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10 \
> > --numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M
> > +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
> > +-numa hmat-cache,node-id=0,size=10K,level=1,assoc=direct,policy=write-back,line=8 \
> > +-numa hmat-cache,node-id=1,size=10K,level=1,assoc=direct,policy=write-back,line=8
> >  @end example
> >  
> >  ETEXI  


