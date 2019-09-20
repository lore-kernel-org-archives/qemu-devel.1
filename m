Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3385C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD062070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpA583s+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD062070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBF9z-0007Rn-Da
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBF8C-0005j1-Tz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBF7V-0004no-Hv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:22:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBF7V-0004mH-C6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:22:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id b9so6031201wrs.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uY+XY95t7uvNSQINcea61sKZRvXuKMDMs4G/Vpb11Sg=;
 b=mpA583s+LX7KmE78WCNl76g3AfsuYRMElXojSYKCBorg8o4bOfBi2bR3Z+q2HdJ0R2
 nLGczG2jL+STVw1OFgu42CoTSWamNaFYPQjLeMWCP7XjGXcaq7mCJagfhpsejv824iPR
 +E/1J8K5XSgxuw/MTts2gY8Qhzb1ngjBxiEeGIHdlupn0NWUCnROsvdEEUjR2XbisUES
 5pvlJKekU0sDHI1u6Ba6A4gZ43d2c619123L5kbaPmgpCJuwHkT1840Qu+qoeulHKBne
 rndjeh3XvD4EMQAblHbxA+Gq9m5xvDcd8ax5LrDkzQJo3/EETmd6X83eC/AAKyMVURbu
 ZFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uY+XY95t7uvNSQINcea61sKZRvXuKMDMs4G/Vpb11Sg=;
 b=I38cZEhq6HQSi5dX0BNpMjQNiNDAbSGPL73d9S8vyeWHPlC+HXUVdFHhi/piEhf8s0
 4OEvZQgsph+bOaaVsIOfPFgamYYLNEGsh+myOxdQkngmQmQtmlJhb0st8cw0QJy3HlEc
 byNY5YPPUlSaLqOlq+JkbMDxhZ9Dyk0724EXmPORGENwJSecJ92mphg32+RImnvS5Imj
 DSrRnGkI0fCbqkpVzDS0wPoLGc6izFrz3QO7Hll6rsgqlaybCEpYKJ1HQx1SSo/EKVMk
 h5KkkX2loQ65BSn5mrqf2QXbRY6S54wLoBbJUIMxfA75NETBCnNn6lyt8WUtyTXEEVGh
 0/wA==
X-Gm-Message-State: APjAAAXk/s2ZJUz4GVImoxEgkOSMuiTq5UNxZEXyMzjIK3yzu3c4i5q5
 IMjrnxmte6TnbsORXsckUD4=
X-Google-Smtp-Source: APXvYqwt4kSn/9rIgR35o6ZeVm3f+UPQYQeVOgWj2I6Cf+UZb/DyYONI26ED6EtDf1E6ZYJUQtG67w==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr239579wrb.233.1568971348364; 
 Fri, 20 Sep 2019 02:22:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o9sm2252703wrh.46.2019.09.20.02.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:22:27 -0700 (PDT)
Date: Fri, 20 Sep 2019 10:22:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20190920092226.GH14365@stefanha-x1.localdomain>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 02:48:43PM -0500, Tony Asleson wrote:
> For a long time I thought that VMs could be a great way to improve OS
> code quality by modifying the simulated hardware to return errors to
> exercise error paths in the OSs, specifically in block devices for right =
now.
> A number of different approaches are available within the Linux kernel, e=
g.
> scsi-debug, dm-flakey, and others.  However, I always though it would be =
best to
> simulate it from the hardware.  To fully exercise the entire stack.  As a
> bonus it's OS agnostic for those projects that cross OSs and it's availab=
le
> before the OS even boots.
>=20
> This POC needs a lot more work, but it's what I have so far.  Learning QE=
MU
> internals, plus some of the different bus types has been interesting to s=
ay
> the least.  I'm most familiar with SCSI, but the others are foreign to me.
> AHCI/SATA/ATA is very interesting with it's history and the associated co=
de to
> handle it's evolution.
>=20
> Eventually I think it would be useful to add functionality for errors on
> write paths, timeouts, and different error behaviors.  Like media error(s=
) that
> are corrected by a re-write (simulate failed write on power loss), bit rot
> injection etc.  I know a number of these can be solved different ways,
> but embracing them from the VM environment seems ideal to me.  Expanding
> to gather statistics on IO patterns, histograms etc. could be very
> useful too.  Having the ability to start/stop information collection and
> then have access to what happened and in what order could allow for
> better error injection of key FS structures and software RAID solutions t=
oo.
>=20
> I've recently been informed that blkdebug exists.  From a cursory investi=
gation
> it does appear have overlap, but I haven't given it a try yet.  From look=
ing
> at the code to insert my changes it appears that some of the errors I'm
> generating are different than what for example an EIO on a read_aio does,=
 but
> I'm not sure.  Perhaps some of the other features that I've outlined above
> already exist too in some other capacity of QEMU?

blkdebug is purely at the QEMU block layer level.  It is not aware of
storage controller-specific error information or features.  If you want
to inject NVMe- or SCSI-specific errors that make no sense in QEMU's
block layer, then trying to do it in blkdebug becomes a layering
violation.  This justifies adding a new error injection feature directly
into AHCI, virtio-scsi, NVMe, etc devices.

What I like about blkdebug is the state machine and relatively powerful
tests that this enables.  It makes sense to reuse those for storage
controller-specific error injection too.  In the future we may wish to
reuse it for network cards and other emulated devices too!

Perhaps the error injection "engine" (the core blkdebug code) can be
extracted and reused?

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EmlIACgkQnKSrs4Gr
c8hnAgf/RT2GTcwF1OaAX0BWkn9Zk+4lGVSTtT8laRScFbQZrm5ZNaNZMYbYscDg
65ZnaVhGWLNovWXTijv88Eve6nJa9LL818G3zUzVTwcwdRaIZigU1SfXYCYRsBPb
1ZuUaLE6Qx/xqn8QCbPolV46VXgtlMtAt/GGsY4niYlIR4T5+a/bAubbC5XO4egJ
3xZ3QH/ikvjAu8+X/Pxo8HKgwfYRd9U4Z0+qqCAGYCLSd2TLsCZjO8A7Lkqkg0vF
3CMuTb7oLQ4htdAhD0WPOXTOnG3LRp3XdKyJbahGjXeDCU2MYYS3rSOQuMZSXC0h
4TxtkJby0ofHG2kLvp/H2HoIcKvPQQ==
=yRfL
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--

