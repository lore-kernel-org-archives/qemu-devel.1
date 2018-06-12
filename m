Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fSkkg-0007YV-NL
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fSkke-0000iw-1P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:58:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fSkkd-0000h8-Tt
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:58:27 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so28372027iob.10
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e0a90bd4-93b0-fd0b-a16d-034093589f6b@amsat.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-6-marcandre.lureau@redhat.com>
	<e0a90bd4-93b0-fd0b-a16d-034093589f6b@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Jun 2018 16:58:26 +0200
Message-ID: <CAMxuvaziSdDMp9JKTDM0abDg127WYxPZwnPbV-rwMi-mOJojJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 05/12] vhost-user: split vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Fri, Jun 8, 2018 at 4:57 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 06/01/2018 01:27 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Split vhost_user_read(), so only header can be read with
>> vhost_user_read_header().
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/virtio/vhost-user.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index cc9298792d..a87db01e55 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -196,7 +196,7 @@ static bool ioeventfd_enabled(void)
>>      return kvm_enabled() && kvm_eventfds_enabled();
>>  }
>>
>> -static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>> +static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *=
msg)
>
> Can this be simply:
>
> static int vhost_user_read_header(CharBackend *chr, VhostUserMsg *msg) ?

It's more convenient and uniform with vhost_user_read() and friends if
it takes vhost_dev as argument. You can also see in patch "vhost-user:
add vhost_user_input_get_config()" that vhost_user_read_header() is
called fromwithout CharBackend* as variable in the caller.

>>  {
>>      struct vhost_user *u =3D dev->opaque;
>>      CharBackend *chr =3D u->chr;
>> @@ -207,7 +207,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vh=
ostUserMsg *msg)
>>      if (r !=3D size) {
>>          error_report("Failed to read msg header. Read %d instead of %d.=
"
>>                       " Original request %d.", r, size, msg->hdr.request=
);
>> -        goto fail;
>> +        return -1;
>>      }
>>
>>      /* validate received flags */
>> @@ -215,7 +215,21 @@ static int vhost_user_read(struct vhost_dev *dev, V=
hostUserMsg *msg)
>>          error_report("Failed to read msg header."
>>                  " Flags 0x%x instead of 0x%x.", msg->hdr.flags,
>>                  VHOST_USER_REPLY_MASK | VHOST_USER_VERSION);
>> -        goto fail;
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>> +{
>> +    struct vhost_user *u =3D dev->opaque;
>> +    CharBackend *chr =3D u->chr;
>> +    uint8_t *p =3D (uint8_t *) msg;
>> +    int r, size;
>> +
>> +    if (vhost_user_read_header(dev, msg) < 0) {
>> +        return -1;
>>      }
>>
>>      /* validate message size is sane */
>> @@ -223,7 +237,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vh=
ostUserMsg *msg)
>>          error_report("Failed to read msg header."
>>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
>>                  VHOST_USER_PAYLOAD_SIZE);
>> -        goto fail;
>> +        return -1;
>>      }
>>
>>      if (msg->hdr.size) {
>> @@ -233,14 +247,11 @@ static int vhost_user_read(struct vhost_dev *dev, =
VhostUserMsg *msg)
>>          if (r !=3D size) {
>>              error_report("Failed to read msg payload."
>>                           " Read %d instead of %d.", r, msg->hdr.size);
>> -            goto fail;
>> +            return -1;
>>          }
>>      }
>>
>>      return 0;
>> -
>> -fail:
>> -    return -1;
>>  }
>>
>>  static int process_message_reply(struct vhost_dev *dev,
>>
