Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454CC2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW8PrBjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454CC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAEt-0004Fg-Ad
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZAE4-0003cq-00
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:32:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZAE2-0006O2-D2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589448740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rgw6qoUMfArRxYwoJdP/OKb7MgiTeBBjM9t+ZLiI8Og=;
 b=TW8PrBjQ7SLIxrDO+ppORftM1xKmcnbVhU7wfrUaIpCXLb7hogt/MgSkV1Z1EwEM05XiJD
 paqN8te7YoI6F8xIaFW4eAsABAvUkfYsTiYZL9bQ4FDoGkV/QiU5iO9e6VY0roJiGxz0rb
 ZKopCHUQXNFgN7kAuvVNrk0lkad6ylw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-mrdV_OGbOWSdnpwRlKIaYw-1; Thu, 14 May 2020 05:32:19 -0400
X-MC-Unique: mrdV_OGbOWSdnpwRlKIaYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D49A0BDA;
 Thu, 14 May 2020 09:32:18 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56BF476E9F;
 Thu, 14 May 2020 09:32:16 +0000 (UTC)
Date: Thu, 14 May 2020 10:32:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200514093213.GD2787@work-vm>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200514084242.GB2787@work-vm>
 <146b4724-69b8-93b5-e2ac-b909721f530b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <146b4724-69b8-93b5-e2ac-b909721f530b@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 14.05.20 10:42, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> > 
> > <snip>
> > 
> >> +void qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList *mapping,
> >> +                                         Error **errp)
> >> +{
> >> +    QDict *in_mapping = qdict_new();
> >> +    QDict *out_mapping = qdict_new();
> >> +
> >> +    for (; mapping; mapping = mapping->next) {
> >> +        MigrationBlockNodeMapping *entry = mapping->value;
> >> +
> >> +        if (qdict_haskey(out_mapping, entry->node_name)) {
> >> +            error_setg(errp, "Cannot map node name '%s' twice",
> >> +                       entry->node_name);
> >> +            goto fail;
> >> +        }
> > 
> > I'm not too clear exactly which case this is protecting against;
> > I think that's protecting against mapping
> > 
> >   'src1'->'dst1' and 'src1'->'dst2'
> > which is a good check.s (or maybe it's checking against dst2 twice?)
> 
> This one is against mapping src1 twice.  Both checks together check that
> it’s a one-to-one bijective mapping.
> 
> The technical reason why it needs to be one-to-one is because we base
> two QDicts off of it, so the inverse mapping needs to work.
> 
> > What about cases where there is no mapping - e.g. imagine
> > that we have b1/b2 on the source and b2/b3 on the dest; now
> > if we add just a mapping:
> > 
> >   b1->b2
> > 
> > then we end up with:
> > 
> >   b1 -> b2
> >   b2 -> b2  (non-mapped)
> >         b3
> > 
> > so we have a clash there - are we protected against that?
> 
> Oh, no, we aren’t.  That wasn’t intentional.  However, I’m not sure how
> we’d protect against it.  We can’t check it in
> qmp_migrate_set_bitmap_node_mapping(), because we don’t know yet which
> nodes will exist at the time of migration, and which of those will have
> bitmaps.
> 
> So we’d need to check it as part of the migration process (by looking up
> any unmapped entries that default to the identity mapping in the
> respective reverse mapping, to see whether anything maps to the same name).

Yeh a once through check of all the nodes at the start of the migration
would probably fix it.

> OTOH, Vladimir proposed adding a parameter to
> migrate-set-bitmap-node-mapping that would make migration fail if any
> bitmaps should be migrated off of unmapped nodes, or if any incoming
> alias is unmapped (instead of defaulting to the identity mapping).  If
> we just make that the only behavior, then we wouldn’t have a problem
> with that at all, because all unmapped nodes would always throw an error.

Yeh that would force you to put a full mapping table in place.

> (And on the third hand, I wonder whether we should actually allow
> migrating bitmaps from multiple nodes to a single one, but I suppose
> that would require two separate commands, one for incoming and one for
> outgoing...)

Wouldn't that get very messy?

Dave

> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


