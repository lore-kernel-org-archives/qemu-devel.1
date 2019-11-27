Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0215B20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJFIbxy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0215B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZtx9-0008TS-2Y
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZtwG-0007rb-0h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZtwE-00067p-2Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:48:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZtwD-00067G-Uz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574848125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xr3Z+gJFamkdsbmebm0FcNpcFZd3MIJ6Dxy2O28e4jU=;
 b=jJFIbxy7rq2/ZJ1GTFFNwJY+1bBZFoPC+3QCBmhzo8AqlvSJl1xyhywnX/1AfMtsKFk6UL
 7pADbEQ9KEiFw/HmviTG23rALb4cwE1bfPGYk5xzviA0H3A75CkDTUQ6mOlzjCMjtrs44j
 bXOyF11bfZeyUPcF3mdzaBsooBALmfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-MJ5N7ocLPv2p2KY-mL52mQ-1; Wed, 27 Nov 2019 04:48:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E081180183C;
 Wed, 27 Nov 2019 09:48:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8CD45D9D6;
 Wed, 27 Nov 2019 09:48:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3971C1138606; Wed, 27 Nov 2019 10:48:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v18 2/8] numa: Extend CLI to provide memory latency and
 bandwidth information
References: <20191127082613.22903-1-tao3.xu@intel.com>
 <20191127082613.22903-3-tao3.xu@intel.com>
Date: Wed, 27 Nov 2019 10:48:33 +0100
In-Reply-To: <20191127082613.22903-3-tao3.xu@intel.com> (Tao Xu's message of
 "Wed, 27 Nov 2019 16:26:07 +0800")
Message-ID: <87d0ddfy4u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MJ5N7ocLPv2p2KY-mL52mQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> in ACPI Heterogeneous Memory Attribute Table (HMAT).

Please mention this requires -machine hmat=3Don.

> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
[...]
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 27d0e37534..c741649d7b 100644
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
> @@ -557,6 +560,93 @@
>     'base': 'CpuInstanceProperties',
>     'data' : {} }
> =20
> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information about @HmatLBMemoryHierarchy see
> +# the chapter 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.

Comma before "see", and s/the chapter/chapter/.

Suggest to fill these paragraphs more evenly:

   # The memory hierarchy in the System Locality Latency and Bandwidth
   # Information Structure of HMAT (Heterogeneous Memory Attribute Table)
   #
   # For more information about @HmatLBMemoryHierarchy, see chapter
   # 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.

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
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information about @HmatLBDataType see
> +# the chapter 5.2.27.4: Table 5-146:  Field "Data Type" of ACPI 6.3 spec=
.

Likewise.

> +#
> +# @access-latency: access latency (nanoseconds)
> +#
> +# @read-latency: read latency (nanoseconds)
> +#
> +# @write-latency: write latency (nanoseconds)
> +#
> +# @access-bandwidth: access bandwidth (B/s)

We spell out bytes per second elsewhere in the QAPI schema.  Let's to
the same here.

> +#
> +# @read-bandwidth: read bandwidth (B/s)
> +#
> +# @write-bandwidth: write bandwidth (B/s)
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
> +# For more information about @NumaHmatLBOptions see
> +# the chapter 5.2.27.4: Table 5-146 of ACPI 6.3 spec.

Likewise.

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
> +# @latency: the value of latency from @initiator to @target proximity do=
main,
> +#           the latency unit is "ns(nanosecond)".
> +#
> +# @bandwidth: the value of bandwidth between @initiator and @target prox=
imity
> +#             domain, the bandwidth unit is "B(/s)".

Break lines around column 70, please.

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
[...]


