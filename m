Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7F8C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C2A2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewzKi6tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C2A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIsuE-0007EL-NB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIsse-0006h9-8F
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIssb-0002xN-E2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600345151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FW9AtZT0GN6kcCA8NMnMBkyX5mFSXFUFAqtljCaz70M=;
 b=ewzKi6tCdcZPXDzRtAS4IJRX0qz+/Uynj0+ZIWXiPYzq2glO7iwjVErXGpSczWLd4QO0TB
 Y6DwJOyGt1pgq1tts4mGqwKMyGi2ez0y/Zg9L070kVf0MjG0f20h8orepf6i5oIZz1XUhV
 Xk7yb/fc0ADwlsTtKfJrEeK0Lc8+osk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-7x5ARQlHPHa_9xz5HK3TOQ-1; Thu, 17 Sep 2020 08:18:58 -0400
X-MC-Unique: 7x5ARQlHPHa_9xz5HK3TOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA219100746D;
 Thu, 17 Sep 2020 12:18:56 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D76A1002388;
 Thu, 17 Sep 2020 12:18:54 +0000 (UTC)
Date: Thu, 17 Sep 2020 13:18:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
Message-ID: <20200917121851.GA1597829@redhat.com>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <20200917011525.GI5258@yekko.fritz.box>
 <87lfh8g8dy.fsf@dusky.pond.sub.org>
 <20200917120437.6ab60ca4@bahia.lan>
 <87ft7g1uee.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87ft7g1uee.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 02:04:41PM +0200, Markus Armbruster wrote:
> Greg Kurz <groug@kaod.org> writes:
> 
> > $ git grep object_property_get_uint -- :^{include,qom/object.c} | wc -l
> > 60
> >
> > Manual inspecting the output of
> >
> > $ git grep -W object_property_get_uint -- :^{include,qom/object.c}
> > ...
> >
> > seems to be showing that most users simply ignore errors (ie. pass NULL
> > as 3rd argument). Then some users pass &error_abort and only a few
> > pass a &err or errp.
> >
> > Assuming that users know what they're doing, I guess my proposal
> > wouldn't bring much to the code base in the end... I'm not even
> > sure now that it's worth changing the contract.
> 
> We'd change
> 
>     val = object_property_get_uint(obj, name, &error_abort);
> 
> to
> 
>     object_property_get_uint(obj, name, &val, &error_abort);
> 
> which is not an improvement.
> 
> Most of the ones passing NULL should probably pass &error_abort
> instead.  Doesn't change the argument.

I wonder if we actually need to have an Error  parameter at all for
the getters. IIUC the only valid runtime error  is probably the case
where the property has not been set, and even then, I think properties
usually have a default value that would be returned.  All the other
errors look like programmer errors.

IOW, can we remove the Error parameter and have all the o_p_get*
method impls use error_abort.

In the rare case where a caller needs to handle a property not
being set, they can use object_property_find() as a test before
invoking the getter.

Of course requires someone motivated to audit all the case that
are not using NULL or error_abort and decide whether the attempt
at passing a local errp was actually justified or not.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


