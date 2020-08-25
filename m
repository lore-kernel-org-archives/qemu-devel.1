Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BF7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815A12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUIJROOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815A12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaVE-00088g-OQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAaUW-0007EN-1f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAaUU-000395-7k
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jigTP9KFZh0mC7ixNbqTATuujyh27fGpbK0VStHgkc=;
 b=hUIJROOZ/DcZ/CWrSMTK0uH9duk6CwuPJ95034eaNbjDhN1E2+K6vIkC2UoALW+Gys1Tcs
 RMCVlJ2aAyc2/IEJba5m5nx254JL04Y4712GdZuh5rZi0eoPt/TKzpHcmwWFBtsNnt3T/9
 ZKLU9DOqSyitvke1aiBxRUWD4ZV7kOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-CnOaQg1aNn60J_hNfAD1Uw-1; Tue, 25 Aug 2020 11:03:56 -0400
X-MC-Unique: CnOaQg1aNn60J_hNfAD1Uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8CEA871803;
 Tue, 25 Aug 2020 15:03:54 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71CDD747DD;
 Tue, 25 Aug 2020 15:03:52 +0000 (UTC)
Date: Tue, 25 Aug 2020 16:03:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 2/6] util: refactor qemu_open_old to split off
 variadic args handling
Message-ID: <20200825150349.GV107278@redhat.com>
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-3-berrange@redhat.com>
 <874koqdb9z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874koqdb9z.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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

On Tue, Aug 25, 2020 at 04:56:40PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This simple refactoring prepares for future patches. The variadic args
> > handling is split from the main bulk of the open logic. The duplicated
> > calls to open() are removed in favour of updating the "flags" variable
> > to have O_CLOEXEC.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/osdep.c | 40 +++++++++++++++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/util/osdep.c b/util/osdep.c
> > index 9df1b6adec..9ff92551e7 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -22,6 +22,7 @@
> >   * THE SOFTWARE.
> >   */
> >  #include "qemu/osdep.h"
> > +#include "qapi/error.h"
> >  
> >  /* Needed early for CONFIG_BSD etc. */
> >  
> > @@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
> >  /*
> >   * Opens a file with FD_CLOEXEC set
> >   */
> > -int qemu_open_old(const char *name, int flags, ...)
> > +static int
> > +qemu_open_internal(const char *name, int flags, mode_t mode)
> >  {
> >      int ret;
> > -    int mode = 0;
> >  
> >  #ifndef _WIN32
> >      const char *fdset_id_str;
> > @@ -323,22 +324,35 @@ int qemu_open_old(const char *name, int flags, ...)
> >      }
> >  #endif
> >  
> > -    if (flags & O_CREAT) {
> > -        va_list ap;
> > -
> > -        va_start(ap, flags);
> > -        mode = va_arg(ap, int);
> > -        va_end(ap);
> > -    }
> > -
> >  #ifdef O_CLOEXEC
> > -    ret = open(name, flags | O_CLOEXEC, mode);
> > -#else
> > +    flags |= O_CLOEXEC;
> > +#endif /* O_CLOEXEC */
> > +
> >      ret = open(name, flags, mode);
> > +
> > +#ifndef O_CLOEXEC
> >      if (ret >= 0) {
> >          qemu_set_cloexec(ret);
> >      }
> > -#endif
> > +#endif /* ! O_CLOEXEC */
> 
> I dislike this part, to be honest.  I find
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
> harder to read than
> 
>     #ifdef O_CLOEXEC
>         ret = open(name, flags | O_CLOEXEC, mode);
>     #else
>         ret = open(name, flags, mode);
>         if (ret >= 0) {
>             qemu_set_cloexec(ret);
>         }
>     #endif

We're re-using 'flags' variable again in a later patch and want to
have O_CLOEXEC present in it then too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


