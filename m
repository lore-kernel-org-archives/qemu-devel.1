Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF473C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07C420661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW1W3BwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07C420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipbmj-00059o-So
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 12:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipbly-0004bW-BI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipblx-0003Ee-4N
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:39:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipblw-0003BL-To
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578591544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6TeDxzrEcmJQU08YWk3xnuNKX8NlcJHrgRQOK2fd58=;
 b=TW1W3BwI2ZMIFuSCteBlbIG1oh/gf6dTjlEW8jclpukOk65HBANrLCnhvUbIe1yaXHa/ia
 3tJEutIXPV4fC62X9TTTndARGH2KUTVGCTHq17NvYHmSeCb3lwrVpQg1Lu5e7o0RYPTe4b
 +Rb6b1hqSHW3TyV8DdvXukWUnf37/us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-AiJwSJLUPd-M0vTvKxCxBw-1; Thu, 09 Jan 2020 12:39:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27EDD800EBF;
 Thu,  9 Jan 2020 17:39:00 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F05446;
 Thu,  9 Jan 2020 17:38:56 +0000 (UTC)
Date: Thu, 9 Jan 2020 17:38:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 bo.liu@linux.alibaba.com
Subject: Re: [PATCH 079/104] virtiofsd: fix memory leak on lo.source
Message-ID: <20200109173853.GO6795@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-80-dgilbert@redhat.com>
 <20200107113734.GT3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107113734.GT3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AiJwSJLUPd-M0vTvKxCxBw-1
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
> On Thu, Dec 12, 2019 at 04:38:39PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >=20
> > valgrind reported that lo.source is leaked on quiting, but it was defin=
ed
> > as (const char*) as it may point to a const string "/".
> >=20
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 33092de65a..45cf466178 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2529,9 +2529,8 @@ int main(int argc, char *argv[])
> >              fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
> >              exit(1);
> >          }
> > -
> >      } else {
> > -        lo.source =3D "/";
> > +        lo.source =3D strdup("/");
> >      }
> >      lo.root.is_symlink =3D false;
> >      if (!lo.timeout_set) {
> > @@ -2610,5 +2609,7 @@ err_out1:
> >          close(lo.root.fd);
> >      }
> > =20
> > +    free((char *)lo.source);
>=20
> Can we not change the 'lo_data' struct so that source is not const
> and thus avoid free'ing a const field ?

Done.  Made that free(lo.source) and dropped the const.

Dave


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


