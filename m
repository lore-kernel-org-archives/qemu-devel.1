Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA72C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9EC24125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbbqL0Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9EC24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuK1x-0000kK-1X
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 12:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuK18-0008OQ-Rt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuK16-0002kw-EG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:42:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuK16-0002kA-8M
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579714930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zrm6iXL4W6DAiQmAzjkiH5jESPe66PqQ8jUlETaAEc=;
 b=GbbqL0Gw+gkBJkKt5VNRFQQ2qx/WuczS8RqRRF5O8pkP7NJJAmUEFAUuPTDTMRUPafnjCy
 HxOcue7bdQgPqu277JjYWpYIezhF8a02C8kQw9scvF8n2T3gK9cIh68fg2ElU54lLkIfra
 GveouCjTGQXTQd2QAVYtiiw+4UHjyXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-W7_OD1veN8SDPOFZMp1TDQ-1; Wed, 22 Jan 2020 12:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04BC78F7B80;
 Wed, 22 Jan 2020 17:42:05 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D57D5DA2C;
 Wed, 22 Jan 2020 17:42:03 +0000 (UTC)
Date: Wed, 22 Jan 2020 17:42:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH v2 070/109] virtiofsd: passthrough_ll: control readdirplus
Message-ID: <20200122174200.GO3263@work-vm>
References: <20200121122433.50803-71-dgilbert@redhat.com>
 <20200122031140.31529-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200122031140.31529-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: W7_OD1veN8SDPOFZMp1TDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com, philmd@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c         | 3 +++
> >  tools/virtiofsd/passthrough_ll.c | 7 ++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index c8cb88afdd..36eb273d8e 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -154,6 +154,9 @@ void fuse_cmdline_help(void)
> >             "                               allowed (default: 10)\n"
> >             "    -o norace                  disable racy fallback\n"
> >             "                               default: false\n"
> > +           "    -o readdirplus|no_readdirplus\n"
> > +           "                               enable/disable readirplus\n=
"
> > +           "                               default: readdirplus\n"
>=20
> Actually, default behavior is
>  1. no_readdirplus if cache=3Dnone
>  2. readdirplus otherwise.
> So help message should be fixed.

Thanks, I've made that:

    -o readdirplus|no_readdirplus
                               enable/disable readirplus
                               default: readdirplus except with cache=3Dnev=
er

and then swapped never for none in the 'clean up cache related options'
patch.

> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thanks.

>=20
> >            );
> >  }
> > =20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index ae364a4825..b15633a044 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -117,6 +117,8 @@ struct lo_data {
> >      double timeout;
> >      int cache;
> >      int timeout_set;
> > +    int readdirplus_set;
> > +    int readdirplus_clear;
> >      struct lo_inode root; /* protected by lo->mutex */
> >      struct lo_map ino_map; /* protected by lo->mutex */
> >      struct lo_map dirp_map; /* protected by lo->mutex */
> > @@ -140,6 +142,8 @@ static const struct fuse_opt lo_opts[] =3D {
> >      { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
> >      { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS =
},
> >      { "norace", offsetof(struct lo_data, norace), 1 },
> > +    { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
> > +    { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1=
 },
> >      FUSE_OPT_END
> >  };
> >  static bool use_syslog =3D false;
> > @@ -478,7 +482,8 @@ static void lo_init(void *userdata, struct fuse_con=
n_info *conn)
> >          fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
> >          conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
> >      }
> > -    if (lo->cache =3D=3D CACHE_NEVER) {
> > +    if ((lo->cache =3D=3D CACHE_NEVER && !lo->readdirplus_set) ||
> > +        lo->readdirplus_clear) {
> >          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
> >          conn->want &=3D ~FUSE_CAP_READDIRPLUS;
> >      }
> > --=20
> > 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


