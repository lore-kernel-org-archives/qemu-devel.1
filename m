Received: from eggs.gnu.org ([2001:4830:134:3::10]:58222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIVa-0005cP-UA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIVX-0002TS-Jg
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:26:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEIVX-0002SS-E5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:26:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-2-lprosek@redhat.com>
	<8760aeb6mn.fsf@dusky.pond.sub.org>
	<CABdb736hx3KEM__F6JB7FymJep+ZHrkA=d8ALok1MuNwaa3NYA@mail.gmail.com>
Date: Mon, 13 Nov 2017 18:26:45 +0100
In-Reply-To: <CABdb736hx3KEM__F6JB7FymJep+ZHrkA=d8ALok1MuNwaa3NYA@mail.gmail.com>
	(Ladi Prosek's message of "Mon, 13 Nov 2017 15:38:30 +0100")
Message-ID: <87d14mytre.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] ivshmem: Don't update non-existent MSI
 routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Ma?= =?utf-8?Q?rc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Ladi Prosek <lprosek@redhat.com> writes:

> On Mon, Nov 13, 2017 at 3:22 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> Ladi Prosek <lprosek@redhat.com> writes:
>>
>>> As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"),
>>> QEMU crashes with:
>>>
>>>   kvm_irqchip_commit_routes: Assertion `ret == 0' failed.
>>>
>>> if the ivshmem device is configured with more vectors than what the server
>>> supports. This is caused by the ivshmem_vector_unmask() being called on
>>> vectors that have not been initialized by ivshmem_add_kvm_msi_virq().
>>>
>>> This commit fixes it by adding a simple check to the mask and unmask
>>> callbacks.
>>>
>>> Note that the opposite mismatch, if the server supplies more vectors than
>>> what the device is configured for, is already handled and leads to output
>>> like:
>>>
>>>   Too many eventfd received, device has 1 vectors
>>>
>>> Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>
>> I think I understand your description of what's wrong.  Not obvious to
>> me is how it can happen.  The cover letter mentions a Windows ivshmem
>> driver.  Is this a device bug a driver can trigger?  If yes, how?
>
> I don't have a Linux guest handy but this code has existed for quite a
> long time so yes, I think it's safe to assume that it can't be
> (easily) triggered by the Linux driver.
>
> The reproducer is as simple as:
>
> ivshmem-server -n 0
> qemu ... -device ivshmem-doorbell,chardev=iv -chardev
> socket,path=/tmp/ivshmem_socket,id=iv
>
> and load the Windows driver in the guest.
>
> Maybe Linux won't enable MSI-X on the device?

Please work your reproducer into the commit message.  Make sure to note
that you're using "the Windows driver" (ideally with a pointer), and why
you assume the Linux driver doesn't trigger it.  With that, you can add
my

Reviewed-by: Markus Armbruster <armbru@redhat.com>
