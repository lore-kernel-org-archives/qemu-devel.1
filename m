Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D0DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E62206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E62206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6E8k-0002ku-Bk
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6E80-0001vx-MQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6E7y-0004Nn-GZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6E7v-0004Aj-60; Fri, 06 Sep 2019 09:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 458A21DA9;
 Fri,  6 Sep 2019 13:18:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE44960C5E;
 Fri,  6 Sep 2019 13:18:01 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:17:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906131758.GH5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-12-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-12-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 06 Sep 2019 13:18:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/13] qcrypto-luks: refactoring:
 simplify the math used for keyslot locations
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

On Mon, Aug 26, 2019 at 04:51:01PM +0300, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 64 +++++++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index d713125925..6a43d97ce5 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -409,6 +409,32 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgor=
ithm cipher,
>      }
>  }
> =20
> +/*
> + * Returns number of sectors needed to store the key material
> + * given number of anti forensic stripes
> + */
> +static int
> +qcrypto_block_luks_splitkeylen_sectors(const QCryptoBlockLUKS *luks,
> +                                       unsigned int stripes)
> +{
> +    /*
> +     * This calculation doesn't match that shown in the spec,
> +     * but instead follows the cryptsetup implementation.
> +     */
> +
> +    size_t header_sectors =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> +        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;

The caller already calculated that so just pass it in

> +
> +    size_t splitkeylen =3D luks->header.master_key_len * stripes;
> +
> +    /* First align the key material size to block size*/
> +    size_t splitkeylen_sectors =3D
> +        DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE);
> +
> +    /* Then also align the key material size to the size of the header=
 */
> +    return ROUND_UP(splitkeylen_sectors, header_sectors);
> +}
> +
>  /*
>   * Stores the main LUKS header, taking care of endianess
>   */
> @@ -1151,7 +1177,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>      QCryptoBlockCreateOptionsLUKS luks_opts;
>      Error *local_err =3D NULL;
>      g_autofree uint8_t *masterkey =3D NULL;
> -    size_t splitkeylen =3D 0;
> +    size_t header_sectors;
> +    size_t split_key_sectors;
>      size_t i;
>      g_autofree char *password;
>      const char *cipher_alg;
> @@ -1370,37 +1397,28 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          goto error;
>      }
> =20
> +    /* start with the sector that follows the header*/
> +    header_sectors =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> +        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> +
> +    split_key_sectors =3D
> +        qcrypto_block_luks_splitkeylen_sectors(luks,
> +                                               QCRYPTO_BLOCK_LUKS_STRI=
PES);
> =20
> -    /* Although LUKS has multiple key slots, we're just going
> -     * to use the first key slot */
> -    splitkeylen =3D luks->header.master_key_len * QCRYPTO_BLOCK_LUKS_S=
TRIPES;
>      for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> -        luks->header.key_slots[i].active =3D QCRYPTO_BLOCK_LUKS_KEY_SL=
OT_DISABLED;
> -        luks->header.key_slots[i].stripes =3D QCRYPTO_BLOCK_LUKS_STRIP=
ES;
> +        QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[i];
> +        slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> =20
> -        /* This calculation doesn't match that shown in the spec,
> -         * but instead follows the cryptsetup implementation.
> -         */
> -        luks->header.key_slots[i].key_offset_sector =3D
> -            (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> -             QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
> -            (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SEC=
TOR_SIZE),
> -                      (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> -                       QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
> +        slot->key_offset_sector =3D header_sectors + i * split_key_sec=
tors;
> +        slot->stripes =3D QCRYPTO_BLOCK_LUKS_STRIPES;
>      }
> =20
> -
>      /* The total size of the LUKS headers is the partition header + ke=
y
>       * slot headers, rounded up to the nearest sector, combined with
>       * the size of each master key material region, also rounded up
>       * to the nearest sector */
> -    luks->header.payload_offset_sector =3D
> -        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> -         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
> -        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_=
SIZE),
> -                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
> -                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
> -         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +    luks->header.payload_offset_sector =3D header_sectors +
> +            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
> =20
>      block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>      block->payload_offset =3D luks->header.payload_offset_sector *

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

