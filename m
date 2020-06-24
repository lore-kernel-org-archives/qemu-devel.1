Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71790C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F070120707
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZJc+TVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4QW-000682-8Y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo4Pq-0005NJ-5a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:22:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo4Pn-0006Hv-Li
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593001326;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMx/hU2BeXoXrVX+nkp1I28WB4HBQMc0mSFOFs/5stg=;
 b=JZJc+TVqNoBxQWPOBsWhvCUxQMB5f9eQc9PyWQu2/a493HEL/6DsfkgX0Ej59Ligy5nVJ6
 xy0PiuuJkAWUCZXlMUVcjJZho0QpiABbE/EA3Fb3QGNpwmvPkFUwXMCWkUr3qjuNbeG3JD
 5ABn1FIkGsVG2xfrDJO/TQOh1FRTmvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-19Ii16bWOAauDWR-H6TP9w-1; Wed, 24 Jun 2020 08:21:57 -0400
X-MC-Unique: 19Ii16bWOAauDWR-H6TP9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7438B1005513
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 12:21:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 535467168D;
 Wed, 24 Jun 2020 12:21:55 +0000 (UTC)
Date: Wed, 24 Jun 2020 13:21:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 25/31] osdep: Make MIN/MAX evaluate arguments only once
Message-ID: <20200624122152.GJ774096@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
 <20200624105048.375353-25-pbonzini@redhat.com>
 <1101afa3-7523-4408-8918-265b1f2dbc3b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1101afa3-7523-4408-8918-265b1f2dbc3b@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 07:13:17AM -0500, Eric Blake wrote:
> On 6/24/20 5:50 AM, Paolo Bonzini wrote:
> > From: Eric Blake <eblake@redhat.com>
> > 
> > I'm not aware of any immediate bugs in qemu where a second runtime
> > evalution of the arguments to MIN() or MAX() causes a problem, but
> 
> evaluation
> 
> > Update the MIN/MAX macros to only evaluate their argument once at
> > runtime;
> 
> > Use of MIN when MIN_CONST is needed:
> > 
> > In file included from /home/eblake/qemu/qemu-img.c:25:
> > /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group within expression allowed only inside a function
> >    249 |     ({                                                  \
> >        |     ^
> > /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro â€˜MINâ€™
> 
> UTF-8 mojibake in the commit message ;(
> 
> 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > Message-Id: <20200604215236.2798244-1-eblake@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> 
> > +#define MIN_CONST(a, b)                                         \
> > +    __builtin_choose_expr(                                      \
> > +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> > +        (a) < (b) ? (a) : (b),                                  \
> > +        ((void)0))
> 
> This one is correct...
> 
> > +#undef MAX
> > +#define MAX(a, b)                                       \
> > +    ({                                                  \
> > +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
> > +        _a > _b ? _a : _b;                              \
> > +    })
> > +#define MAX_CONST(a, b)                                         \
> > +    __builtin_choose_expr(                                      \
> > +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> > +        (a) > (b) ? (a) : (b),                                  \
> > +        __builtin_unreachable())
> 
> ...but this one should also use ((void)0), to match the commit message.
> 
> > +
> > +/* Minimum function that returns zero only if both values are zero.
> >    * Intended for use with unsigned values only. */
> 
> And checkpatch complains about the formatting here.
> 
> Ah well.  I had all these things fixed in my tree, but failed to post a v5.
> Not worth holding up this pull request in isolation, but if there are any
> other build issues, I'll post a v5 of this patch, otherwise a followup.

FWIW, the current QEMU code defining MIN/MAX was a no-op, since they
were already defined by GLib in /usr/include/glib-2.0/glib/gmacros.h
which we get via glib.h

Now, the GLib impl shared the same theoretical flaw as the old QEMU
impl, but you said it wasn't a real problem right now.

So I'm wondering if the better option would be to remove the MIN/MAX
def from QEMU, and then submit a pull request to GLib to improve
their definition ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


