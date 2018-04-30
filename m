Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fDD2G-0002yx-8N
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fDD2B-0004vr-EG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:56:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fDD2B-0004um-9S
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:56:19 -0400
From: Bandan Das <bsd@redhat.com>
References: <20180227083919.12339-1-kraxel@redhat.com>
	<20180227083919.12339-5-kraxel@redhat.com>
	<CAFEAcA8D=xERhHb06izoE9SeWN7zp8qRUqGjij3k1hR4xpiZsA@mail.gmail.com>
Date: Mon, 30 Apr 2018 13:56:10 -0400
In-Reply-To: <CAFEAcA8D=xERhHb06izoE9SeWN7zp8qRUqGjij3k1hR4xpiZsA@mail.gmail.com>
	(Peter Maydell's message of "Fri, 27 Apr 2018 14:38:25 +0100")
Message-ID: <jpg1sewshmt.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 4/5] usb-mtp: Introduce write support for
 MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 February 2018 at 08:39, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> From: Bandan Das <bsd@redhat.com>
>>
>> Allow write operations on behalf of the initiator. The
>> precursor to write is the sending of the write metadata
>> that consists of the ObjectInfo dataset. This patch introduces
>> a flag that is set when the responder is ready to receive
>> write data based on a previous SendObjectInfo operation by
>> the initiator (The SendObjectInfo implementation is in a
>> later patch)
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> Message-id: 20180223164829.29683-5-bsd@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Hi. Coverity (CID 1390604) complains here about a possible
> use-after-NULL-check:
>
>> @@ -1567,8 +1706,13 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
>>              p->status = USB_RET_STALL;
>>              return;
>>          }
>> -        usb_packet_copy(p, &container, sizeof(container));
>> -        switch (le16_to_cpu(container.type)) {
>> +        if (s->data_out && !s->data_out->first) {
>> +            container_type = TYPE_DATA;
>
> Here we check s->data_out, so we might set container_type
> to TYPE_DATA with s->data_out == NULL...

Just to be sure, is it enough to replace the if with:
if (s->data !=NULL && !s->data->first) ?

Bandan

>> +        } else {
>> +            usb_packet_copy(p, &container, sizeof(container));
>> +            container_type = le16_to_cpu(container.type);
>> +        }
>> +        switch (container_type) {
>>          case TYPE_COMMAND:
>>              if (s->data_in || s->data_out || s->result) {
>>                  trace_usb_mtp_stall(s->dev.addr, "transaction inflight");
>> @@ -1599,6 +1743,15 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
>>                                    (cmd.argc > 4) ? cmd.argv[4] : 0);
>>              usb_mtp_command(s, &cmd);
>>              break;
>> +        case TYPE_DATA:
>> +            /* One of the previous transfers has already errored but the
>> +             * responder is still sending data associated with it
>> +             */
>> +            if (s->result != NULL) {
>> +                return;
>> +            }
>> +            usb_mtp_get_data(s, &container, p);
>
> ...but here we call usb_mtp_get_data(), which will always
> dereference s->data_out, and so will crash if it is NULL.
>
>> +            break;
>>          default:
>>              /* not needed as long as the mtp device is read-only */
>>              p->status = USB_RET_STALL;
>> --
>> 2.9.3
>
> thanks
> -- PMM
