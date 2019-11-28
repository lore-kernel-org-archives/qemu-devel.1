Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9F1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DB8208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hlr27X9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJFb-0000sl-Ht
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iaJB8-00079E-Od
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iaJB4-0004Hh-Ac
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iaJB4-0004BL-4L
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574945144;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFYk46yR4pubyIuF4vfzAO4EN9UVTzlSg0yarn5xADI=;
 b=Hlr27X9MseQpq5iE3WXwTNnZy0RvtfHUn8ua4yq/wZUiguPUgicxdjNllAZn44HcJcZU/O
 HvcdrjniFruiZ771+jqirIFIJ9GPLxjeW+vJ0JbE72d5LBC/TnXgm1wUYMlK356IQ7LBL6
 aynM7Rb6DPYu//PDGDWLgULrY4tx+l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-qs8wqYC9Poi-rtBJOK3xww-1; Thu, 28 Nov 2019 07:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31474800D41;
 Thu, 28 Nov 2019 12:45:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6664A100164D;
 Thu, 28 Nov 2019 12:45:34 +0000 (UTC)
Date: Thu, 28 Nov 2019 12:45:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] qga: fence guest-set-time if hwclock not available
Message-ID: <20191128124532.GF248361@redhat.com>
References: <20191128123658.28351-1-cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128123658.28351-1-cohuck@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qs8wqYC9Poi-rtBJOK3xww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 01:36:58PM +0100, Cornelia Huck wrote:
> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
>=20
> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> Not sure if that is the correct approach, but the current error
> message is really quite confusing.

I guess the alternative is to just #ifndef __s390x__ the whole
impl of the qmp_guest_set_time  method, but I don't have a
strong opinion on which is best.

>=20
> Gave it a quick test with an s390x and an x86_64 guest; invoking
> 'virsh domtime <value>' now fails with 'not currently supported'
> on s390x and continues to work as before on x86_64.
>=20
> ---
>  qga/commands-posix.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165daed8..bd298a38b716 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -149,6 +149,13 @@ int64_t qmp_guest_get_time(Error **errp)
>     return tq.tv_sec * 1000000000LL + tq.tv_usec * 1000;
>  }
> =20
> +static int check_hwclock_available(const char *path)
> +{
> +    struct stat st;
> +
> +    return (stat(path, &st) < 0) ? 0 : 1;
> +}
> +
>  void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
>  {
>      int ret;
> @@ -156,6 +163,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_=
ns, Error **errp)
>      pid_t pid;
>      Error *local_err =3D NULL;
>      struct timeval tv;
> +    const char *hwclock_path =3D "/sbin/hwclock";
> +    static int hwclock_available =3D -1;
> +
> +    if (hwclock_available < 0) {
> +        hwclock_available =3D check_hwclock_available(hwclock_path);

Could do this inline with:

    hwclock_available =3D (access(hwclock_available, X_OK) =3D=3D 0);

getting a slightly better result as this check for it being
executable as well as existing.

> +    }
> +
> +    if (!hwclock_available) {
> +        error_setg(errp, QERR_UNSUPPORTED);
> +        return;
> +    }
> =20
>      /* If user has passed a time, validate and set it. */
>      if (has_time) {
> @@ -195,7 +213,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)
> =20
>          /* Use '/sbin/hwclock -w' to set RTC from the system time,
>           * or '/sbin/hwclock -s' to set the system time from RTC. */
> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>                 NULL, environ);
>          _exit(EXIT_FAILURE);
>      } else if (pid < 0) {
> --=20
> 2.21.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


