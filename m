Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF74C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2857220838
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT7bOWF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2857220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipu9X-0007UQ-W1
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 08:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipu8D-0006aE-1l
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipu8B-0000Ab-HB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:15:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipu8B-000092-Aq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578662114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Hn+MxLDUNfuH9pjzjB8E7QU87i7NfMLknolHa1WD1I=;
 b=CT7bOWF1V5Xv29dyLHoSPUpXCe0yJADwmVg/ANmg8N9ilpfCXOKeuxr5+HGbZjXzcD/pYq
 F3oL55JAgpvmDWKzB2ud9gOvrbHy82AZJ+MT13+Wdj2O6RfaxJhItA8UUj6Bg9mhyxKi2W
 EX/A9INQ3jh4sWVKpP/jikDXOTMWBRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-LlpjPbfZPc-llf4vmrzNQg-1; Fri, 10 Jan 2020 08:15:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98542189CD03
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 13:15:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 680A280628;
 Fri, 10 Jan 2020 13:15:07 +0000 (UTC)
Date: Fri, 10 Jan 2020 13:15:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 099/104] virtiofsd: use fuse_buf_writev to replace
 fuse_buf_write for better performance
Message-ID: <20200110131504.GF3901@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-100-dgilbert@redhat.com>
 <20200107122347.GI3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107122347.GI3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LlpjPbfZPc-llf4vmrzNQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> On Thu, Dec 12, 2019 at 04:38:59PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: piaojun <piaojun@huawei.com>
> >=20
> > fuse_buf_writev() only handles the normal write in which src is buffer
> > and dest is fd. Specially if src buffer represents guest physical
> > address that can't be mapped by the daemon process, IO must be bounced
> > back to the VMM to do it by fuse_buf_copy().
> >=20
> > Signed-off-by: Jun Piao <piaojun@huawei.com>
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/buffer.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> >=20
> > diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
> > index ae420c70c4..4875473785 100644
> > --- a/tools/virtiofsd/buffer.c
> > +++ b/tools/virtiofsd/buffer.c
> > @@ -33,9 +33,7 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv)
> >      return size;
> >  }
> > =20
> > -__attribute__((unused))
> > -static ssize_t fuse_buf_writev(fuse_req_t req,
>=20
> Lets cull the fuse_req_t param in the previous patch

Done.

> > -                               struct fuse_buf *out_buf,
> > +static ssize_t fuse_buf_writev(struct fuse_buf *out_buf,
> >                                 struct fuse_bufvec *in_buf)
> >  {
> >      ssize_t res, i, j;
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


