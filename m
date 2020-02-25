Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C8C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7181820CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KllIaFlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7181820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yhe-0006Qi-IN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6YgR-0005Q8-5J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6YgO-0000Vi-CV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:47:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28170
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6YgN-0000Gj-Qt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582631242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z72NBR48CZHD8tfcL/I1+UmGq0D1W63ZEXBmd+dPpE8=;
 b=KllIaFlk7s2YFKR5b+Bc4Q3EQw3+8sQKGjIOiXS5C7ySvgfwAySNa71sTZibFOk85XZ/Sv
 9+xKwSKNi642VWxuHqNSyZ4JSnnfOXEqFzqqipzp4ne5x2kmj7duX9RBWZGbKnI+NFYVpV
 rorFX5H6R9MDVzlpuyn7HSKtzYE3hAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-GlKo3mkTMLONPI_MZBvM9A-1; Tue, 25 Feb 2020 06:47:17 -0500
X-MC-Unique: GlKo3mkTMLONPI_MZBvM9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47AEADB22;
 Tue, 25 Feb 2020 11:47:16 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AA4127185;
 Tue, 25 Feb 2020 11:47:12 +0000 (UTC)
Date: Tue, 25 Feb 2020 12:47:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: Race condition in overlayed qcow2?
Message-ID: <20200225114711.GA7632@linux.fritz.box>
References: <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
 <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
 <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
 <796f18ec7246b8d07ac5d6bb59dca71f@ispras.ru>
 <b408733f-a0d7-62ab-8862-8d70d7148e5f@virtuozzo.com>
 <ac41c395f09a4101b7403e4116beba6a@ispras.ru>
 <e11be78b-9461-6068-969a-2f242ef5ada0@virtuozzo.com>
 <004b01d5ebc3$626dc9d0$27495d70$@ru>
MIME-Version: 1.0
In-Reply-To: <004b01d5ebc3$626dc9d0$27495d70$@ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: 'Vladimir Sementsov-Ogievskiy' <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.02.2020 um 11:07 hat Pavel Dovgalyuk geschrieben:
> CC'ing Stefan due to the same question back in 2010:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
>=20
> I also encountered this with Windows guest.
> E.g., there were the requests like:
>=20
> Read 2000 bytes:
> addr=3DA, size=3D1000
> addr=3DA, size=3D1000
>=20
> I.e. reading 1000 bytes in real, but the purpose of such request is uncle=
ar.

I think the conclusion back then was that the result is undefined (i.e.
you can get any mix between both parts). I'm not sure if we ever found
out why Windows is even issuing such requests. Maybe Stefan knows.

Kevin

