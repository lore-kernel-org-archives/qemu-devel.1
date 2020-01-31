Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2B3C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2730F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6foFGv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2730F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixRA9-0007qn-BX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 02:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ixR9X-0007P9-U3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ixR9W-0000tA-66
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:55:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ixR9W-0000pT-1K
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580457345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWB/MNoGGSq+xocCaE/kbZMuI/QBgjlndtSJU+9txqc=;
 b=A6foFGv+/FCZj6IWtb8B2FYhjbAW7txGrTPeb5pfhJ5aPKdbeqUXufVsHQb5QSBFhexLat
 9rxyT/f4K5sTsvD5bkNuhwKuE1e1Cf0FGUTSNpb3nQFzFfoTW2/+8E/H8ssFRSCOzTOH15
 n3TDUOZ9465rvcifqieKCu2b4TYJ+qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-LLjNYEMGOaK4NgvDTMkoXA-1; Fri, 31 Jan 2020 02:55:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CBD8017CC;
 Fri, 31 Jan 2020 07:55:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-135.ams2.redhat.com
 [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9813E83861;
 Fri, 31 Jan 2020 07:55:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BF1DA16E2D; Fri, 31 Jan 2020 08:55:36 +0100 (CET)
Date: Fri, 31 Jan 2020 08:55:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
Message-ID: <20200131075536.lcxdvrlwrrbjy6d6@sirius.home.kraxel.org>
References: <20200117182621.GB13724.ref@chuwi-lt0>
 <20200117182621.GB13724@chuwi-lt0>
 <29987343-f835-2280-4457-067d970c9c5e@redhat.com>
 <2b889c2c-04ac-c6ef-ae3e-2901492a2824@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2b889c2c-04ac-c6ef-ae3e-2901492a2824@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LLjNYEMGOaK4NgvDTMkoXA-1
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, KJ Liew <liewkj@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 02:46:58AM +0100, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2020-01-18 07:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/17/20 7:26 PM, KJ Liew wrote:
> > > QEMU Windows has broken dsound backend since the rewrite of audio API=
 in
> > > version 4.2.0. Both playback and capture buffers failed to lock with
> > > invalid parameters error.
> >=20
> > Fixes: 7fa9754ac88 (dsoundaudio: port to the new audio backend api)
>=20
> Hmm, I see the old code specified those parameters, but MSDN reads:
>=20
> If the application passes NULL for the ppvAudioPtr2 and pdwAudioBytes2
> parameters, the lock extends no further than the end of the buffer and do=
es
> not wrap.
>=20
> Looks like this means that if the lock doesn't fit in the buffer it fails
> instead of truncating it.  I'm sure I tested the code under wine, and
> probably in a win8.1 vm too, and it worked there, maybe it's dependent on
> the windows version or sound driver?

Ping.  Any news here?  I'm busy collecting all pending audio fixes for
the next pull request ...

>=20
> >=20
> > Cc'ing Zolt=C3=A1n who wrote 7fa9754ac88, and Gerd (the maintainer of t=
his
> > file):
> >=20
> >  =C2=A0 $ ./scripts/get_maintainer.pl -f audio/dsoundaudio.c
> >  =C2=A0 Gerd Hoffmann <kraxel@redhat.com> (maintainer:Audio)
> >=20
> > > --- ../orig/qemu-4.2.0/audio/dsoundaudio.c=C2=A0=C2=A0=C2=A0 2019-12-=
12
> > > 10:20:47.000000000 -0800
> > > +++ ../qemu-4.2.0/audio/dsoundaudio.c=C2=A0=C2=A0=C2=A0 2020-01-17
> > > 08:05:46.783966900 -0800
> > > @@ -53,6 +53,7 @@
> > > =C2=A0 typedef struct {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HWVoiceOut hw;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPDIRECTSOUNDBUFFER dsound_buffer;
> > > +=C2=A0=C2=A0=C2=A0 void *last_buf;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dsound *s;
> > > =C2=A0 } DSoundVoiceOut;
> > > @@ -414,10 +415,10 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DSoundVoiceOut *ds =3D (DSoundVoiceOut=
 *) hw;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPDIRECTSOUNDBUFFER dsb =3D ds->dsound=
