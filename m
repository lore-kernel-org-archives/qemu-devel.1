Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002C6207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm3YByX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002C6207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOjk-0001lk-9f
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOT2-0005B1-EO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:23:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOSw-0005fD-7F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593793385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXbqi18zuYAUAUlj5zh3aEhL+GzySFPFP88WbTLgBqI=;
 b=Mm3YByX9U1MjjrvB5F6emQjmaEt4F5WFq41IuNSpmVQ3VvLr3VvrMR0cVDMXfZwicTysaH
 zVwPazA8cNCKyhb5JMMLy1CVjyYt+xmxO/0K5ItUk6H3Sw3cAsQWV/BKj0e9gCed44wWIP
 nOk4BAHPoogvO6fJoDfs9yBwJAwwvog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-MFnR3dCJPMOdBmp92p9VSw-1; Fri, 03 Jul 2020 12:22:52 -0400
X-MC-Unique: MFnR3dCJPMOdBmp92p9VSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B31C18FF664;
 Fri,  3 Jul 2020 16:22:51 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 952582DE8F;
 Fri,  3 Jul 2020 16:22:48 +0000 (UTC)
Date: Fri, 3 Jul 2020 17:22:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200703162246.GI6641@work-vm>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
 <20200702182452.GP1888119@redhat.com>
 <20200703154933.GE6641@work-vm>
 <20200703160235.GM2213227@redhat.com>
 <20200703161012.GH6641@work-vm>
 <20200703161654.GN2213227@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703161654.GN2213227@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Fri, Jul 03, 2020 at 05:10:12PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > On Fri, Jul 03, 2020 at 04:49:33PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > > > On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> > > > > > On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> > > > > > > savevm, loadvm and delvm are some of the few commands that have never
> > > > > > > been converted to use QMP. The primary reason for this lack of
> > > > > > > conversion is that they block execution of the thread for as long as
> > > > > > > they run.
> > > > > > > 
> > > > > > > Despite this downside, however, libvirt and applications using libvirt
> > > > > > > has used these commands for as long as QMP has existed, via the
> > > > > > > "human-monitor-command" passthrough command. IOW, while it is clearly
> > > > > > > desirable to be able to fix the blocking problem, this is not an
> > > > > > > immediate obstacle to real world usage.
> > > > > > > 
> > > > > > > Meanwhile there is a need for other features which involve adding new
> > > > > > > parameters to the commands. This is possible with HMP passthrough, but
> > > > > > > it provides no reliable way for apps to introspect features, so using
> > > > > > > QAPI modelling is highly desirable.
> > > > > > > 
> > > > > > > This patch thus introduces trival savevm, loadvm, delvm commands
> > > > > > 
> > > > > > trivial
> > > > > > 
> > > > > > > to QMP that are functionally identical to the HMP counterpart, including
> > > > > > > the blocking problem.
> > > > > > 
> > > > > > Should we name them 'x-savevm', 'x-loadvm', 'x-delvm' to give ourselves room
> > > > > > to change them when we DO solve the blocking issue?  Or will the solution of
> > > > > > the blocking issue introduce new QMP commands, at which point we can add QMP
> > > > > > deprecation markers on these commands to eventually retire them?
> > > > > 
> > > > > I was in two minds about this, so I'm open to arguments either way.
> > > > > 
> > > > > The primary goal is for libvirt to consume the APIs as soon as possible,
> > > > > and generally libvirt doesn't want todo this is they are declared experimental
> > > > > via a "x-" prefix. So that pushes me away from "x-".
> > > > > 
> > > > > If we don't have an "x-" prefix and want to make changes, we can add extra
> > > > > parameters to trigger new behaviour in backwards compatible manner. Or we can
> > > > > simply deprecate these commands, deleting them 2 releases later, while adding
> > > > > completely new commands.
> > > > > 
> > > > > If we think the prposed design will definitely need incompatible changes in
> > > > > a very short time frame though, that would push towards "x-".
> > > > > 
> > > > > So IMHO the right answer largely depends on whether there is a credible
> > > > > strategy to implement the ideal non-blocking solution in a reasonable amount
> > > > > of time. I can't justify spending much time on this myself, but I'm willing
> > > > > to consider & try proposals for solving the blocking problem if they're not
> > > > > too complex / invasive.
> > > > 
> > > > Remind me, what was the problem with just making a block: migration
> > > > channel, and then we can migrate to it?
> > > 
> > > migration only does vmstate, not disks. The current blockdev commands
> > > are all related to external snapshots, nothing for internal snapshots
> > > AFAIK. So we still need commands to load/save internal snapshots of
> > > the disk data in the qcow2 files.
> > > 
> > > So we could look at loadvm/savevm conceptually as a syntax sugar above
> > > a migration transport that targets disk images, and blockdev QMP command
> > > that can do internal snapshots. Neither of these exist though and feel
> > > like a significantly larger amount of work than using existing functionality
> > > that is currently working.
> > 
> > I think that's what we should aim for; adding this wrapper isn't gaining
> > that much without moving a bit towards that; so I would stick with the
> > x- for now.
> 
> The question is how much work that approach will be and whether anyone can
> realistically commit to doing that ? It looks like a much larger piece of
> work in both QEMU and libvirt side to do that. I don't want to see us stuck
> with a x-savevm for years because no one has resource to work on the perfect
> solution. If we did get a perfect solution at a point in future, we can
> still deprecate and then remove any "savevm" command we add to QMP.

I'd at least like to understand that we've got a worklist for it though.
We've already got qemu_fopen_bdrv - what's actually wrong with that - is
that enough to do the migrate to a stream (given a tiny amount of
syntax) ?

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


