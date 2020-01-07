Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE8C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B98A206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdS1aST8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B98A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iond4-0003Bt-8Y
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iomvt-0001Gu-PE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iomvs-00056O-GD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iomvs-00054W-BC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396115;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPhqErhV+RtvqVE6Fap9iSQQ+GtipyBigjroZG4daxY=;
 b=NdS1aST8f/q/06uUb/78AhsTyzsGV4eUXyMQC/zZC0KKzgV/eq8Rk27VpeIwFDYDge5xyJ
 fV7Kuwq+9XxaxE3wGixd8yM2px/rchwpQ5pVm2+AQ9Z4MmqknxRwvxDNfyfC/E0FSp7kf3
 8nNVO/+W8YQ9m/UViIu22cGGsTzIMX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-qxXmmf9PMUKNIise4quIyg-1; Tue, 07 Jan 2020 06:21:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C77810054E3
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:21:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBC095C1BB;
 Tue,  7 Jan 2020 11:21:46 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:21:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Message-ID: <20200107112143.GJ3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-67-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-67-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qxXmmf9PMUKNIise4quIyg-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:26PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Miklos Szeredi <mszeredi@redhat.com>
>=20
> No glibc support yet, so use syscall().

It exists in glibc in my Fedora 31 install.

Presumably this is related to an older version

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 91d3120033..bed2270141 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
>      }
> =20
>      if (flags) {
> +#ifndef SYS_renameat2
>          fuse_reply_err(req, EINVAL);
> +#else
> +        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
> +                      lo_fd(req, newparent), newname, flags);
> +        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
> +            fuse_reply_err(req, EINVAL);
> +        } else {
> +            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> +        }
> +#endif

We should use the formal API if available as first choice


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


