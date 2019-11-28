Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F1AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D90D21774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dew3G0v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D90D21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPSA-0002qO-Ma
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iaOgT-0006EM-8x
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iaOg7-00089e-BU
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:38:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iaOg5-0007sD-Ut
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574966287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdgt50hjQpCcnDwoPcms4KQ6G0kR/izkzJKfGW8hlVo=;
 b=Dew3G0v/VybL6SQLMndRRakHUrygB3zk+HpoCx+pCiVz763c7YEy4CjTgSJNfqPkeEvJVA
 1xez/+l6nwXiwa4rrIVB7c0UkWaVitHyjH9oCJFjfMqCK/fRv7UM8DHegkq0HwB9ZMSfUQ
 PdTA8gDYfSWNtM3/r72WL9sB2AvshoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-di8Dn4O8NIWDu5yr6Isx2Q-1; Thu, 28 Nov 2019 13:38:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172E6107ACC4;
 Thu, 28 Nov 2019 18:38:05 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-145.ams2.redhat.com
 [10.36.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9912D5C1B0;
 Thu, 28 Nov 2019 18:38:01 +0000 (UTC)
Subject: Re: [PATCH v2] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20191128181100.23187-1-cohuck@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a3c19a0f-54bd-b406-aff3-d68ec95c0cff@redhat.com>
Date: Thu, 28 Nov 2019 19:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191128181100.23187-1-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: di8Dn4O8NIWDu5yr6Isx2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cornelia,

On 11/28/19 19:11, Cornelia Huck wrote:
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

Did you drop the "static" storage-class specifier on purpose?

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

I think it's somewhat obscure now that arg="hwclock" is supposed to
match the last pathname component in hwclock_path="/sbin/hwclock".

There are multiple ways to compute "arg" like that, of course. But I
think they all look uglier than the above. So I'm fine if we just keep this.


If you purposely dropped the "static", then:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

If you just missed the "static" and now intend to add it back, then for v3:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo



>                 NULL, environ);
>          _exit(EXIT_FAILURE);
>      } else if (pid < 0) {
> 


