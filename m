Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B8C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7AC23899
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYyjtTso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7AC23899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHpb-0005CI-2H
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNHnn-0003lb-Qk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNHnk-0004OX-So
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:44:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601394259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu0JbI1trYTq4bfHFn40negxWJX7LAQ5375dSsESbDM=;
 b=eYyjtTsoG8Z06WIhZI13q/Kwjx5dxxBjzGgNfJ4uEUV5K1vcXSiw0Ny6thfIJSVzJT68f1
 LDaRX8uS0auQE37EC6AS8umWWQXQv9pWF8czEWmT9xAnf2CFbGUJme8s/vuDno4Wc86u4v
 BJIpBmKGSeapfp3hdBcRSJb2tfBWkRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-i5usrRmnNFyIPlwQXM8DpQ-1; Tue, 29 Sep 2020 11:44:16 -0400
X-MC-Unique: i5usrRmnNFyIPlwQXM8DpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2706807356;
 Tue, 29 Sep 2020 15:44:15 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C1697EEDA;
 Tue, 29 Sep 2020 15:44:08 +0000 (UTC)
Date: Tue, 29 Sep 2020 16:44:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 4/4] block/export: add iothread and fixed-iothread
 options
Message-ID: <20200929154407.GA191675@stefanha-x1.localdomain>
References: <20200929125516.186715-1-stefanha@redhat.com>
 <20200929125516.186715-5-stefanha@redhat.com>
 <7f99e542-c6a1-cec4-26f9-30ce4e271c65@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7f99e542-c6a1-cec4-26f9-30ce4e271c65@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 08:07:38AM -0500, Eric Blake wrote:
> On 9/29/20 7:55 AM, Stefan Hajnoczi wrote:
> > Make it possible to specify the iothread where the export will run. By
> > default the block node can be moved to other AioContexts later and the
> > export will follow. The fixed-iothread option forces strict behavior
> > that prevents changing AioContext while the export is active. See the
> > QAPI docs for details.
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
> >   qapi/block-export.json               | 11 ++++++++++
> >   block/export/export.c                | 31 +++++++++++++++++++++++++++=
-
> >   block/export/vhost-user-blk-server.c |  5 ++++-
> >   nbd/server.c                         |  2 --
> >   4 files changed, 45 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index 87ac5117cd..e2cb21f5f1 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -219,11 +219,22 @@
> >   #                export before completion is signalled. (since: 5.2;
> >   #                default: false)
> >   #
> > +# @iothread: The name of the iothread object where the export will run=
. The
> > +#            default is to use the thread currently associated with th=
e #
>=20
> Stray #
>=20
> > +#            block node. (since: 5.2)
> > +#
> > +# @fixed-iothread: True prevents the block node from being moved to an=
other
> > +#                  thread while the export is active. If true and @iot=
hread is
> > +#                  given, export creation fails if the block node cann=
ot be
> > +#                  moved to the iothread. The default is false.
> > +#
>=20
> Missing a '(since 5.2)' tag.  (Hmm, we're inconsistent on whether it is
> 'since 5.2' or 'since: 5.2' inside () parentheticals; Markus, is that
> something we should be cleaning up as part of the conversion to rST?)
>=20
> > @@ -63,10 +64,11 @@ static const BlockExportDriver *blk_exp_find_driver=
(BlockExportType type)
> >   BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
> >   {
> > +    bool fixed_iothread =3D export->has_fixed_iothread && export->fixe=
d_iothread;
>=20
> Technically, our QAPI code guarantees that export->fixed_iothread is fals=
e
> if export->has_fixed_iothread is false.  And someday I'd love to let QAPI
> express default values for bools so that we don't need a has_FOO field wh=
en
> a default has been expressed.  But neither of those points affect this
> patch; what you have is correct even if it is verbose.
>=20
> Otherwise looks reasonable.

Great, thanks for pointing this out.

I'll wait for comments from Kevin. These things could be fixed when
merging.

Stefan

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9zVkcACgkQnKSrs4Gr
c8hhVgf/cghg6s8wFfICddOTm5IvkG2DYptFLUFU4JGu3SQQBxRPOYcTLnsAn7WK
EnyQHGTnjqAa3QHzJH+f39P441PrKhdfFsdgUGy/03+fVkbSW+9Uv1oNw6G4m9IF
fW2rKHvDIIjyZxFZAQVX1IRbt9M+HVYIVzE88VmskTAUcO276tPkFOBnklq7q3Q8
7/3XA4nXczoQ5f0Ho2ZtXwBhebTnu8WyssNLjTEktmgW9KpQ2tDYSuMly5mxtBom
Wx5UZ1g+qqySLOHR9kl9/59MRQCJz5rn3TpM2O22jewnncrUPDj9zUEiabduNe7z
BqLuZiPQlv/REw8lroghW6PzYucXDA==
=DUBP
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


