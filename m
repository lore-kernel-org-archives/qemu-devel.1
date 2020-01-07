Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C12C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C7820656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0lMGBQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C7820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopB9-0005oN-MT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iooqb-0001mj-MS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iooqY-0001xf-Ud
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iooqY-0001xN-Qu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxp5XWspXCFx1p/qkyz0To8lkzLvJ+l5Oa8Rn2EGkmM=;
 b=B0lMGBQoaVOGa1s0/XFmaVy7yukOpVPcE4qsxEDORjL8KI0em+fh7SyZh+qKdtazysBzlR
 zzn1UyXCj/sswVHNGyhW6b+8IW5XQ1FxsElD/xJrxn7ROyARe6xAFVcfnXxdQU3j5b/NN7
 2ryHGzDrJ5WgKD5Uu+A0B5L8DddDPww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-5R5kmxzMN4epOn99Q4U4mQ-1; Tue, 07 Jan 2020 08:24:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B83E800D4E
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:24:31 +0000 (UTC)
Received: from work-vm (ovpn-117-52.ams2.redhat.com [10.36.117.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE2E25D9CA;
 Tue,  7 Jan 2020 13:24:27 +0000 (UTC)
Date: Tue, 7 Jan 2020 13:24:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 086/104] virtiofsd: use fuse_lowlevel_is_virtio() in
 fuse_session_destroy()
Message-ID: <20200107132425.GG2732@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-87-dgilbert@redhat.com>
 <20200107120112.GA3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107120112.GA3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5R5kmxzMN4epOn99Q4U4mQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:46PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > vu_socket_path is NULL when --fd=3DFDNUM was used.  Use
> > fuse_lowlevel_is_virtio() instead.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >   pull request 10
>=20
> Extraneous line

Hmm, not sure where that came from; thanks.

> > ---
> >  tools/virtiofsd/fuse_lowlevel.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks!

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


