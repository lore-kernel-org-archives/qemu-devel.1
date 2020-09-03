Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B14C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0842C207EA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1WpXBcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0842C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmoY-0004EJ-3h
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDmnk-0002pW-Uh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDmni-0003HP-8o
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599130145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyeBm2HxP3qGxd+Y3yG3FK2yIce4QKdI+1An1dinHiA=;
 b=i1WpXBcMfvUwTSaRAKjzA/6osNhew4oLanqgWRRib75K2NEN+5j19VdXe8hiTqkoBI1nLx
 9XgYNCRwQQCq2BNQMZpD+73A8ZTkYibhM/jfR0RQxeEn+NKZMeedzLClaUdhI/dKB5MM95
 xn4Nw/fqHc/Zju4TVqBCiQZ6ZdAMkSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-D63tQvlaNe6hRer8g_SHMg-1; Thu, 03 Sep 2020 06:49:01 -0400
X-MC-Unique: D63tQvlaNe6hRer8g_SHMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD0F1091065;
 Thu,  3 Sep 2020 10:49:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF947D50E;
 Thu,  3 Sep 2020 10:48:58 +0000 (UTC)
Date: Thu, 3 Sep 2020 11:48:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 1/8] monitor: simplify functions for getting a dup'd
 fdset entry
Message-ID: <20200903104856.GM441291@redhat.com>
References: <20200902170913.1785194-1-berrange@redhat.com>
 <20200902170913.1785194-2-berrange@redhat.com>
 <87mu27s0mf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mu27s0mf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 10:52:40AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Currently code has to call monitor_fdset_get_fd, then dup
> > the return fd, and then add the duplicate FD back into the
> > fdset. This dance is overly verbose for the caller and
> > introduces extra failure modes which can be avoided by
> > folding all the logic into monitor_fdset_dup_fd_add and
> > removing monitor_fdset_get_fd entirely.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/monitor/monitor.h |  3 +-
> >  include/qemu/osdep.h      |  1 +
> >  monitor/misc.c            | 58 +++++++++++++++++----------------------
> >  stubs/fdset.c             |  8 ++----
> >  util/osdep.c              | 19 ++-----------
> >  5 files changed, 32 insertions(+), 57 deletions(-)
> >

> > -int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
> > -{
> > -    MonFdset *mon_fdset;
> > -    MonFdsetFd *mon_fdset_fd_dup;
> > -
> > -    qemu_mutex_lock(&mon_fdsets_lock);
> > -    QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> > -        if (mon_fdset->id != fdset_id) {
> > -            continue;
> > +        if (fd == -1) {
> > +            errno = EINVAL;
> > +            return -1;
> 
> Missing qemu_mutex_unlock().
> 
> >          }
> 
> Old monitor_fdset_get_fd() returns -ENOENT when @fdset_id does not
> exist, and -EACCES when it doesn't contain a file descriptor matching
> @flags.
> 
> The new code seems to use EINVAL for the latter case.  Intentional?

No, its a mistake.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


