Received: from eggs.gnu.org ([209.51.188.92]:49190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gw0lL-0006xV-CC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gw0lJ-00008R-E6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:28:23 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1gw0lF-000061-LP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:28:19 -0500
Received: by mail-qk1-x742.google.com with SMTP id r21so11519634qkl.11
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 00:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20190215174659.4007-1-v.maffione@gmail.com>
	<5159fece-5573-7d9e-b6fe-c5832138d63e@redhat.com>
	<CA+_eA9jMpjAvpX94N36+Kp52xZrtr6gbu=n9G78yYhnZRKYxgg@mail.gmail.com>
	<dcb76591-c022-a81e-43bc-fbb9b6830d15@redhat.com>
In-Reply-To: <dcb76591-c022-a81e-43bc-fbb9b6830d15@redhat.com>
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Tue, 19 Feb 2019 09:28:03 +0100
Message-ID: <CA+_eA9j-OPfLNagPAoSPSZRBtsVFEPsBWg0-U7jfQxAYEZTdWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/1] Allow TAP to unnegotiate virtio-net
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Il giorno mar 19 feb 2019 alle ore 07:48 Jason Wang <jasowang@redhat.com>
ha scritto:

>
> On 2019/2/18 =E4=B8=8B=E5=8D=887:53, Vincenzo Maffione wrote:
> > Hi Jason,
> >    Thanks for the quick reply.
> >
> > My PV device (to be open sourced soon) uses the QEMU net backend
> interface,
> > in a way similar to virtio-net.
> > For example it uses qemu_set_offload(), qemu_has_vnet_hdr_len(),
> > qemu_using_vnet_hdr(), qemu_send_packet(), etc.
> > This means that the device itself does not know which net backend is
> using,
> > of course.
> > In addition to TAP, also the netmap backend supports the virtio-net
> header,
> > and so the PV device will work with both.
> > Regarding the virtio-net header, the netmap backend is more flexible
> > because you can change the virtio-net header length as you wish (choosi=
ng
> > between 0, 10 and 12 bytes).
>
>
> Interesting, actually, there's case that vnet header is not used even
> for virtio-net, e.g for the case of XDP withouth csum support. If we
> don't pass vnet header in this case, we may get even higher PPS.
>

I guess in this case we simply pass a zeroed header. According to my
experience I think it's unlikely that PPS are affected by having 12
additional bytes to copy around, as long as no processing is done on the
header. I may be wrong of course.

>
>
> >
> > My problem cannot be solved by making sure that TAPs are opened without
> > IFF_VNET_HDR. What I want instead
> > is to dynamically change the length of the virtio-net header that the
> > backend accepts, switching between 12 bytes (virtio 1.0 header) and 0 (=
no
> > header). By "dynamically" I mean while the guest (and the device) is
> > running. This is possible and safe if we get rid of that assert().
> > The virtio-net device does not need that flexibility (once you enable t=
he
> > vtnet header, you never disable that again), so I guess that's why you
> have
> > that assert().
> > My PV device can be reconfigured on the fly in such a way it may or not
> may
> > be aware of the virtio-net header, and as a consequence it may need to
> call
> > qemu_using_vnet_hdr() with true or false (multiple times).
> >
> > Does it make sense?
>
>
> Yes, it is. But I think maybe it's better to send this patch with your
> new PV device implementation.
>
> Sounds good, thanks.

Cheers,
  Vincenzo


> Thanks
>
>
> >
> > Cheers,
> >    Vincenzo
> >
> >
> > Il giorno lun 18 feb 2019 alle ore 05:19 Jason Wang <jasowang@redhat.co=
m
> >
> > ha scritto:
> >
> >> On 2019/2/16 =E4=B8=8A=E5=8D=881:46, Vincenzo Maffione wrote:
> >>> Hi,
> >>>     I was doing experiments with a custom paravirtualized net device,
> >>> and I ran into a limitation of the TAP backend. I see from the kernel
> >>> code that it is not possible to set the TAP virtio-net header
> >>> length to something different from 10 or 12, which means that it
> >>> is not possible to set it to 0. That's fine.
> >>> The QEMU implementation of the TAP backend already supports
> >>> the case where virtio-net header is set to 10 or 12 in kernel,
> >>> but the emulated/paravirtualized net device is not using that:
> >>> the TAP backend will just strip/prepend a zeroed header in this case
> >>> (e.g., see the if statement in tap_receive_iov()).
> >>> However, the tap_using_vnet_hdr() has an assert() that prevents
> >>> this situation to happen, and I don't understand why. Maybe it
> >>> is a leftover? I tried to remove the assert and by doing that
> >>> my paravirtualized device was able to stop using the virtio-net
> >>> header.
> >>
> >> Hi:
> >>
> >> If  I understand this correctly, your PV device is API compatible with
> >> TAP? Then you may just adding code to call TUNSETIFF without
> IFF_VNET_HDR?
> >>
> >> Thanks
> >>
> >>
> >>> Vincenzo Maffione (1):
> >>>     net: tap: allow net frontends to un-negotiate virtio-net header
> >>>
> >>>    net/tap.c | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>>
> >
>


--=20
Vincenzo
