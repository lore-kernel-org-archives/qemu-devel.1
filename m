Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2AEE-0003ss-EG
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2AEA-0001XF-CR
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2AEA-0001W8-45
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:10:46 -0400
Message-ID: <1507702242.31518.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Oct 2017 08:10:42 +0200
In-Reply-To: <20171010171218.14298-1-martin@schrodt.org>
References: <20171010171218.14298-1-martin@schrodt.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

On Tue, 2017-10-10 at 19:12 +0200, Martin Schrodt wrote:
> Please see
>=20
> https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_dr
> iver_for_qemu/
>=20
> for motivation, and more coverage.
>=20
> Changes:
>=20
> - Remove PA reader/writer threads from paaudio.c, and do IO from the
> audio timer directly.
> - Add 1 millisecond timers which interface with the HDA device,
> pulling and pushing data
> =C2=A0 to and from it, to enable the guest driver to measure DMA timing=
 by
> just looking the
> =C2=A0 LPIB registers.
> - Expose new configurable settings, such as TLENGTH and FRAGSIZE,
> plus settings to
> =C2=A0 enable PA_STREAM_ADJUST_LATENCY for input and output device
> separately.
> - Fix the input delay when first using the input device.

This needs splitting into smaller patches, probably at least one patch
per change listed here.  Also the description of each change should go
directly into the commit message, not into a link pointing to the web.

> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 65beb6f010..089af32e4d 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -1,16 +1,44 @@
> -/* public domain */
> +/*
> + * QEMU ALSA audio driver
           ^^^^ ???

> + *
> + * Copyright (c) 2017 Martin Schrodt (spheenik)
> + *
> + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> + * of this software and associated documentation files (the
> "Software"), to deal
> + * in the Software without restriction, including without limitation
> the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense,
> and/or sell
> + * copies of the Software, and to permit persons to whom the
> Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
> OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> + * THE SOFTWARE.
> + */

Hmm.  Changing the licence of existing files need agreement from all
past authors.  This looks ok though, seems to be just the long version
of "public domain", so no actual change.  Should be a separate patch.

> +#ifdef PA_STREAM_ADJUST_LATENCY
> +=C2=A0=C2=A0=C2=A0=C2=A0int adjust_latency_out;
> +=C2=A0=C2=A0=C2=A0=C2=A0int adjust_latency_in;
> +#endif

Do you know which pa version added this?

If it is old enough we maybe can simply require it and don't need the
ifdefs here.

> +//=C2=A0=C2=A0=C2=A0=C2=A0if (avail_bytes < max_bytes) {
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dolog("avail: %d, wa=
nted: %d \n", (int)avail_bytes,
> (int)max_bytes);
> +//=C2=A0=C2=A0=C2=A0=C2=A0}

qemu has support for tracepoints (see docs/devel/tracing.txt) which are
 useful for this kind of debug messages.

> @@ -897,11 +779,37 @@ static void qpa_audio_fini (void *opaque)
> =C2=A0
> =C2=A0struct audio_option qpa_options[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
SAMPLES",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
INT_BUF_SIZE",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tag=C2=A0=C2=A0=C2=
=A0=3D AUD_OPT_INT,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.samples,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "buffer siz=
e in samples"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.buffer_size,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "internal b=
uffer size in frames"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
TLENGTH",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tag=C2=A0=C2=A0=C2=A0=
=3D AUD_OPT_INT,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.tlength,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "playback b=
uffer target length in frames"
> +=C2=A0=C2=A0=C2=A0=C2=A0},

What is the difference between these two?

> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
FRAGSIZE",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tag=C2=A0=C2=A0=C2=A0=
=3D AUD_OPT_INT,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.fragsize,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "fragment l=
ength of recording device in frames"
> +=C2=A0=C2=A0=C2=A0=C2=A0},
> +#ifdef PA_STREAM_ADJUST_LATENCY
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
ADJUST_LATENCY_OUT",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tag=C2=A0=C2=A0=C2=A0=
=3D AUD_OPT_BOOL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.adjust_latency_out,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "let PA adj=
ust latency for playback device"
> +=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=3D "=
ADJUST_LATENCY_IN",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tag=C2=A0=C2=A0=C2=A0=
=3D AUD_OPT_BOOL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valp=C2=A0=C2=A0=3D &=
glob_conf.adjust_latency_in,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.descr =3D "let PA adj=
ust latency for recording device"
> +=C2=A0=C2=A0=C2=A0=C2=A0},
> +#endif

What are the effects of enabling/disabling these settings?

> @@ -592,8 +733,9 @@ static const VMStateDescription
> vmstate_hda_audio_stream =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(ga=
in_right, HDAAudioStream),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_BOOL(mute=
_left, HDAAudioStream),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_BOOL(mute=
_right, HDAAudioStream),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(bpos, H=
DAAudioStream),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_BUFFER(bu=
f, HDAAudioStream),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_INT64(rpos, HD=
AAudioStream),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_INT64(wpos, HD=
AAudioStream),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_END_OF_LI=
ST()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

Oops.  vmstate changes break live migration.
Must figure something for backward compatibility here.

> -=C2=A0=C2=A0=C2=A0=C2=A0if (st->ctl & (1 << 26)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Wait with the =
next DMA xfer until the guest
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* has acked the =
buffer completion interrupt
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> -=C2=A0=C2=A0=C2=A0=C2=A0}
> +//=C2=A0=C2=A0=C2=A0=C2=A0if (st->ctl & (1 << 26)) {
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Wait with th=
e next DMA xfer until the guest
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* has acked th=
e buffer completion interrupt
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> +//=C2=A0=C2=A0=C2=A0=C2=A0}

Just drop the code, best as separate patch saying why it isn't needed
(any more) in the commit message.  There is always "git revert" in case
it turns out to be wrong, so no need to keep the code commented out.

cheers,
  Gerd
