Received: from eggs.gnu.org ([2001:4830:134:3::10]:49185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJk4l-0004R3-Rv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJk4l-0004pT-3b
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:25:59 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJk4k-0004pC-Uh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:25:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id w123-v6so7914792oia.4
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 11:25:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <jpga7swygak.fsf_-_@linux.bootlegged.copy>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
	<CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
	<jpgr2maq7rs.fsf@linux.bootlegged.copy>
	<jpga7swygak.fsf_-_@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:25:37 +0100
Message-ID: <CAFEAcA_QOHPbhmEAqaDvSVgBiktBkh06uA623bNzgK16msBAXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Assert on suspicious TYPE_DATA
 packet from initiator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 19:22, Bandan Das <bsd@redhat.com> wrote:
>
> CID 1390604
> If the initiator sends a packet with TYPE_DATA set without
> initiating a CMD_GET_OBJECT_INFO first, then usb_mtp_get_data
> can trip on a null s->data_out.
>
> Signed-off-by: Bandan Das <bsd@redhat.com>

I think you said this can be provoked by the guest?
Misbehaving or malicious guests should never be able
to provoke assertions.

> ---
>  hw/usb/dev-mtp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 3d59fe4944..905e025d7f 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1696,6 +1696,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>      uint64_t dlen;
>      uint32_t data_len = p->iov.size;
>
> +    assert(d != NULL);
>      if (d->first) {
>          /* Total length of incoming data */
>          d->length = cpu_to_le32(container->length) - sizeof(mtp_container);
> --
> 2.14.3

thanks
-- PMM
