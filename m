Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCD120702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDZC3mbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvYu-0006G0-Uy
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqvYF-0005Q8-Vb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:30:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqvYE-0007Da-4N
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593682237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4esx7D8Y8Mj5GMByJj+NtBXc7y1Ja/77zP2wofn4rMw=;
 b=QDZC3mbZdJDvv2KuYV6hs/aog3BXHl0GT+YoDA/2rDW4E6HxOo20Ihcgt2Y6xMJok4f33X
 P4aYGKZSCu/vpdvhrJ7R1fPPzXJ4NTsI8fErIvhk7JUAgh7LAoVrVzkYdCLHAA5sr4lfe+
 aNPkJJb3nv/EYPc0IuV2p+oHpSN72c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-yoH6HXZFNaemdxKobmmxBw-1; Thu, 02 Jul 2020 05:30:28 -0400
X-MC-Unique: yoH6HXZFNaemdxKobmmxBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA2F0EC1A0;
 Thu,  2 Jul 2020 09:30:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74D4E778A0;
 Thu,  2 Jul 2020 09:30:22 +0000 (UTC)
Date: Thu, 2 Jul 2020 10:30:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] util: support detailed error reporting for qemu_open
Message-ID: <20200702093019.GE1888119@redhat.com>
References: <20200701160509.1523847-1-berrange@redhat.com>
 <20200701160509.1523847-3-berrange@redhat.com>
 <87a70i7b4r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a70i7b4r.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 07:13:08AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Create a "qemu_open_err" method which does the same as "qemu_open",
