Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092332076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaWuKRvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092332076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5KA-0002MW-7P
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1jH5JX-0001xF-BY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1jH5JT-0002iS-Ai
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:39:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1jH5JT-0002ht-7H
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585139954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NG4Cv/1VYv1QAw9lbe0ambjT6yy1Phk0TZejG4L3HvY=;
 b=MaWuKRvl7+JYkV96Yo7Vpz7F90EASWIK4cWo0uwuNo9jirYm3/6g043mtr2MjLmwS8lEPY
 gPe0Y7t59rnvQbheJzobLVvTWRaZ5EyVYX1t/0d9JD2wm+nxB7GP11cZ0ClZEgpkqL06n1
 /VNk3nsbUVs+bLdvnYB0p6i51eXo3CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-4vmmWSOaM0y5ebn6xpVPWQ-1; Wed, 25 Mar 2020 08:39:12 -0400
X-MC-Unique: 4vmmWSOaM0y5ebn6xpVPWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FE8D801E74;
 Wed, 25 Mar 2020 12:39:11 +0000 (UTC)
Received: from localhost (unknown [10.33.36.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59EE85C8A6;
 Wed, 25 Mar 2020 12:39:06 +0000 (UTC)
Date: Wed, 25 Mar 2020 13:39:05 +0100
From: Sergio Lopez <slp@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: backup transaction with io-thread core dumps
Message-ID: <20200325123905.4mygg2ljie7prtbc@dritchie>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
 <20200325081312.7wtz6crlgotsw5ul@dritchie>
 <20200325114639.rxwhs7h4bkxhkgsu@dritchie>
 <523142611.32.1585139388758@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <523142611.32.1585139388758@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bwe3uj6plqcscj46"
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
Cc: kwolf@redhat.com, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bwe3uj6plqcscj46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2020 at 01:29:48PM +0100, Dietmar Maurer wrote:
> > As expected, if both BDS are running on the same IOThread (and thus,
> > the same AioContext), the problem is not reproducible.
> >
> > In a general sense, we could say that completion modes other than
> > "individual" are not supported for a transaction that may access
> > different AioContexts. I don't see a safe an easy way to fix this. We
> > could opt for simply detect and forbid such completion modes when the
> > BDS's are assigned to different AioContexts. Perhaps Kevin (in CC) has
> > a better idea.
>
> So the solution is to disable backups when using io-threads?
>

I meant forbidding transactions with completion-mode == grouped. It
would be still possible running transactions (and thus, backups) with
completion-mode == individual, which is the default.

Sergio.

--bwe3uj6plqcscj46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl57UOgACgkQ9GknjS8M
AjVYow/+M33QJDJzYxomikauSPVpb9zumL3pvlzi5+hnn6mTAYHRkLkCOjEdD2w6
Ar2cm+JzIYnTPytq/bGTHbU7lqAgO9HdAVJ3D3F2TJKiNbLsGHCOskXiLMnsjwpl
GKwGHcCf6CqLmqBZih3DcYQjyjQ9sUAUxrpXGIIjZOiPHs2e2Iw0MODucRaRXnSX
hNiK4JQtgooQvMEGisCTq64JjrnmxySX1nJl4qMSM+n/16mhJi2tgYaYFIQyDwSN
Mxqh9Bh+iKcR0VZkiGURV1BQaPBZcByr1d5T5lUhpi5eiqsQb4gf1rXZBwMhsLSg
30197M37qqb1gZBsI1JV6/TdFYNLhgl24CFaq7mDULcez+8WGM9g82LkGAPkFDOz
LPdJZzYPbv9q/hh1XdHLu9hmz7AlSQcPSEc/0VqPKpY3BygivnXfk/pfTI54UMk0
dnHGmiF6TC3T0DqEOahSPklNflupT/NOyL7YLLpeNW4gtesRfTDfkv4tB7iC2xeR
LFaWs2Iv1VjvL8o4cqEHKlUSJsOmb+7iMdyw/+KLkQyxkRJhazwoDqgG/T5FwD4o
GJ7yoBuwMXBztS7z1pkswdFAqEduKLZ05eFhFJkBPv65nrGR4kGykbvqZfoVFx14
AoOYh3KkHGqDxtsLW30jtD3lFHVkSsJFRJgW0jGciUFXbYOorHg=
=IqLz
-----END PGP SIGNATURE-----

--bwe3uj6plqcscj46--


