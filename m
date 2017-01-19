Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU9vh-0002V1-7B
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU9ve-0000u4-2p
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:26:53 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cU9vd-0000tP-NZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:26:49 -0500
Received: by mail-lf0-x243.google.com with SMTP id x1so4824470lff.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 02:26:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
	<1587720065.2308546.1484319819288.JavaMail.zimbra@redhat.com>
	<AF473AD9-3343-4C5F-8DE1-B0870DC65327@nutanix.com>
	<20170113190029-mutt-send-email-mst@kernel.org>
	<93A04CF9-EC7D-4250-8AE5-3C5F3F0E325E@nutanix.com>
	<20170113193004-mutt-send-email-mst@kernel.org>
	<560A07C4-C641-4055-93D1-628FF19C3CF4@nutanix.com>
	<20170117203922-mutt-send-email-mst@kernel.org>
	<55D2006A-3164-4C06-AB71-29FE3EAD00B8@nutanix.com>
	<20170117205832-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de787d49-c238-8e30-7b37-f1e238a3dcdc@redhat.com>
Date: Thu, 19 Jan 2017 11:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170117205832-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>



On 17/01/2017 20:00, Michael S. Tsirkin wrote:
>>> vhost user is not supposed to use maskfd at all.
>>>
>>> We have this code:
>>>        if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>>>            dev->use_guest_notifier_mask = false;
>>>        }
>>>
>>> isn't it effective?
>>
>> I'm observing this problem when using vhost-user-scsi, not -net. So the code above is not in effect. Anyway, I'd expect the race I described to also happen on vhost-scsi.
>
> maskfd is just racy for vhost-user ATM.  I'm guessing vhost-scsi should
> just set use_guest_notifier_mask, that will fix it.  Alternatively,
> rework masking to support sync with the backend - but I doubt it's
> useful.

I agree with Michael that this is a QEMU bug, not a libvhost-user bug.

Thanks,

Paolo

>>>
>>>
>>>
>>>> Qemu sends the new callfd to the application
>>>>
>>>> It's not hard to repro. How could this situation be avoided?
>>>>
>>>> Cheers,
>>>> Felipe
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Perhaps it's best for now to delay the callfd notification with a flag until it is received?
>>>>>>>>
>>>>>>>> The other idea is to always kick when we receive the callfd. I remember discussing that alternative with you before libvhost-user went in. The protocol says both the driver and the backend must handle spurious kicks. This approach also fixes the bug.
>>>>>>>>
>>>>>>>> I'm happy with whatever alternative you want, as long it makes libvhost-user usable for storage devices.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Felipe
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>>>>>>>>> ---
>>>>>>>>>> contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
>>>>>>>>>> 1 file changed, 13 insertions(+), 13 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/contrib/libvhost-user/libvhost-user.c
>>>>>>>>>> b/contrib/libvhost-user/libvhost-user.c
>>>>>>>>>> index af4faad..a46ef90 100644
>>>>>>>>>> --- a/contrib/libvhost-user/libvhost-user.c
>>>>>>>>>> +++ b/contrib/libvhost-user/libvhost-user.c
>>>>>>>>>> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>>>>>>>>>>      DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> -    dev->vq[index].started = true;
>>>>>>>>>> -    if (dev->iface->queue_set_started) {
>>>>>>>>>> -        dev->iface->queue_set_started(dev, index, true);
>>>>>>>>>> -    }
>>>>>>>>>> -
>>>>>>>>>> -    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
>>>>>>>>>> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>>>>>>>>>> -                       vu_kick_cb, (void *)(long)index);
>>>>>>>>>> -
>>>>>>>>>> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
>>>>>>>>>> -               dev->vq[index].kick_fd, index);
>>>>>>>>>> -    }
>>>>>>>>>> -
>>>>>>>>>>  return false;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>>>>>>>>>>
>>>>>>>>>>  DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
>>>>>>>>>>
>>>>>>>>>> +    dev->vq[index].started = true;
>>>>>>>>>> +    if (dev->iface->queue_set_started) {
>>>>>>>>>> +        dev->iface->queue_set_started(dev, index, true);
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
>>>>>>>>>> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>>>>>>>>>> +                       vu_kick_cb, (void *)(long)index);
>>>>>>>>>> +
>>>>>>>>>> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
>>>>>>>>>> +               dev->vq[index].kick_fd, index);
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>>  return false;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> 1.9.4
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
> 
> 
