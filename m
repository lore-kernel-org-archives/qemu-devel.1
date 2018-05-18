Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJkHD-0000dB-Ef
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJkH8-0002sl-Kz
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:38:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fJkH8-0002sV-G8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:38:46 -0400
From: Bandan Das <bsd@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
	<CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
	<jpgr2maq7rs.fsf@linux.bootlegged.copy>
	<jpga7swygak.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_QOHPbhmEAqaDvSVgBiktBkh06uA623bNzgK16msBAXQ@mail.gmail.com>
Date: Fri, 18 May 2018 14:38:45 -0400
In-Reply-To: <CAFEAcA_QOHPbhmEAqaDvSVgBiktBkh06uA623bNzgK16msBAXQ@mail.gmail.com>
	(Peter Maydell's message of "Fri, 18 May 2018 19:25:37 +0100")
Message-ID: <jpg1se87qru.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 18 May 2018 at 19:22, Bandan Das <bsd@redhat.com> wrote:
>>
>> CID 1390604
>> If the initiator sends a packet with TYPE_DATA set without
>> initiating a CMD_GET_OBJECT_INFO first, then usb_mtp_get_data
>> can trip on a null s->data_out.
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>
> I think you said this can be provoked by the guest?

Yes, this can only be initated by the guest as far as I
understand.

> Misbehaving or malicious guests should never be able
> to provoke assertions.

I am not sure, I thought it's better to kill a misbehaving guest rather
than silently letting it run. Anyway, it's possible to send a
No_Valid_ObjectInfo as well and we wouldn't have to mark it as a
false positive either.

Bandan

>> ---
>>  hw/usb/dev-mtp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 3d59fe4944..905e025d7f 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1696,6 +1696,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>>      uint64_t dlen;
>>      uint32_t data_len = p->iov.size;
>>
>> +    assert(d != NULL);
>>      if (d->first) {
>>          /* Total length of incoming data */
>>          d->length = cpu_to_le32(container->length) - sizeof(mtp_container);
>> --
>> 2.14.3
>
> thanks
> -- PMM
