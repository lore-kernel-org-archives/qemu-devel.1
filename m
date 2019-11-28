Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86350C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E08D2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj/innP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E08D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIMf-0004Wr-Ef
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaIJi-00035M-KS
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaIJa-0002Tw-M2
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:50:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaIJW-00026w-8Z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574941821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ec0qDGMzGKvVzfzZ1v94v9yvOIr4mSrhsTpFwHtw0e8=;
 b=Mj/innP8hIEKIGLDNX5+v6/xQMEUWbcbJZSnWOGrxl6cH40shjSdwtyRsERS+/1Kz/TEsK
 3wP1KBgbw2vI3VbOqDiZVh6o/9r+O/jUhcjIq/bo7QjD/dg+zmq2wTLtIx4JWjym3haTx0
 DKzAIvCtM5GPq5P3ZLxLUn8ksSIN+aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ZmX8qJSuO-eP3swe3mXyLA-1; Thu, 28 Nov 2019 06:50:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3949FDC06;
 Thu, 28 Nov 2019 11:50:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6958E19C4F;
 Thu, 28 Nov 2019 11:50:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38E151138606; Thu, 28 Nov 2019 12:50:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v19 2/8] numa: Extend CLI to provide memory latency and
 bandwidth information
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-3-tao3.xu@intel.com>
Date: Thu, 28 Nov 2019 12:50:12 +0100
In-Reply-To: <20191128082109.30081-3-tao3.xu@intel.com> (Tao Xu's message of
 "Thu, 28 Nov 2019 16:21:03 +0800")
Message-ID: <87o8wwnrt7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZmX8qJSuO-eP3swe3mXyLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT). Before using
> hmat-lb option, enable HMAT with -machine hmat=3Don.
>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 27d0e37534..cf9851fcd1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -426,10 +426,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 5.0)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -444,7 +446,8 @@
>    'data': {
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
> -    'cpu': 'NumaCpuOptions' }}
> +    'cpu': 'NumaCpuOptions',
> +    'hmat-lb': 'NumaHmatLBOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -557,6 +560,92 @@
>     'base': 'CpuInstanceProperties',
>     'data' : {} }
> =20
> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency and Bandwidth
> +# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
> +#
> +# For more information about @HmatLBMemoryHierarchy see chapter

@HmatLBMemoryHierarchy, see

> +# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @first-level: first level of memory side cache
> +#
> +# @second-level: second level of memory side cache
> +#
> +# @third-level: third level of memory side cache
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatLBMemoryHierarchy',
> +  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
> +
> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency and Bandwidth
> +# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
> +#
> +# For more information about @HmatLBDataType see chapter

@HmatLBDataType, see

> +# 5.2.27.4: Table 5-146:  Field "Data Type" of ACPI 6.3 spec.
> +#
> +# @access-latency: access latency (nanoseconds)
> +#
> +# @read-latency: read latency (nanoseconds)
> +#
> +# @write-latency: write latency (nanoseconds)
> +#
> +# @access-bandwidth: access bandwidth (Bytes per second)
> +#
> +# @read-bandwidth: read bandwidth (Bytes per second)
> +#
> +# @write-bandwidth: write bandwidth (Bytes per second)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatLBDataType',
> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# For more information about @NumaHmatLBOptions see chapter

@NumaHmatLBOptions, see

> +# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.
> +#
> +# @latency: the value of latency from @initiator to @target
> +#           proximity domain, the latency unit is "ns(nanosecond)".
> +#
> +# @bandwidth: the value of bandwidth between @initiator and @target
> +#             proximity domain, the bandwidth unit is
> +#             "Bytes per second".
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +    'data': {
> +    'initiator': 'uint16',
> +    'target': 'uint16',
> +    'hierarchy': 'HmatLBMemoryHierarchy',
> +    'data-type': 'HmatLBDataType',
> +    '*latency': 'uint64',
> +    '*bandwidth': 'size' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 63f6b33322..23303fc7d7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -168,16 +168,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
> -    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n",
> +    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
> +@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarch=
y=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
> =20
>  Legacy VCPU assignment uses @samp{cpus} option where
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> @@ -256,6 +259,49 @@ specified resources, it just assigns existing resour=
ces to NUMA
>  nodes. This means that one still has to use the @option{-m},
>  @option{-smp} options to allocate RAM and VCPUs respectively.
> =20
> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Informat=
ion
> +between initiator and target NUMA nodes in ACPI Heterogeneous Attribute =
Memory Table (HMAT).
> +Initiator NUMA node can create memory requests, usually it has one or mo=
re processors.
> +Target NUMA node contains addressable memory.
> +
> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{hierarchy} =
is the memory
> +hierarchy of the target NUMA node: if @var{hierarchy} is 'memory', the s=
tructure
> +represents the memory performance; if @var{hierarchy} is 'first-level|se=
cond-level|third-level',
> +this structure represents aggregated performance of memory side caches f=
or each domain.
> +@var{type} of 'data-type' is type of data represented by this structure =
instance:
> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency o=
r 'access|read|write'
> +bandwidth of the target memory; if 'hierarchy' is 'first-level|second-le=
vel|third-level',
> +'data-type' is 'access|read|write' hit latency or 'access|read|write' hi=
t bandwidth of the
> +target memory side cache.
> +
> +@var{lat} is latency value in nanoseconds. @var{bw} is bandwidth value,
> +the possible value and units are NUM[M|G|T], mean that the bandwidth val=
ue are
> +NUM byte per second (or MB/s, GB/s or TB/s depending on used suffix).
> +And if input bandwidth value without any unit, the unit will be byte per=
 second.

This sentence feels redundant to me.

> +Note that if latency or bandwidth value is 0, means the corresponding la=
tency or
> +bandwidth information is not provided.
> +
> +For example, the following options describe 2 NUMA nodes. Node 0 has 2 c=
pus and
> +a ram, node 1 has only a ram. The processors in node 0 access memory in =
node
> +0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
> +The processors in NUMA node 0 access memory in NUMA node 1 with access-l=
atency 10
> +nanoseconds, access-bandwidth is 100 MB/s.
> +@example
> +-machine hmat=3Don \
> +-m 2G \
> +-object memory-backend-ram,size=3D1G,id=3Dm0 \
> +-object memory-backend-ram,size=3D1G,id=3Dm1 \
> +-smp 2 \
> +-numa node,nodeid=3D0,memdev=3Dm0 \
> +-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D1 \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D5 \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D200M \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D10 \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M
> +@end example
> +
>  ETEXI
> =20
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,


