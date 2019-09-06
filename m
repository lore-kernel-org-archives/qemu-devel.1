Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63616C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66CE206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66CE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Dx9-0004SN-RV
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6DwT-0003xS-D7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6DwR-0000Bp-U4
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:06:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6DwO-0008Kw-DM; Fri, 06 Sep 2019 09:06:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A55518C4273;
 Fri,  6 Sep 2019 13:06:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C815C1D8;
 Fri,  6 Sep 2019 13:06:06 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:06:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906130603.GE5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-9-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-9-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 06 Sep 2019 13:06:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 08/13] qcrypto-luks: extract store and
 load header
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 04:50:58PM +0300, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 166 +++++++++++++++++++++++++++-----------------
>  1 file changed, 102 insertions(+), 64 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index cad65ae0aa..b4dc6fc899 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -409,6 +409,105 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorithm cipher,
>      }
>  }
>  
> +/*
> + * Stores the main LUKS header, taking care of endianess
> + */
> +static int
> +qcrypto_block_luks_store_header(QCryptoBlock *block,
> +                                QCryptoBlockWriteFunc writefunc,
> +                                void *opaque,
> +                                Error **errp)
> +{
> +    const QCryptoBlockLUKS *luks = block->opaque;
> +    Error *local_err = NULL;
> +    size_t i;
> +    QCryptoBlockLUKSHeader *hdr_copy;

Initialize to NULL and mark with g_autofree

> +
> +    /* Create a copy of the header */
> +    hdr_copy = g_new0(QCryptoBlockLUKSHeader, 1);
> +    memcpy(hdr_copy, &luks->header, sizeof(QCryptoBlockLUKSHeader));
> +
> +    /*
> +     * Everything on disk uses Big Endian (tm), so flip header fields
> +     * before writing them
> +     */
> +    cpu_to_be16s(&hdr_copy->version);
> +    cpu_to_be32s(&hdr_copy->payload_offset_sector);
> +    cpu_to_be32s(&hdr_copy->master_key_len);
> +    cpu_to_be32s(&hdr_copy->master_key_iterations);
> +
> +    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        cpu_to_be32s(&hdr_copy->key_slots[i].active);
> +        cpu_to_be32s(&hdr_copy->key_slots[i].iterations);
> +        cpu_to_be32s(&hdr_copy->key_slots[i].key_offset_sector);
> +        cpu_to_be32s(&hdr_copy->key_slots[i].stripes);
> +    }
> +
> +    /* Write out the partition header and key slot headers */
> +    writefunc(block, 0, (const uint8_t *)hdr_copy, sizeof(*hdr_copy),
> +              opaque, &local_err);
> +
> +    g_free(hdr_copy);

And then this can be removed

> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Loads the main LUKS header,and byteswaps it to native endianess
> + * And run basic sanity checks on it
> + */
> +static int
> +qcrypto_block_luks_load_header(QCryptoBlock *block,
> +                                QCryptoBlockReadFunc readfunc,
> +                                void *opaque,
> +                                Error **errp)
> +{
> +    ssize_t rv;
> +    size_t i;
> +    int ret = 0;
> +    QCryptoBlockLUKS *luks = block->opaque;
> +
> +    /*
> +     * Read the entire LUKS header, minus the key material from
> +     * the underlying device
> +     */
> +
> +    rv = readfunc(block, 0,
> +                  (uint8_t *)&luks->header,
> +                  sizeof(luks->header),
> +                  opaque,
> +                  errp);
> +    if (rv < 0) {
> +        ret = rv;
> +        goto fail;

Nothing happens at the fail: label, so you can just 'return rv'
straightaway IMHO

> +    }
> +
> +    /*
> +     * The header is always stored in big-endian format, so
> +     * convert everything to native
> +     */
> +    be16_to_cpus(&luks->header.version);
> +    be32_to_cpus(&luks->header.payload_offset_sector);
> +    be32_to_cpus(&luks->header.master_key_len);
> +    be32_to_cpus(&luks->header.master_key_iterations);
> +
> +    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        be32_to_cpus(&luks->header.key_slots[i].active);
> +        be32_to_cpus(&luks->header.key_slots[i].iterations);
> +        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
> +        be32_to_cpus(&luks->header.key_slots[i].stripes);
> +    }
> +
> +
> +    return 0;
> +fail:
> +    return ret;
> +}

> -    /* Read the entire LUKS header, minus the key material from
> -     * the underlying device */
> -    rv = readfunc(block, 0,
> -                  (uint8_t *)&luks->header,
> -                  sizeof(luks->header),
> -                  opaque,
> -                  errp);
> -    if (rv < 0) {
> -        ret = rv;
> +    ret = qcrypto_block_luks_load_header(block, readfunc, opaque, errp);
> +    if (ret) {

if (ret < 0)

>          goto fail;
>      }
>  
> -    /* The header is always stored in big-endian format, so
> -     * convert everything to native */
> -    be16_to_cpus(&luks->header.version);
> -    be32_to_cpus(&luks->header.payload_offset_sector);
> -    be32_to_cpus(&luks->header.master_key_len);
> -    be32_to_cpus(&luks->header.master_key_iterations);
> -
> -    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> -        be32_to_cpus(&luks->header.key_slots[i].active);
> -        be32_to_cpus(&luks->header.key_slots[i].iterations);
> -        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
> -        be32_to_cpus(&luks->header.key_slots[i].stripes);
> -    }
>  
>      if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
>                 QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
> @@ -1235,46 +1312,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          goto error;
>      }

> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)) {

The comparison should be "< 0"

>          goto error;
>      }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

