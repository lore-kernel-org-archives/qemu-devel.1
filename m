Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81BBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD49206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD49206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6E2X-0006m6-P0
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6E1l-0006J7-V9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6E1k-0007JH-IK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6E1h-0007G3-5s; Fri, 06 Sep 2019 09:11:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 913A87F768;
 Fri,  6 Sep 2019 13:11:43 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07DA7166CE;
 Fri,  6 Sep 2019 13:11:39 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:11:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906131123.GF5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-10-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-10-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 06 Sep 2019 13:11:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/13] qcrypto-block: extract check and
 parse header
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

On Mon, Aug 26, 2019 at 04:50:59PM +0300, Maxim Levitsky wrote:
> This is just to make qcrypto_block_luks_open more
> reasonable in size.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 254 +++++++++++++++++++++++++-------------------
>  1 file changed, 146 insertions(+), 108 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index b4dc6fc899..cc9a52c9af 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -508,6 +508,148 @@ fail:
>      return ret;
>  }
>  
> +/*
> + * Does basic sanity checks on the LUKS header
> + */
> +static int
> +qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
> +{
> +    int ret;
> +
> +    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> +               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
> +        error_setg(errp, "Volume is not in LUKS format");
> +        ret = -EINVAL;
> +        goto fail;
> +    }

Just 'return -1' here immediately - don't return an errno, as we're
using Error objects for reporting.

> +
> +    if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
> +        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
> +                   luks->header.version);
> +        ret = -ENOTSUP;
> +        goto fail;
> +    }
> +
> +    return 0;
> +fail:
> +    return ret;
> +}
> +
> +/*
> + * Parses the crypto parameters that are stored in the LUKS header
> + */
> +
> +static int
> +qcrypto_block_luks_parse_header(QCryptoBlockLUKS *luks, Error **errp)
> +{
> +    g_autofree char *cipher_mode = g_strdup(luks->header.cipher_mode);
> +    char *ivgen_name, *ivhash_name;
> +    int ret = -1;
> +    Error *local_err = NULL;
> +
> +    /*
> +     * The cipher_mode header contains a string that we have
> +     * to further parse, of the format
> +     *
> +     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
> +     *
> +     * eg  cbc-essiv:sha256, cbc-plain64
> +     */
> +    ivgen_name = strchr(cipher_mode, '-');
> +    if (!ivgen_name) {
> +        ret = -EINVAL;

Again, don't use errnos - just return -1 in this method.

> +        error_setg(errp, "Unexpected cipher mode string format %s",
> +                   luks->header.cipher_mode);
> +        goto out;
> +    }
> +    *ivgen_name = '\0';
> +    ivgen_name++;
> +
> +    ivhash_name = strchr(ivgen_name, ':');
> +    if (!ivhash_name) {
> +        luks->ivgen_hash_alg = 0;
> +    } else {
> +        *ivhash_name = '\0';
> +        ivhash_name++;
> +
> +        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
> +                                                                   &local_err);
> +        if (local_err) {
> +            ret = -ENOTSUP;
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +    }
> +
> +    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
> +                                                              &local_err);
> +    if (local_err) {
> +        ret = -ENOTSUP;
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    luks->cipher_alg =
> +            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
> +                                                  luks->cipher_mode,
> +                                                  luks->header.master_key_len,
> +                                                  &local_err);
> +    if (local_err) {
> +        ret = -ENOTSUP;
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    luks->hash_alg =
> +            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
> +                                               &local_err);
> +    if (local_err) {
> +        ret = -ENOTSUP;
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
> +                                                           &local_err);
> +    if (local_err) {
> +        ret = -ENOTSUP;
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
> +        if (!ivhash_name) {
> +            ret = -EINVAL;
> +            error_setg(errp, "Missing IV generator hash specification");
> +            goto out;
> +        }
> +        luks->ivgen_cipher_alg =
> +                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
> +                                                luks->ivgen_hash_alg,
> +                                                &local_err);
> +        if (local_err) {
> +            ret = -ENOTSUP;
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +    } else {
> +
> +        /*
> +         * Note we parsed the ivhash_name earlier in the cipher_mode
> +         * spec string even with plain/plain64 ivgens, but we
> +         * will ignore it, since it is irrelevant for these ivgens.
> +         * This is for compat with dm-crypt which will silently
> +         * ignore hash names with these ivgens rather than report
> +         * an error about the invalid usage
> +         */
> +        luks->ivgen_cipher_alg = luks->cipher_alg;
> +    }
> +    ret = 0;
> +out:
> +    return ret;
> +
> +}
> +
>  /*
>   * Given a key slot, and user password, this will attempt to unlock
>   * the master encryption key from the key slot.
> @@ -720,12 +862,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>                          Error **errp)
>  {
>      QCryptoBlockLUKS *luks = NULL;
> -    Error *local_err = NULL;
>      int ret = 0;
>      g_autofree uint8_t *masterkey = NULL;
> -    char *ivgen_name, *ivhash_name;
>      g_autofree char *password = NULL;
> -    g_autofree char *cipher_mode = NULL;
>  
>      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
>          if (!options->u.luks.key_secret) {
> @@ -748,117 +887,16 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          goto fail;
>      }
>  
> -
> -    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> -               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
> -        error_setg(errp, "Volume is not in LUKS format");
> -        ret = -EINVAL;

I can't remember why I set ret to an errno in my original code.
it is entirely pointless, as the caller of this method merely
checks "ret < 0" and doesn't do anything else with the return
value. IOW, we should just purge the errnors from this existing
code entirely.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

