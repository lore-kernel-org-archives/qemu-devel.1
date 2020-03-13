Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEE02074A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYDQ6ZF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEE02074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCgOM-0002sM-3s
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCgNQ-00028x-GV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCgNN-0002OE-K6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:13:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCgNM-0002Le-LO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584090781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw/kWsXmVgVyyhr1DGtnI11sBPXCta5LSGeMZrDdnZk=;
 b=SYDQ6ZF7YNTxDkYfbM1LoVlyXrrK7eFPCNv/e/qFQVFu69o7k4FMWt8cGeGi8C5d4LQSem
 w1d/HyJQLW5oFP6x6sTxGoUDL9sw7y2qk1I4aXxxxA8RPICofJEse/OvSDKLXCLtMJ3ynw
 8TnpS/6n1D5CqcI3U63hJFKAzDioZsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-QR5FM8g8PceFQn6F5F2nMQ-1; Fri, 13 Mar 2020 05:12:56 -0400
X-MC-Unique: QR5FM8g8PceFQn6F5F2nMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8572800D50;
 Fri, 13 Mar 2020 09:12:54 +0000 (UTC)
Received: from work-vm (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 533B765F40;
 Fri, 13 Mar 2020 09:12:51 +0000 (UTC)
Date: Fri, 13 Mar 2020 09:12:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH] configure: Fix configure error.
Message-ID: <20200313091248.GA3581@work-vm>
References: <20200313065525.31722-1-chen.zhang@intel.com>
 <e240baab-18b8-94b9-7ed5-e7ec9daed489@vivier.eu>
 <3fdff67c4e4047859c0e8aa183bd53d9@intel.com>
MIME-Version: 1.0
In-Reply-To: <3fdff67c4e4047859c0e8aa183bd53d9@intel.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Juan Quintela <quintela@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-dev <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhang, Chen (chen.zhang@intel.com) wrote:
>=20
>=20
> > -----Original Message-----
> > From: Laurent Vivier <laurent@vivier.eu>
> > Sent: Friday, March 13, 2020 4:18 PM
> > To: Zhang, Chen <chen.zhang@intel.com>; qemu-dev <qemu-
> > devel@nongnu.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>; Dr . David Alan Gilbert
> > <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>
> > Subject: Re: [PATCH] configure: Fix configure error.
> >=20
> > Le 13/03/2020 =E0 07:55, Zhang Chen a =E9crit=A0:
> > > From: Zhang Chen <chen.zhang@intel.com>
> > >
> > > When run the ./configure will always get this error:
> > > Unknown option --exist
> > >
> > > It caused by this patch:
> > > commit 3a67848134d0c07da49033f9ed08bf0ddeec0c6d
> > > Author: Juan Quintela <quintela@redhat.com>
> > > Date:   Tue Dec 17 21:15:24 2019 +0100
> > >
> > >     configure: Enable test and libs for zstd
> > >
> > >     Add it to several build systems to make testing good.
> > >
> > > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > > ---
> > >  configure | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/configure b/configure
> > > index 3c7470096f..305591f7e0 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -2475,7 +2475,7 @@ fi
> > >  # zstd check
> > >
> > >  if test "$zstd" !=3D "no" ; then
> > > -    if $pkg_config --exist libzstd ; then
> > > +    if $pkg_config --exists libzstd ; then
> > >          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
> > >          zstd_libs=3D"$($pkg_config --libs libzstd)"
> > >          LIBS=3D"$zstd_libs $LIBS"
> > >
> >=20
> > Juan already sent a patch to fix that:
> >=20
> > [PATCH v2] configure: Improve zstd test
> > https://patchew.org/QEMU/20200310111431.173151-1-
> > quintela@redhat.com/
>=20
> OK, Looks haven't merged to upstream.

I've built a pull with it in, testing it now.

Dave

> Thanks
> Zhang Chen
>=20
> >=20
> > Thanks,
> > Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


