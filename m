Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D57C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C7F207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4BHMpMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C7F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMogC-0007hA-QJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMoey-0006xW-VD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMoex-0005zw-2r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:37:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601282241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRg4A8UOs/WkXLuP3Jk6RqZdGwstzM8LSF/rvxUqcwg=;
 b=Y4BHMpMso2l6fs0ksEmJMghyAVdLpK0//mCkgWbcmD6IzMj1LhpckcztAsRBnQqH5JpyY2
 yq9Ef3suUUIatynT/n1rQ3AOMQbjTAudUptud8QPd5bYygILpnXwYF/YsjxfhoIlVWUbk5
 8k0kBDJpEoSESqKKZ5oV1I/iGgI+qLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-jyTqREAKMcGL29BJed1XSg-1; Mon, 28 Sep 2020 04:37:19 -0400
X-MC-Unique: jyTqREAKMcGL29BJed1XSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2364A1868403;
 Mon, 28 Sep 2020 08:37:18 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7F08100239A;
 Mon, 28 Sep 2020 08:37:17 +0000 (UTC)
Date: Mon, 28 Sep 2020 09:37:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 4/4] block/export: add BlockExportOptions->iothread member
Message-ID: <20200928083716.GB43571@stefanha-x1.localdomain>
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-5-stefanha@redhat.com>
 <20200925150142.GD5731@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200925150142.GD5731@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 05:01:42PM +0200, Kevin Wolf wrote:
> Am 25.09.2020 um 15:42 hat Stefan Hajnoczi geschrieben:
> > Make it possible to specify the iothread where the export will run.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Note the x-blockdev-set-iothread QMP command can be used to do the same=
,
> > but not from the command-line. And it requires sending an additional
> > command.
> >=20
> > In the long run vhost-user-blk will support per-virtqueue iothread
> > mappings. But for now a single iothread makes sense and most other
> > transports will just use one iothread anyway.
> > ---
> >  qapi/block-export.json |  4 ++++
> >  block/export/export.c  | 26 +++++++++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index 87ac5117cd..eba6f6eae9 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -219,11 +219,15 @@
> >  #                export before completion is signalled. (since: 5.2;
> >  #                default: false)
> >  #
> > +# @iothread: The name of the iothread object where the export will run=
. The
> > +#            default is the main loop thread. (since: 5.2)
>=20
> NBD exports currently switch automatically to a different AioContext if
> another user (usually a guest device using the same node) tries to
> change the AioContext. I believe this is also the most useful mode in
> the context of the system emulator.
>=20
> I can see the need for an iothread option in qemu-storage-daemon where
> usually nobody else will move the node into a different AioContext.
>=20
> But we need to define the semantics more precisely and specify what
> happens if another user wants to change the AioContext later. Currently,
> the NBD export will allow this and just switch the AioContext - after
> this patch, ignoring what the user set explicitly with this new option.
>=20
> I see two options to handle this more consistently:
>=20
> 1. If @iothread is set, move the block node into the requested
>    AioContext, and if that fails, block-export-add fails. Other users of
>    the node will be denied to change the AioContext while the export is
>    active.
>=20
>    If @iothread is not given, it behaves like today: Use whatever
>    AioContext the node is currently in and switch whenever another user
>    requests it.
>=20
> 2. Add a bool option @fixed-iothread that determines whether other users
>    can change the AioContext while the export is active.
>=20
>    Giving an @iothread and fixed-iothread =3D=3D true means that we'll
>    enforce the given AioContext during the whole lifetime of the export.
>    With fixed-iothread =3D=3D false it means that we try to move the bloc=
k
>    node to the requested iothread if possible (but we won't fail if it
>    isn't possible) and will follow any other user switching the
>    AioContext of the node.
>=20
>    Not giving @iothread means that we start with the current AioContext
>    of the node, and @fixed-iothread then means the same as before.
>=20
> Does this make sense to you?

Thanks for raising this. #2 is more flexible. I suspect most users will
be happy with fixed-iothread =3D false by default (i.e. things keep
working even if the iothread is changed).

I can adjust this patch to follow those semantics.

Stefan

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xoLwACgkQnKSrs4Gr
c8gZaggAu4xZQ8B7Pp6jTgGZUNApHGowQEOOfYv1UVDxKu7fsLa4vDBycWd4a78y
/jd53p4KzEdoamjo4jYoI3Hhzm9mKGbnkp9nmUvrqY2QYIYMCQCkR7FTwr4lS7z/
GWOor9SPRycqjfOH6X/l4IFpfQIWXb2aZUIB/ainaTSax2ifXBxFe0t1m6NOhovN
ibB+sHQT4ho+/lqX5hhXesxZDRMpKdNffeO23iVvaWtyuOh5ZafidKYL0Napl4VR
yADDuHKZ6Ne/STc/ddkkNuDDdoniBIQ+GyW/RTUPj+NBWutO/Xyx/NT7bjJkgcYc
ByTI03ynuFT1iflaC/i2PFma4M/MKg==
=d74k
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--


