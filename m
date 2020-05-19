Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1691C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776E620709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHkMo3Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776E620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxcF-00021v-KB
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jaxbT-0001Ib-G6
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:27:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jaxbR-0007V2-MA
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589876876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8zNl1furgodCsnB0y9GzQeUIzBe1BGSJrs1JTbcccM=;
 b=jHkMo3Cp+Utjl9OUKMNr+yAL0FZApCtbz1CMYzT/gjMy0zLqaEa4WkyPLCq4j7P2vUybpL
 yPomDPuuXuF/RYi9Ud9uRZnOtaQmQda/Q3BQ5AGz3GP4OIVsOi14+/uS5Er1JNKLThTZKl
 7GeqMx1B9UppXP665Va0WTqaV1erb08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-JB0hT40PMImHAsgwl4avJg-1; Tue, 19 May 2020 04:27:54 -0400
X-MC-Unique: JB0hT40PMImHAsgwl4avJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9772B8018AD;
 Tue, 19 May 2020 08:27:53 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE07579A6;
 Tue, 19 May 2020 08:27:50 +0000 (UTC)
Date: Tue, 19 May 2020 10:27:48 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200519082748.GE2995787@angien.pipo.sk>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 15:49:02 -0500, Eric Blake wrote:
> On 5/13/20 10:49 PM, John Snow wrote:

[...]

> > +
> > +    /* NB: new bitmap is anonymous and enabled */
> > +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> > +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> > +    if (!new_bitmap) {
> > +        return NULL;
> > +    }
> 
> This means if the guest writes to the disk while the job is ongoing, the
> bitmap will be updated to mark that portion of the bitmap as set, even if it
> was not allocated at the time the job started.  But then again, the guest
> writes are causing allocation, so this seems like the right thing to do.

Well, this could be made problem of the caller by skipping any newly
allocated sectors to be written to the bitmap. The caller then can
decide whether a snapshot of the allocation map is needed and thus a new
inactive bitmap should be used as the destination, or whether new writes
should be tracked by using an active bitmap.

> Do we need to worry about the converse case where the job started with
> something allocated but runs in parallel with the guest trimming, such that
> our bitmap marks something as set even though at the conclusion of our job
> it is no longer allocated?

Given the semantics above this would conveniently not be a problem of
the population job. If you create a snapshot of the allocation map any
any point we'd care about that state.

Anyways, from the point of view of the bitmap code any write to a sector
sets the bit so the trimming should not be treated differently.

Speicifically libvirt plans to use it on overlay(snapshot) images where
the btimaps are not present so in that case even trimmed sectors need to
mask the data in the backing image so they can technically be considered
as allocated too.


