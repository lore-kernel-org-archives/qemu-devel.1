Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE61E2465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+yAYa4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE61E2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGPJ-0006lF-N6
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iiGOB-00064i-Fc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iiGO8-0005iB-Oe
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:24:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iiGO8-0005bv-4n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576841047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn6hOzgwUAX76JObcNAb9wWKeZNmZjG5/1ELqPvf4TU=;
 b=K+yAYa4tdC8++4+o+rCOtbDeQy4vW0LyfhnAvvK9i2GWT7qcYROEv3l4Q9Z35IIrDon3/F
 FXOISxllYpBqyiFkpsEQg7iHexRcyQwK8I+ibnrclY4Ay+BWzy5koWhx8Lo8T8YY3Hi76k
 f8fP+ynuTTrT6KswS7qSZMufU8Y06Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-LXyhQzNyMouqmTma62Ct2g-1; Fri, 20 Dec 2019 06:24:05 -0500
X-MC-Unique: LXyhQzNyMouqmTma62Ct2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C86818552A0;
 Fri, 20 Dec 2019 11:24:04 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A453526FB3;
 Fri, 20 Dec 2019 11:24:03 +0000 (UTC)
Date: Fri, 20 Dec 2019 12:24:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
Message-ID: <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.12.2019 um 11:48 hat Max Reitz geschrieben:
> On 20.12.19 11:26, Kevin Wolf wrote:
> > Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
> >> fuse-export-add allows mounting block graph nodes via FUSE on some
> >> existing regular file.  That file should then appears like a raw disk
> >> image, and accesses to it result in accesses to the exported BDS.
> >>
> >> Right now, we only set up the mount point and tear all mount points do=
wn
> >> in bdrv_close_all().  We do not implement any access functions, so
> >> accessing the mount point only results in errors.  This will be
> >> addressed by a followup patch.
> >>
> >> The set of exported nodes is kept in a hash table so we can later add =
a
> >> fuse-export-remove that allows unmounting.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> >> diff --git a/qapi/block.json b/qapi/block.json
> >> index 145c268bb6..03f8d1b537 100644
> >> --- a/qapi/block.json
> >> +++ b/qapi/block.json
> >> @@ -317,6 +317,29 @@
> >>  ##
> >>  { 'command': 'nbd-server-stop' }
> >> =20
> >> +##
> >> +# @fuse-export-add:
> >> +#
> >> +# Exports a block graph node on some (file) mountpoint as a raw image=
.
> >> +#
> >> +# @node-name: Node to be exported
> >> +#
> >> +# @mountpoint: Path on which to export the block device via FUSE.
> >> +#              This must point to an existing regular file.
> >> +#
> >> +# @writable: Whether clients should be able to write to the block
> >> +#            device via the FUSE export. (default: false)
> >> +#
> >> +# Since: 5.0
> >> +##
> >> +{ 'command': 'fuse-export-add',
> >> +  'data': {
> >> +      'node-name': 'str',
> >> +      'mountpoint': 'str',
> >> +      '*writable': 'bool'
> >> +  },
> >> +  'if': 'defined(CONFIG_FUSE)' }
> >=20
> > Can this use a BlockExport union from the start like I'm introducing in
> > the storage daemon series, together with a generic block-export-add?
>=20
> Hm, you mean still adding a FuseExport structure that would be part of
> BlockExport and then dropping fuse-export-add in favor of a
> block-export-add that we want anyway?

Yes.

> > It also looks like node-name and writable should be part of the common
> > base of BlockExport.
>=20
> node-name definitely, I=E2=80=99m not so sure about writable.  Or, to be =
more
> precise, I think that if we want writable to be in the base, we also
> want growable to be there: Both are primarily options for the
> BlockBackend that the exports use.
>=20
> But both of course also need to be supported by the export
> implementation.  nbd can make its BB growable all it wants, but that
> doesn=E2=80=99t make it work.

Right. Pragmatically, I think exports are very like to support writable,
but probably rather unlikely to support growable. So I do think there
would be a point for making writable part of the common base, but not
growable.

> So if we kept writable and growable in the common base, then the schema
> would give no information about what exports actually support them.
>=20
> On one hand, I don=E2=80=99t know whether it=E2=80=99s important to have =
this
> information in a static form, or whether it=E2=80=99s sufficient to learn=
 at
> runtime.
>=20
> On the other, I don=E2=80=99t know whether it=E2=80=99s important to have=
 those fields
> in the base or not.  Would it make a difference on the wire?

Not for the command itself, so I think we're free to change it later. It
might make a difference for introspection, though, not sure. Markus?

Having it in the base might allow us to remove some duplication in the
code. Probably not much, though, so not too important.

> > Unfortunately this would mean that I can't use the
> > same BlockExportNbd for the existing nbd-server-add command any more. I
> > guess I could somehow get a shared base type for both, though.
>=20
> Hm.  This sounds like you want to make it your problem.  Can I take that
> to mean that you want to implement block-export-add and I can wait with
> v2 until that=E2=80=99s done? :-)

The NBD integration, yes. I already added the BlockExport type to my
patches, too, but I expect you would beat me to it. I'm not currently
planning to write a block-export-add because it doesn't add anything new
for the storage daemon, so FuseExport and the command this is your part.
The type currently only exists for --export.

Kevin


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd/K9SAAoJEH8JsnLIjy/WfTYP/1pvBX2oQbNzz/pZ8lfudm8G
BDO6C4gXf4j5QPH/JHpgsTuUeUfmcC3RF9N8mj38AJhEDggydh3r9yHt8FrSU99A
PwyEXHZwbqsuCnH8Ck2AVs71/97siqRaZBWRj2BFlWb7xU4LAC08ZLOpjD6oij5Q
wm5z9JbeCSzi6IfPn3fVmI2GzFS2Ma34y+yP7ymDSmo+KFxVAoA9Pf9grEU030Cb
Ek4xtFiXHxqI9V8OvNUvhCiLTZyqGNWsJK34aAS44S3iQCKqHSPFlrYkTto5TSVb
xQEkaZNpqjR4znY/ejovDL3JPNVSMR8xgl+D5su26DveJlD25izipV2IvajxPXTI
YQMD+HYPzrPo45/BLDP0TAUdVog+6rvCLYpKiFKbhfFxnMtvHn+IcuOOgT35nG6c
TO2gB0qp3K4EqiFbPjaD6oOiuTUZS5OjA/m7fQ146GtqyxpUtg1EfUWLRxzZRd81
bpVCExFMq7feMQOvYaFjudcnWYJKpACQMrIS1lGDIchH6hO21eGC0Kh9MCS6BtyC
YWlcJeIftNOu40Ikgnv3FuGarzu62+hbWfvi1Ej/ZnUBeKBrav1Jp4C7z1MBaY7P
JUztPqDisdA4Hi20MPWkoY93drSSw80fHa8ugb6UErikiOK1TXkxE1STkVYP8J7X
vnz2yHx7iTLn1M/vQnrf
=A8Ij
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


