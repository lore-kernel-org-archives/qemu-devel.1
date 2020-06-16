Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319020739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF6ukEVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC90-0007zK-Q0
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlC6H-00038E-8q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:58:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlC6E-0003CU-Fm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592315880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxDodg8ROY+/ZhLEXQVJSKCaJfuVRHBsSJhxdg0auwY=;
 b=UF6ukEVN4NkV11NZRF1SPS2zDbKssEBozGMo7KNMq5YfzGMFhyjkqr+Pos4e2MdsKhP93Y
 rCHY3PbFfBmEiRlSc5kerX++RpJnjCNX1Oy66C204Z2erRh9cYX26FT+2pftU7VCHQJB3X
 QmavBGl5Z0OCJQp1es1fPT4/CNJ83Ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-4L6UW6qVOIOz-V-_bwC4gw-1; Tue, 16 Jun 2020 09:57:58 -0400
X-MC-Unique: 4L6UW6qVOIOz-V-_bwC4gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34B8018A8229;
 Tue, 16 Jun 2020 13:57:57 +0000 (UTC)
Received: from starship (unknown [10.35.206.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D22D7CCE8;
 Tue, 16 Jun 2020 13:57:46 +0000 (UTC)
Message-ID: <be57ad36212353a088ae88d9b84396874b29856f.camel@redhat.com>
Subject: Re: [PATCH v8 07/14] block/crypto: implement the encryption key
 management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 16 Jun 2020 16:57:45 +0300
In-Reply-To: <99997649-bf06-f494-8dce-c12bb1d17b66@redhat.com>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
 <20200608094030.670121-8-mlevitsk@redhat.com>
 <99997649-bf06-f494-8dce-c12bb1d17b66@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-06-08 at 14:14 +0200, Max Reitz wrote:
> On 08.06.20 11:40, Maxim Levitsky wrote:
> > This implements the encryption key management using the generic code in
> > qcrypto layer and exposes it to the user via qemu-img
> > 
> > This code adds another 'write_func' because the initialization
> > write_func works directly on the underlying file, and amend
> > works on instance of luks device.
> > 
> > This commit also adds a 'hack/workaround' I and Kevin Wolf (thanks)
> > made to make the driver both support write sharing (to avoid breaking the users),
> > and be safe against concurrent  metadata update (the keyslots)
> > 
> > Eventually the write sharing for luks driver will be deprecated
> > and removed together with this hack.
> > 
> > The hack is that we ask (as a format driver) for BLK_PERM_CONSISTENT_READ
> > and then when we want to update the keys, we unshare that permission.
> > So if someone else has the image open, even readonly, encryption
> > key update will fail gracefully.
> > 
> > Also thanks to Daniel Berrange for the idea of
> > unsharing read, rather that write permission which allows
> > to avoid cases when the other user had opened the image read-only.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  block/crypto.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  block/crypto.h |  34 +++++++++++++
> >  2 files changed, 161 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 1960b47ceb..b9c40e6922 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> 
> [...]
> 
> > +static void
> > +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > +                         const BdrvChildRole role,
> 
> Well, it isn’t wrong to have this be a const, nor is it against any
> coding guidelines.  While I do believe this was an accident, I also
> think that in fact, maybe being strict about const-ness is what we
> should’ve done everywhere from the start.
> 
> So this is not a complaint, quite the contrary.
> 
> (I felt it was interesting enough to warrant this mail.  *shrug*)

Yep, that was 100% accident I confess.

Best regards,
	Maxim Levitsky

> 
> > +                         BlockReopenQueue *reopen_queue,
> > +                         uint64_t perm, uint64_t shared,
> > +                         uint64_t *nperm, uint64_t *nshared)
> > +{
> > +
> > +    BlockCrypto *crypto = bs->opaque;
> > +
> > +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
> > +
> > +    /*
> > +     * For backward compatibility, manually share the write
> > +     * and resize permission
> > +     */
> > +    *nshared |= (BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +    /*
> > +     * Since we are not fully a format driver, don't always request
> > +     * the read/resize permission but only when explicitly
> > +     * requested
> > +     */
> > +    *nperm &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +    *nperm |= perm & (BLK_PERM_WRITE | BLK_PERM_RESIZE);
> 
> Looks good, thanks!
> 
> Max
> 



