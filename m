Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4D3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0697F207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtzF3LbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697F207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3um-0007Gn-5n
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3tk-0006Ge-RD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:25:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3ti-0000DC-RN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593714322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsXhKCtm9Ibu1z9nqe5bDONCasaxloRB9E/5kwkGmJo=;
 b=AtzF3LbS72V5cC7l6icmeEwhUD5rtcEaFlaD3LAlc81rcaRv0F+Nj5LNm0jblKLmGA3yGP
 c33B8iMnkbM5/bwRrmTPCKKKL2PmrdTtXeqFxylCSmOvTwnq28Hz0sCTtb7iL6HyV+xpy3
 glgThytar+IsHtQl7AtqHKoN0QqDG3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fgtQZ-GPMhC_yDERcJAHcA-1; Thu, 02 Jul 2020 14:25:01 -0400
X-MC-Unique: fgtQZ-GPMhC_yDERcJAHcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72F448015F4;
 Thu,  2 Jul 2020 18:25:00 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AED5C1B0;
 Thu,  2 Jul 2020 18:24:56 +0000 (UTC)
Date: Thu, 2 Jul 2020 19:24:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200702182452.GP1888119@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> > savevm, loadvm and delvm are some of the few commands that have never
> > been converted to use QMP. The primary reason for this lack of
> > conversion is that they block execution of the thread for as long as
> > they run.
> > 
> > Despite this downside, however, libvirt and applications using libvirt
> > has used these commands for as long as QMP has existed, via the
> > "human-monitor-command" passthrough command. IOW, while it is clearly
> > desirable to be able to fix the blocking problem, this is not an
> > immediate obstacle to real world usage.
> > 
> > Meanwhile there is a need for other features which involve adding new
> > parameters to the commands. This is possible with HMP passthrough, but
> > it provides no reliable way for apps to introspect features, so using
> > QAPI modelling is highly desirable.
> > 
> > This patch thus introduces trival savevm, loadvm, delvm commands
> 
> trivial
> 
> > to QMP that are functionally identical to the HMP counterpart, including
> > the blocking problem.
> 
> Should we name them 'x-savevm', 'x-loadvm', 'x-delvm' to give ourselves room
> to change them when we DO solve the blocking issue?  Or will the solution of
> the blocking issue introduce new QMP commands, at which point we can add QMP
> deprecation markers on these commands to eventually retire them?

I was in two minds about this, so I'm open to arguments either way.

The primary goal is for libvirt to consume the APIs as soon as possible,
and generally libvirt doesn't want todo this is they are declared experimental
via a "x-" prefix. So that pushes me away from "x-".

If we don't have an "x-" prefix and want to make changes, we can add extra
parameters to trigger new behaviour in backwards compatible manner. Or we can
simply deprecate these commands, deleting them 2 releases later, while adding
completely new commands.

If we think the prposed design will definitely need incompatible changes in
a very short time frame though, that would push towards "x-".

So IMHO the right answer largely depends on whether there is a credible
strategy to implement the ideal non-blocking solution in a reasonable amount
of time. I can't justify spending much time on this myself, but I'm willing
to consider & try proposals for solving the blocking problem if they're not
too complex / invasive.

I just don't want to end up having a "x-savevm" command for another 10 years,
waiting for a perfect solution that never arrives because people always have
higher priority items, as apps are clearly able to accept the blocking problem
if the alternative is no snapshots at all.


> > +
> > +##
> > +# @savevm:
> > +#
> > +# Save a VM snapshot
> > +#
> > +# @tag: name of the snapshot to create. If it already
> > +# exists it will be replaced.
> > +#
> > +# Note that execution of the VM will be paused during the time
> > +# it takes to save the snapshot
> > +#
> > +# Returns: nothing
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "savevm",
> > +#      "data": {
> > +#         "tag": "my-snap"
> > +#      }
> > +#    }
> > +# <- { "return": { } }
> > +#
> > +# Since: 5.2
> 
> I guess you are NOT trying to make 5.1 soft freeze next week?

Correct. It is unrealistic to consider this for soft freeze.

I'd really love to have a solution in 5.2 though, even if it doesn't
solve all our problems. Something that can at least unblock apps that
want to use OVMF with internal snapshots today.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


