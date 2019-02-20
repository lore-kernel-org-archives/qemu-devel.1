Received: from eggs.gnu.org ([209.51.188.92]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPbH-0000jQ-HJ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPb8-0005MN-BN
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:59:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPb6-0005LR-VF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:59:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so1695610qkl.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-7-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-7-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 11:59:16 +0100
Message-ID: <CAMxuvawqVgk6PP2wUZLbD9NyCktJDSoeLdduPQCysaEvwgDd_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/25] gdbstub: Use size_t to hold
 GDBState::last_packet_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 2:04 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> In put_packet_binary() we have:
>
>     uint8_t *p;
>     for(;;) {
>         p =3D s->last_packet;
>         *(p++) =3D ...
>         s->last_packet_len =3D p - s->last_packet;
>         put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);
>
> The 'p' pointer start at s->last_packet, then is only incremented.
> Since we have "p >=3D s->last_packet", we are sure than
> "p - s->last_packet >=3D 0", thus "p - s->last_packet" is positive.
>
> The few other places where s->last_packet_len is set is with constant
> positive values.
>
> It makes sense to use size_t to hold last_packet_len values.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 76eca3bb7e..69340d7cd1 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -323,7 +323,7 @@ typedef struct GDBState {
>      int line_sum; /* running checksum */
>      int line_csum; /* checksum at the end of the packet */
>      uint8_t last_packet[MAX_PACKET_LENGTH + 4];
> -    int last_packet_len;
> +    size_t last_packet_len;
>      int signal;
>  #ifdef CONFIG_USER_ONLY
>      int fd;
> --
> 2.20.1
>
