Received: from eggs.gnu.org ([2001:4830:134:3::10]:54430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fRSGl-00060f-V4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fRSGk-0004Gp-R3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:02:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fRSGk-0004GS-Kz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 21:02:14 -0400
Received: by mail-wm0-x241.google.com with SMTP id n5-v6so6556672wmc.5
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 18:02:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+v0NCX+88=MGW7uM_05tgcB4d7rRC-RC87n0a6gAq4kA@mail.gmail.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-12-marcandre.lureau@redhat.com>
	<20180604093750.mtlx2frtx5mzv5w2@sirius.home.kraxel.org>
	<CAJ+F1C+v0NCX+88=MGW7uM_05tgcB4d7rRC-RC87n0a6gAq4kA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Jun 2018 03:02:12 +0200
Message-ID: <CAJ+F1CL4VMqjZqTxb4JUyo=Erb++_HU_yYtf5SiuiZCqQ2Adww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 11/12] Add virtio-gpu vhost-user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Dave Airlie <airlied@gmail.com>

On Fri, Jun 8, 2018 at 7:25 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Mon, Jun 4, 2018 at 11:37 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> On Fri, Jun 01, 2018 at 06:27:48PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>>> Add to virtio-gpu devices a "vhost-user" property. When set, the
>>> associated vhost-user backend is used to handle the virtio rings.
>>>
>>> For now, a socketpair is created for the backend to share the rendering
>>> results with qemu via a simple VHOST_GPU protocol.
>>
>> Why this isn't a separate device, like vhost-user-input-pci?
>
> Ok, let's have vhost-user-gpu-pci and vhost-user-vga, inheriting from
> existing devices.
>
>>> +typedef struct VhostGpuUpdate {
>>> +    uint32_t scanout_id;
>>> +    uint32_t x;
>>> +    uint32_t y;
>>> +    uint32_t width;
>>> +    uint32_t height;
>>> +    uint8_t data[];
>>> +} QEMU_PACKED VhostGpuUpdate;
>>
>> Hmm, when designing a new protocol I think we can do better than just
>> squeering the pixels into a tcp stream.  Use shared memory instead?  Due
>> to vhost we are limited to linux anyway, so we might even consider stuff
>> like dmabufs here.
>
> Well, my goal is not to invent a new spice or wayland protocol :) I
> don't care much about 2d performance at this point, more about 3d. Can
> we leave 2d improvements for another day? Beside, what would dmabuf
> bring us for 2d compared to shmem?
>
> There seems to be a lot of overhead with the roundtrip vhost-user ->
> qemu -> spice worker -> spice client -> wayland/x11 -> gpu already
> (but this isn't necessarily so bad at 60fps or less).
> Ideally, I would like to bypass qemu & spice for local rendering, but
> I don't think wayland support that kind of nested window composition
> (at least tracking messages weston --nested doesn't show that kind of
> optimization).
>
> FWIW, here are some Unigine Heaven 4.0 benchmarks (probably within +-10%)=
:
>
> qemu-gtk/egl+virtio-gpu: fps:2.6/ score: 64
> qemu-gtk/egl+vhost-user-gpu: fps:12.9 / score: 329
>
> spice+virtio-gpu: fps:2.8 / score: 70
> spice+vhost-user-gpu: fps:12.1 / score: 304
>
> That should give an extra motivation :)
>

(host is fps:31.1 / score:784



--=20
Marc-Andr=C3=A9 Lureau
