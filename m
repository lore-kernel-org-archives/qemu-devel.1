Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D27C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D1D2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv6SxIdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D1D2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyfM-0002zD-GE
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyyeh-0002C2-GN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:26:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyyef-0003tI-PN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595600792;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdUd9yQHZ60bJf5GYw+6+t/uFe3+skw7L8ImmtVxIZw=;
 b=gv6SxIdztC40XqIc/L1qBnJXsfrbGFADOBmDw099KIYSTtnEjBv4CJ+FN0BRfiM/uQwYML
 qoUuC/fW4TDHBMWk2rWYzpEgxSER0WJcYxu3ik43cc6DqnrTUhI79eVGNLft6y9U7NSll5
 0MPT1lyDLN1zevBVX4wE8o2rk20f+CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-jz9Y56dvOB-a9wO7Z1v7NQ-1; Fri, 24 Jul 2020 10:26:24 -0400
X-MC-Unique: jz9Y56dvOB-a9wO7Z1v7NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B388015CE;
 Fri, 24 Jul 2020 14:26:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 360851002391;
 Fri, 24 Jul 2020 14:26:21 +0000 (UTC)
Date: Fri, 24 Jul 2020 15:26:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] block: switch to use qemu_open/qemu_create for
 improved errors
Message-ID: <20200724142618.GE3146350@redhat.com>
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-5-berrange@redhat.com>
 <18b793fa-bb7f-f2a2-62de-f6b396f5e93f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <18b793fa-bb7f-f2a2-62de-f6b396f5e93f@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 09:10:00AM -0500, Eric Blake wrote:
> On 7/24/20 8:25 AM, Daniel P. Berrangé wrote:
> > Currently at startup if using cache=none on a filesystem lacking
> > O_DIRECT such as tmpfs, at startup QEMU prints
> > 
> > qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: file system may not support O_DIRECT
> > qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Could not open '/tmp/foo.img': Invalid argument
> 
> Are we trying to get this in 5.1?

It is probably verging on too late to justify for the rc

> 
> > 
> > while at QMP level the hint is missing, so QEMU reports just
> > 
> >    "error": {
> >        "class": "GenericError",
> >        "desc": "Could not open '/tmp/foo.img': Invalid argument"
> >    }
> > 
> > which is close to useless for the end user trying to figure out what
> > they did wrong.
> > 
> > With this change at startup QEMU prints
> > 
> > qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT
> > 
> > while at the QMP level QEMU reports a massively more informative
> > 
> >    "error": {
> >       "class": "GenericError",
> >       "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does not support O_DIRECT"
> >    }
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> 
> > @@ -3335,7 +3331,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
> >       for (index = 0; index < num_of_test_partitions; index++) {
> >           snprintf(test_partition, sizeof(test_partition), "%ss%d", bsd_path,
> >                    index);
> > -        fd = qemu_open_old(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
> > +        fd = qemu_open(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE, NULL);
> 
> Should qemu_open() always be setting O_BINARY|O_LARGEFILE, without us having
> to worry about them at each caller?  But that's a separate cleanup.

Hmm, I think both of these are dead code.

IIUC, O_BINARY  is a no-op on any platform except Windows, and this is
file-posix.c, and O_LARGEFILE is a no-op, if you have _FILE_OFFSET_BITS=64,
which we hardcode.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


