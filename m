Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIf2C-0007Pr-Ns
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIf2B-0002U8-SF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:50:52 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:40575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIf2B-0002Tx-NI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:50:51 -0400
Received: by mail-oi0-x22e.google.com with SMTP id c203-v6so1133422oib.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:50:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507094448.32386-2-kraxel@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 19:50:30 +0100
Message-ID: <CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/3] usb-mtp: Add some NULL checks for
 issues pointed out by coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>

On 7 May 2018 at 10:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Bandan Das <bsd@redhat.com>
>
> CID 1390578: In usb_mtp_write_metadata, parent can never be NULL but
> just in case, add an assert
> CID 1390592: Check for o->format only if o !=NULL
> CID 1390604: Check s->data_out != NULL in usb_mtp_handle_data

> @@ -1838,7 +1838,7 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
>              p->status = USB_RET_STALL;
>              return;
>          }
> -        if (s->data_out && !s->data_out->first) {
> +        if ((s->data_out != NULL) && !s->data_out->first) {
>              container_type = TYPE_DATA;
>          } else {
>              usb_packet_copy(p, &container, sizeof(container));
> --

I just noticed this, but this isn't actually changing the logic
in this function: "s->data_out" and "s->data_out != NULL" are
exactly the same test. So this won't change CID 1390604.

Looking back at my previous email on this, it looks like I
managed to completely misinterpret the code and/or what
coverity is talking about, which is probably the source of
the confusion. Let me try again...

In the function usb_mtp_handle_data() EP_DATA_OUT case, we have:
 (1) a check for whether s->data_out is NULL, which implies
     that it might be NULL sometimes
 (2) some time later, a call to usb_mtp_get_data() which is
     not protected by a test for whether s->data_out is NULL

and if s->data_out is NULL at point (2) then usb_mtp_get_data()
will crash.

Obviously the code path that goes through "containe_type = TYPE_DATA"
must have s->data_out being non-NULL. But in the else branch of
that, can the container_type we get via usb_packet_copy() ever
be TYPE_DATA ? (It's not clear to me whether that comes from
a trusted or untrusted source.)

If this is a "can't happen" situation we can mark it as a false
positive in coverity.

thanks
-- PMM
