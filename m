Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF992C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0E9207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uifl/ymN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E9207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8iVr-0003Ch-0q
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iV6-0002OO-EZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:12:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iV4-0000bQ-UW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597921974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvRw29diqQmXhsD6iCFZ89xhTaRY4DeBmMfva0LR3Xs=;
 b=Uifl/ymNhkXr3j+dE5Q60L6UIO8NzgRHHcAREWbyXrlCvSdstw7mLF6pKhkYd0hCcXuGOa
 rvCehzhIRUU43rm14nz+q8cJZH+EieCvAqAyAgWilR9Eqsj+5GHUQxFpB3xLedPzmkcsyW
 hFBtynGHRBvjTzVdDr/hlOxsp8TC0bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-RuyputajPD-2Ppvk2qPY_g-1; Thu, 20 Aug 2020 07:12:50 -0400
X-MC-Unique: RuyputajPD-2Ppvk2qPY_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34CB8100670F;
 Thu, 20 Aug 2020 11:12:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24FBD2B598;
 Thu, 20 Aug 2020 11:12:45 +0000 (UTC)
Date: Thu, 20 Aug 2020 13:12:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 08/22] nbd: Add max-connections to nbd-server-start
Message-ID: <20200820111244.GC99531@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-9-kwolf@redhat.com>
 <973cb8f5-b042-fa70-da45-0aefeaad2fcd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <973cb8f5-b042-fa70-da45-0aefeaad2fcd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.08.2020 um 22:00 hat Eric Blake geschrieben:
> On 8/13/20 11:29 AM, Kevin Wolf wrote:
> > This is a QMP equivalent of qemu-nbd's --share option, limiting the
> > maximum number of clients that can attach at the same time.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-export.json         | 10 ++++++++--
> >   include/block/nbd.h            |  3 ++-
> >   block/monitor/block-hmp-cmds.c |  2 +-
> >   blockdev-nbd.c                 | 33 ++++++++++++++++++++++++++-------
> >   qemu-storage-daemon.c          |  4 ++--
> >   5 files changed, 39 insertions(+), 13 deletions(-)
> > 
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index 40369814b4..1fdc55c53a 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -14,6 +14,8 @@
> >   #             is only resolved at time of use, so can be deleted and
> >   #             recreated on the fly while the NBD server is active.
> >   #             If missing, it will default to denying access (since 4.0).
> > +# @max-connections: The maximum number of connections to allow at the same
> > +#                   time, 0 for unlimited. (since 5.2; default: 0)
> 
> Nice way to add feature parity.
> 
> Limiting the number of connections (particularly for a writable client,
> where we cannot guarantee cache consistency between the connections), seems
> like a worthwhile feature to have; I've always found it odd that qemu-nbd
> and QMP nbd-server-add defaulted to different limits (1 vs. unlimited).  For
> reference, nbdkit defaults to unlimited, and I'm happy if
> qemu-storage-daemon does likewise; but changing qemu-nbd's default of 1
> would be backwards incompatible and may cause surprises (there's always
> 'qemu-nbd -e' when needed).  I also wonder if we should change 'qemu-nbd -e
> 0' to mean unlimited rather than an error (right now, qemu-iotests/common.rc
> uses -e 42 for all nbd-based tests for a saner limit than just 1, but it
> smells of being arbitrary compared to unlimited).

I think eventually the actual NBD server implementation in qemu-nbd
should go away and it should just reuse the QMP one. Changing the
default would remove one more difference between them, which can only be
helpful in this process. (Though of course having a different default is
still simple enough for a simple wrapper.)

Kevin


