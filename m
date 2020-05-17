Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62243C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E7A2065F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfdbfO2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E7A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaES5-0002oi-96
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 04:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaEQv-0002Hm-76
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:14:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaEQs-0003hV-2u
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589703236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKy9YqVVCZ3uhdLyEgORMybMHMWOG4YiGF1AbNk3i7I=;
 b=bfdbfO2KNtOEExUqq54HA6J0LN8uDdj5DbkQrxY5bFQHJGzPAci/d8jU02koPD+XaIso89
 E5q3T69npkHCRV3aOs0xIW3BdOeTjzpAYn2MOMN9hOk7ID6bzuMhvZloh18rbY76/GPyfl
 XwOw5HbKRcCxaKe2u2a27prUxuhhZf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hhNcMJlqMkGE40NDt0wGtQ-1; Sun, 17 May 2020 04:13:54 -0400
X-MC-Unique: hhNcMJlqMkGE40NDt0wGtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F710461;
 Sun, 17 May 2020 08:13:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CCD5D9D3;
 Sun, 17 May 2020 08:13:50 +0000 (UTC)
Message-ID: <07063bb064e00eab5966f015f9cf8767f8afe10e.camel@redhat.com>
Subject: Re: [PATCH v6 02/14] qcrypto/luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 17 May 2020 11:13:49 +0300
In-Reply-To: <48813eda-4fa9-6988-296d-58793e8b812f@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-3-mlevitsk@redhat.com>
 <48813eda-4fa9-6988-296d-58793e8b812f@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 02:23:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-14 at 13:56 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > Next few patches will expose that functionality to the user.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  crypto/block-luks.c | 395 +++++++++++++++++++++++++++++++++++++++++++-
