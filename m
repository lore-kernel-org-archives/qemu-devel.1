Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31586C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41AF2072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqH63mNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41AF2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGUr-0004JM-6m
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jiGSz-0002Ns-Ah
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jiGSy-0006re-5R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591617683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66jggCPqgSBEugNPDS+QBih1yxY02/mopup0hUIi9U4=;
 b=eqH63mNEDIsXipN5f8wyMZKtCCgpo/9NuYlYGoP9aQCVvUzTcNqhrbWONIdpDaTaocIDsX
 d62OS7aS8GngVHmL+b0QbEcNz1FSw/lXWD35IpZwEf5cEKdpKCizquad/q9RcEIN06LWbM
 WDH1FIJ3Vaq8u7xyftIbClfJIJS+9zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_Dq_rOI3OgGmiEWT6sImHg-1; Mon, 08 Jun 2020 08:01:21 -0400
X-MC-Unique: _Dq_rOI3OgGmiEWT6sImHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED37100CCC2;
 Mon,  8 Jun 2020 12:01:20 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C764B5C1C5;
 Mon,  8 Jun 2020 12:01:17 +0000 (UTC)
Date: Mon, 8 Jun 2020 14:01:14 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200608120114.GA619314@angien.pipo.sk>
References: <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
 <20200608093812.GA400568@angien.pipo.sk>
 <f6be06b3-fc18-0adf-51b9-c69138ce2906@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f6be06b3-fc18-0adf-51b9-c69138ce2906@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 13:30:48 +0300, Vladimir Sementsov-Ogievskiy wrote:
> 08.06.2020 12:38, Peter Krempa wrote:
> > On Sat, Jun 06, 2020 at 09:55:13 +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > 05.06.2020 13:59, Peter Krempa wrote:

[...]

> > 
> > It's not only a "user forgot" thing, but more that a systemic change
> > would be required.
> > 
> > Additionally until _very_ recently it wasn't possible to create bitmaps
> > using qemu-img, which made it impossible to create overlays for inactive
> 
> Didn't you consider to use qemu started in stopped mode to do block
> operations in same manner as for running vm? What's wrong with it?
> Also, there is qemu-storage-daemon, which is developed as separated
> binary, where block-layer is compiled in together with QMP interface.

It's still considered, but I didn't have time to implement anything
related to it and nobody else implemented it either.

Additionally the problem isn't in libvirt's handling but more in other
apps handling. We still due to historical reasons support if users
create overlays outside of libvirt.

This would mean that either backups break if the overlay is not done
properly or we have to have a fallback to use
'block-dirty-bitmap-populate'. At this point for both my sanity and
actually finishing all the details in regards to incremental backup

> > VMs. Arguably this has changed so we could require it. It still adds a
> > moving part which can break if the user doesn't add the bitmap or
> > requires yet another special case handling if we want to compensate for
> > that.
> > 
> > As of such, in libvirt's tech-preview implementation that is present
> > currently upstream, if you create a qcow2 overlay without adding the
> > appropriate bitmaps, the backups simply won't work.
> > 
> > > What do you think of granularity? We in Virtuozzo use 1M cluster as a default for qcow2 images. But we use 64k granularity (default) for bitmaps, to have smaller incremental backups. So, this is advantage of creating bitmap over relaying on block-status capturing by block-dirty-bitmap-populate: you don't control dirtiness granularity. So, I think that bitmap propagation, or just creating new dirty bitmap to track dirtiness from start of new snapshot is better.
> > 
> > This is a valid argument. Backups in this scenario will be bigger. I
> > still don't feel like the code needs to be made much more complex
> > because of it though.
> 
> May be, there is a simple solution? an option for blockdev-snapshot-sync to create a bitmap in a new image (or if you create image by qemu-img, just create bitmap by qemu-img as well, using new functionality).

You mean like we do now?:

https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_driver.c#L15020

That is slated to be deleted with my patchset though.

Good thing is that we can theoretically re-add it later.

For now I'd go with the simpler option that has fewer side effects.

> Isn't it simpler than to just use existing block-status-bitmap, than run a job?

No. Because we'd still need to support cases where user added an overlay
without the appropriate bitmap. As said I'd prefer to keep the code
simple and then work on optimizations. Good thing is that with 'one
active bitmap per point in time' this is simpler to achieve.

[...]

> > > 
> > > What is 'merge' step?
> > 
> > In some previous replies to Kevin, we discussed that it might be worth
> > optimizing 'block-dirty-bitmap-populate' to directly populate the bits
> > in the target bitmap rather than after the job is complete, so
> > efectively directly mering it. I probably described it wrong here.
> > 
> > > Do you mean that populating directly into target bitmap is not really needed?
> > 
> > I need the bitmap populated by 'block-dirty-bitmap-populate' to be
> > merged into multiple bitmaps in the new semantics. If the job itself
> > doesn't support that sematics, changing it to just to directly populate
> > one bitmap doesn't seem to be worth it since I'll be using intermediate
> > bitmaps anyways.
> > 
> 
> Hmm, if the main use case of populating job is to merge changes since snapshot to several bitmaps (all active bitmaps?), than I think it's correct to implement exactly this semantics, allowing a list of targets as well as list of source bitmaps. We even can reuse same structure for target-list which we use for source-list. And it's simple to implement in Qemu.

I'd mainly like for the design to converge. I actually have almost
complete patches which use the current semantics. I'm okay with
reworking it but at some point there should be a line when it won't
change.


