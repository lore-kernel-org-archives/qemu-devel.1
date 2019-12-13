Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F6C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E9F24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2B3N5fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E9F24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmY6-0000sr-QO
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1ifmXM-00008q-2G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1ifmXL-0005EM-1y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:07:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ifmXK-0005Cl-U1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576249642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeaw94CjRLH2InwRSYkSIiG5LPDy/OQ/jN3H0cNrI1M=;
 b=h2B3N5fprWJ2P/YV+Rl2E4tPx1vxypgIlU+hkqLPLvu+0kT2aXnnVYsz/pz99vC3JphE7h
 GYSBAbr6mhOlYl0dN8d0UxaUq1Ftwo8fzMJE1LKF8wWs7GtezZoJ2zAb/rAtkU3zwn4woA
 tzd4tXPptgIrBbyrxTPq1KW58lFaWOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-v6V-g228PfGkgWYNdHE4Ag-1; Fri, 13 Dec 2019 10:07:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09F8107BAAB;
 Fri, 13 Dec 2019 15:07:17 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9FB95D9CA;
 Fri, 13 Dec 2019 15:07:08 +0000 (UTC)
Date: Fri, 13 Dec 2019 16:07:06 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [libvirt] [PATCH] virtio-blk: deprecate SCSI passthrough
Message-ID: <20191213150706.GS2441258@angien.pipo.sk>
References: <20191213144626.1208237-1-stefanha@redhat.com>
 <a14facd1-731e-f1cd-2476-1bd676da1e7d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a14facd1-731e-f1cd-2476-1bd676da1e7d@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: v6V-g228PfGkgWYNdHE4Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 15:56:08 +0100, Paolo Bonzini wrote:
> On 13/12/19 15:46, Stefan Hajnoczi wrote:
> > The Linux virtio_blk.ko guest driver is removing legacy SCSI passthroug=
h
> > support.  Deprecate this feature in QEMU too.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-deprecated.texi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 4b4b7425ac..ef94d497da 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -285,6 +285,17 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=3Dv=
1.9.1`` command line argument.
> > =20
> >  @section Device options
> > =20
> > +@subsection Emulated device options
> > +
> > +@subsubsection -device virtio-blk,scsi=3Don|off (since 5.0.0)
> > +
> > +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  V=
IRTIO 1.0
> > +and later do not support it because the virtio-scsi device was introdu=
ced for
> > +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is r=
equired.
> > +
> > +Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off'', wh=
ich is an
> > +alias.
> > +
> >  @subsection Block device options
> > =20
> >  @subsubsection "backing": "" (since 2.12.0)
> >=20
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Libvirt still allows and exposes this configuration:

    <disk type=3D'block' device=3D'lun'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source dev=3D'/dev/sdfake2'/>
      <target dev=3D'vdb' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x0'/>
    </disk>

which results into the following command line:

-drive file=3D/dev/sdfake2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1=
 \
-device virtio-blk-pci,scsi=3Don,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-virti=
o-disk1,\
id=3Dvirtio-disk1

In this case I don't see any possibility how to fix it since it requires
change of controller.

I don't think that we've also added interlocks for this with VIRTIO 1.0


