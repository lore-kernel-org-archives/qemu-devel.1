Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FB920786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPUJhRjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FB920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAao6-00035g-3F
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAanK-000281-Jl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:23:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAanI-00067Y-Mn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598369007;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ts9bUL2x/gA0kZ1KIwkkdK1Iyrrqb453Jto6SYXOzys=;
 b=JPUJhRjIhlFb5MeT8w71J9p/7VrCshC/cEiLnx4+uOUv55KgW9yZCGgsn6bMdcJnN6TOEf
 hPcxsd33RuW7Qk3WO7r4BH3Mk014UJ7L0qEWMRELpH2R/S7btcrY0+tHqHcPPio8xcIT5E
 3Bbr+JsMBEI/m7qi71GC6pKQgVuUxw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-o0oshSSGPbmDIEIFgyDBhw-1; Tue, 25 Aug 2020 11:23:25 -0400
X-MC-Unique: o0oshSSGPbmDIEIFgyDBhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58BCC2FD02;
 Tue, 25 Aug 2020 15:23:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB78219C4F;
 Tue, 25 Aug 2020 15:23:22 +0000 (UTC)
Date: Tue, 25 Aug 2020 16:23:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 5/6] util: give a specific error message when O_DIRECT
 doesn't work
Message-ID: <20200825152319.GX107278@redhat.com>
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-6-berrange@redhat.com>
 <87o8mybvmu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8mybvmu.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 05:19:53PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > A common error scenario is to tell QEMU to use O_DIRECT in combination
> > with a filesystem that doesn't support it. To aid users to diagnosing
> > their mistake we want to provide a clear error message when this happens.
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/osdep.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/util/osdep.c b/util/osdep.c
> > index a4956fbf6b..6c24985f7a 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -345,6 +345,19 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
> >  
> >      if (ret == -1) {
> >          const char *action = flags & O_CREAT ? "create" : "open";
> > +#ifdef O_DIRECT
> > +        if (errno == EINVAL && (flags & O_DIRECT)) {
> > +            ret = open(name, flags & ~O_DIRECT, mode);
> > +            if (ret != -1) {
> > +                close(ret);
> > +                error_setg(errp, "Could not %s '%s' flags 0x%x: "
> > +                           "filesystem does not support O_DIRECT",
> > +                           action, name, flags);
> > +                errno = EINVAL; /* close() clobbered earlier errno */
> 
> More precise: close() may have clobbered

Either open or close in fact.

> 
> Sure open() can only fail with EINVAL here?

We don't care about the errno from the open() call seen in this context,
we're restoring the EINVAL from the previous open() call above this patch
contxt, that we match on with  "if (errno == EINVAL && ...)" line.

> 
> > +                return -1;
> > +            }
> > +        }
> > +#endif /* O_DIRECT */
> >          error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> >                           action, name, flags);
> >      }
> 
> There is no qemu_set_cloexec().  Intentional?

We've called close() immediately after open(). Adding qemu_set_cloexec()
doesnt make it any less racy on platforms lacking O_CLOSEXEC

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


