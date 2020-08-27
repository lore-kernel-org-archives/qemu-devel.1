Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97ADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A4022CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7zx2JGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A4022CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBL54-0002DG-SV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfoster@redhat.com>)
 id 1kBL4E-0001Os-CB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:48:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <bfoster@redhat.com>)
 id 1kBL4A-0003UO-CO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598546873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++InBjskBUT021uU8278WFMqMyljhryA671fVTnvT0Y=;
 b=c7zx2JGqnkiOr+tIr4Xt7zmTMOyjGVj3Q2Z5J54njcdGt/AwRKLJB0Rg1nLSqT3UQJTHg0
 lGxJPJA1I/694sXRQAd6Rm2HmZ3x3DhrgthkUjWV7btVVu6em2zP+zzOdL72rtDGfgh1sj
 F/5XT2pbZvChrrVGNghwTPGJn5h4KEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-w_twRgycNF2ie7vPuX5feg-1; Thu, 27 Aug 2020 12:47:50 -0400
X-MC-Unique: w_twRgycNF2ie7vPuX5feg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFCCE801AC2;
 Thu, 27 Aug 2020 16:47:48 +0000 (UTC)
Received: from bfoster (ovpn-112-11.rdu2.redhat.com [10.10.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE4E55C1C2;
 Thu, 27 Aug 2020 16:47:47 +0000 (UTC)
Date: Thu, 27 Aug 2020 12:47:45 -0400
From: Brian Foster <bfoster@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
Message-ID: <20200827164745.GA434083@bfoster>
References: <20200820215811.GC7941@dread.disaster.area>
 <20200821110506.GB212879@bfoster>
 <w51364gjkcj.fsf@maestria.local.igalia.com>
 <w51zh6oi4en.fsf@maestria.local.igalia.com>
 <20200821170232.GA220086@bfoster>
 <w51d03evrol.fsf@maestria.local.igalia.com>
 <20200825165415.GB321765@bfoster>
 <w51d03etzj8.fsf@maestria.local.igalia.com>
 <20200825194724.GA338144@bfoster>
 <w51wo1l6ytj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51wo1l6ytj.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=207.211.31.120; envelope-from=bfoster@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Dave Chinner <david@fromorbit.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 08:34:32PM +0200, Alberto Garcia wrote:
> On Tue 25 Aug 2020 09:47:24 PM CEST, Brian Foster <bfoster@redhat.com> wrote:
> > My fio fallocates the entire file by default with this command. Is that
> > the intent of this particular test? I added --fallocate=none to my test
> > runs to incorporate the allocation cost in the I/Os.
> 
> That wasn't intentional, you're right, it should use --fallocate=none (I
> don't see a big difference in my test anyway).
> 
> >> The Linux version is 4.19.132-1 from Debian.
> >
> > Thanks. I don't have LUKS in the mix on my box, but I was running on a
> > more recent kernel (Fedora 5.7.15-100). I threw v4.19 on the box and
> > saw a bit more of a delta between XFS (~14k iops) and ext4 (~24k). The
> > same test shows ~17k iops for XFS and ~19k iops for ext4 on v5.7. If I
> > increase the size of the LVM volume from 126G to >1TB, ext4 runs at
> > roughly the same rate and XFS closes the gap to around ~19k iops as
> > well. I'm not sure what might have changed since v4.19, but care to
> > see if this is still an issue on a more recent kernel?
> 
> Ok, I gave 5.7.10-1 a try but I still get similar numbers.
> 

Strange.

> Perhaps with a larger filesystem there would be a difference? I don't
> know.
> 

Perhaps. I believe Dave mentioned earlier how log size might affect
things.

I created a 125GB lvm volume and see slight deltas in iops going from
testing directly on the block device, to a fully allocated file on
XFS/ext4 and then to a preallocated file on XFS/ext4. In both cases the
numbers are comparable between XFS and ext4. On XFS, I can reproduce a
serious drop in iops if I reduce the default ~64MB log down to 8MB.
Perhaps you could try increasing your log ('-lsize=...' at mkfs time)
and see if that changes anything?

Beyond that, I'd probably try to normalize and simplify your storage
stack if you wanted to narrow it down further. E.g., clean format the
same bdev for XFS and ext4 and pull out things like LUKS just to rule
out any poor interactions.

Brian

> Berto
> 


