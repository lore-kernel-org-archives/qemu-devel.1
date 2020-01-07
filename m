Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F9C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3642146E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gch5sodD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3642146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq5S-0004nj-FP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iootm-0002ao-Dd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iootk-0003aT-W8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iootk-0003aC-SB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFHdwo3Nl4Hc/YwEFaJOyv2mMZkI7m8j3abRPQsvzSY=;
 b=Gch5sodDVUUxJMpXvFN/4vMgD57hpHWlWMrC9lx+xLev+UklsvYB6HWaFuR4GK4IUEXSXn
 wfnWL2LAnj6Oh/fL1opbf93yLuugxv5JDtWepEcR/h4fHW3KIZiSIE64WJEsVtWIxH6aUG
 1XdduZMjWBFdHgF1G2mI5WiRENz/fls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-9qOEjienNGqdvhn6BtVRjQ-1; Tue, 07 Jan 2020 08:27:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DECD100551D
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:27:49 +0000 (UTC)
Received: from work-vm (ovpn-117-52.ams2.redhat.com [10.36.117.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99202100164D;
 Tue,  7 Jan 2020 13:27:45 +0000 (UTC)
Date: Tue, 7 Jan 2020 13:27:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 097/104] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Message-ID: <20200107132743.GH2732@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-98-dgilbert@redhat.com>
 <20200107122007.GG3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107122007.GG3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9qOEjienNGqdvhn6BtVRjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:57PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> >=20
> > When writeback mode is enabled (-o writeback), O_APPEND handling is
> > done in kernel. Therefore virtiofsd clears O_APPEND flag when open.
> > Otherwise O_APPEND flag takes precedence over pwrite() and write
> > data may corrupt.
> >=20
> > Currently clearing O_APPEND flag is done in lo_open(), but we also
> > need the same operation in lo_create(). So, factor out the flag
> > update operation in lo_open() to update_open_flags() and call it
> > in both lo_open() and lo_create().
> >=20
> > This fixes the failure of xfstest generic/069 in writeback mode
> > (which tests O_APPEND write data integrity).
>=20
> Seeing this mention of xfstest reminds me that there are no tests
> added anywhere in this patch series.  Is there another followup
> pending with tests or is it a todo item ?

We've got some github CI setup, but not too much automatic of as yet.
As you spotted in another patch we need root to run this at the moment
which makes life harder; we also need a full guest to drive fuse
requests.

> We can usefully wire up this xfstest program in the functional
> tests of QEMU in some way ?

>=20
> >=20
> > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 66 ++++++++++++++++----------------
> >  1 file changed, 33 insertions(+), 33 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks.

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


