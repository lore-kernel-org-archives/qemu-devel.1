Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72FC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422CB208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoEdJCAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422CB208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjW8-0001ww-FC
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjVI-0001Sk-45
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjVG-0002Zq-BS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:59:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTjVF-0002ZM-Np
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588154379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jYOq4Gb+OkYpVamoTbaBqMjn4E1fE8/sdbhLXcJUPY=;
 b=GoEdJCAocUbisWES2VWaBEDPc1nI+rayO2qQYuH/k3drBfIsWJPqykmCcvqy08IYs+E4Xt
 5OD0+d4PZCsKdIVaP7iumwe1kgTIUgGA3rUc5gsDvBrOJXB5ysbGeI+UP+H1P3LRl5MKW8
 1Zdmy7YEJZlJDzlMd4TfJhoKxzYSChY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-mzUDz_ofPTucDPfcUQlXhA-1; Wed, 29 Apr 2020 05:59:38 -0400
X-MC-Unique: mzUDz_ofPTucDPfcUQlXhA-1
Received: by mail-wm1-f72.google.com with SMTP id t62so1000267wma.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JYxdyAlutb9zDaOY9t3Vu3+pNQAF3vOgY2lUUuKWw+M=;
 b=qVAoiLxezlDMJoSapPYupSDirlmRAtmbywggjuZzk97pCtTHlId7i775YxKgyFLrZt
 9PE4PIZ9an6vFDJKI4ccye6kvXm1WcP3h1iHLxFB5VM9U8y/gp1Jb0bdiS2kgYHX1cNn
 FydclmT5uMtxfW8/H6mCOKU1L3JDA+tDr3OoWZh7s0HT5W+n2JJ7vhePEcZz8tmSlr6D
 15Nt693M1rR8nWl77DLAUeyaV8tnl3GFqC37rQ5OVQe8FSLjKBIaNoHm7il9BKnu8HOi
 /q2XbAk9rYGWTp1zgbT4vdX0ehUR1gIo4m7jbD/4ZnuPSGcUlrxdCJr86jI98bwOVqg+
 e0OA==
X-Gm-Message-State: AGi0PuYxTd7Muz/qugk9+ptJdMd9ZxM3nhjjNXh3DsfmPfLQEjV5ydWm
 pALFTYtpVP2+YOeUqN0/EUihXp/V/3EEDRsdR2W6tWXsMmSeJM9RwGONDkyl1296tTLm0L6pax0
 9B2XHmPJvJUHia+Q=
X-Received: by 2002:a05:600c:c8:: with SMTP id
 u8mr2451637wmm.142.1588154377005; 
 Wed, 29 Apr 2020 02:59:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypK/7CegLYWmlY3x0cK612JYNPQcPXZkkFHuAc/jVZiBak5TvPqkLToP/Ypa0vKcGBgldmemUg==
X-Received: by 2002:a05:600c:c8:: with SMTP id
 u8mr2451602wmm.142.1588154376821; 
 Wed, 29 Apr 2020 02:59:36 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w6sm30327391wrm.86.2020.04.29.02.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 02:59:36 -0700 (PDT)
Date: Wed, 29 Apr 2020 05:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200429055243-mutt-send-email-mst@kernel.org>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200428172920.GA111124@stefanha-x1.localdomain>
 <20200428134350-mutt-send-email-mst@kernel.org>
 <20200429093030.GD122432@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200429093030.GD122432@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 10:30:30AM +0100, Stefan Hajnoczi wrote:
> > > I suggest dropping the remote device program from this patch series (=
and
> > > maybe never bringing it back).  Instead, use the softmmu target for t=
he
> > > remote device.

...

> >=20
> > Building QEMU twices just to get the remote is however not very
> > attractive. So how about making remote a special target?
> > Either remote-softmmu/ or if impossible x86_64-remote-softmmu/
>=20
> Yes, that's a good idea.  It needs to be the full x86_64-remote-softmmu
> because hw/ code depends on the QEMU target :(.

BTW using QEMU as backend source also gives us goodies such as
cross-version compatibility for free.

--=20
MST


