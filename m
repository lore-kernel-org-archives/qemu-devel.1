Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97762C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D620684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2zBm4FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWNG-00006g-B9
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWHS-0008OY-RT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:10:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWHR-0001eQ-7P
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PHdG29wGN4I9MI/wkI87O+ARLdLfreLkEJirNzpFBOM=;
 b=f2zBm4FRQ9J5ScNuTTyaPrQcL8bbKUgKHjBiSFyIlN6Q9tL7uJV/oeF5ymRPMsmAca/RPq
 B2P+p7oqH1evw6UXErEUQ2pfmabjGiDKL4nBgDpoi2sewOlQ+6XHDCGcaPgoA+ZE8ZosYG
 wKHGbEFfD1Su8foVh1A/pa76e6+YpEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-1SCj9HSFPlyPYjwMzXmJeA-1; Wed, 02 Sep 2020 13:10:34 -0400
X-MC-Unique: 1SCj9HSFPlyPYjwMzXmJeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0850C1084C80;
 Wed,  2 Sep 2020 17:10:33 +0000 (UTC)
Received: from redhat.com (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BAA119C59;
 Wed,  2 Sep 2020 17:10:30 +0000 (UTC)
Date: Wed, 2 Sep 2020 18:10:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 5/6] util: give a specific error message when O_DIRECT
 doesn't work
Message-ID: <20200902171027.GS403297@redhat.com>
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-6-berrange@redhat.com>
 <87o8mybvmu.fsf@dusky.pond.sub.org>
 <20200825152319.GX107278@redhat.com>
 <875z957ixy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <875z957ixy.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 01:19:53PM +0200, Markus Armbruster wrote:

> Now back to my dislike of the #ifdeffery I voiced in reply to PATCH 2.
> 
> Code now:
> 
>     #ifdef O_CLOEXEC
>         flags |= O_CLOEXEC;
>     #endif /* O_CLOEXEC */
> 
>         ret = open(name, flags, mode);
> 
>     #ifndef O_CLOEXEC
>         if (ret >= 0) {
>             qemu_set_cloexec(ret);
>         }
>     #endif /* ! O_CLOEXEC */
> 
>         if (ret == -1) {
>             const char *action = flags & O_CREAT ? "create" : "open";
>     #ifdef O_DIRECT
>             if (errno == EINVAL && (flags & O_DIRECT)) {
>                 ret = open(name, flags & ~O_DIRECT, mode);
>                 if (ret != -1) {
>                     close(ret);
>                     [O_DIRECT not supported error...]
>                     errno = EINVAL; /* close() clobbered earlier errno */
>                     return -1;
>                 }
>             }
>     #endif /* O_DIRECT */
>             [generic error...]
>         }
> 
> Compare:
> 
>     #ifdef O_CLOEXEC
>         flags |= O_CLOEXEC;
>         ret = open(name, flags, mode);
>     #else
>         ret = open(name, flags, mode);
>         if (ret >= 0) {
>             qemu_set_cloexec(ret);
>         }
>     #endif /* ! O_CLOEXEC */
> 
>         if (ret == -1) {
>             const char *action = flags & O_CREAT ? "create" : "open";
>     #ifdef O_DIRECT
>             if (errno == EINVAL && (flags & O_DIRECT)) {
>                 ret = open(name, flags & ~O_DIRECT, mode);
>                 if (ret != -1) {
>                     close(ret);
>                     [O_DIRECT not supported error...]
>                     errno = EINVAL; /* close() clobbered earlier errno */
>                     return -1;
>                 }
>             }
>     #endif /* O_DIRECT */
>             [generic error...]
>         }
> 
> I like this a bit better, but not enough to make a strong
> recommendation, let alone demand.

In v5 I've gone with neither approach, and instead spun off a helper
method qemu_open_cloexec which I think is clearer than both.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


