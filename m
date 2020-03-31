Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB11C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB23220714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvDcdP94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB23220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJC3k-0007Eb-Vt
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJC2Q-0006K5-8q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJC2O-0002Rb-Pm
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:14:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJC2O-0002Q3-Lx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585642458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkDmtCSHG/YZFGy0CB7wwl+2/gYgAwK74jGoPZwutTg=;
 b=UvDcdP94DP0KH4cua9AD6MZTtq+A3Mag7wefCtVgtzOqLyKNwciD5NVVvO/oRVcAcEBrk3
 qC+s2s1d536lDuvoSF/C0ehhJMs7zWvNK31uAQaYFef2i37e8E5dbR4DF1tujAzOWzncQF
 I2KkOptDbY8nsd0gLC/6+t+mMhwsjVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-AG-w02SkP6mkOatehgXZIw-1; Tue, 31 Mar 2020 04:14:04 -0400
X-MC-Unique: AG-w02SkP6mkOatehgXZIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 934A51005512;
 Tue, 31 Mar 2020 08:14:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 712F58AC36;
 Tue, 31 Mar 2020 08:13:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0025811385E2; Tue, 31 Mar 2020 10:13:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-7-vsementsov@virtuozzo.com>
 <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
Date: Tue, 31 Mar 2020 10:13:57 +0200
In-Reply-To: <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com> (Eric Blake's
 message of "Tue, 24 Mar 2020 15:03:17 -0500")
Message-ID: <87lfnh3pru.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 3/24/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
>> local_err is used several times in guest_suspend(). Setting non-NULL
>> local_err will crash, so let's zero it after freeing. Also fix possible
>> leak of local_err in final if().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qga/commands-posix.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 93474ff770..cc69b82704 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1773,6 +1773,7 @@ static void guest_suspend(SuspendMode mode, Error =
**errp)
>>       }
>>         error_free(local_err);
>> +    local_err =3D NULL;
>
> Let's show this with more context.
>
>> static void guest_suspend(SuspendMode mode, Error **errp)
>> {
>>     Error *local_err =3D NULL;
>>     bool mode_supported =3D false;
>>
>>     if (systemd_supports_mode(mode, &local_err)) {
>
> Hmm - we have an even earlier bug that needs fixing.  Note that
> systemd_supports_mode() returns a bool AND conditionally sets errp.
> But it is inconsistent: it has the following table of actions based on
> the results of run_process_child() on "systemctl status" coupled with
> the man page on "systemctl status" return values:
> -1 (unable to run systemctl) -> errp set, return false
> 0 (unit is active) -> errp left unchanged, return false
> 1 (unit not failed) -> errp left unchanged, return true
> 2 (unused) -> errp left unchanged, return true
> 3 (unit not active) -> errp left unchanged, return true
> 4 (no such unit) -> errp left unchanged, return false
> 5+ (unexpected from systemctl) -> errp left unchanged, return false

Three coarser cases:

* systemd_supports_mode() returned false with @local_err set
* systemd_supports_mode() returned false with @local_err clear
* systemd_supports_mode() returned true with @local_err clear

GLib specificially advises against the second case with GError:

    By convention, if you return a boolean value indicating success then
    TRUE means success and FALSE means failure.  Avoid creating
    functions which have a boolean return value and a GError parameter,
    but where the boolean does something other than signal whether the
    GError is set.

    https://developer.gnome.org/glib/stable/glib-Error-Reporting.html

In my opinion, the advice applies to our Error just as much.

> But the comments in systemd_supports_mode() claim that ANY status < 4
> (other than -1, which means we did not run systemctl) should count as
> the service existing, even though the most common status is 3.  If our
> comment is to be believed, then we should return true, not false, for
> status 0.
>
> Now, back to _this_ function:
>
>>         mode_supported =3D true;
>>         systemd_suspend(mode, &local_err);
>
> Okay - if we get here (whether from status 1-3, or with
> systemd_supports_mode fixed to support status 0-3), local_err is still
> unset prior to calling systemd_suspend(), and we are guaranteed that
> after the call, either we suspended successfully or local_err is now
> set.
>
>>     }

The conditional code splits the third case.  Result:

* systemd_supports_mode() returned false with @local_err set
* systemd_supports_mode() returned false with @local_err clear
* systemd_supports_mode() returned true, systemd_suspend() failed,
  @local_err set
* systemd_supports_mode() returned true, systemd_suspend() succeeded,
  @local_err clear

>>
>>     if (!local_err) {
>>         return;
>>     }
>
> So if returned, we succeeded at systemd_suspend, and there is nothing
> further to do; but if we get past that point, we don't know if it was
> systemd_supports_mode that failed or systemd_suspend that failed, and
> we don't know if local_err is set.
>
>>
>>     error_free(local_err);
>> +    local_err =3D NULL;

We use @local_err as one bit of information.

> Yet, we blindly throw away local_err, without trying to report it.  If
> that's the case, then WHY are we passing in local_err?  Wouldn't it be
> better to pass in NULL (we really don't care about the error message),
> and/or fix systemd_suspend() to return a bool just like
> systemd_supports_mode, and/or fix systemd_supports_mode to guarantee
> that it sets errp when returning false?

You're right, these interfaces are awkward.  They're used just here, so
there's no excuse for keeping them awkward.

Let's step back and examine what we're trying to do.  Pseudo-code:

    for method in systemd, pmutils, linux_sys_state:
        if method supports mode:
            try method
            if successful:
                return success

    if no method supports mode:
        return failure "the requested suspend mode is not supported by the =
guest"
    // we tried at least one method
    return the last method's failure

Observations:

1. We can abstract from the methods, or we can unroll the loop.
   Unrolling seems simpler here.

2. 'Method supports mode' is used as a simple predicate.  So make it
   one: return bool, and not take an Error ** argument.

3. The error for 'try method' is ignored except for the last try.  I'm
   not sure reporting just the last one is appropriate, but let's assume
   it is.  Preferred solution: make 'try method' return true on success,
   false on failure, ignore error (by passing null) unless we actually
   need it.  Acceptable solution: keep it void, free the Error objects
   we ignore.


