Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C587C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577B22076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thkp0r+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577B22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7al-0002Oq-L0
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU7Z0-0008Rz-6O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU7Yz-0008SS-6N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU7Yy-0008SJ-KB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588246867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+ma8bu7QFZ8wvYWj/WDoAmkKQs+EpON/u4pTMOVcmg=;
 b=Thkp0r+QRY4q6fR1LUWEOyCRoU7ZzUwZ+oXemFoECw3ukYaGgE52ek/ppGn8kB4Qe0RRvY
 /3hOyfQLC90gvZAKcoRpbTRX5uNRNc0I4eb5URS7WDMY3nIIRq4KElznH3kDqPPz+ocloQ
 n+iEusXcBuyiUNz3rUEBJ1OGR7yaAlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-sYIIhYuKMx6pAtLsQKqbYQ-1; Thu, 30 Apr 2020 07:41:03 -0400
X-MC-Unique: sYIIhYuKMx6pAtLsQKqbYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF16800D24;
 Thu, 30 Apr 2020 11:40:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F27A67641;
 Thu, 30 Apr 2020 11:40:45 +0000 (UTC)
Date: Thu, 30 Apr 2020 12:40:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200430114041.GN2084570@redhat.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 11:23:34AM +0000, Thanos Makatos wrote:
> > > > I've just shared with you the Google doc we've working on with John
> > > where we've
> > > > been drafting the protocol specification, we think it's time for so=
me first
> > > > comments. Please feel free to comment/edit and suggest more people
> > to
> > > be on the
> > > > reviewers list.
> > > >
> > > > You can also find the Google doc here:
> > > >
> > > >
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__docs.google.com_document_d_1FspkL0hVEnZqHbdoqGLUpyC38rSk-
> > 5F&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6ogtti46a
> > tk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJW7NMg
> > Rg&s=3DRyyhgVrLX2bBTqpXZnBmllqkCg_wyalxwZKkfcYt50c&e=3D
> > > 7HhY471TsVwyK8/edit?usp=3Dsharing
> > > >
> > > > If a Google doc doesn't work for you we're open to suggestions.
> > >
> > > I can't add comments to the document so I've inlined them here:
> > >
> > > The spec assumes the reader is already familiar with VFIO and does no=
t
> > > explain concepts like the device lifecycle, regions, interrupts, etc.
> > > We don't need to duplicate detailed VFIO information, but I think the
> > > device model should be explained so that anyone can start from the
> > > VFIO-user spec and begin working on an implementation.  Right now I
> > > think they would have to do some serious investigation of VFIO first =
in
> > > order to be able to write code.
> >=20
> > I've added a high-level overview of how VFIO is used in this context.
> >=20
> > > "only the source header files are used"
> > > I notice the current <linux/vfio.h> header is licensed "GPL-2.0 WITH
> > > Linux-syscall-note".  I'm not a lawyer but I guess this means there a=
re
> > > some restrictions on using this header file.  The <linux/virtio*.h>
> > > header files were explicitly licensed under the BSD license to make i=
t
> > > easy to use the non __KERNEL__ parts.
> >=20
> > My impression is that this note actually relaxes the licensing requirem=
ents, so
> > that proprietary software can use the system call headers and run on Li=
nux
> > without being considered derived work. In any case I'll double check wi=
th our
> > legal team.
> >=20
> > > VFIO-user Command Types: please indicate for each request type whethe=
r
> > > it is client->server, server->client, or both.  Also is it a "command=
"
> > > or "request"?
> >=20
> > Will do. It's a command.
> >=20
> >=20
> > > vfio_user_req_type <-- is this an extension on top of <linux/vfio.h>?
> > > Please make it clear what is part of the base <linux/vfio.h> protocol
> > > and what is specific to vfio-user.
> >=20
> > Correct, it's an extension over <linux/vfio.h>. I've clarified the two =
symbol
> > namespaces.
> >=20
> >=20
> > > VFIO_USER_READ/WRITE serve completely different purposes depending
> > on
> > > whether they are sent client->server or server->client.  I suggest
> > > defining separate request type constants instead of overloading them.
> >=20
> > Fixed.
> >=20
> > > What is the difference between VFIO_USER_MAP_DMA and
> > > VFIO_USER_REG_MEM?
> > > They both seem to be client->server messages for setting up memory bu=
t
> > > I'm not sure why two request types are needed.
> >=20
> > John will provide more information on this.
> >=20
> > > struct vfio_user_req->data.  Is this really a union so that every
> > > message has the same size, regardless of how many parameters are
> > passed
> > > in the data field?
> >=20
> > Correct, it's a union so that every message has the same length.
> >=20
> > > "a framebuffer where the guest does multiple stores to the virtual
> > > device."  Do you mean in SMP guests?  Or even in a single CPU guest?
> >=20
> > @John
> >=20
> > > Also, is there any concurrency requirement on the client and server
> > > side?  Can I implement a client/server that processes requests
> > > sequentially and completes them before moving on to the next request =
or
> > > would that deadlock for certain message types?
> >=20
> > I believe that this might also depend on the device semantics, will nee=
d to
> > think about it in greater detail.
>=20
> I've looked at this but can't provide a definitive answer yet. I believe =
the
> safest thing to do is for the server to process requests in order.
>=20
> > More importantly, considering:
> > a) Marc-Andr=C3=A9's comments about data alignment etc., and
> > b) the possibility to run the server on another guest or host,
> > we won't be able to use native VFIO types. If we do want to support tha=
t
> > then
> > we'll have to redefine all data formats, similar to
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
> > 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6
> > ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ
> > W7NMgRg&s=3D1d_kB7VWQ-8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
> >=20
> > So the protocol will be more like an enhanced version of the Vhost-user
> > protocol
> > than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhost-user=
),
> > so we need to decide before proceeding as the request format is
> > substantially
> > different.
>=20
> Regarding the ability to use the protocol on non-AF_UNIX sockets, we can=
=20
> support this future use case without unnecessarily complicating the proto=
col by
> defining the C structs and stating that data alignment and endianness for=
 the=20
> non AF_UNIX case must be the one used by GCC on a x86_64 bit machine, or =
can=20
> be overridden as required.

Defining it to be x86_64 semantics is effectively saying "we're not going
to do anything and it is up to other arch maintainers to fix the inevitable
portability problems that arise".

Since this is a new protocol should we take the opportunity to model it
explicitly in some common standard RPC protocol language. This would have
the benefit of allowing implementors to use off the shelf APIs for their
wire protocol marshalling, and eliminate questions about endianness and
alignment across architectures.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


