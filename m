Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC2C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F9621721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn/W+rJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F9621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabE5-0002it-D7
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iab8w-0000QJ-UE
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iab8o-0000Xj-Tb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:56:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iab8n-0008WK-NQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575014191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yY8LoFUfQZeQENdfkF9j+qRSJ3HGQ9ejMRlDygOXz0=;
 b=Hn/W+rJKSaPfNJNVcMdx9KPezRRZypwUNm7v4JTGAPRBUejt3S/O5ezxNn7qpZqt6k4vq1
 1XUGUOdpkZUFBiggqa+pIoE7CA7ruGKSsvkXexhgny2nz8VU7xbdr4PEATQgiy4mPuaeVT
 nGi8vJPb6AbMISV6lyGimpVuJ+1Wk9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-B4jAes0kMRyVEUbV1pv4AA-1; Fri, 29 Nov 2019 02:56:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EB2DB61;
 Fri, 29 Nov 2019 07:56:27 +0000 (UTC)
Received: from gondolin (ovpn-116-140.ams2.redhat.com [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE5C5608C9;
 Fri, 29 Nov 2019 07:56:25 +0000 (UTC)
Date: Fri, 29 Nov 2019 08:56:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2] qga: fence guest-set-time if hwclock not available
Message-ID: <20191129085623.498e76b2.cohuck@redhat.com>
In-Reply-To: <a3c19a0f-54bd-b406-aff3-d68ec95c0cff@redhat.com>
References: <20191128181100.23187-1-cohuck@redhat.com>
 <a3c19a0f-54bd-b406-aff3-d68ec95c0cff@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B4jAes0kMRyVEUbV1pv4AA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 19:38:00 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> Hi Cornelia,
> 
> On 11/28/19 19:11, Cornelia Huck wrote:
> > The Posix implementation of guest-set-time invokes hwclock to
> > set/retrieve the time to/from the hardware clock. If hwclock
> > is not available, the user is currently informed that "hwclock
> > failed to set hardware clock to system time", which is quite
> > misleading. This may happen e.g. on s390x, which has a different
> > timekeeping concept anyway.
> > 
> > Let's check for the availability of the hwclock command and
> > return QERR_UNSUPPORTED for guest-set-time if it is not available.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > v1 (RFC) -> v2:
> > - use hwclock_path[]
> > - use access() instead of stat()
> > 
> > ---
> >  qga/commands-posix.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 1c1a165daed8..ffb6420fa9cd 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
> >      pid_t pid;
> >      Error *local_err = NULL;
> >      struct timeval tv;
> > +    const char hwclock_path[] = "/sbin/hwclock";  
> 
> Did you drop the "static" storage-class specifier on purpose?

No, I just need to do patches when I'm less tired :/

> 
> > +    static int hwclock_available = -1;
> > +
> > +    if (hwclock_available < 0) {
> > +        hwclock_available = (access(hwclock_path, X_OK) == 0);
> > +    }
> > +
> > +    if (!hwclock_available) {
> > +        error_setg(errp, QERR_UNSUPPORTED);
> > +        return;
> > +    }
> >  
> >      /* If user has passed a time, validate and set it. */
> >      if (has_time) {
> > @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
> >  
> >          /* Use '/sbin/hwclock -w' to set RTC from the system time,
> >           * or '/sbin/hwclock -s' to set the system time from RTC. */
> > -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> > +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",  
> 
> I think it's somewhat obscure now that arg="hwclock" is supposed to
> match the last pathname component in hwclock_path="/sbin/hwclock".
> 
> There are multiple ways to compute "arg" like that, of course. But I
> think they all look uglier than the above. So I'm fine if we just keep this.

Yes, I was not able to come up with something elegant, either.

[Side note: does really everyone put hwclock under /sbin (i.e., nobody
doing something creative?)]

> 
> 
> If you purposely dropped the "static", then:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> If you just missed the "static" and now intend to add it back, then for v3:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks
> Laszlo

Thanks for looking! There'll be a v3.

> 
> 
> 
> >                 NULL, environ);
> >          _exit(EXIT_FAILURE);
> >      } else if (pid < 0) {
> >   
> 


