Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FDFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71695208B6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEs6nZsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71695208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9jB-0001ht-AY
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL9WK-0004ll-Tb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL9WF-0000e8-S8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600885771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EPLBQJ6EsewgEtYsiGGB0q8AzJKujco+13wfxVH0Dx4=;
 b=jEs6nZslxpO/TQLht56pQUEu7FSIEBWkIcO+ph5RSfUkDxMTLcFNtTXBa619TkIbKPHyX3
 4jdjm71qZolnZlBTXGePhhE/jxMr3NSR2G6ivpzWgNNYHQg4NuzMR1136nsBRWW32OsuM2
 WAPsyUSMXU1/RDPGNUtZ5g/ZMJf0kGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-vhC89qQBPiy3q_ENkqm0iQ-1; Wed, 23 Sep 2020 14:29:26 -0400
X-MC-Unique: vhC89qQBPiy3q_ENkqm0iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A27F81007464;
 Wed, 23 Sep 2020 18:29:25 +0000 (UTC)
Received: from localhost (ovpn-112-110.ams2.redhat.com [10.36.112.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 422DD1002C00;
 Wed, 23 Sep 2020 18:29:25 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:29:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 11/11] block/export: convert vhost-user-blk server to
 block export API
Message-ID: <20200923182924.GB70694@stefanha-x1.localdomain>
References: <20200922160401.294055-1-stefanha@redhat.com>
 <20200922160401.294055-12-stefanha@redhat.com>
 <87v9g44njt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87v9g44njt.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 03:42:30PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > Use the new QAPI block exports API instead of defining our own QOM
> > objects.
> >
> > This is a large change because the lifecycle of VuBlockDev needs to
> > follow BlockExportDriver. QOM properties are replaced by QAPI options
> > objects.
> >
> > VuBlockDev is renamed VuBlkExport and contains a BlockExport field.
> > Several fields can be dropped since BlockExport already has equivalents=
.
> >
> > The file names and meson build integration will be adjusted in a future
> > patch. libvhost-user should probably be built as a static library that
> > is linked into QEMU instead of as a .c file that results in duplicate
> > compilation.
> >
> > The new command-line syntax is:
> >
> >   $ qemu-storage-daemon \
> >       --blockdev file,node-name=3Ddrive0,filename=3Dtest.img \
> >       --export vhost-user-blk,node-name=3Ddrive0,id=3Dexport0,unix-sock=
et=3D/tmp/vhost-user-blk.sock
> >
> > Note that unix-socket is optional because we may wish to accept chardev=
s
> > too in the future.
>=20
> It's optional in the QAPI schema, but the code cosunming the --export
> appears to require it.
>=20
> There is no need to make it optional now just in case: Changing an
> option parameter from mandatory to optional is backward-compatible.

Good point, it should be mandatory.

Stefan

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rlAMACgkQnKSrs4Gr
c8jWXQf9HaNOtDWupGGrQb84o9Buc9zj5Af5FDdlhwKPF/qMtqnHG0eiksblG1Jf
DaN9ISPTCvDOOb6lPleNlrBeX7jJcI08qrcIj/Tzf+tOg95cRmQ4hMCoS9NnU36/
hkS0M+wXEfkeVfN224aDfFZTNUQGXxgGjtbsjOJoCw+NGGAsjBSuGJSUuRC79NmT
6KSdUFjpC70buz1MBkm3KawX+ehqfBzcq7liApeNz0EQQIApaQVe1Ta6npjooXWF
JKouq/uVMlXy4NnOka2r9y5HA7yPIDHRyDLoXjHqk8O+AGWhCy2CB0ksXAOUL+U8
N2fnSZ2Wxyow7n3rTZoCZRMNF96WVw==
=WCA8
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--


