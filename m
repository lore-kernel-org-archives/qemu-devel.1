Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92253C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A2621850
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6pwNQM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A2621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2EI-0000vs-Bz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iX2DH-0008Ti-Hv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iX2DG-0000Bc-Cn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:02:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iX2DG-0000BP-9V
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574164949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO1ZKOs9wrDjKXX+JQqQ1bmXbXwkdrTcp3OW9OYDxeI=;
 b=E6pwNQM/94/iijZoBx8QvvCgwVu6xBO80V1TVG69Y4Yz3DJDLLETm/3GYbYjPlLx0BsAp5
 f8qqBnWIf+YbGp0Z9MaYTraG0QFSycwJ2dTmErtEuM4zNMbVmK9Mgz4aobBl0FhOId99TC
 RszDxOCY0+VCJPbRymejyMUhEbROeYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-shDwPMhIOvW1ww4IGG6rYw-1; Tue, 19 Nov 2019 07:02:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C5980269B;
 Tue, 19 Nov 2019 12:02:25 +0000 (UTC)
Received: from gondolin (ovpn-117-102.ams2.redhat.com [10.36.117.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19B695E264;
 Tue, 19 Nov 2019 12:02:22 +0000 (UTC)
Date: Tue, 19 Nov 2019 13:02:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20191119130220.7c0eef35.cohuck@redhat.com>
In-Reply-To: <20191119122340.41c77c5b.pasic@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
 <20191118191334.001f9343.cohuck@redhat.com>
 <20191119122340.41c77c5b.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: shDwPMhIOvW1ww4IGG6rYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 12:23:40 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 18 Nov 2019 19:13:34 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > > EIO is returned by vfio-ccw mediated device when the backing
> > > host subchannel is not operational anymore. So return cc=3D3
> > > back to the guest, rather than returning a unit check.
> > > This way the guest can take appropriate action such as
> > > issue an 'stsch'.   =20
> >=20
> > Hnm, I'm trying to recall whether that was actually a conscious choice,
> > but I can't quite remember... the change does make sense at a glance,
> > however. =20
>=20
> Is EIO returned if and only if the host subchannel/device is not
> operational any more, or are there cases as well?=20

Ok, I walked through the kernel code, and it seems -EIO can happen
- when we try to do I/O while in the NOT_OPER or STANDBY states... cc 3
  makes sense in those cases
- when the cp is not initialized when trying to fetch the orb... which
  is an internal vfio-ccw kernel module error

Btw., this patch only changes one of the handlers; I think you have to
change all of start/halt/clear?

[Might also be good to double-check the handling for the different
instructions.]

> Is the mapping
> (cc to condition) documented? By the QEMU code I would think that
> we already have ENODEV and EACCESS for 'not operational' -- no idea
> why we need two codes though.

-ENODEV: device gone
-EACCES: no path operational

We should be able to distinguish between the two; in the 'no path
operational' case, the device may still be accessible with a different
path mask in the request.


