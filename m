Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84562C2BBC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9CA206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYWMaXx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9CA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKhO-0004PT-Hv
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOKgS-0003mA-3X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOKgQ-0007Zf-U8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:28:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOKgQ-0007XV-EQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586867333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SC13OSlVWcX+oi/nUOBYBUfJmJYytcYjodc5uLNZbZE=;
 b=LYWMaXx0MsbzE+dFfVdNwTxRqeKrfoFcp3DNsMS11KqllJJIlRd31Gnc7kJcsXqW6c5yFc
 idElqMUxHw7paedHUkZxbQUN/nm5eATHZYDPbWEEud3D/LVK1okDag6EPa1S9MFsn28zwf
 FUf0yVMPCoUjF/O2TgOdgxgXFh8pu3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-aaosDquLOHCEnahOq2q8FQ-1; Tue, 14 Apr 2020 08:28:51 -0400
X-MC-Unique: aaosDquLOHCEnahOq2q8FQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8EB58010F0;
 Tue, 14 Apr 2020 12:28:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA32C19C58;
 Tue, 14 Apr 2020 12:28:49 +0000 (UTC)
Date: Tue, 14 Apr 2020 14:28:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: qcow2: Zero-initialization of external data files
Message-ID: <20200414122848.GC7747@linux.fritz.box>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
 <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
 <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.04.2020 um 16:32 hat Eric Blake geschrieben:
> On 4/9/20 9:10 AM, Max Reitz wrote:
>=20
> > >=20
> > > What happens when an operation attempts to unmap things?=C2=A0 Do we =
reject
> > > all unmap operations when data-file-raw is set (thus leaving a cluste=
r
> > > marked as allocated at all times, if we can first guarantee that
> > > preallocation set things up that way)?
> > No, unmap operations currently work.  qcow2_free_any_clusters() passes
> > them through to the external data file.
> >=20
> > The problem is that the unmap also zeroes the L2 entry, so if you then
> > write data to the raw file, it won=E2=80=99t be visible from the qcow2 =
side of
> > things.  However, I=E2=80=99m not sure whether we support modifications=
 of a raw
> > file when it is already =E2=80=9Cin use=E2=80=9D by a qcow2 image, so m=
aybe that=E2=80=99s fine.
>=20
> We don't support concurrent modification. But if the guest is running and
> unmaps things, then shuts off, then we edit the raw file offline, then we
> restart the guest, the guest should see the results of those offline edit=
s.

If you write to the external data file other than through qcow2, you
have invalidated the qcow2 layer. You can only use the image as a raw
image after this.

There is no point in bending over backwards in qcow2 to allow something
like this. If you're not interested in valid metadata, but want to
ignore all of it, you can just use raw from the start.

Kevin


