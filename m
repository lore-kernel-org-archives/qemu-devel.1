Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED1020723
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnB9+Imq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED1020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxSb-0006Eo-Sv
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqxIj-00045o-V8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:22:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqxIh-0005oy-SZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEIRLYDCugYR2H3a2D8pEfKRmmlFze6gYPTlF7c8iXU=;
 b=WnB9+ImqpYvAPaD2pTpVe+FvwcDcp+Bny4HXyDrSH+FijBQAdWSGVyRHMdySHo+3kXeiXe
 MAuQFTgoMUUCIJErV34m81XdZs/A8Q2ueyzifUtHWr1ksMGNQW6OyydMpYrae0w6PqQGf/
 zUp/hWnyX0L96cOxzlQ8TXbIi5hql6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-bphEbzXGNW2nDLyl-EU4cQ-1; Thu, 02 Jul 2020 07:22:40 -0400
X-MC-Unique: bphEbzXGNW2nDLyl-EU4cQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA86107ACCD;
 Thu,  2 Jul 2020 11:22:39 +0000 (UTC)
Received: from work-vm (ovpn-114-239.ams2.redhat.com [10.36.114.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2F060CD3;
 Thu,  2 Jul 2020 11:22:36 +0000 (UTC)
Date: Thu, 2 Jul 2020 12:22:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
Message-ID: <20200702112234.GB14863@work-vm>
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <20200630105121.GD2673@work-vm>
 <a6a3d41c-6bfa-3341-14f1-c2de9cbd1531@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a6a3d41c-6bfa-3341-14f1-c2de9cbd1531@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 30.06.20 12:51, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> This migration parameter allows mapping block node names and bitmap
> >> names to aliases for the purpose of block dirty bitmap migration.
> >>
> >> This way, management tools can use different node and bitmap names on
> >> the source and destination and pass the mapping of how bitmaps are to be
> >> transferred to qemu (on the source, the destination, or even both with
> >> arbitrary aliases in the migration stream).
> >>
> >> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  qapi/migration.json            |  83 +++++++-
> >>  migration/migration.h          |   3 +
> >>  migration/block-dirty-bitmap.c | 372 ++++++++++++++++++++++++++++-----
> >>  migration/migration.c          |  29 +++
> >>  4 files changed, 432 insertions(+), 55 deletions(-)
> >>
> >> diff --git a/qapi/migration.json b/qapi/migration.json
> >> index d5000558c6..5aeae9bea8 100644
> >> --- a/qapi/migration.json
> >> +++ b/qapi/migration.json
> >> @@ -507,6 +507,44 @@
> >>    'data': [ 'none', 'zlib',
> >>              { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
> >>  
> >> +##
> >> +# @BitmapMigrationBitmapAlias:
> >> +#
> >> +# @name: The name of the bitmap.
> >> +#
> >> +# @alias: An alias name for migration (for example the bitmap name on
> >> +#         the opposite site).
> >> +#
> >> +# Since: 5.1
> >> +##
> >> +{ 'struct': 'BitmapMigrationBitmapAlias',
> >> +  'data': {
> >> +      'name': 'str',
> >> +      'alias': 'str'
> >> +  } }
> >> +
> >> +##
> >> +# @BitmapMigrationNodeAlias:
> >> +#
> >> +# Maps a block node name and the bitmaps it has to aliases for dirty
> >> +# bitmap migration.
> >> +#
> >> +# @node-name: A block node name.
> >> +#
> >> +# @alias: An alias block node name for migration (for example the
> >> +#         node name on the opposite site).
> >> +#
> >> +# @bitmaps: Mappings for the bitmaps on this node.
> >> +#
> >> +# Since: 5.1
> >> +##
> >> +{ 'struct': 'BitmapMigrationNodeAlias',
> >> +  'data': {
> >> +      'node-name': 'str',
> >> +      'alias': 'str',
> >> +      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
> >> +  } }
> >> +
> >>  ##
> >>  # @MigrationParameter:
> >>  #
> >> @@ -641,6 +679,18 @@
> >>  #          will consume more CPU.
> >>  #          Defaults to 1. (Since 5.0)
> >>  #
> >> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> >> +#          aliases for the purpose of dirty bitmap migration.  Such
> >> +#          aliases may for example be the corresponding names on the
> >> +#          opposite site.
> >> +#          The mapping must be one-to-one and complete: On the source,
> >> +#          migrating a bitmap from a node when either is not mapped
> >> +#          will result in an error.  On the destination, similarly,
> >> +#          receiving a bitmap (by alias) from a node (by alias) when
> >> +#          either alias is not mapped will result in an error.
> >> +#          By default, all node names and bitmap names are mapped to
> >> +#          themselves. (Since 5.1)
> >> +#
> >>  # Since: 2.4
> >>  ##
> >>  { 'enum': 'MigrationParameter',
> >> @@ -655,7 +705,8 @@
> >>             'multifd-channels',
> >>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> >>             'max-cpu-throttle', 'multifd-compression',
> >> -           'multifd-zlib-level' ,'multifd-zstd-level' ] }
> >> +           'multifd-zlib-level' ,'multifd-zstd-level',
> >> +           'block-bitmap-mapping' ] }
> >>  
> >>  ##
> >>  # @MigrateSetParameters:
> >> @@ -781,6 +832,18 @@
> >>  #          will consume more CPU.
> >>  #          Defaults to 1. (Since 5.0)
> >>  #
> >> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> >> +#          aliases for the purpose of dirty bitmap migration.  Such
> >> +#          aliases may for example be the corresponding names on the
> >> +#          opposite site.
> >> +#          The mapping must be one-to-one and complete: On the source,
> >> +#          migrating a bitmap from a node when either is not mapped
> >> +#          will result in an error.  On the destination, similarly,
> >> +#          receiving a bitmap (by alias) from a node (by alias) when
> >> +#          either alias is not mapped will result in an error.
> >> +#          By default, all node names and bitmap names are mapped to
> >> +#          themselves. (Since 5.1)
> >> +#
> >>  # Since: 2.4
> >>  ##
> >>  # TODO either fuse back into MigrationParameters, or make
> >> @@ -811,7 +874,8 @@
> >>              '*max-cpu-throttle': 'int',
> >>              '*multifd-compression': 'MultiFDCompression',
> >>              '*multifd-zlib-level': 'int',
> >> -            '*multifd-zstd-level': 'int' } }
> >> +            '*multifd-zstd-level': 'int',
> >> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> > 
> > That's a hairy type for a migration parameter!
> > I'm curious what 'info migrate_parameters' does in hmp or what happens
> > if you try and set it?
> 
> Oh.  I didn’t know these were accessible via HMP.
> 
> As for setting it, that fails an assertion because I thus forgot to
> handle it in hmp_migrate_set_parameter().  I think the best thing to do
> would be to just error out, stating that you cannot set that parameter
> via HMP.

OK, we can clean that up sometime later; it seems an easy enough mapping
to add (I'd appreciate if you did, but won't force it).

> Similarly, info migrate_parameters doesn’t suport it, because I didn’t
> implement it in hmp_info_migrate_parameters().  Since
> hmp_info_migrate_parameters() seems to allow free-form reporting, I
> suppose we could report it as:
> 
> block-bitmap-mapping:
>   node1 -> alias1
>     bitmap1 -> bmap-alias1
>     bitmap2 -> bmap-alias2
>   node2 -> alias2
>     bitmap1 -> bmap-alias1
> 
> etc.
> 
> Or we just don’t report it there (apart from maybe “(present)”), because
> you can’t set it via migrate_set_parameter.
> 
> 
> If there’s any problem with exposing this via the migration parameters,
> I have no problem with adding a new QMP command as I did in the RFC.  I
> was just pointed towards the migration parameters by reviewers, which
> made sense to me, because, well, this kind of is a migration parameter.

Yep, seems like a migration parameter to me; it's just the first time
we've had such a hairy type in there;  make sure the libvirt people are
happy with using it that way please.

Dave

> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


