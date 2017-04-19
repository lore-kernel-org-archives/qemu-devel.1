Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d0jxo-0003Nb-Pl
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d0jxl-0001QX-EO
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d0jxl-0001PO-4f
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:23:41 -0400
References: <20170414174056.28946-1-maxime.coquelin@redhat.com>
	<20170414174056.28946-4-maxime.coquelin@redhat.com>
	<20170417032958.GA16703@pxdev.xzpeter.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <edb96a11-49b8-5483-0160-9855989822b6@redhat.com>
Date: Wed, 19 Apr 2017 09:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170417032958.GA16703@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/4] vhost-user: add slave-req-fd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 04/17/2017 05:29 AM, Peter Xu wrote:
> On Fri, Apr 14, 2017 at 07:40:55PM +0200, Maxime Coquelin wrote:
> 
> [...]
> 
>> @@ -486,6 +500,18 @@ Message types
>>         If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
>>         with zero in case the specified MTU is valid, or non-zero otherwise.
>>   
>> + * VHOST_USER_SET_SLAVE_REQ_FD
>> +
>> +      Id: 21
>> +      Equivalent ioctl: N/A
>> +      Master payload: N/A
>> +
>> +      Set the socket file descriptor for slave initiated requests. It is passed
>> +      in the ancillary data.
>> +      This request should be sent only when VHOST_USER_F_PROTOCOL_FEATURES
>> +      has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_F_SLAVE_REQ
>> +      bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
> 
> Here, do we need to mention REPLY_ACK as well? Like:
> 
>        If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must
>        respond with zero in case the slave request channel is setup
>        correctly, or non-zero otherwise.
> 
> Since I see the other two users are mentioning it.

Sure, it won't hurt. I'll add this in next revision.

> [...]
> 
>> +static int vhost_setup_slave_channel(struct vhost_dev *dev)
>> +{
>> +    VhostUserMsg msg = {
>> +        .request = VHOST_USER_SET_SLAVE_REQ_FD,
>> +        .flags = VHOST_USER_VERSION,
>> +    };
>> +    struct vhost_user *u = dev->opaque;
>> +    int sv[2];
>> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
>> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
>> +
>> +    if (!virtio_has_feature(dev->protocol_features,
>> +                            VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
>> +        return 0;
>> +    }
>> +
>> +    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) == -1) {
>> +        error_report("socketpair() failed");
>> +        return -1;
>> +    }
>> +
>> +    u->slave_fd = sv[0];
>> +    qemu_set_fd_handler(u->slave_fd, slave_read, NULL, dev);
>> +
>> +    if (reply_supported) {
>> +        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
>> +    }
>> +
>> +    vhost_user_write(dev, &msg, &sv[1], 1);
> 
> Do we need to close(sv[1]) afterward?

Right, thanks. It will be leaked otherwise.

>> +
>> +    if (reply_supported) {
>> +        return process_message_reply(dev, msg.request);
> 
> Here do we need to cleanup u->slave_fd if backend replied something
> wrong? Or I guess it might be leaked.

That make sense, I'll fix this.


Thanks!
Maxime
> Thanks,
> 
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> 