> > -----Original Message-----
> > From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> > Sent: Tuesday, February 25, 2020 12:27 PM
> > To: 'kwolf@redhat.com'
> > Cc: 'qemu-devel@nongnu.org'; 'mreitz@redhat.com'; 'Vladimir Sementsov-O=
gievskiy'
> > Subject: RE: Race condition in overlayed qcow2?
> >=20
> > Kevin, what do you think about it?
> >=20
> > What guest is intended to receive, when it requests multiple reads to t=
he same buffer in a
> > single DMA transaction?
> >=20
> > Should it be the first SG part? The last one?
> > Or just a random set of bytes? (Then why it is reading this data in tha=
t case?)
> >=20
> > Pavel Dovgalyuk
> >=20
> > > -----Original Message-----
> > > From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
> > > Sent: Tuesday, February 25, 2020 12:19 PM
> > > To: dovgaluk
> > > Cc: qemu-devel@nongnu.org; mreitz@redhat.com; kwolf@redhat.com
> > > Subject: Re: Race condition in overlayed qcow2?
> > >
> > > 25.02.2020 10:56, dovgaluk wrote:
> > > > Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02=
-25 10:27:
> > > >> 25.02.2020 8:58, dovgaluk wrote:
> > > >>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-=
02-21 16:23:
> > > >>>> 21.02.2020 15:35, dovgaluk wrote:
> > > >>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 202=
0-02-21 13:09:
> > > >>>>>> 21.02.2020 12:49, dovgaluk wrote:
> > > >>>>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2=
020-02-20 12:36:
> > > >>>>>>
> > > >>>>>> So, preadv in file-posix.c returns different results for the s=
ame
> > > >>>>>> offset, for file which is always opened in RO mode? Sounds imp=
ossible
> > > >>>>>> :)
> > > >>>>>
> > > >>>>> True.
> > > >>>>> Maybe my logging is wrong?
> > > >>>>>
> > > >>>>> static ssize_t
> > > >>>>> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t =
offset)
> > > >>>>> {
> > > >>>>>      ssize_t res =3D preadv(fd, iov, nr_iov, offset);
> > > >>>>>      qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_t)offset);
> > > >>>>>      int i;
> > > >>>>>      uint32_t sum =3D 0;
> > > >>>>>      int cnt =3D 0;
> > > >>>>>      for (i =3D 0 ; i < nr_iov ; ++i) {
> > > >>>>>          int j;
> > > >>>>>          for (j =3D 0 ; j < (int)iov[i].iov_len ; ++j)
> > > >>>>>          {
> > > >>>>>              sum +=3D ((uint8_t*)iov[i].iov_base)[j];
> > > >>>>>              ++cnt;
> > > >>>>>          }
> > > >>>>>      }
> > > >>>>>      qemu_log("size: %x sum: %x\n", cnt, sum);
> > > >>>>>      assert(cnt =3D=3D res);
> > > >>>>>      return res;
> > > >>>>> }
> > > >>>>>
> > > >>>>
> > > >>>> Hmm, I don't see any issues here..
> > > >>>>
> > > >>>> Are you absolutely sure, that all these reads are from backing f=
ile,
> > > >>>> which is read-only and never changed (may be by other processes)=
?
> > > >>>
> > > >>> Yes, I made a copy and compared the files with binwalk.
> > > >>>
> > > >>>> 2. guest modifies buffers during operation (you can catch it if
> > > >>>> allocate personal buffer for preadv, than calculate checksum, th=
en
> > > >>>> memcpy to guest buffer)
> > > >>>
> > > >>> I added the following to the qemu_preadv:
> > > >>>
> > > >>>      // do it again
> > > >>>      unsigned char *buf =3D g_malloc(cnt);
> > > >>>      struct iovec v =3D {buf, cnt};
> > > >>>      res =3D preadv(fd, &v, 1, offset);
> > > >>>      assert(cnt =3D=3D res);
> > > >>>      uint32_t sum2 =3D 0;
> > > >>>      for (i =3D 0 ; i < cnt ; ++i)
> > > >>>          sum2 +=3D buf[i];
> > > >>>      g_free(buf);
> > > >>>      qemu_log("--- sum2 =3D %x\n", sum2);
> > > >>>      assert(sum2 =3D=3D sum);
> > > >>>
> > > >>> These two reads give different results.
> > > >>> But who can modify the buffer while qcow2 workers filling it with=
 data from the disk?
> > > >>>
> > > >>
> > > >> As far as I know, it's guest's buffer, and guest may modify it dur=
ing
> > > >> the operation. So, it may be winxp :)
> > > >
> > > > True, but normally the guest won't do it.
> > > >
> > > > But I noticed that DMA operation which causes the problems has the =
following set of the
> > > buffers:
> > > > dma read sg size 20000 offset: c000fe00
> > > > --- sg: base: 2eb1000 len: 1000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 2eb2000 len: 3000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 2eb5000 len: b000
> > > > --- sg: base: 3040000 len: 1000
> > > > --- sg: base: 2f41000 len: 3000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 2f44000 len: 4000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 2f48000 len: 2000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 3000000 len: 1000
> > > > --- sg: base: 3000000 len: 1000
> > > >
> > > >
> > > > It means that one DMA transaction performs multiple reads into the =
same address.
> > > > And no races is possible, when there is only one qcow2 worker.
> > > > When there are many of them - they can fill this buffer simultaneou=
sly.
> > > >
> > >
> > > Hmm, actually if guest start parallel reads into same buffer from dif=
ferent offsets, races
> > are
> > > possible anyway, as different requests run in parallel even with one =
worker, because
> > > MAX_WORKERS is per-request value, not total... But several workers ma=
y increase probability
> > of
> > > races or introduce new ones.
> > >
> > > So, actually, several workers of one request can write to the same bu=
ffer only if guest
> > > provides broken iovec, which references the same buffer several times=
 (if it is possible at
> > > all).
> > >
> > >
> > >
> > > --
> > > Best regards,
> > > Vladimir
>=20


