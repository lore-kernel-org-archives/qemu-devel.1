Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6039DC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4CD20409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDtWOCv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4CD20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpmc-0000ei-Cj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 16:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGplp-0000DU-Fe
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGplo-0007f6-1T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:03:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGpln-0007eo-Rl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585080207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8MNNRbg+bRwtci2pKFgzEsCe+hwl9dEwuw2oAOovR0=;
 b=gDtWOCv4YUEZdigU1cJ/n0mzLTkudsfDSVZPRirfNrQ7fm2XBS5J1q9OkMORWeQTUU72li
 k54QsWvL4v7dnzI2ysW2O5iSgW8PlVJKILCpiPlpuPu062F5DZ/7HlBTtSZejO6GBq0pza
 EghExtYXwOrbN1ql/8bcNGZpNN+YKbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-vQcBUbD8NHy1ZjVoM8Xq7A-1; Tue, 24 Mar 2020 16:03:23 -0400
X-MC-Unique: vQcBUbD8NHy1ZjVoM8Xq7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1794107ACC4;
 Tue, 24 Mar 2020 20:03:21 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2628ABBBC2;
 Tue, 24 Mar 2020 20:03:18 +0000 (UTC)
Subject: Re: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
Date: Tue, 24 Mar 2020 15:03:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324153630.11882-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> local_err is used several times in guest_suspend(). Setting non-NULL
> local_err will crash, so let's zero it after freeing. Also fix possible
> leak of local_err in final if().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qga/commands-posix.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 93474ff770..cc69b82704 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1773,6 +1773,7 @@ static void guest_suspend(SuspendMode mode, Error **errp)
>       }
>   
>       error_free(local_err);
> +    local_err = NULL;

Let's show this with more context.

> static void guest_suspend(SuspendMode mode, Error **errp)
> {
>     Error *local_err = NULL;
>     bool mode_supported = false;
> 
>     if (systemd_supports_mode(mode, &local_err)) {

Hmm - we have an even earlier bug that needs fixing.  Note that 
systemd_supports_mode() returns a bool AND conditionally sets errp.  But 
it is inconsistent: it has the following table of actions based on the 
results of run_process_child() on "systemctl status" coupled with the 
man page on "systemctl status" return values:
-1 (unable to run systemctl) -> errp set, return false
0 (unit is active) -> errp left unchanged, return false
1 (unit not failed) -> errp left unchanged, return true
2 (unused) -> errp left unchanged, return true
3 (unit not active) -> errp left unchanged, return true
4 (no such unit) -> errp left unchanged, return false
5+ (unexpected from systemctl) -> errp left unchanged, return false

But the comments in systemd_supports_mode() claim that ANY status < 4 
(other than -1, which means we did not run systemctl) should count as 
the service existing, even though the most common status is 3.  If our 
comment is to be believed, then we should return true, not false, for 
status 0.

Now, back to _this_ function:

>         mode_supported = true;
>         systemd_suspend(mode, &local_err);

Okay - if we get here (whether from status 1-3, or with 
systemd_supports_mode fixed to support status 0-3), local_err is still 
unset prior to calling systemd_suspend(), and we are guaranteed that 
after the call, either we suspended successfully or local_err is now set.

>     }
> 
>     if (!local_err) {
>         return;
>     }

So if returned, we succeeded at systemd_suspend, and there is nothing 
further to do; but if we get past that point, we don't know if it was 
systemd_supports_mode that failed or systemd_suspend that failed, and we 
don't know if local_err is set.

> 
>     error_free(local_err);
> +    local_err = NULL;

Yet, we blindly throw away local_err, without trying to report it.  If 
that's the case, then WHY are we passing in local_err?  Wouldn't it be 
better to pass in NULL (we really don't care about the error message), 
and/or fix systemd_suspend() to return a bool just like 
systemd_supports_mode, and/or fix systemd_supports_mode to guarantee 
that it sets errp when returning false?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


