Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4E8C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892942072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/kB44Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892942072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPhq-00032l-Lz
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXPQW-0000OT-5x
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXPQS-0003om-3P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWb+CUgzzsvBw6LcuSTX8e5El7EwMe06N6sz+5CTYUw=;
 b=a/kB44Lxxg1EFhZmOqXlgZbil55BSY/pcA9jkPWmNbpKRayKWvK4fDGQVxEYcStMo0YssT
 TlvebGV2SIUCWxOD0cXcFMXsLV0I0/skf8nqdQ1o+KUAfER0YNzufX41Q8OMblMgcIQhKk
 XAX+RgwlzYROg6ar0V0oUhouP8gNgtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-0OKn7k-ZNAO7iFgqA3rMoA-1; Tue, 27 Oct 2020 09:54:06 -0400
X-MC-Unique: 0OKn7k-ZNAO7iFgqA3rMoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 792F31084D69;
 Tue, 27 Oct 2020 13:54:05 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2056C5578F;
 Tue, 27 Oct 2020 13:54:04 +0000 (UTC)
Date: Tue, 27 Oct 2020 13:54:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] block: End quiescent sections when a BDS is deleted
Message-ID: <20201027135404.GB102411@stefanha-x1.localdomain>
References: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2020 at 05:01:10PM +0200, Greg Kurz wrote:
> +/**
> + * End all quiescent sections started by bdrv_drain_all_begin(). This is
> + * only needed when deleting a BDS before bdrv_drain_all_end() is called.
> + */
> +void bdrv_drain_all_end_quiesce(BlockDriverState *bs);

This function is only called from block.c. Can it be moved to the
private block_int.h header?

The code is not clear on whether bdrv_drain_all_end_quiesce() is an API
that others can use or an internal helper function that must only be
called by bdrv_close(). I came to the conclusion that the latter is true
after reviewing the patch.

Please update the bdrv_drain_all_end_quiesce() doc comment to clarify
that this function is an internal helper for bdrv_close() - no one else
needs to worry about it.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+YJnsACgkQnKSrs4Gr
c8iNwgf/bk/cepsytuxJgvLNXgwrKQ6cbFkeAvHqtcekMZzMcIQE1+GLgFZEL3jh
fd7SmqLh/ZAuLrafKpM/7FqPXWBRFpgXI/rqL0+F3IhLnTRFXkCzPPXVqIAu+b3m
4DRxQJtI2q9cBrFJUOyXQ+5SkUolUrha8re6Xa9QoQrMFMt4mWu85ZeCt+N8Fu7n
CS+QHVOTGmLozIPF7DhJMOXqMjoN9F8cBGStCZAftAAHVO4oHOYJTsCKnKeFwLhT
QVPpB3ABFiyWtxT5aIkaUO9CybWPYTzU8ORoKVYkm3TIp1Y91w/ZLwwMS4ofEaP0
4dG+hbW6CxDJLXrUAKZJiw1xh7E9xw==
=ucgQ
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--


