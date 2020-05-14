Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC8F2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Atu7ZVg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEk9-0002Pg-E2
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZEd3-0007pB-H6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZEd1-0003pC-UG
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589465666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kddAf0OUGIL+GWNN2CM1uGVSiQ/lYcCZ4WkqHaU4dpU=;
 b=Atu7ZVg3nRZstRRDJj+vGnt1G6w7NUvJ8b2jJCtoU6UV+po7cUnytArE+ARaEF5dOEfp5m
 ZUbk3fRxlemHbJ0Y4jFA6EncUer9/pdJVHB9rrt+IfpTzLxydDXw4Lf2buamYU5SVxLvVs
 BCuUWkbM5xX8vybsHMT0owvP/aSPF8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-Jn2WUKHyP1G8LbnBkVgUCg-1; Thu, 14 May 2020 10:14:25 -0400
X-MC-Unique: Jn2WUKHyP1G8LbnBkVgUCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 194421899528;
 Thu, 14 May 2020 14:14:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 151461001B07;
 Thu, 14 May 2020 14:14:21 +0000 (UTC)
Date: Thu, 14 May 2020 15:14:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v6 07/14] block/crypto: implement the encryption key
 management
Message-ID: <20200514141418.GJ1280939@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-8-mlevitsk@redhat.com>
 <1413abb3-f226-5ecc-3ea9-3dd945a134ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1413abb3-f226-5ecc-3ea9-3dd945a134ed@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 04:09:59PM +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
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
> > ---
> >  block/crypto.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  block/crypto.h |  34 +++++++++++++
> >  2 files changed, 158 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 2e16b62bdc..b14cb0ff06 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> 
> [...]
> 
> > +static void
> > +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > +                         const BdrvChildRole *role,
> > +                         BlockReopenQueue *reopen_queue,
> > +                         uint64_t perm, uint64_t shared,
> > +                         uint64_t *nperm, uint64_t *nshared)
> > +{
> > +
> > +    BlockCrypto *crypto = bs->opaque;
> > +
> > +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> > +            perm, shared, nperm, nshared);
> > +    /*
> > +     * Ask for consistent read permission so that if
> > +     * someone else tries to open this image with this permission
> > +     * neither will be able to edit encryption keys, since
> > +     * we will unshare that permission while trying to
> > +     * update the encryption keys
> > +     */
> > +    if (!(bs->open_flags & BDRV_O_NO_IO)) {
> > +        *nperm |= BLK_PERM_CONSISTENT_READ;
> > +    }
> 
> I’m not sure this is important, because this really means we won’t do
> I/O.  Its only relevant use in this case is for qemu-img info.  Do we
> really care if someone edits the key slots while qemu-img info is
> processing?

FWIW, OpenStack runs  qemu-img info in a periodic background job, so
it can be concurrent with anything else they are running. Having said
that due to previous QEMU bugs, they unconditonally pass the arg to
qemu-img to explicitly disable locking


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


