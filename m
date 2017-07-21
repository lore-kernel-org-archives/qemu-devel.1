Received: from eggs.gnu.org ([2001:4830:134:3::10]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dYWHN-0003Yn-7j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dYWHJ-0000uh-Uz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:39:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dYWHJ-0000uI-Oc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:39:29 -0400
Date: Fri, 21 Jul 2017 13:39:08 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170721113908.qm3fqbwsm2zao3a4@dhcp-192-218.str.redhat.com>
References: <20170721095553.10717-1-jfreimann@redhat.com>
	<20170721095553.10717-4-jfreimann@redhat.com>
	<CAJ+F1CJsCQWVeaGNwVz5ZNjv0b=mGR=ttOJQn9w5K3mUu4VLeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJsCQWVeaGNwVz5ZNjv0b=mGR=ttOJQn9w5K3mUu4VLeQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] libvhost-user: quit when no more data
 received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, victork@redhat.com, stefanha@redhat.com, mst@redhat.com

On Fri, Jul 21, 2017 at 10:59:23AM +0000, Marc-Andr=E9 Lureau wrote:
>On Fri, Jul 21, 2017 at 11:58 AM Jens Freimann <jfreimann@redhat.com> wr=
ote:
>
>> From: Jens Freimann <jfreiman@redhat.com>
>>
>> End processing of messages when VHOST_USER_NO_MESSAGE
>> is received.
>>
>>
>What is VHOST_USER_NO_MESSAGE?

I meant VHOST_USER_NONE. Will fix in next versionn.=20
>
>> Without this we run into a vubr_panic() call and get
>> "PANIC: Unhandled request: 0"
>>
>> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>>
>
>---
>>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.c
>> b/contrib/libvhost-user/libvhost-user.c
>> index 9efb9da..85523ca 100644
>> --- a/contrib/libvhost-user/libvhost-user.c
>> +++ b/contrib/libvhost-user/libvhost-user.c
>> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUser=
Msg
>> *vmsg)
>>          rc =3D recvmsg(conn_fd, &msg, 0);
>>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>>
>> -    if (rc <=3D 0) {
>> +    if (rc < 0) {
>>
>
>that's looks fine
>
>
>>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>>          return false;
>>      }
>> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>>          return vu_get_queue_num_exec(dev, vmsg);
>>      case VHOST_USER_SET_VRING_ENABLE:
>>          return vu_set_vring_enable_exec(dev, vmsg);
>> +    case VHOST_USER_NONE:
>> +        return true;
>>
>
>return true means 'reply_requested', is that what you want so
>vu_message_write() is called? If so, please explain in commit message.

No reply needed. I'll change it to return false.=20

Thanks for the review!

regards,
Jens
