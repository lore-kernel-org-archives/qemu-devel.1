Received: from eggs.gnu.org ([2001:4830:134:3::10]:42922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLAHO-00088B-OM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLAHJ-000541-O0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLAHJ-00053K-Hn
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:32:17 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-18-rkagan@virtuozzo.com>
	<ebb4867f-a072-cfa0-6ca8-b493ef157458@redhat.com>
	<20170614152848.GA19027@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62f00098-87c5-b0d9-6a07-71990b537c8d@redhat.com>
Date: Wed, 14 Jun 2017 17:32:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170614152848.GA19027@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/23] hyperv: add synic message delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 14/06/2017 17:28, Roman Kagan wrote:
> On Wed, Jun 14, 2017 at 05:08:02PM +0200, Paolo Bonzini wrote:
>>
>>
>> On 06/06/2017 20:19, Roman Kagan wrote:
>>> +    sint_route->msg_status = ret;
>>> +    /* notify the msg originator of the progress made; if the slot was busy we
>>> +     * set msg_pending flag in it so it will be the guest who will do EOM and
>>> +     * trigger the notification from KVM via sint_ack_notifier */
>>> +    if (ret != -EAGAIN) {
>>> +        qemu_bh_schedule(sint_route->msg_bh);
>>> +    }
>>
>> It may be faster to use aio_bh_schedule_oneshot, depending on the number
>> of devices.
> 
> Messages aren't used on fast paths, they are only exchanged at device
> setup/teardown.  So I cared more about readability than speed here.

Then you really want to use aio_bh_schedule_oneshot, because bottom
halves incur a (small) cost even when you don't use them: each iteration
of the event loop visits the list of bottom halves.

Persistent bottom halves, thus, are only a good idea if they are
expected to trigger very often on a busy VM.  If this bottom half is
only triggered at setup/teardown, it shouldn't use them.

Paolo