_buffer;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HRESULT hr;
> > > -=C2=A0=C2=A0=C2=A0 DWORD ppos, act_size;
> > > +=C2=A0=C2=A0=C2=A0 DWORD ppos, act_size, last_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t req_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > > -=C2=A0=C2=A0=C2=A0 void *ret;
> > > +=C2=A0=C2=A0=C2=A0 void *ret, *last_ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hr =3D IDirectSoundBuffer_GetCurrentPo=
sition(dsb, &ppos, NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (FAILED(hr)) {
> > > @@ -426,17 +427,24 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 if (ppos =3D=3D hw->pos_emul) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ds->last_buf;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_size =3D audio_ring_dist(ppos, hw-=
>pos_emul, hw->size_emul);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_size =3D MIN(req_size, hw->size_em=
ul - hw->pos_emul);
> > > -=C2=A0=C2=A0=C2=A0 err =3D dsound_lock_out(dsb, &hw->info, hw->pos_e=
mul, req_size,
> > > &ret, NULL,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &act_size, NULL, false, ds->s);
> > > +=C2=A0=C2=A0=C2=A0 err =3D dsound_lock_out(dsb, &hw->info, hw->pos_e=
mul, req_size,
> > > &ret, &last_ret,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &act_size, &last_size, false, ds->s);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dolog("Failed =
to lock buffer\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 ds->last_buf =3D g_realloc(ds->last_buf, act_size=
);
> > > +=C2=A0=C2=A0=C2=A0 memcpy(ds->last_buf, ret, act_size);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D act_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > =C2=A0 }
>=20
> I don't really understand what's happening here, why do you need that mem=
ory
> allocation and memcpy?  This function should return a buffer where the
> caller will write data, that *size =3D 0; when returning ds->last_buf als=
o
> looks incorrect to me (the calling function won't write anything into it)=
.
>=20
> I'm attaching a patch with a probably better (and totally untested) way t=
o
> do this (if someone can tell me how to copy-paste a patch into thunderbir=
d
> without it messing up long lines, please tell me).
>=20
>=20
> > > @@ -445,6 +453,8 @@
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DSoundVoiceOut *ds =3D (DSoundVoiceOut=
 *) hw;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPDIRECTSOUNDBUFFER dsb =3D ds->dsound=
_buffer;
> > > +=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D dsound_unlock_out(dsb, buf=
, NULL, len, 0);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>=20
> Msdn says "The second pointer is needed even if nothing was written to th=
e
> second pointer." so that NULL doesn't look okay.
>=20
> > > @@ -508,10 +518,10 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DSoundVoiceIn *ds =3D (DSoundVoiceIn *=
) hw;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds=
->dsound_capture_buffer;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HRESULT hr;
> > > -=C2=A0=C2=A0=C2=A0 DWORD cpos, act_size;
> > > +=C2=A0=C2=A0=C2=A0 DWORD cpos, act_size, last_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t req_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > > -=C2=A0=C2=A0=C2=A0 void *ret;
> > > +=C2=A0=C2=A0=C2=A0 void *ret, *last_ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hr =3D IDirectSoundCaptureBuffer_GetCu=
rrentPosition(dscb, &cpos,
> > > NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (FAILED(hr)) {
> > > @@ -520,11 +530,16 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 if (cpos =3D=3D hw->pos_emul) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_size =3D audio_ring_dist(cpos, hw-=
>pos_emul, hw->size_emul);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_size =3D MIN(req_size, hw->size_em=
ul - hw->pos_emul);
> > > -=C2=A0=C2=A0=C2=A0 err =3D dsound_lock_in(dscb, &hw->info, hw->pos_e=
mul, req_size,
> > > &ret, NULL,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &act_size, NULL, false, ds->s);
> > > +=C2=A0=C2=A0=C2=A0 err =3D dsound_lock_in(dscb, &hw->info, hw->pos_e=
mul, req_size,
> > > &ret, &last_ret,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &act_size, &last_size, false, ds->s);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dolog("Failed =
to lock buffer\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D 0;
> > >=20
>=20
> You're completely ignoring last_ret and last_size here.  Don't you lose
> samples here?  I think it's possible to do something like I posted above
> with output here.
>=20
> Regards,
> Zoltan



