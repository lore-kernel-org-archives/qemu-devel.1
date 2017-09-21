Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dv1a8-0003O6-La
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dv1a2-0002Js-On
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dv1a2-0002JQ-Gc
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:31:50 -0400
Date: Thu, 21 Sep 2017 15:31:37 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170921133137.dbs6o6mwe6tm3joh@localhost.localdomain>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-4-jfreimann@redhat.com>
	<CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
	<20170920150903.arckboulxo7o72d4@dhcp-192-218.str.redhat.com>
	<CAJ+F1CJVZxt3pWW1GEuy+0KNab4wxY4wc8A-raMPzTF5Qq_G4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJVZxt3pWW1GEuy+0KNab4wxY4wc8A-raMPzTF5Qq_G4Q@mail.gmail.com>
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

On Wed, Sep 20, 2017 at 04:14:33PM +0000, Marc-Andr?? Lureau wrote:
>On Wed, Sep 20, 2017 at 5:09 PM, Jens Freimann <jfreimann@redhat.com> wrote:
>> On Tue, Sep 19, 2017 at 04:46:24PM +0000, Marc-Andr?? Lureau wrote:
>>>
>>> Hi
>>>
>>> On Tue, Aug 8, 2017 at 10:52 PM Jens Freimann <jfreimann@redhat.com>
>>> wrote:
>>>>
>>>>
>>>> From: Jens Freimann <jfreiman@redhat.com>
>>>>
>>>> End processing of messages when VHOST_USER_NONE
>>>> is received.
>>>>
>>>> Without this we run into a vubr_panic() call and get
>>>> "PANIC: Unhandled request: 0"
>>>>
>>>> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>>>> ---
>>>>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/contrib/libvhost-user/libvhost-user.c
>>>> b/contrib/libvhost-user/libvhost-user.c
>>>> index 9efb9dac0e..35fa0c5e56 100644
>>>> --- a/contrib/libvhost-user/libvhost-user.c
>>>> +++ b/contrib/libvhost-user/libvhost-user.c
>>>> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg
>>>> *vmsg)
>>>>          rc = recvmsg(conn_fd, &msg, 0);
>>>>      } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>>>
>>>> -    if (rc <= 0) {
>>>> +    if (rc < 0) {
>>>>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>>>>          return false;
>>>>      }
>>>> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>>>>          return vu_get_queue_num_exec(dev, vmsg);
>>>>      case VHOST_USER_SET_VRING_ENABLE:
>>>>          return vu_set_vring_enable_exec(dev, vmsg);
>>>> +    case VHOST_USER_NONE:
>>>> +        break;
>>>
>>>
>>>
>>> I am afraid this isn't working. vu_message_read() returns
>>> true/success, vu_process_message() returns false/no-reply, so
>>> vu_dispatch() will return success, and the caller has no clear way to
>>> know that the socket got disconnected. For me the vu_panic() was quite
>>> more appropriate here.
>>>
>>> What problem did this patch exactly solve?
>>
>>
>> The problem was that a VhostUserMsg of size 0 is considered an
>> error. But recvmsg() can return 0. When I ran my pxe
>
>When did recvmsg() return 0? It should only be called after a poll
>IN/ERR, in case of data it should always return != 0, and if
>disconnected, it returns 0.

My usecase is that my testcase starts a pxeboot data transfer that
goes through vhost-user-bridge. When the transfer is done the socket
is disconnected and recvmsg() returns 0. I want vhost-user-bridge to
end gracefully, without spitting out an error message. Is that
reasonable? 
>
>> testcase using vhost-user-bridge I ran into vu_panic() because of this.
>> This worked because VHOST_USER_NONE is defined as 0. Instead of
>> doing this we could just allow a vmsg size of zero and not tread it
>> as an error?
>
>We want to treat disconnect as a panic condition imho, that the
>library user is free to implement in different way (abort() clean
>exit, reconnect etc).

Ok, that wasn't obvious to me. Thanks for clarifying! 
So I was "fixing" the wrong part. On a disconnect vubr_panic() in
vhost-user-bridge.c is called and is supposed to do the right thing. 

Currently it will print an error message "PANIC: Unhandled request:
0" in my use case. I could ignore that or check for exactly this
string and suppress the error message. Both seems a bit ugly to me...

>
>Please explain your use case and how you ran into recvmsg() = 0 and
>what you expect to happen at this point.

Hope this helps! Looks like we can revert this patch. I'll send a
patch to do this.  

regards,
Jens 
