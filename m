Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D65424650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe/00OkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D65424650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtVq-0002Im-2g
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihtRT-0005C4-UN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihtRR-0004GL-09
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:54:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihtRQ-00046E-7J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576752839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X7JQHJqpSE94r/hcxYv/KAfSo3Nkw8dKpmnEAlhICqI=;
 b=Fe/00OkQyeYZvRa6tKBhTyDtfVE+ebErzlY48QqVD3FzUY9NoPmBf4EeOn94nKUjb4doWj
 DfiEkRLNrHz4pMOeb8GVHUqYikBevT9Qa97S6StN/gzwSnqcHViZHeRhH7XnpoqyPHwSTZ
 EsrJW/Bjqn2xghPmhHSsHtlY0lfI5p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-w3YvkL1oPHm8IoRmpDsb0Q-1; Thu, 19 Dec 2019 05:53:52 -0500
X-MC-Unique: w3YvkL1oPHm8IoRmpDsb0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B47C185432C;
 Thu, 19 Dec 2019 10:53:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CFD269401;
 Thu, 19 Dec 2019 10:53:50 +0000 (UTC)
Date: Thu, 19 Dec 2019 11:53:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: qcow2 api not secured by mutex lock
Message-ID: <20191219105347.GE5230@linux.fritz.box>
References: <1ea7f93d-8f48-d565-70e7-0d66f1b80c1e@virtuozzo.com>
 <20191219100230.GC5230@linux.fritz.box>
 <28355f81-2eb3-4883-f05d-03e4fde4f74b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <28355f81-2eb3-4883-f05d-03e4fde4f74b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.12.2019 um 11:35 hat Max Reitz geschrieben:
> On 19.12.19 11:02, Kevin Wolf wrote:
> > Am 18.12.2019 um 11:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
>=20
> [...]
>=20
> >> qcow2_write_snapshots actually called unlocked from
> >> qcow2_check_fix_snapshot_table.. It seems unsafe.
> >=20
> > This is curious, I'm not sure why you would drop the lock there. Max?
> >=20
> > bdrv_flush() calls would have to replaced with qcow2_write_caches() to
> > avoid a deadlock, but otherwise I don't see why we would want to drop
> > the lock.
> >=20
> > Of course, this should only be called from qemu-img check, so in
> > practice it's probably not a bug.
>=20
> Maybe I should have read all of this before replying...  Is
> qcow2_write_caches() all that we want?  I mean, bdrv_flush() also
> flushes the children (well, at least the file child right now).

You're probably right and we want to call qcow2_cache_flush() instead. I
forgot that we split these functions.

> OTOH qcow2_write_snapshots() probably does not need to take care of
> actually flushing @bs, does it?

I think it wants to get the right ordering to avoid corruption on
crashes, so we certainly do want to flush all the way down to the disk.

At least after qcow2_alloc_clusters(), it needs to flush bs itself; for
the second one, it could be enough to flush bs->file, but flushing bs
can't hurt.

Kevin

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd+1a7AAoJEH8JsnLIjy/WNasQAMnuH6ltCWo1rqB9dr63QjKt
W7DZhkTiCHOP1+3OUF6j9pI+fCsZrcQmcZNSRQdRcHxeOetdX9g3A7xJVzvzxIjP
KO7sSHXCblGpAtN0OzqU5HUFn+LdMUIGiWTpv1NcrBE0NTxTYQ7eibyzVTkUxJJE
fmQ/h7taDnKKvtbOu0Kgn99Mzyz4z2ZjBiQ3C4c8r/nK4PpXc+w4OCx6/BKGoB86
BX9oNPGQlzVqPCAet43YiE/e3PmpORgrPmqwd73mviIadl5upAClJ7NDwvNQpiLk
oia/LrboAfNclUFNAxAVzlRze2T29zQX6l2e5UtMDOfvUz/AtPrNWQ3nGwRCUPpk
0ihSHguYz7O3sMA6mvIJmkRHI1YdVzvK49FY1q/ICjUULc8hnLkAqJVA0fdwgcOQ
/fpgSETuCy/uKKXW2QBSXa2d9v/Qui9M4Z1rX0rNz8fA/3dcdsxxHWS4ycMk2Zm5
fsfdxpbXWLURueulNA6qGLHquOPAb6paw40Ofa2ECPuVGjg8sazyNyYjKFJXSZPx
kbW1LKtrZcdUNBJh6H/kiPYQhoh9riXKEepHjoTBKBwaRCPitLD7kKFLrGD5Ybrv
4Cl3Mkr854q5P+0jeKc7QT9hiC6iOEPREvw1lIIzmlJUzSPYM3HpjFtRSVpoASbv
vgcC9n30W54D3P/1VlDs
=c29w
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


