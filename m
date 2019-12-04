Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BBFC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B67A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt2zZsat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B67A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVPX-0001LZ-Mk
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icVOe-0000qs-Je
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icVOb-0002OI-Qn
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:12:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icVOb-0002IR-Gs
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575468768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fx4HPfHoOU0v6xpaOj/z3RD0RKZcUIX5iOUwLOFUXeg=;
 b=Pt2zZsatyBB9JcAXUUxr4n7htDWPmJCBJM8vFWfPxgexajg7tT230iwE3tvxyqaJ4/r3eA
 qkACHOmkqaS6WVk/Tv7H841TBW6toXM5LQhclLxZeUfBIzV3xP24gWAduKZ5WGZqWws/hW
 m5Sumwb/VU4RAmDIineAaHKERzHI7qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-iRvXMeGtPvCFvWevDNPCPw-1; Wed, 04 Dec 2019 09:12:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494F3DB60;
 Wed,  4 Dec 2019 14:12:46 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 610A75C1B2;
 Wed,  4 Dec 2019 14:12:45 +0000 (UTC)
Date: Wed, 4 Dec 2019 15:12:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] qga: fence guest-set-time if hwclock not available
Message-ID: <20191204151242.2e15cb12.cohuck@redhat.com>
In-Reply-To: <20191128181100.23187-1-cohuck@redhat.com>
References: <20191128181100.23187-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iRvXMeGtPvCFvWevDNPCPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 19:11:00 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
> 
> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Michael, any comments before I send a v3?

> ---
> 
> v1 (RFC) -> v2:
> - use hwclock_path[]
> - use access() instead of stat()
> 
> ---
>  qga/commands-posix.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165daed8..ffb6420fa9cd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
>      pid_t pid;
>      Error *local_err = NULL;
>      struct timeval tv;
> +    const char hwclock_path[] = "/sbin/hwclock";
> +    static int hwclock_available = -1;
> +
> +    if (hwclock_available < 0) {
> +        hwclock_available = (access(hwclock_path, X_OK) == 0);
> +    }
> +
> +    if (!hwclock_available) {
> +        error_setg(errp, QERR_UNSUPPORTED);
> +        return;
> +    }
>  
>      /* If user has passed a time, validate and set it. */
>      if (has_time) {
> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
>  
>          /* Use '/sbin/hwclock -w' to set RTC from the system time,
>           * or '/sbin/hwclock -s' to set the system time from RTC. */
> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>                 NULL, environ);
>          _exit(EXIT_FAILURE);
>      } else if (pid < 0) {


