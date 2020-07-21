Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F6C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA5220702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J74nKDvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA5220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxt9W-0002fj-Hz
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxt8u-0002BF-5K
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:21:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxt8s-0003NM-DP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595341273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7XC9aUdBRzr20xGKM7Y3cmuiOCTZ7sP7xKrNSwkGco=;
 b=J74nKDvYLqH1VfzgKoq3z5ayQsC+7ZYThNhgtjtVvKrBJCIFzW2hORcImSbG0xBwNWYL/4
 zdc3nSZC6kZDf5LSJ0iizJOXbZypa7G5H71H/4JWd45Eg5hQOsVUIJ3bU5gnaIxeab04Ez
 AZaVFEHkmByn96skhpY8g+3mwRwhppU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-6KrVvjN0NTORm3_KMgygoQ-1; Tue, 21 Jul 2020 10:21:10 -0400
X-MC-Unique: 6KrVvjN0NTORm3_KMgygoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A241015DA8;
 Tue, 21 Jul 2020 14:21:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0D742DE89;
 Tue, 21 Jul 2020 14:21:08 +0000 (UTC)
Date: Tue, 21 Jul 2020 16:21:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Antoine Damhet <antoine.damhet@blade-group.com>
Subject: Re: [PATCH RESEND] file-posix: Handle `EINVAL` fallocate return value
Message-ID: <20200721142107.GC18481@linux.fritz.box>
References: <20200717135603.51180-1-antoine.damhet@blade-group.com>
 <20200720140726.GD5541@linux.fritz.box>
 <20200720153722.2zv2vhzficgg73lo@tartarus>
MIME-Version: 1.0
In-Reply-To: <20200720153722.2zv2vhzficgg73lo@tartarus>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:20:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, "open list:raw" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.07.2020 um 17:37 hat Antoine Damhet geschrieben:
> On Mon, Jul 20, 2020 at 04:07:26PM +0200, Kevin Wolf wrote:
> > Am 17.07.2020 um 15:56 hat antoine.damhet@blade-group.com geschrieben:
> > > From: Antoine Damhet <antoine.damhet@blade-group.com>
> > >=20
> > > The `detect-zeroes=3Dunmap` option may issue unaligned
> > > `FALLOC_FL_PUNCH_HOLE` requests, raw block devices can (and will) ret=
urn
> > > `EINVAL`, qemu should then write the zeroes to the blockdev instead o=
f
> > > issuing an `IO_ERROR`.
> > >=20
> > > Signed-off-by: Antoine Damhet <antoine.damhet@blade-group.com>
> >=20
> > Do you have a simple reproducer for this? I tried it with something lik=
e
> > this (also with a LV instead of loop, but it didn't really make a
> > difference):
> >=20
> > $ ./qemu-io -c 'write -P 0 42 1234' --image-opts driver=3Dhost_device,f=
ilename=3D/dev/loop0,cache.direct=3Don,detect-zeroes=3Don
> > wrote 1234/1234 bytes at offset 42
> > 1.205 KiB, 1 ops; 00.00 sec (2.021 MiB/sec and 1717.5697 ops/sec)
> >=20
> > So I don't seem to run into an error.
>=20
> ```
> $ qemu-io -c 'write -P 0 42 1234' --image-opts driver=3Dhost_device,filen=
ame=3D/dev/loop0,detect-zeroes=3Dunmap
> write failed: Invalid argument
> ```
>=20
> This seems do do the trick :) (We triggered the bug with Windows 10
> guests and with an iSCSI drive so it was hardly a simple reproducer).

Oops, I made a stupid mistake with the detect-zeroes syntax there. :-)

So you actually need non-O_DIRECT. Okay, I can reproduce with your line.

> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 8067e238cb..b2fabcc1b8 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -1620,7 +1620,11 @@ static int handle_aiocb_write_zeroes_unmap(voi=
d *opaque)
> > >  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > >      int ret =3D do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL=
_KEEP_SIZE,
> > >                             aiocb->aio_offset, aiocb->aio_nbytes);
> > > -    if (ret !=3D -ENOTSUP) {
> > > +    switch (ret) {
> > > +    case -ENOTSUP:
> > > +    case -EINVAL:
> > > +        break;
> > > +    default:
> > >          return ret;
> > >      }
> > >  #endif
> >=20
> > This means that we fall back to BLKZEROOUT in case of -EINVAL. Does thi=
s
> > return a better error code in the relevant cases, or did you just happe=
n
> > to test a case where it was skipped or returned -ENOTSUP?
>=20
> I guess I misinterpreted the comment before calling
> `handle_aiocb_write_zeroes`.
>=20
> The codepath is:
> * handle_aiocb_write_zeroes_unmap -> handle_aiocb_write_zeroes -> handle_=
aiocb_write_zeroes_block
>=20
> In witch the code will return `-ENOSTUP` (`!s->has_write_zeroes`) and
> never fall back to `BLKZEROOUT`.
>=20
> So it's working as I expected but now I am unsure that my fix is the
> right thing to do, what do you think ?

It's obviously fixing something for you, though it might not be as
complete as we'd like. Maybe we would just need to do the same thing in
more places, though ideally we would need reproducers for each of them.

I just noticed that handle_aiocb_write_zeroes() already turns EINVAL
into ENOTSUP, so your change is not unprecedented.

I'll just apply your patch for now, and we can always fix more cases on
top of it.

Kevin

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8W+dMACgkQfwmycsiP
L9YhjA//T67JoGIkqB62ZgRveOVAmphJbJlEgurNPZOgmFv0QQleRTynsTxGqtT8
JPuqVzkdO7Gf3B0g61sQ17OMZvIiRvTxSpK4S0XJOJMgMuf75/I5/PJPau6DQcbI
5xA7nUsxesQYWV5nmJZ+KWVWJHjvqY1jEOAobb6XjfPg1iVk/H+k3I4buGxhbFG+
RM00TOycqG73MCcdu4XQbDIVhp4b8jq4hJw3gd7D113B7fJCejINMrttP5oy29o1
qAwMPKHYuSwIzQ7tWBFpXiiJ2ogZglpKKWstuup7gFleh0lSrZm79/iF7KpEGj4k
lP9EzlJjJbuEKDBdVO8mTkCxLbQckJ7uHKUIUOV4cU/3BwMGrsvhxBz3G9iajl87
r5og82rSdAIEx82Z4IFvH86c6Sc09WIRv5wYSrIh3dM3LUacJ0dD0cMStpfze3kB
zFicGPCB4NvZUFP5sbwr2GPoLlhXU8PlZBfoAXtW/+w6cgtr3s2BTexAQAsMJ0dw
b8Kf3uK4YuCsyRUjZuhwOlcEc2RyreNKUsVbJwHuzy/4oyB3PM6aJdNhoiFxQP5/
kK3Xxg2YYsVZN5zGaaV2pyrcb4nCPjvda73tWDITTpf+MPCI4lw+CTNi2XVZx508
Knbs0H0WGq+gG5M26Kyv58hgjyPgkdR76DzETip3kpr8cHC6Pbo=
=o/fx
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--


