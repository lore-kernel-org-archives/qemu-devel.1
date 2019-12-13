Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9AC47409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BBB21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQxODS+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BBB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmb9-0002Ip-V9
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifmaJ-0001bn-Jt
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifmaH-0001yB-8L
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:10:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifmaH-0001vA-24
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576249823;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+7UFyqaPVDIizD1A2VE949dUs6zEbftEiylQTOVsxA=;
 b=FQxODS+HUqZBSWoyNC/h+dvYf7SeTnXxzAWeJXkrdlq8K+K2q/GuJNrkNjiGqHDzSM5AfO
 NM7vcrFMYrYBA4DZVOnfTld3snFjDsjyJd7JbXYdEl6LYdTiNbxWdeNQHit3wTPnDwt1Bg
 M81ZDbOFg/D0VXJ6CUQOIUr+lCOF/QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-e0xFfsYvPuO8X5sKyXHZYA-1; Fri, 13 Dec 2019 10:10:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A348911A4;
 Fri, 13 Dec 2019 15:10:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF08460BF4;
 Fri, 13 Dec 2019 15:10:11 +0000 (UTC)
Date: Fri, 13 Dec 2019 15:10:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [libvirt] [PATCH] virtio-blk: deprecate SCSI passthrough
Message-ID: <20191213151009.GF2232389@redhat.com>
References: <20191213144626.1208237-1-stefanha@redhat.com>
 <a14facd1-731e-f1cd-2476-1bd676da1e7d@redhat.com>
 <20191213150706.GS2441258@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20191213150706.GS2441258@angien.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e0xFfsYvPuO8X5sKyXHZYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 04:07:06PM +0100, Peter Krempa wrote:
> On Fri, Dec 13, 2019 at 15:56:08 +0100, Paolo Bonzini wrote:
> > On 13/12/19 15:46, Stefan Hajnoczi wrote:
> > > The Linux virtio_blk.ko guest driver is removing legacy SCSI passthro=
ugh
> > > support.  Deprecate this feature in QEMU too.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  qemu-deprecated.texi | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > > index 4b4b7425ac..ef94d497da 100644
> > > --- a/qemu-deprecated.texi
> > > +++ b/qemu-deprecated.texi
> > > @@ -285,6 +285,17 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=
=3Dv1.9.1`` command line argument.
> > > =20
> > >  @section Device options
> > > =20
> > > +@subsection Emulated device options
> > > +
> > > +@subsubsection -device virtio-blk,scsi=3Don|off (since 5.0.0)
> > > +
> > > +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature. =
 VIRTIO 1.0
> > > +and later do not support it because the virtio-scsi device was intro=
duced for
> > > +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is=
 required.
> > > +
> > > +Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off'', =
which is an
> > > +alias.
> > > +
> > >  @subsection Block device options
> > > =20
> > >  @subsubsection "backing": "" (since 2.12.0)
> > >=20
> >=20
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Libvirt still allows and exposes this configuration:
>=20
>     <disk type=3D'block' device=3D'lun'>
>       <driver name=3D'qemu' type=3D'qcow2'/>
>       <source dev=3D'/dev/sdfake2'/>
>       <target dev=3D'vdb' bus=3D'virtio'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
>     </disk>
>=20
> which results into the following command line:
>=20
> -drive file=3D/dev/sdfake2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-dis=
k1 \
> -device virtio-blk-pci,scsi=3Don,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-vir=
tio-disk1,\
> id=3Dvirtio-disk1
>=20
> In this case I don't see any possibility how to fix it since it requires
> change of controller.

I don't think it really matters. QEMU is deprecating it with no
seemless direct replacement, so I don't think libvirt needs to
be concerned. The feature simply becomes unsupported.

At the very most we need to check if it exists before using it,
but even that's just a nice to have which results in a slightly
prettier error message.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


