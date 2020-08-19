Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB292205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIqnf5XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB292205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Mqx-00009b-VA
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Mq3-0007ak-0s
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Mq1-0006Mf-Cx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597838704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=COsr2f0a9Qhapa2K2c/lvN1g+F05onyC+7ezHuvpP3g=;
 b=iIqnf5XEH6iEDn/nL8aPB7howlmxI35WEzCBJTMZ+t46HptqFWMssfC5Rh82GBS2m+Ybud
 jUjsu3wlgJBdrKWPXsi6N9LLnCoL3QsQOnT2V22epBa86zEFB6fOsPp76laVqWT0gVyV0m
 NS9bYaYSC+iEBDjZYFoV4zapT1fnFyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-fqJPqezyO_eKxWHZHHFGzg-1; Wed, 19 Aug 2020 08:05:00 -0400
X-MC-Unique: fqJPqezyO_eKxWHZHHFGzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447BA80B736;
 Wed, 19 Aug 2020 12:04:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E68A2B3A0;
 Wed, 19 Aug 2020 12:04:58 +0000 (UTC)
Date: Wed, 19 Aug 2020 14:04:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 22/22] block/export: Add query-block-exports
Message-ID: <20200819113107.GC10272@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-23-kwolf@redhat.com>
 <eb78ea1a-1196-62df-c2be-e1fba5a9a5e4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eb78ea1a-1196-62df-c2be-e1fba5a9a5e4@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 05:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.08.2020 um 13:04 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > This adds a simple QMP command to query the list of block exports.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json | 33 +++++++++++++++++++++++++++++++++
> >  block/export/export.c  | 23 +++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >=20
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index a067de2ba3..0b184bbd7c 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -226,3 +226,36 @@
> >  ##
> >  { 'command': 'block-export-del',
> >    'data': { 'id': 'str', '*mode': 'BlockExportRemoveMode' } }
> > +
> > +##
> > +# @BlockExportInfo:
> > +#
> > +# Information about a single block export.
> > +#
> > +# @id: The unique identifier for the block export
> > +#
> > +# @type: This field is returned only for compatibility reasons, it sho=
uld
> > +#        not be used (always returns 'unknown')
>=20
> =C3=84h?
>=20
> I don=E2=80=99t understand.  It looks like it definitely doesn=E2=80=99t =
always return
> =E2=80=9Cunknown=E2=80=9D.  Also, the =E2=80=9Ccompatibility reasons=E2=
=80=9D aren=E2=80=99t really immediately
> clear to me... :?

Oops, this seems to be copied from BlockInfo and I forgot to change it...

Kevin

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl89FWgACgkQfwmycsiP
L9YZ1Q/6A+8KrUsXkIUJDvgCjE3ZZsjIo9RoLNcujKV+JAUqPeheXUzXhdemdSrN
ri384RMqF0UjqfCJv8CctCHdIPmvmxqHY31huLb+JfGWNKpIPE8PgH6hTo209a9A
rPyDssyV1/FUBFAaiSeI5NFmdzvWDfnPslCTDlJWgZ4f+RCWO0C+AmOqAVv+lxsv
2ksGWCYPqGUQvjUFrBzIQIHOMimRX2IlkKPr3aVA57rs3t3LUj4wEi/1mMF/bAuf
Gn6vya9tsBA8nBLn5SqKe/J+XdTBZm+qB6QdE8mc1hVH65aweHFmCe7ooB0rRdcv
Nuxrm1+51y++Bn3Gk7l9euONTzaHuuCRCzTOX8Z6pPAmPWL7sChEoOYXQ0XYchTu
epvvjBTDZ93ktQZOClx3DtXonND8TWR2/7HSYx4jqWUMBnujpTl1PPjz9jQXFgIL
q1rdM6EqQgc5JizByVQEMMNsArK5bngbf0Iu9n+J9++sKyrFO28iB+XlftCAcyR0
QwMHt9DmikRST24Xxfqteht5Ef42dSzFlZMKWlpECUohQDee8hFhYBb7+xuuL6iC
6p7hSAhBCK/PqenIX5XiBs81dYTKPb7K+vRJFWdlszKUKPoK0zmdih3uUeZW86nB
ja+/IPkeZro8PnX8xYVpvLfsGug0WIZssqmlqXfrZ3pxmeOC55k=
=YXHm
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--