> >  qapi/crypto.json    |  61 ++++++-
> >  2 files changed, 452 insertions(+), 4 deletions(-)
> > 
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 4861db810c..967d382882 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> 
> [...]
> 
> > @@ -1069,6 +1076,119 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
> >      return -1;
> >  }
> >  
> > +/*
> > + * Returns true if a slot i is marked as active
> > + * (contains encrypted copy of the master key)
> > + */
> > +static bool
> > +qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
> > +                               unsigned int slot_idx)
> > +{
> > +    uint32_t val = luks->header.key_slots[slot_idx].active;
> > +    return val ==  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> 
> One space too many after the ==.
Fixed, thanks!
> 
> [...]
> 
> > +/*
> > + * Erases an keyslot given its index
> > + * Returns:
> > + *    0 if the keyslot was erased successfully
> > + *   -1 if a error occurred while erasing the keyslot
> > + *
> > + */
> > +static int
> > +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> > +                             unsigned int slot_idx,
> > +                             QCryptoBlockWriteFunc writefunc,
> > +                             void *opaque,
> > +                             Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks = block->opaque;
> > +    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
> > +    g_autofree uint8_t *garbagesplitkey = NULL;
> > +    size_t splitkeylen = luks->header.master_key_len * slot->stripes;
> 
> This accesses header.key_slots[slot_idx] before...
> 
> > +    size_t i;
> > +    Error *local_err = NULL;
> > +    int ret;
> > +
> > +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> 
> ...we assert that slot_idx is in bounds.
Fixed, thanks as well!
There are few more places where I didn't place this assert,
and I added it just in case.

> 
> I suppose that’s kind of fine, because assertions aren’t meant to fire
> either, but this basically makes the assertion useless.
> 
> > +    assert(splitkeylen > 0);
> > +    garbagesplitkey = g_new0(uint8_t, splitkeylen);
> > +
> > +    /* Reset the key slot header */
> > +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> > +    slot->iterations = 0;
> > +    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +
> > +    ret = qcrypto_block_luks_store_header(block,  writefunc,
> 
> Superfluous space after the comma.
True, fixed.

> 
> > +                                          opaque, &local_err);
> > +
> > +    if (ret < 0) {
> > +        error_propagate(errp, local_err);
> > +    }
> 
> error_propagate() is a no-op with local_err == NULL, so you could do
> without checking @ret (just calling error_propagate() unconditionally).
> 
> (But who cares, we need to set @ret anyway, so we might as well check it.)
Yep.
> 
> [...]
> 
> > +static int
> > +qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
> > +                                     QCryptoBlockReadFunc readfunc,
> > +                                     QCryptoBlockWriteFunc writefunc,
> > +                                     void *opaque,
> > +                                     QCryptoBlockAmendOptionsLUKS *opts_luks,
> > +                                     bool force,
> > +                                     Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks = block->opaque;
> > +    uint64_t iter_time = opts_luks->has_iter_time ?
> > +                         opts_luks->iter_time :
> > +                         QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> > +    int keyslot;
> > +    g_autofree char *old_password = NULL;
> > +    g_autofree char *new_password = NULL;
> > +    g_autofree uint8_t *master_key = NULL;
> 
> (I assume we don’t really care about purging secrets from memory after use)
Yep, I tried once fixing this but I decided to just leave it as is,
and later fix in independent patch series, which would need to touch
much that luks (we for example keep the qcrypto secrets in memory as well).


> 
> [...]
> 
> > +static int
> > +qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
> > +                                        QCryptoBlockReadFunc readfunc,
> > +                                        QCryptoBlockWriteFunc writefunc,
> > +                                        void *opaque,
> > +                                        QCryptoBlockAmendOptionsLUKS *opts_luks,
> > +                                        bool force,
> > +                                        Error **errp)
> > +{
> 
> [...]
> 
> > +        for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +            int rv = qcrypto_block_luks_load_key(block,
> > +                                                 i,
> > +                                                 old_password,
> > +                                                 tmpkey,
> > +                                                 readfunc,
> > +                                                 opaque,
> > +                                                 errp);
> > +            if (rv == -1) {
> > +                return -1;
> > +            } else if (rv == 1) {
> > +                bitmap_set(&slots_to_erase_bitmap, i, 1);
> 
> We should assert that QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS <=
> sizeof(slots_to_erase_bitmap) * 8.  As it is, this looks like a possible
> out-of-bounds access on first glance.
OK, fixed.

> 
> [...]
> 
> > +static int
> > +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> > +                                 QCryptoBlockReadFunc readfunc,
> > +                                 QCryptoBlockWriteFunc writefunc,
> > +                                 void *opaque,
> > +                                 QCryptoBlockAmendOptions *options,
> > +                                 bool force,
> > +                                 Error **errp)
> > +{
> > +    QCryptoBlockAmendOptionsLUKS *opts_luks = &options->u.luks;
> > +
> > +    if (opts_luks->state == Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE_ACTIVE) {
> 
> switch { case } might be nicer to catch unhandled cases.  Or else if +
> else { g_assert_not_reached() }.
> 
> > +        return qcrypto_block_luks_amend_add_keyslot(block, readfunc,
> > +                                                    writefunc, opaque,
> > +                                                    opts_luks, force, errp);
> > +    } else {
> > +        return qcrypto_block_luks_amend_erase_keyslots(block, readfunc,
> > +                                                       writefunc, opaque,
> > +                                                       opts_luks, force, errp);
> > +    }
> > +}
This function used to contain the whole thing, and was converted to a wrapper at the
final minute, so yeh, I agree, a switch will be nice here.
Done.


> 
> [...]
> 
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index aeb6c7ef7b..29276e5e5e 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -1,6 +1,8 @@
> >  # -*- Mode: Python -*-
> >  #
> >  
> > +{ 'include': 'common.json' }
> > +
> 
> Why?  Seems to compile without it just fine.
Lefover from the days of me using the StrOrNull
Fixed.

> 
> Max
> 

Thanks for the review!
Best regards,
	Maxim Levitsky


