Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54B6C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FD0208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7oKqTst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FD0208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXeh-0007XU-IU
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:32:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jUXbB-0003Po-QX
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jUXb5-0000PP-K9
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:29:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jUXb5-0000NR-4S
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588346941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWrrjpSqzO/3pVbG9kvcqp/Vvhv/ZBgPsk2/MVYG7JM=;
 b=M7oKqTstaMV8bKxdO78rhOk/XdI/Zz3rBFmWhAv0EjsvsNVNm+r5XDzYMIIzJpNFkHUaWG
 reDw8duG4dBmKe+Qvlm0vFM5mQJeLU8tvjEf8qhjLS2vvauTFvvhIo8fgVZ29OBATVirQ2
 GJjVwl8WSDBfPwlv7hcrcvAGoYohtIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ghc7ejtbOUWPeEzZDm1u6Q-1; Fri, 01 May 2020 11:28:45 -0400
X-MC-Unique: ghc7ejtbOUWPeEzZDm1u6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C73308005B7;
 Fri,  1 May 2020 15:28:42 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9A160BE1;
 Fri,  1 May 2020 15:28:27 +0000 (UTC)
Date: Fri, 1 May 2020 16:28:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200501152825.GA3356@redhat.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
 <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 01, 2020 at 03:01:01PM +0000, Felipe Franciosi wrote:
> Hi,
>=20
> > On Apr 30, 2020, at 4:20 PM, Thanos Makatos <thanos.makatos@nutanix.com=
> wrote:
> >=20
> >>>> More importantly, considering:
> >>>> a) Marc-Andr=C3=A9's comments about data alignment etc., and
> >>>> b) the possibility to run the server on another guest or host,
> >>>> we won't be able to use native VFIO types. If we do want to support =
that
> >>>> then
> >>>> we'll have to redefine all data formats, similar to
> >>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> >>>> 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
> >>>>=20
> >> 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6
> >>>>=20
> >> ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ
> >>>> W7NMgRg&s=3D1d_kB7VWQ-
> >> 8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
> >>>>=20
> >>>> So the protocol will be more like an enhanced version of the Vhost-u=
ser
> >>>> protocol
> >>>> than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhost-u=
ser),
> >>>> so we need to decide before proceeding as the request format is
> >>>> substantially
> >>>> different.
> >>>=20
> >>> Regarding the ability to use the protocol on non-AF_UNIX sockets, we =
can
> >>> support this future use case without unnecessarily complicating the
> >> protocol by
> >>> defining the C structs and stating that data alignment and endianness=
 for
> >> the
> >>> non AF_UNIX case must be the one used by GCC on a x86_64 bit machine,
> >> or can
> >>> be overridden as required.
> >>=20
> >> Defining it to be x86_64 semantics is effectively saying "we're not go=
ing
> >> to do anything and it is up to other arch maintainers to fix the inevi=
table
> >> portability problems that arise".
> >=20
> > Pretty much.
> >=20
> >> Since this is a new protocol should we take the opportunity to model i=
t
> >> explicitly in some common standard RPC protocol language. This would h=
ave
> >> the benefit of allowing implementors to use off the shelf APIs for the=
ir
> >> wire protocol marshalling, and eliminate questions about endianness an=
d
> >> alignment across architectures.
> >=20
> > The problem is that we haven't defined the scope very well. My initial =
impression=20
> > was that we should use the existing VFIO structs and constants, however=
 that's=20
> > impossible if we're to support non AF_UNIX. We need consensus on this, =
we're=20
> > open to ideas how to do this.
>=20
> Thanos has a point.
>=20
> From https://wiki.qemu.org/Features/MultiProcessQEMU, which I believe
> was written by Stefan, I read:
>=20
> > Inventing a new device emulation protocol from scratch has many
> > disadvantages. VFIO could be used as the protocol to avoid reinventing
> > the wheel ...
>=20
> At the same time, this appears to be incompatible with the (new?)
> requirement of supporting device emulation which may run in non-VFIO
> compliant OSs or even across OSs (ie. via TCP or similar).

To be clear, I don't have any opinion on whether we need to support
cross-OS/TCP or not.

I'm merely saying that if we do decide to support cross-OS/TCP, then
I think we need a more explicitly modelled protocol, instead of relying
on serialization of C structs.

There could be benefits to an explicitly modelled protocol, even for
local only usage, if we want to more easily support non-C languages
doing serialization, but again I don't have a strong opinion on whether
that's neccessary to worry about or not.

So I guess largely the question boils down to setting the scope of
what we want to be able to achieve in terms of RPC endpoints.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


