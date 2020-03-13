Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EDCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51BC20663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaeE1CwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51BC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCs3K-0004pW-2T
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCs2h-0004Bx-GF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCs2g-00063m-27
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:40:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCs2f-0005yw-UX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584135628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7KMye8407+Ra9yTJt/q0cP1UFOtuBrlF28m8VUyT2A=;
 b=WaeE1CwJDIRNXSMvqQzBmlOVEx7xhWZsLofaYWbbEcY+8svS5dcif5ZflBBWa6YdgLxnPd
 O/4YcXB68XXpt8KHbL16ZCTLtQyWuwWxk+4aB4/bytd83NmN5hOnADnVKGAlNEO7CJsJwB
 LH4z8oyVSki/l/CD4ulJFrK56Lr7xYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Kb8H3kQ-MpegmX_f3HrqLA-1; Fri, 13 Mar 2020 17:40:11 -0400
X-MC-Unique: Kb8H3kQ-MpegmX_f3HrqLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7348518AB2C0;
 Fri, 13 Mar 2020 21:40:10 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76EE95C1B0;
 Fri, 13 Mar 2020 21:40:09 +0000 (UTC)
Subject: Re: [PATCH v6 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
 <20200312092242.5536-2-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fb17996c-1c96-353d-a537-748bd05b94ff@redhat.com>
Date: Fri, 13 Mar 2020 16:40:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312092242.5536-2-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 4:22 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
> 
> The tests are fixed in the following ways:
>      * filter out compression_type for all the tests

Presumably this filter is optional, and we will not use it on the 
specific new tests that prove zstd compression works - but that should 
be later in the series, so for this patch it is okay.

>      * fix header size, feature table size and backing file offset
>        affected tests: 031, 036, 061, 080
>        header_size +=8: 1 byte compression type
>                         7 bytes padding
>        feature_table += 48: incompatible feture compression type

feature

>        backing_file_offset += 56 (8 + 48 -> header_change + fature_table_change)

feature

(interesting that you have two different changed spellings ;)

>      * add "compression type" for test output matching when it isn't filtered
>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255

Or maybe the comment above should be changed to "many tests" rather than 
"all the tests".

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json             |  22 +++++-
>   block/qcow2.h                    |  20 ++++-
>   include/block/block_int.h        |   1 +
>   block/qcow2.c                    | 121 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 ++--
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 +++++++++++++-------------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 +++++----
>   tests/qemu-iotests/065           |  28 ++++---
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 ++
>   tests/qemu-iotests/255.out       |   8 +-
>   tests/qemu-iotests/common.filter |   3 +-
>   16 files changed, 275 insertions(+), 96 deletions(-)
> 

> +++ b/block/qcow2.h
> @@ -146,8 +146,16 @@ typedef struct QCowHeader {
>   
>       uint32_t refcount_order;
>       uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t  compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t  padding[7];

Why two spaces after uint8_t (twice)?


> @@ -369,6 +380,13 @@ typedef struct BDRVQcow2State {
>   
>       bool metadata_preallocation_checked;
>       bool metadata_preallocation;
> +    /*
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compression type set

Missing trailing '.'.  Maybe someday we can get 'qemu-img amend' to also 
adjust the compression type in-place; if that's something we think we 
might do, then this could be better worded as "For now, the only way to 
change...".

> +++ b/block/qcow2.c
> @@ -1242,6 +1242,48 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
>       return ret;
>   }
>   
> +static int validate_compression_type(BDRVQcow2State *s, Error **errp)

> +
> +static int qcow2_compression_type_from_format(const char *ct)
> +{
> +    if (g_str_equal(ct, "zlib")) {
> +        return QCOW2_COMPRESSION_TYPE_ZLIB;
> +    } else {
> +        return -EINVAL;
> +    }

Why are you open-coding this?

qapi_enum_parse(&Qcow2CompressionType_lookup, ct, -1, errp)

should do what you use this for, and automatically updates itself when 
you add zstd to the qapi enum later.


> @@ -3401,6 +3493,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           .refcount_table_offset      = cpu_to_be64(cluster_size),
>           .refcount_table_clusters    = cpu_to_be32(1),
>           .refcount_order             = cpu_to_be32(refcount_order),
> +        /* don't deal with endians since compression_type is 1 byte long */

endianness

> +        .compression_type           = compression_type,
>           .header_length              = cpu_to_be32(sizeof(*header)),
>       };
>   
> @@ -5516,6 +5631,12 @@ static QemuOptsList qcow2_create_opts = {
>               .help = "Width of a reference count entry in bits",
>               .def_value_str = "16"
>           },
> +        {
> +            .name = BLOCK_OPT_COMPRESSION_TYPE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Compression method used for image clusters compression",

s/clusters/cluster/

Overall, getting closer. I assume this would go through Max's tree, if 
he has time to include it before soft freeze...

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


