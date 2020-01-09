Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A5D20721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtPQBNLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A5D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipbpf-0007IM-He
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 12:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipbou-0006Tg-BY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipbot-0008VX-0o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:42:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipbos-0008St-Oz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578591726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozFjmZyp2lcykqJRazyA26Na0g2o5U3XCSIZB8aEoGY=;
 b=XtPQBNLIOo9+E9CldaVIrpQxmKqDooFkLONLxa2mzN5BQpxV1QGaDmcX9sZp9mtfDeciVm
 JptAaAkxwwYOT66/kfqOHWxy5j5fnsjZ1oAobj4/KBiUmxcVEGYvZtS7/FaDcxK4nKIVyM
 xzDq1bfRdW8jvwn3YWoBb8anXPxFTCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-rO_CszkjMpesLKLG01nexw-1; Thu, 09 Jan 2020 12:42:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B6DA107ACC7
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 17:41:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA8AC1A8E2;
 Thu,  9 Jan 2020 17:41:55 +0000 (UTC)
Date: Thu, 9 Jan 2020 17:41:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 080/104] virtiofsd: add helper for lo_data cleanup
Message-ID: <20200109174153.GP6795@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-81-dgilbert@redhat.com>
 <20200107114001.GU3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107114001.GU3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rO_CszkjMpesLKLG01nexw-1
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
> On Thu, Dec 12, 2019 at 04:38:40PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >=20
> > This offers an helper function for lo_data's cleanup.
> >=20
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 37 ++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks.

>=20
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 45cf466178..097033aa00 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2439,6 +2439,26 @@ static gboolean lo_key_equal(gconstpointer a, gc=
onstpointer b)
> >      return la->ino =3D=3D lb->ino && la->dev =3D=3D lb->dev;
> >  }
> > =20
> > +static void fuse_lo_data_cleanup(struct lo_data *lo)
> > +{
> > +    if (lo->inodes) {
> > +        g_hash_table_destroy(lo->inodes);
> > +    }
> > +    lo_map_destroy(&lo->fd_map);
> > +    lo_map_destroy(&lo->dirp_map);
> > +    lo_map_destroy(&lo->ino_map);
> > +
> > +    if (lo->proc_self_fd >=3D 0) {
> > +        close(lo->proc_self_fd);
> > +    }
> > +
> > +    if (lo->root.fd >=3D 0) {
> > +        close(lo->root.fd);
> > +    }
> > +
> > +    free((char *)lo->source);
>=20
> This will need changing if you follow my comment on prev patch about
> removing the const & cast

Done.

>=20
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
> > @@ -2594,22 +2614,7 @@ err_out2:
> >  err_out1:
> >      fuse_opt_free_args(&args);
> > =20
> > -    if (lo.inodes) {
> > -        g_hash_table_destroy(lo.inodes);
> > -    }
> > -    lo_map_destroy(&lo.fd_map);
> > -    lo_map_destroy(&lo.dirp_map);
> > -    lo_map_destroy(&lo.ino_map);
> > -
> > -    if (lo.proc_self_fd >=3D 0) {
> > -        close(lo.proc_self_fd);
> > -    }
> > -
> > -    if (lo.root.fd >=3D 0) {
> > -        close(lo.root.fd);
> > -    }
> > -
> > -    free((char *)lo.source);
> > +    fuse_lo_data_cleanup(&lo);
> > =20
> >      return ret ? 1 : 0;
> >  }
> > --=20
> > 2.23.0
> >=20
> >=20
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


