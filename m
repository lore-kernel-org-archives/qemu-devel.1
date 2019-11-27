Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A726C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C970A2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxLCZ/4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C970A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZu4I-0003Ia-Su
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZu3S-0002Nf-Ut
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZu3R-00034T-9u
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:56:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZu3R-000341-6H
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574848572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KbSQsuDEcl3GiCi7uQ+eR8PO+RRMjE9Li71FR86fzg=;
 b=UxLCZ/4xO8M+LxLNDB8F6L9ne1rwKl4bomuLIkoSdCWGXWuUk8TpZqzMLJPWgrwB0Gs91B
 FwCE4Dp4MjmbgTjCXkVyVvq+maBm2g2LMsWGkg5w2/tLeS2uxv2l3IJVhni92WHdlySBTY
 gGDeTs1Pw3GqYiPd4YVj2jdu0h69u2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-6tsMc_q9NeCAwGloNdSoEQ-1; Wed, 27 Nov 2019 04:56:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77BDDB60;
 Wed, 27 Nov 2019 09:56:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA2B5D6C8;
 Wed, 27 Nov 2019 09:56:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F1701138606; Wed, 27 Nov 2019 10:56:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v18 3/8] numa: Extend CLI to provide memory side cache
 information
References: <20191127082613.22903-1-tao3.xu@intel.com>
 <20191127082613.22903-4-tao3.xu@intel.com>
Date: Wed, 27 Nov 2019 10:56:03 +0100
In-Reply-To: <20191127082613.22903-4-tao3.xu@intel.com> (Tao Xu's message of
 "Wed, 27 Nov 2019 16:26:08 +0800")
Message-ID: <871rttfxsc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6tsMc_q9NeCAwGloNdSoEQ-1
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
 mdroth@linux.vnet.ibm.com, Daniel Black <daniel@linux.ibm.com>,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> From: Liu Jingqi <jingqi.liu@intel.com>
>
> Add -numa hmat-cache option to provide Memory Side Cache Information.
> These memory attributes help to build Memory Side Cache Information
> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).

Please mention this requires -machine hmat=3Don.

> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
[...]
> diff --git a/qapi/machine.json b/qapi/machine.json
> index c741649d7b..3d0ba226a9 100644
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
> @@ -647,6 +650,77 @@
>      '*latency': 'uint64',
>      '*bandwidth': 'size' }}
> =20
> +##
> +# @HmatCacheAssociativity:
> +#
> +# Cache associativity in the Memory Side Cache
> +# Information Structure of HMAT
> +#
> +# For more information of @HmatCacheAssociativity see
> +# the chapter 5.2.27.5: Table 5-147 of ACPI 6.3 spec.

  # Cache associativity in the Memory Side Cache Information Structure
  # of HMAT
  #
  # For more information of @HmatCacheAssociativity, see chapter
  # 5.2.27.5: Table 5-147 of ACPI 6.3 spec.

> +#
> +# @none: None

What does cache associativity @none mean?  A none-associative cache?  I
guess it makes sense to people familiar with the ACPI spec...

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
> +# Cache write policy in the Memory Side Cache
> +# Information Structure of HMAT
> +#
> +# For more information of @HmatCacheWritePolicy see
> +# the chapter 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.=
3 spec.

Break lines around column 70, please.

> +#
> +# @none: None

What does cache write policy @none mean?

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
> +# For more information of @NumaHmatCacheOptions see
> +# the chapter 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.=
3 spec.
> +#
> +# @node-id: the memory proximity domain to which the memory belongs.
> +#
> +# @size: the size of memory side cache in bytes.
> +#
> +# @level: the cache level described in this structure.
> +#
> +# @assoc: the cache associativity, none/direct-mapped/complex(complex ca=
che indexing).
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

Ignorant question: you use 'uint16' for other "proximity domains".  Is
'uint32' intentional here?

> +   'size': 'size',
> +   'level': 'uint8',
> +   'assoc': 'HmatCacheAssociativity',
> +   'policy': 'HmatCacheWritePolicy',
> +   'line': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
[...]


