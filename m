Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dugdv-0006wA-1M
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dugcn-0000AT-7v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:10:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dugcm-0008U1-7R
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:09:16 -0400
Date: Wed, 20 Sep 2017 17:09:03 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170920150903.arckboulxo7o72d4@dhcp-192-218.str.redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-4-jfreimann@redhat.com>
	<CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andr?? Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 19, 2017 at 04:46:24PM +0000, Marc-Andr?? Lureau wrote:
>Hi
>
>On Tue, Aug 8, 2017 at 10:52 PM Jens Freimann <jfreimann@redhat.com> wrote:
>>
>> From: Jens Freimann <jfreiman@redhat.com>
>>
>> End processing of messages when VHOST_USER_NONE
>> is received.
>>
>> Without this we run into a vubr_panic() call and get
>> "PANIC: Unhandled request: 0"
>>
>> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>> ---
>>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
>> index 9efb9dac0e..35fa0c5e56 100644
>> --- a/contrib/libvhost-user/libvhost-user.c
>> +++ b/contrib/libvhost-user/libvhost-user.c
>> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>>          rc = recvmsg(conn_fd, &msg, 0);
>>      } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>
>> -    if (rc <= 0) {
>> +    if (rc < 0) {
>>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>>          return false;
>>      }
>> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>>          return vu_get_queue_num_exec(dev, vmsg);
>>      case VHOST_USER_SET_VRING_ENABLE:
>>          return vu_set_vring_enable_exec(dev, vmsg);
>> +    case VHOST_USER_NONE:
>> +        break;
>
>
>I am afraid this isn't working. vu_message_read() returns
>true/success, vu_process_message() returns false/no-reply, so
>vu_dispatch() will return success, and the caller has no clear way to
>know that the socket got disconnected. For me the vu_panic() was quite
>more appropriate here.
>
>What problem did this patch exactly solve?

The problem was that a VhostUserMsg of size 0 is considered an
error. But recvmsg() can return 0. When I ran my pxe
testcase using vhost-user-bridge I ran into vu_panic() because of this. 

This worked because VHOST_USER_NONE is defined as 0. Instead of
doing this we could just allow a vmsg size of zero and not tread it
as an error?


regards,
Jens 
