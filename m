Received: from eggs.gnu.org ([2001:4830:134:3::10]:42930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVxaB-0001io-QI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVxa6-0005hL-Qm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dVxa6-0005gr-IV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:12:18 -0400
Date: Fri, 14 Jul 2017 12:12:07 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170714101207.kj3r3oh6oyd2bhbf@dhcp-192-218.str.redhat.com>
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712094149.23069-4-jfreimann@redhat.com>
	<CAJ+F1CL0pjOaxHNcCUXqjbLi=Hr2TYaEpMjYoGApdkoob4Q3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL0pjOaxHNcCUXqjbLi=Hr2TYaEpMjYoGApdkoob4Q3eQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, victork@redhat.com, mst@redhat.com

On Thu, Jul 13, 2017 at 04:01:34PM +0000, Marc-Andr=E9 Lureau wrote:
>Hi
>
>On Wed, Jul 12, 2017 at 1:47 PM Jens Freimann <jfreimann@redhat.com> wro=
te:
>
>> From: Jens Freimann <jfreiman@redhat.com>
>>
>> When recvmsg() returns a message size of zero and
>> errno is ENOENT end processing of vhost-user messages.

The man page says that zero-length messages indicate a orderly
shutdown for stream sockets, but for datagram sockets they are
permitted as normal messages. So technically quitting when receiving =20
a zero-length packet is not correct here.

I found I can replace this entire patch with this hunk:

@@ -812,6 +812,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
                return vu_get_queue_num_exec(dev, vmsg);
        case VHOST_USER_SET_VRING_ENABLE:
                return vu_set_vring_enable_exec(dev, vmsg);
+       case VHOST_USER_NONE:
+               return true;
        default:
                vmsg_close_fds(vmsg);
                vu_panic(dev, "Unhandled
                        request: %d",
                        vmsg->request);

This works, because vmsg is initialzed to all zeros. When we read a
message of length zero, vmsg->request is 0, which is VHOST_USER_NONE.

Would this be acceptable?

>>
>> Without this we run into a vubr_panic() call and get
>>      PANIC: Error while recvmsg: No such file or directory
>>      Error while dispatching.
>>
>>
>How do you get ENOENT on recvmsg()?

I don't. I looked at errno when the return code of recvmsg() was 0,
but errno is only set in case of an error. So it is has no meaning
regarding recvmsg().=20

>Add a switch "quit" to the vhost user device and set true to stop
>> processing messages.
>>
>> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>> ---
>>  contrib/libvhost-user/libvhost-user.c | 12 +++++++++++-
>>  contrib/libvhost-user/libvhost-user.h |  1 +
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.c
>> b/contrib/libvhost-user/libvhost-user.c
>> index 9efb9da..5538859 100644
>> --- a/contrib/libvhost-user/libvhost-user.c
>> +++ b/contrib/libvhost-user/libvhost-user.c
>> @@ -161,7 +161,10 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUse=
rMsg
>> *vmsg)
>>          rc =3D recvmsg(conn_fd, &msg, 0);
>>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>>
>> -    if (rc <=3D 0) {
>> +    if (rc =3D=3D 0 && (errno =3D=3D ENOENT)) {
>> +        vmsg->size =3D 0;
>> +        dev->quit =3D true;
>> +    } else if (rc < 0) {
>>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>>          return false;
>>      }
>> @@ -755,6 +758,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg=
)
>>      DPRINT("Flags:   0x%x\n", vmsg->flags);
>>      DPRINT("Size:    %d\n", vmsg->size);
>>
>> +    if (dev->quit) {
>> +        return true;
>> +    }
>>
>
>Make it false, as no reply is expected then

ok
>
>
>> +
>>      if (vmsg->fd_num) {
>>          int i;
>>          DPRINT("Fds:");
>> @@ -822,6 +829,9 @@ vu_dispatch(VuDev *dev)
>>      bool success =3D false;
>>
>>      if (!vu_message_read(dev, dev->sock, &vmsg)) {
>> +        if (vmsg.size =3D=3D 0) {
>> +            success =3D true;
>> +        }
>>
>
>There might be better ways to indicate a disconnection than modifying an=
d
>checking vmsg.size. Perhaps dev->quit alone is enough?

yes, it is enough. I'll change it.
>
>         goto end;
>>      }
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.h
>> b/contrib/libvhost-user/libvhost-user.h
>> index 53ef222..c02215a 100644
>> --- a/contrib/libvhost-user/libvhost-user.h
>> +++ b/contrib/libvhost-user/libvhost-user.h
>> @@ -217,6 +217,7 @@ struct VuDev {
>>      uint64_t features;
>>      uint64_t protocol_features;
>>      bool broken;
>> +    bool quit;
>>
>
>I also think you could re-use broken in this case.

I could use broken, it just felt wrong because in this case the device
is not broken, we just want to quit receiving messages because there is
no more data to be received. But if this is not enough to justify a
new variable, I'm fine with using broken.

Thanks for the review!

regards,
Jens=20
>
>>
>>      /* @set_watch: add or update the given fd to the watch set,
>>       * call cb when condition is met */
>> --
>> 2.9.4
>>
>>
>> --
>Marc-Andr=E9 Lureau
