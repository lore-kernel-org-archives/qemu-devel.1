Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61615206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC0gxQXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61615206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg4rm-0005oS-N8
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jg4r3-0005J2-65
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:13:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jg4r0-0000h5-SB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591096387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duwyCSAOfXnCzdupzn/gf8mkl0T7zjWfMCiI9q1AsQk=;
 b=YC0gxQXeucQ62xAIYEPd9znDVy41ed3la5Vq06QBIROig1jEvagNBN8tFRKY3qFTH1Kpn6
 OVP+8ghBWfJJoGlq4340WJEpE7QreLiuuOjJ1/JKi7gIPxi4hUCTtc9sirUwuX86eS4wAB
 GZ09e5CA6wuHkU/bcLBoeBcDxqOrKhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-70vHO9ZWPFC51LI26pmsag-1; Tue, 02 Jun 2020 07:13:03 -0400
X-MC-Unique: 70vHO9ZWPFC51LI26pmsag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55BC88018AB;
 Tue,  2 Jun 2020 11:13:02 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FD7A78EFB;
 Tue,  2 Jun 2020 11:13:00 +0000 (UTC)
Date: Tue, 2 Jun 2020 13:12:57 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200602111257.GU2995787@angien.pipo.sk>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200518162648.GC2995787@angien.pipo.sk>
 <1216f9b8-d9b6-204c-b0a9-06c14b286413@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1216f9b8-d9b6-204c-b0a9-06c14b286413@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 02, 2020 at 12:56:32 +0200, Max Reitz wrote:
> On 18.05.20 18:26, Peter Krempa wrote:
> > On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:
> >> This command allows mapping block node names to aliases for the purpose
> >> of block dirty bitmap migration.
> >>
> >> This way, management tools can use different node names on the source
> >> and destination and pass the mapping of how bitmaps are to be
> >> transferred to qemu (on the source, the destination, or even both with
> >> arbitrary aliases in the migration stream).
> >>
> >> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---

[...]

> >> +# @migrate-set-bitmap-node-mapping:
> > 
> > qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
> > of migrate-set-parameters. Is it worth/necessary to add a new command
> > here?
> 
> I wasn’t aware of that.  It would probably indeed make sense from a
> user’s perspective.
> 
> It would make the implementation rather different, though, because
> instead of putting the mapping locally (and statically) into
> migration/block-dirty-bitmap.c, it would require putting it into the
> central MigrationState.  Which isn’t to say it’d be worse.  I suppose
> it’d be better, actually, but I’ll have to try to say for sure.
> 
> You also suggested “setting nothing will clear the mapping” in your
> second mail.  That would be a weird default.  Right now, the default for
> all migration parameters is to leave them as-is, so it would be different.
> 
> The first question would be: What do you mean by “clear the mapping”?
> Reset it to the original identity mapping?  Or actually clear it, so
> that no bitmap is migrated?  I presume the former, because the latter
> can easily be achieved by passing an empty array.

Yeah, lucikily this is easy with json:

default mapping:

"mapping": null

empty mapping:

"mapping": [ ]

> I understand that it seems to make sense to be able to return to the
> original identity mapping, but is there actually a use for this?  After
> you have started using a custom mapping, wouldn’t you always use custom
> mappings?

Libvirt mostly doesn't care. Downgrade of libvirt version is unsupported
so this should not be a problem.

> If there is a use for it, I think the better way to do it would be to
> use an alternate type where an explicit null resets the mapping to the
> identity mapping.

yes :)


