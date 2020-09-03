Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07909C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8E2206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bohM1Bt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8E2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmtj-00022k-PK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDmsz-0001SK-9t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:54:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDmsx-00044Z-De
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599130470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAB0YMFXKtOYlYYe6ABtqQPTKQTkyx8YhhtopwkUrLE=;
 b=bohM1Bt/+IQQ9saDbbNBUEMClc5fT+uuCgsqihKugXoVOAqTJnfMveW3Eg2ssusRmB7n2S
 P6Bma3k7NXha79lx31B7w+tpvVo4Hb6aeQcVMh4XjBs7Jsro7EJAf0RN66iuM5tlNqcsfM
 cYJUhmXUJISTslPwaTKUIw812OMZ/KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-_WlAdAEFP8WMVB5JbfiAyw-1; Thu, 03 Sep 2020 06:54:26 -0400
X-MC-Unique: _WlAdAEFP8WMVB5JbfiAyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E94107464A;
 Thu,  3 Sep 2020 10:54:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6090D1002393;
 Thu,  3 Sep 2020 10:54:21 +0000 (UTC)
Date: Thu, 3 Sep 2020 11:54:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 5/8] util: add Error object for qemu_open_internal
 error reporting
Message-ID: <20200903105418.GN441291@redhat.com>
References: <20200902170913.1785194-1-berrange@redhat.com>
 <20200902170913.1785194-6-berrange@redhat.com>
 <87363zs03r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87363zs03r.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 11:03:52AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Instead of relying on the limited information from errno, we can now
> > also provide detailed error messages to callers that ask for it.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/osdep.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/osdep.c b/util/osdep.c
> > index dd34b58bb7..28aa89adc9 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -298,7 +298,7 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
> >   * Opens a file with FD_CLOEXEC set
> >   */
> >  static int
> > -qemu_open_internal(const char *name, int flags, mode_t mode)
> > +qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
> >  {
> >      int ret;
> >  
> > @@ -312,12 +312,15 @@ qemu_open_internal(const char *name, int flags, mode_t mode)
> >  
> >          fdset_id = qemu_parse_fdset(fdset_id_str);
> >          if (fdset_id == -1) {
> > +            error_setg(errp, "Could not parse fdset %s", name);
> >              errno = EINVAL;
> >              return -1;
> >          }
> >  
> >          dupfd = monitor_fdset_dup_fd_add(fdset_id, flags);
> >          if (dupfd == -1) {
> > +            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
> > +                             name, flags);
> 
> You kept the reporting of flags here.  Intentional?

I think it is useful because one of the failure reasons for
monitor_fdset_dup_fd_add is mis-matching flags. So if we ever
get a bug report mentioning this error message it'd be useful
to have the flags present.

> > @@ -343,7 +353,7 @@ int qemu_open_old(const char *name, int flags, ...)
> >      }
> >      va_end(ap);
> >  
> > -    ret = qemu_open_internal(name, flags, mode);
> > +    ret = qemu_open_internal(name, flags, mode, NULL);
> >  
> >  #ifdef O_DIRECT
> >      if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


