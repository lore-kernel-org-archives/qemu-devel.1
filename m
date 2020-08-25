Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74702C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E3020782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azWlNai3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E3020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAb1G-0003Vf-Hp
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAb0D-0002d9-Vr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:36:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAb0B-0000C2-SX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598369806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7LkEvEMX/K/bjUDynAnTPkXstaQwbnUvKQ07RpG+9I=;
 b=azWlNai3TTV/SLQsth0ONdVckHtcqu8FDNLYwP9S0wkvmtUEnxc4PllT6yzNXWJ4S4aAyR
 sHh0xwISMwSmPsUJdmfikJTpn8cEb1qf7AixBrw4kncs2lQQ85b0uWeZljgrcuKhfxznOY
 nqzOayXFyuyIjrhLtgcxoHdggFh2o+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-1X3pkMcGMZePFeMNXngYjw-1; Tue, 25 Aug 2020 11:36:39 -0400
X-MC-Unique: 1X3pkMcGMZePFeMNXngYjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C4E18B9F07;
 Tue, 25 Aug 2020 15:36:38 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257845D9E8;
 Tue, 25 Aug 2020 15:36:29 +0000 (UTC)
Date: Tue, 25 Aug 2020 16:36:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 3/6] util: add Error object for qemu_open_internal
 error reporting
Message-ID: <20200825153627.GA107278@redhat.com>
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-4-berrange@redhat.com>
 <87wo1mbvw2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wo1mbvw2.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 25, 2020 at 05:14:21PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Instead of relying on the limited information from errno, we can now
> > also provide detailed error messages.
> 
> The more detailed error messages are currently always ignored, but the
> next patches will fix that.
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/osdep.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/osdep.c b/util/osdep.c
> > index 9ff92551e7..9c7118d3cb 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -284,7 +284,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
> >   * Opens a file with FD_CLOEXEC set
> >   */
> >  static int
> > -qemu_open_internal(const char *name, int flags, mode_t mode)
> > +qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
> >  {
> >      int ret;
> >  
> > @@ -298,24 +298,31 @@ qemu_open_internal(const char *name, int flags, mode_t mode)
> >  
> >          fdset_id = qemu_parse_fdset(fdset_id_str);
> >          if (fdset_id == -1) {
> > +            error_setg(errp, "Could not parse fdset %s", name);
> >              errno = EINVAL;
> >              return -1;
> >          }
> >  
> >          fd = monitor_fdset_get_fd(fdset_id, flags);
> >          if (fd < 0) {
> > +            error_setg_errno(errp, -fd, "Could not acquire FD for %s flags %x",
> > +                             name, flags);
> >              errno = -fd;
> >              return -1;
> >          }
> >  
> >          dupfd = qemu_dup_flags(fd, flags);
> >          if (dupfd == -1) {
> > +            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
> > +                             name, flags);
> >              return -1;
> >          }
> >  
> >          ret = monitor_fdset_dup_fd_add(fdset_id, dupfd);
> >          if (ret == -1) {
> >              close(dupfd);
> > +            error_setg(errp, "Could not save FD for %s flags %x",
> > +                       name, flags);
> 
> Can this happen?

Well there's code in monitor_fdset_dup_fd_add that can return -1.

> 
> >              errno = EINVAL;
> >              return -1;
> >          }
> > @@ -336,6 +343,16 @@ qemu_open_internal(const char *name, int flags, mode_t mode)
> >      }
> >  #endif /* ! O_CLOEXEC */
> >  
> > +    if (ret == -1) {
> > +        const char *action = "open";
> > +        if (flags & O_CREAT) {
> > +            action = "create";
> > +        }
> > +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> > +                         action, name, flags);
> 
> Not a good user experience:
> 
>     Could not open '/etc/shadow' flags 0x0: Permission denied
> 
> Better:
> 
>     Could not open '/etc/shadow' for reading: Permission denied
> 
> Are you sure flags other than the access mode (O_RDONLY, O_WRONLY,
> O_RDWR) must be included in the error message?

It was the flags other than access mode that I was thinking were
more important to log. I'm ambivalent htough, so can drop the
flags if it is thought to be overkill.

> 
> If you must report flags in hexadecimal, then please reporting them more
> consistently.  Right now you have
> 
>     for %s flags 0x%x
>     '%s' flags %x
> 
> Perhaps '%s' with flags 0x%x
> 
> > +    }
> > +
> > +
> >      return ret;
> >  }
> >  
> > @@ -352,7 +369,7 @@ int qemu_open_old(const char *name, int flags, ...)
> >      }
> >      va_end(ap);
> >  
> > -    ret = qemu_open_internal(name, flags, mode);
> > +    ret = qemu_open_internal(name, flags, mode, NULL);
> >  
> >  #ifdef O_DIRECT
> >      if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