> > but with a "Error **errp" for error reporting. There should be no
> > behavioural difference for existing callers at this stage.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/osdep.h |  1 +
> >  util/osdep.c         | 71 +++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 58 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 0d26a1b9bd..e41701a308 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -483,6 +483,7 @@ int qemu_madvise(void *addr, size_t len, int advice);
> >  int qemu_mprotect_rwx(void *addr, size_t size);
> >  int qemu_mprotect_none(void *addr, size_t size);
> >  
> > +int qemu_open_err(const char *name, int flags, Error **errp, ...);
> >  int qemu_open(const char *name, int flags, ...);
> >  int qemu_close(int fd);
> >  int qemu_unlink(const char *name);
> > diff --git a/util/osdep.c b/util/osdep.c
> > index 4bdbe81cec..450b3a5da3 100644
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
> > @@ -282,7 +283,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
> >  /*
> >   * Opens a file with FD_CLOEXEC set
> >   */
> > -int qemu_open(const char *name, int flags, ...)
> > +static int qemu_openv(const char *name, int flags, Error **errp, va_list ap)
> >  {
> >      int ret;
> >      int mode = 0;
> > @@ -297,24 +298,31 @@ int qemu_open(const char *name, int flags, ...)
> >  
> >          fdset_id = qemu_parse_fdset(fdset_id_str);
> >          if (fdset_id == -1) {
> > +            error_setg(errp, "Unable to parse fdset %s", name);
> >              errno = EINVAL;
> >              return -1;
> >          }
> >  
> >          fd = monitor_fdset_get_fd(fdset_id, flags);
> >          if (fd < 0) {
> > +            error_setg_errno(errp, -fd, "Unable acquire FD for %s flags %x",
> > +                             name, flags);
> >              errno = -fd;
> >              return -1;
> >          }
> >  
> >          dupfd = qemu_dup_flags(fd, flags);
> >          if (dupfd == -1) {
> > +            error_setg_errno(errp, errno, "Unable dup FD for %s flags %x",
> > +                             name, flags);
> >              return -1;
> >          }
> >  
> >          ret = monitor_fdset_dup_fd_add(fdset_id, dupfd);
> >          if (ret == -1) {
> >              close(dupfd);
> > +            error_setg(errp, "Unable save FD for %s flags %x",
> > +                       name, flags);
> >              errno = EINVAL;
> >              return -1;
> >          }
> > @@ -324,11 +332,7 @@ int qemu_open(const char *name, int flags, ...)
> >  #endif
> >  
> >      if (flags & O_CREAT) {
> > -        va_list ap;
> > -
> > -        va_start(ap, flags);
> >          mode = va_arg(ap, int);
> > -        va_end(ap);
> >      }
> >  
> >  #ifdef O_CLOEXEC
> > @@ -340,25 +344,64 @@ int qemu_open(const char *name, int flags, ...)
> >      }
> >  #endif
> >  
> > +    if (ret == -1) {
> > +        const char *action = "open";
> > +        if (flags & O_CREAT) {
> > +            action = "create";
> > +        }
> >  #ifdef O_DIRECT
> > -    if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
> > -        int newflags = flags & ~O_DIRECT;
> > +        if (errno == EINVAL && (flags & O_DIRECT)) {
> > +            int newflags = flags & ~O_DIRECT;
> >  # ifdef O_CLOEXEC
> > -        ret = open(name, newflags | O_CLOEXEC, mode);
> > +            ret = open(name, newflags | O_CLOEXEC, mode);
> >  # else
> > -        ret = open(name, newflags, mode);
> > +            ret = open(name, newflags, mode);
> >  # endif
> > -        if (ret != -1) {
> > -            close(ret);
> > -            error_report("file system does not support O_DIRECT");
> > -            errno = EINVAL;
> > +            if (ret != -1) {
> > +                close(ret);
> > +                error_setg(errp, "Unable to %s '%s' flags 0x%x: "
> > +                           "filesystem does not support O_DIRECT",
> > +                           action, name, flags);
> > +                if (!errp) {
> 
> If the caller ignores errors, ...
> 
> > +                    error_report("file system does not support O_DIRECT");
> 
> ... we report this error to stderr (but not any of the other ones).
> This is weird.  I figure you do it here to reproduce the weirdness of
> qemu_open() before the patch.  Goes back to
> 
>     commit a5813077aac7865f69b7ee46a594f3705429f7cd
>     Author: Stefan Hajnoczi <stefanha@redhat.com>
>     Date:   Thu Aug 22 11:29:03 2013 +0200
> 
>         osdep: warn if open(O_DIRECT) on fails with EINVAL
> 
>         Print a warning when opening a file O_DIRECT fails with EINVAL.  This
>         saves users a lot of time trying to figure out the EINVAL error, which
>         is typical when attempting to open a file O_DIRECT on Linux tmpfs.
> 
>         Reported-by: Deepak C Shetty <deepakcs@linux.vnet.ibm.com>
>         Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>         Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> The message isn't phrased as a warning, though.  Should it use
> warn_report()?  Stefan?

I was really in two minds as to whether to keep this error_report or
not. It depends depends on whether any other callers of qemu_open
still need it. In fact if nothing outside the block layer uses O_DIRECT
then I think we can remove the error_report line.


> > +int qemu_open_err(const char *name, int flags, Error **errp, ...)
> > +{
> > +    va_list ap;
> > +    int rv;
> > +
> > +    va_start(ap, errp);
> > +    rv = qemu_openv(name, flags, errp, ap);
> > +    va_end(ap);
> > +
> > +    return rv;
> > +}
> > +
> > +int qemu_open(const char *name, int flags, ...)
> > +{
> > +    va_list ap;
> > +    int rv;
> > +
> > +    va_start(ap, flags);
> > +    rv = qemu_openv(name, flags, NULL, ap);
> > +    va_end(ap);
> > +
> > +    return rv;
> > +}
> 
> I'd rename this to qemu_open_with_bad_error_messages().

My goal was to avoid a big bang conversion of all callers.

> 
> For better ones, callers can use
> 
>     if (qemu_open_err(name, flags, &err) < 0) {
>         error_report_err(err);
>         ...
>     }
> 
> or, where the error is fatal
>     
>     qemu_open_err(name, flags, &error_fatal);
> 
> If you prefer not to rename it now, please add a comment why it should
> not be used in new code, and existing uses should be converted.
> 
> If you rename, call the new one qemu_open().

Maybe it is better to rename upfront though, instead of waiting till
everything uses the qemu_open_err and then renaming back to qemu_open.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


