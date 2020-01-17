Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602CCC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEDF206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWVBPedR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEDF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVOA-00061X-98
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isVNW-0005S9-50
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isVNQ-0006c9-KM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:25:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isVNQ-0006bA-G1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579281943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tc5+ZeEuSC2hRH2pHBKM/57NPiuMVYA60tAKILWTrbs=;
 b=TWVBPedRJnKuh50s8FPUuQgNTe6YF6/yv/vxMnbdJ3ExK+uZUwJqSJSSSIfoEiYlRO5MqP
 +RhdUdqzfl9yMjzHh6SGkXGKD8k+zFaZ9xwWAnSXsmVyO2YEXdvr+F9igiKnu6AC7tWmJu
 gcRh9mUAoXk1DTX8L52IXs6BPn2HEsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-a7OeDq0aNrKttT6TrFiTSw-1; Fri, 17 Jan 2020 12:25:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E4F800D5C;
 Fri, 17 Jan 2020 17:25:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 798801001901;
 Fri, 17 Jan 2020 17:25:28 +0000 (UTC)
Date: Fri, 17 Jan 2020 17:25:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200117172526.GQ3209@work-vm>
References: <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
 <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
 <20200103155920.GB281236@stefanha-x1.localdomain>
 <39A027D6-21C3-484F-8F90-9F04DCB9E4CF@oracle.com>
MIME-Version: 1.0
In-Reply-To: <39A027D6-21C3-484F-8F90-9F04DCB9E4CF@oracle.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: a7OeDq0aNrKttT6TrFiTSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "mst@redhat.com" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* John G Johnson (john.g.johnson@oracle.com) wrote:

<snip>

> DMA
>=20
> =09This is one place where I might diverge from VFIO.  It uses an
> ioctl to tell the kernel driver what areas of guest memory the device
> can address.  The driver then pins that memory so it can be programmed
> into a HW IOMMU.  We could avoid pinning of guest memory by adopting
> the vhost-user idea of sending the file descriptors used by QEMU to
> create guest memory to the emulation process, and having it mmap() the
> guest itself.  IOMMUs are handled by having the emulation process
> request device DMA to guest PA translations from QEMU.

The interface in vhost-user to pass these memory fd's is a bit hairy;
so it would be great if there was something better for multi-process.

Some things to think about:
  a) vhost-user filters it so that areas of memory not backed by an fd
aren't passed to the client; this filters out some of the device
specific RAM blocks that aren't really normal RAM.

  b) Hugepages are tricky; especially on a PC where the 0-1MB area is
broken up into chunks and you're trying to mmap 2MB chunks into the
client.

  c) Postcopy with vhost-user was pretty tricky as well; there needs
to be some coordination with the qemu to handle pages that are missing.

  d) Some RAM mappings can change; mostly not the ones sent to the
client; but just watch out that these can happen at unexpected times.

Dave


>=20
>=20
> > If implementations can use the kernel uapi vfio header files then we're
> > on track for compatibility with VFIO.
> >=20
> >>> This is just a more elaborate explanation for the "the cat is out of =
the
> >>> bag" comments that have already been made on licensing.  Does anyone
> >>> still disagree or want to discuss further?
> >>>=20
> >>> If there is agreement that a stable API is okay then I think the
> >>> practical way to do this is to first merge a cleaned-up version of
> >>> multi-process QEMU as an unstable experimental API.  Once it's being
> >>> tested and used we can write a protocol specification and publish it =
as
> >>> a stable interface when the spec has addressed most use cases.
> >>>=20
> >>> Does this sound good?
> >>=20
> >> In that case, wouldn't it be preferable to revive our proposal from
> >> Edinburgh (KVM Forum 2018)? Our prototypes moved more of the Qemu VFIO
> >> code to "common" and added a "user" backend underneath it, similar to
> >> how vhost-user-scsi moved some of vhost-scsi to vhost-scsi-common and
> >> added vhost-user-scsi. It was centric on PCI, but it doesn't have to
> >> be. The other side can be implemented in libmuser for facilitating thi=
ngs.
> >=20
> > That sounds good.
> >=20
>=20
>        The emulation program API could be based on the current
> libmuser API or the libvfio-user API.  The protocol itself wouldn=E2=80=
=99t
> care which is chosen.  Our multi-processQEMU project would have to
> change how devices are specified from the QEMU command line to the
> emulation process command line.
>=20
> =09=09=09=09=09=09=09JJ
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


