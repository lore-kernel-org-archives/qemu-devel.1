Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E58C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0108B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbkgqlH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0108B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5Bb-0001iW-5v
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1is5AZ-0000Mv-2d
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1is5AV-0004sG-HC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:26:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1is5AV-0004rv-DO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579181198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuIhmKM1YJi8AGwySDUC0RkuSJOHceqyjUi15Bxh3Fc=;
 b=CbkgqlH0spJOeyxLKQsmExc1RegLvQ7uOazt3ZxYXf3yTKO0Jpn2Hz0QAs1sYwr3kgJsEd
 r4LD7XZ6f6CtFtBzBwFXhu8H5I+GFqipI+PfJsYYTp2bHuEPBCefeGnEzvGJr/ZcaPXxaf
 Vmaj9M1UFEJaPDXZX2F1+ZCe2sovNzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Mm7Gfjk3M0qwR2UMKN5GmQ-1; Thu, 16 Jan 2020 08:26:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B1F477;
 Thu, 16 Jan 2020 13:26:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDD9C10016EB;
 Thu, 16 Jan 2020 13:26:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 73700220A24; Thu, 16 Jan 2020 08:26:31 -0500 (EST)
Date: Thu, 16 Jan 2020 08:26:31 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 085/104] virtiofsd: Support remote posix locks
Message-ID: <20200116132631.GA25291@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-86-dgilbert@redhat.com>
 <20200115233831.mw6sttmepespg4kk@gabell>
MIME-Version: 1.0
In-Reply-To: <20200115233831.mw6sttmepespg4kk@gabell>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Mm7Gfjk3M0qwR2UMKN5GmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 06:38:31PM -0500, Masayoshi Mizuma wrote:

[..]
> > +/* Should be called with inode->plock_mutex held */
> > +static struct lo_inode_plock *lookup_create_plock_ctx(struct lo_data *=
lo,
> > +                                                      struct lo_inode =
*inode,
> > +                                                      uint64_t lock_ow=
ner,
> > +                                                      pid_t pid, int *=
err)
> > +{
> > +    struct lo_inode_plock *plock;
> > +    char procname[64];
> > +    int fd;
> > +
> > +    plock =3D
> > +        g_hash_table_lookup(inode->posix_locks, GUINT_TO_POINTER(lock_=
owner));
> > +
> > +    if (plock) {
> > +        return plock;
> > +    }
> > +
> > +    plock =3D malloc(sizeof(struct lo_inode_plock));
> > +    if (!plock) {
> > +        *err =3D ENOMEM;
> > +        return NULL;
> > +    }
> > +
> > +    /* Open another instance of file which can be used for ofd locks. =
*/
> > +    sprintf(procname, "%i", inode->fd);
> > +
> > +    /* TODO: What if file is not writable? */
> > +    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
> > +    if (fd =3D=3D -1) {
>=20
> > +        *err =3D -errno;
>=20
> I think the errno is positive value, so the minus isn't needed?
>=20
>            *err =3D errno;

That's sounds right. Thanks.=20

David, will you be able to do this tweak in your tree or you want me to
send a separate fix patch.

Thanks
Vivek

>=20
> Otherwise looks good to me.
>=20
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> Thanks,
> Masa
>=20


