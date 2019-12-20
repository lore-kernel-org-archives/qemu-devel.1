Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A9FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602982072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czoNfX2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602982072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJyb-0001ZI-Ij
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iiJuN-00042a-Oc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iiJuM-0004CP-LX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:09:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iiJuM-0004Bk-Gd
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576854578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdnXmdNDgkw+WhqkUwonjZgeZY3MdsFbxNe6Gdz1TUc=;
 b=czoNfX2ZDQ4GLzxCXohivEP8JD3+7p8DiSWLP+c/BfPn+RZS3CRQRwouKjbrFl/VxUSzTU
 AU++MD0YZCKAyNfF48WCFS4Ogzimche7EubXCrZ6XgJ6KqKAVPPKQD5qoOi3pVIp9IPxnz
 LZ5bjoKkNAK7EXD7hWv7GsML0w1oac4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Tta8HcvoPr-dmFBxdrjlPw-1; Fri, 20 Dec 2019 10:09:36 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so3181180wrm.23
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 07:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tKBsLtGhO6JFcJuJYey6uXwanmMO3IwP55PfE7j3f84=;
 b=svOOpolD+jDTmFvqqrjUhEXpEMtES3N7TFUDScXC/k9QWqA/dfgKO00xtgLK92kZ8t
 /qbNpByZnj9OvX6kpfEO3OUw7HS1rh61+vJ+NHoN/hWcAb81QpP/F8ObgBT4f7NWXn+n
 fe4zAirqAXGeZCGcWnlxcgVDt28OMa4WA3SeRbovrS2me1IhK6MTb2mtE+Aa9q8GjZEl
 YOFf5wA6AR1NDLFttFcCeUt3yM4TlUfBlZ2ix7fJXIC8MXvwI9y4FcYO/qB0Iq7414ve
 xbzndGzYLzRSeP5TE8hLO42vtWGddroSIGUncVLlGk3RIYFbSxRpQEAy0wuKajLII3o6
 wcPw==
X-Gm-Message-State: APjAAAUzMbqQwqgOjP+yES8rXhvabdjEz+FWJekCCRnSFalmPWStuvhY
 4tAvFV3GWRmJbqOdoGJD469Ec+hArFhzZVZnLY4boZNTaXPxHtzOTB2sVK++Xb597ee7Bhf/vrJ
 H4Onfkl1sII7Zmoo=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr16483309wrp.2.1576854575476; 
 Fri, 20 Dec 2019 07:09:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzOHiXyIqzN3N2Omo4XXhxlqGZhh8Ie8RJqGX1TzJud/Y5S5lgk9DEOWcWjS7nduJljVJJ1g==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr16483278wrp.2.1576854575212; 
 Fri, 20 Dec 2019 07:09:35 -0800 (PST)
Received: from steredhat (host219-64-dynamic.11-87-r.retail.telecomitalia.it.
 [87.11.64.219])
 by smtp.gmail.com with ESMTPSA id o15sm10361136wra.83.2019.12.20.07.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 07:09:34 -0800 (PST)
Date: Fri, 20 Dec 2019 16:09:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Florian Florensa <fflorensa@online.net>
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
Message-ID: <20191220150931.hiaopmv72xax3ek5@steredhat>
References: <20191219133416.671431-1-fflorensa@online.net>
 <20191219145125.iwhxhzmt5mow5pea@steredhat>
 <20191220141125.wxlm4eizbwie6522@flash.localdomain>
 <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
X-MC-Unique: Tta8HcvoPr-dmFBxdrjlPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dillaman@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 09:56:51AM -0500, Jason Dillaman wrote:
> On Fri, Dec 20, 2019 at 9:11 AM Florian Florensa <fflorensa@online.net> w=
rote:
> >
> > Hello Stefano and Jason,
> >
> > First of all thanks for the quick reply,
> > Response inline belowe
> > > Hi Florian,
> > >
> > > I think we need to add (Since: 5.0).
> >
> > Are you implying by that (Since: 5.0) that we need to specify its
> > availability target is qemu 5.0 ?

Exactly, as Jason suggested is part of documentation,

Following the file, I mean something like that:

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0cf68fea14..9ebc020e93 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3657,6 +3657,8 @@
 #
 # @pool:               Ceph pool name.
 #
+# @namespace:          Rados namespace name in the Ceph pool. (Since: 5.0)
+#
 # @image:              Image name in the Ceph pool.
 #
 # @conf:               path to Ceph configuration file.  Values


>=20
> FWIW, I took this as just a comment to add some documentation that the
> field is only valid starting w/ qemu v5.
>=20
> > I guess that maybe a version check would be better ? Like try to do
> > namespaces stuff only if we have a recent enough librbd in the system ?
> > Using something like :
> >
> > int rbd_major;
> >
> > rbd_version(&rbd_major, NULL, NULL);
> > /*
> >  * Target only nautilus+ librbd for namespace support
> > */
> > if (rbd_major >=3D 14) // tar
> >  <process namespace>
>=20
> Unfortunately, those versions weren't updated in the Mimic nor
> Nautilus release so it would still return 1/12 (whoops). I think that
> means you would need to add a probe in "configure" to test for librbd
> namespace support (e.g. test for the existence of the `rbd_list2`
> function or the `rbd_linked_image_spec_t` structure). I'll fix this
> before the forthcoming Octopus release.
>=20
> > > The patch LGTM, but I'd like to use 'namespace' instead of cryptic
> > > 'nspace'. (as BlockdevOptionsNVMe did)
> > > What do you think?
> > >
> > Yes no worries, I can rename it to 'rbd_namespace' to avoid any possibl=
e
> > confusion, is this Ok for you ?
>=20
> We use "pool_namespace" in the rbd CLI if you are trying to avoid the
> word "namespace".
>=20

Agree, I'd avoid the 'rbd_' prefix.

Thanks,
Stefano


