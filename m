Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D8C214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D8C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2tQu-0004ev-VF
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i2tP0-0003vJ-Vi
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i2tOz-00084l-Om
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:34:02 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:40474
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i2tOz-00082g-9v
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:34:01 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i2tOt-0003de-BF; Wed, 28 Aug 2019 10:33:55 +0200
Message-ID: <a2200bb4951f8037de3b9fcb6921fb0ff5210eda.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Date: Wed, 28 Aug 2019 10:33:54 +0200
In-Reply-To: <CAMxuvaykLW7U5gppHe8Z2zCg6bcGxeVuBMrkKk8Eh9V3oQAY6w@mail.gmail.com>
References: <20190827124909.16824-1-johannes@sipsolutions.net>
 <CAMxuvaykLW7U5gppHe8Z2zCg6bcGxeVuBMrkKk8Eh9V3oQAY6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [PATCH v3] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> > +    g_source_unref(src);
> > +    g_source_destroy(src);
> 
> I would call destroy() (detach) before unref().

Fair enough. I think there's an internal reference, but it's probably
safer that way.

> > +    vugg_source_destroy(vi.evsrc);
> 
> typo

Oops. I thought I compiled it, I guess I didn't, fixed.

> >      g_array_free(vi.config, TRUE);
> >      g_free(vi.queue);
> >      return 0;
> 
> vhost-user-input calls g_source_destroy(), please replace it too with
> vug_source_destroy().

That's what the patch above was, apart from the typo :-)

> vhost-user-gpu "renderer_source" leaks, not this patch fault, but
> worth to mention in the commit. 

I did:

>> vhost-user-gpu also uses vug_source_new(), but never seems to free
>> the result at all, so I haven't changed anything there.

> Feel free to add a second commit to fix that too.

I looked at it briefly but couldn't unwind the paths, sorry.

johannes


