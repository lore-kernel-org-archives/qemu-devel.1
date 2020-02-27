Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3202C3F34D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B322E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCslXB64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B322E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JlZ-0006F5-TG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7Jjr-0003fJ-Di
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7Jjp-0001P9-NA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7Jjp-0001OR-HP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plPQvCPGem8dBqzXvHD8a+JHvK4+d4fjXONl5YKCfOo=;
 b=WCslXB644bBCo20lvJVvvhpW5ROG93bFKx0NygnTQIe/xdYdQVs974JccT6S/MshrFy7xc
 ZNVHnHpXSOhH81Q2+ceO4iHBeC0C7Qe+1HcsG7opVr53sMqpIhjijB+zIOkrUwtmVs/Kd4
 /E7w8zwoHHveM8jSU3vXzGIDNCr1KK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-KI0cYz-2MPOfOAxjHG4_DA-1; Thu, 27 Feb 2020 09:01:46 -0500
X-MC-Unique: KI0cYz-2MPOfOAxjHG4_DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 714641419;
 Thu, 27 Feb 2020 14:01:45 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E6F19C7F;
 Thu, 27 Feb 2020 14:01:44 +0000 (UTC)
Subject: Re: [PATCH v1 3/8] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-4-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6b9b3f63-5760-c0a1-b330-b92ac894970a@redhat.com>
Date: Thu, 27 Feb 2020 08:01:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227072953.25445-4-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:29 AM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    size_t ret;
> +
> +    /*
> +     * steal ZSTD_LEN_BUF bytes in the very beginng of the buffer

beginning

> +     * to store compressed chunk size
> +     */
> +    char *d_buf = ((char *) dest) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can store the compressed data length,
> +     * and there is some space left for the compressor buffer
> +     */
> +    if (dest_size <= ZSTD_LEN_BUF) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -= ZSTD_LEN_BUF;
> +
> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall) {
> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /* paraniod sanity check that we can store the commpressed size */

paranoid, compressed

> +    if (ret > UINT_MAX) {
> +        return -ENOMEM;
> +    }

This is pointless.  Better is to ensure that we actually compressed data 
(the pigeonhole principle states that there are some inputs that MUST 
result in inflation, in order for most other inputs to result in 
compression).  But that check was satisfied by checking for 
ZSTD_error_dstSize_tooSmall, which is what happens for one of those 
uncompressible inputs.  Namely, zstd will never return a result larger 
than dest_size, and since dest_size is smaller than UINT_MAX on entry, 
this check is pointless.  But if you want something, I'd be okay with: 
assert(ret <= dest_size).

> +++ b/docs/interop/qcow2.txt
> @@ -208,6 +208,7 @@ version 2.
>   
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> +                        1: zstd <http://github.com/facebook/zstd>
>   
>   
>   === Header padding ===
> @@ -575,11 +576,28 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>                       Another compressed cluster may map to the tail of the final
>                       sector used by this compressed cluster.
>   
> +                    The layout of the compressed data depends on the compression
> +                    type used for the image (see compressed cluster layout).
> +
>   If a cluster is unallocated, read requests shall read the data from the backing
>   file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>   no backing file or the backing file is smaller than the image, they shall read
>   zeros for all parts that are not covered by the backing file.
>   
> +=== Compressed Cluster Layout ===
> +
> +The compressed cluster data has a layout depending on the compression
> +type used for the image, as follows:
> +
> +Compressed data layout for the available compression types:
> +(x = data_space_length - 1)
> +
> +    0:  (default)  zlib <http://zlib.net/>:
> +            Byte  0 -  x:     the compressed data content
> +                              all the space provided used for compressed data
> +    1:  zstd <http://github.com/facebook/zstd>:
> +            Byte  0 -  3:     the length of compressed data in bytes
> +                  4 -  x:     the compressed data content
>   
>   == Snapshots ==
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 873fbef3b5..4b6e576c44 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4401,11 +4401,12 @@
>   # Compression type used in qcow2 image file
>   #
>   # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>   #
>   # Since: 5.0
>   ##
>   { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>   

The spec and UI changes are okay.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


