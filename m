Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B4F2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6S9RUEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B4F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHdL-0003bz-KM
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiHca-00030X-52
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:15:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32433
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiHcZ-0002r1-0A
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591622122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQXVEK7uCg2SwW/FZoaFVrf2vpH0WG+E/3+/XWZXA2I=;
 b=E6S9RUEiRiVvTgdATz6ey13FiJ+2PoIDPGZnB4ZEAqbPXGWKe9zyIGzmEwI64IBBKOwipx
 E45fv8AbAzN9pLeKiD3YJk/7aOXVHvStj5ftTGkWmeN6B8UIWcDvVyw3p2o6bsUaCpRuQv
 /Ps0pSWhJDr82eqTT3dbmvzWYkIdzq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Tyf0LdvoNTW60vXtxNXU7g-1; Mon, 08 Jun 2020 09:15:17 -0400
X-MC-Unique: Tyf0LdvoNTW60vXtxNXU7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2029B107AFAF;
 Mon,  8 Jun 2020 13:15:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFECF89280;
 Mon,  8 Jun 2020 13:15:02 +0000 (UTC)
Date: Mon, 8 Jun 2020 15:15:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200608131501.GC6419@linux.fritz.box>
References: <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
 <20200608092127.GB6419@linux.fritz.box>
 <0362d7ec-7584-e5e9-2619-f4a1fd292761@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <0362d7ec-7584-e5e9-2619-f4a1fd292761@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.06.2020 um 12:00 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 08.06.2020 12:21, Kevin Wolf wrote:
> > Am 06.06.2020 um 08:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Allowing to use one target for several populating job is an
> > > interesting idea. Current series does
> > > "bdrv_dirty_bitmap_set_busy(target_bitmap, true);", which forbids it..
> > > Hmm. If we just drop it, nothing prevents user just remove target
> > > bitmap during the job. So, we'll need something like collective-busy
> > > bitmap..
> > 
> > I'm not sure for what the busy flag is used in detail, but if this is
> > the problem, maybe it's possible to just replace it with a counter?
> 
> busy flag means that bitmap is already in-use by some process (for
> example backup, or exported through NBD, or being migrated). User
> can't change or use busy bitmaps for another jobs.

I think this rule is overly restrictive. That you can't delete a bitmap
that is in use is obvious. That you can't have more than one "consumer"
of dirty bits that clears bits after processing them seems at least
reasonable. But why shouldn't you be able to have more than one
"producer" of dirty bits?

> So multiple jobs writing into one bitmaps should be an exclusion from
> this rule (we want to allow several similar block-jobs, but still
> don't want to allow migration or NBD-export in the same time, or
> bitmap removing). I think we can just hardcode this case, add a new
> flag, which says that bitmap is used as target of populating jobs and
> being busy still allowed as a target for another populating job.

I think we need to find a more general pattern. Maybe the distinction I
made above between producer (setting dirty bits) and consumer (clearing
dirty bits) is what we need, or maybe we need something else to
distinguish roles. But I don't think the definition should have any
reference to bitmap-populate.

Kevin


