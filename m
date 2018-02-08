Received: from eggs.gnu.org ([2001:4830:134:3::10]:43771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejndX-0006K2-Su
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejndU-000612-Qm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:57:19 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejndU-00060c-Jm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:57:16 -0500
Received: by mail-wm0-f48.google.com with SMTP id t74so10037951wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:57:16 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-12-rkagan@virtuozzo.com>
	<10ea956e-3a47-9da4-2005-af5b1c636518@redhat.com>
	<20180207190615.GC18247@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da05e0ef-1617-7809-3b98-716b7b100bf4@redhat.com>
Date: Thu, 8 Feb 2018 15:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180207190615.GC18247@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 11/34] hyperv: add synic message
 delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 07/02/2018 20:06, Roman Kagan wrote:
>>> +    struct hyperv_message *msg;
>>> +    /*
>>> +     * the state of the message staged in .msg:
>>> +     * 0        - the staging area is not in use (after init or message
>>> +     *            successfully delivered to guest)
>>> +     * -EBUSY   - the staging area is being used in vcpu thread
>>> +     * -EAGAIN  - delivery attempt failed due to slot being busy, retry
>>> +     * -EXXXX   - error
>>> +     */
>>> +    int msg_status;
>>> +
>> Access to these fields needs to be protected by a mutex (the refcount is
>> okay because it is only released in the bottom half).
> Hmm, I'll double-check, but the original idea was that this stuff is
> only used/ref-d/unref-d in the main thread so no mutex was necessary.

"Passing the buck" from iothread to vCPU and vice versa should work;
async_run_on_cpu and aio_bh_schedule_oneshot introduce the necessary
ordering.  However you could still have concurrent access to the state.

The mutex is the safest option, but please document whatever you come up
with.

Thanks,

Paolo
