Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24832C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B502074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIynSD5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B502074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGokR-0003RH-SD
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGojm-0002da-CU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGojl-0006Wd-BU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:57:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGojl-0006WY-7t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585076237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPYPmbF4macxsU0TlXHH9h8GmrdIAJ6ip7Q3GYlXO7g=;
 b=FIynSD5KmnMHF87hdyu03+tqmKGD2oUj+gPmUArjvqjc5p0LmTmBHy8/nfu0Q/vH6+ZBPW
 iNPVcHTQDm8sz9EQGrMlgvugeIXhfb91raW+v4Xhtq4WkLxPbgCyU1PApWVU5HDR68QH4B
 fYlh8Gh+5qVJn05K2tFKT/vjB/VrYMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-p6zAnNBFMvCi5E3tk2bZvA-1; Tue, 24 Mar 2020 14:57:15 -0400
X-MC-Unique: p6zAnNBFMvCi5E3tk2bZvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE8E1011980;
 Tue, 24 Mar 2020 18:56:56 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2DF5DA7B;
 Tue, 24 Mar 2020 18:56:51 +0000 (UTC)
Date: Tue, 24 Mar 2020 18:56:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] tools/virtiofsd/passthrough_ll: Fix double close()
Message-ID: <20200324185648.GE17043@work-vm>
References: <20200321120654.7985-1-philmd@redhat.com>
 <efee418f-d160-2d0e-ca99-e112f0264013@redhat.com>
MIME-Version: 1.0
In-Reply-To: <efee418f-d160-2d0e-ca99-e112f0264013@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 3/21/20 1:06 PM, Philippe Mathieu-Daud=E9 wrote:
> > On success, the fdopendir() call closes fd. Later on the error
> > path we try to close an already-closed fd. This can lead to
> > use-after-free. Fix by only closing the fd if the fdopendir()
> > call failed.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: 7c6b66027 (Import passthrough_ll from libfuse fuse-3.8.0)
>=20
> libfuse is correct, the bug was introduced in commit b39bce121b, so:
>=20
> Fixes: b39bce121b (add dirp_map to hide lo_dirp pointers)

Queued with that tweak

> > Reported-by: Coverity (CID 1421933 USE_AFTER_FREE)
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >   tools/virtiofsd/passthrough_ll.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 4f259aac70..4c35c95b25 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -1520,8 +1520,7 @@ out_err:
> >       if (d) {
> >           if (d->dp) {
> >               closedir(d->dp);
> > -        }
> > -        if (fd !=3D -1) {
> > +        } else if (fd !=3D -1) {
> >               close(fd);
> >           }
> >           free(d);
> >=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


