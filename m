Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB91DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5D622247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1lOjvUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D622247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtpJ-0005D7-8l
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUtkF-0007f5-HZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUtkD-0001a0-Lm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603208412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VARkBn82hSX0plF3A+pV2d6fXSAAPb/MX/ilbfJcNA0=;
 b=W1lOjvUONuczLxvfMUddSn2j77idX3QVOLY5HQlmv0bR9R3i7YqyDlhRLdgoNAri+d7wiR
 GQcZ5EkPxcRRMupT2NHl94cKSluVSPMWZLEtqL3Su/2ymexOvPaJA+BDYpydSrxgNxLRdo
 igHvaIgebS6T2msThpZOLKW8+Ulr1k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-8NBWoz0qNsCT2sC8bPS4ww-1; Tue, 20 Oct 2020 11:40:08 -0400
X-MC-Unique: 8NBWoz0qNsCT2sC8bPS4ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D01680BCA3;
 Tue, 20 Oct 2020 15:40:06 +0000 (UTC)
Received: from localhost (ovpn-115-118.ams2.redhat.com [10.36.115.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD877389;
 Tue, 20 Oct 2020 15:40:05 +0000 (UTC)
Date: Tue, 20 Oct 2020 16:40:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] accel/kvm: add PIO ioeventfds only in case
 kvm_eventfds_allowed is true
Message-ID: <20201020154004.GC279266@stefanha-x1.localdomain>
References: <20201017210102.26036-1-eafanasova@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201017210102.26036-1-eafanasova@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 17, 2020 at 02:01:01PM -0700, Elena Afanasova wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  accel/kvm/kvm-all.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks, applied just this patch to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+PBNQACgkQnKSrs4Gr
c8hfLwf+MZghYDQW9AUuzDtEBKncXLYkNwG3Pfgg6qOs8d1bdH5reHEO7tw+2zV2
vRoB+D4PG5zGFIgmtqEH4SdKRpzNhKKo2OGMhwVo60+f7FioN1yPI0aNfTjjzJRn
sBMpXoBHUJMYBwH7b4J2/LJIyKvDoOGNQa8PKkMQlYHv9r/b9CKBlpBA6Bqf/tph
1nmPh0Wg6Qs5j/RlnQ4HFL26nG+toF7+C7u8DwaDhW+sYy9KpQznQJLf8AJLJJp7
mBfgIyVbY7KvnR8a4+qwZoIrHhUMOI7ahSkYq+eV/NFic/f49oA0WIrtZWNV6sFC
Mcfg8FhFpHhu6zuU+knnm2G8SRw1IQ==
=zEJ6
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--


