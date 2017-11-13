Received: from eggs.gnu.org ([2001:4830:134:3::10]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEFsh-0000Sd-0E
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEFsd-0001IL-OO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:38:35 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:56040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eEFsd-0001I0-KC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:38:31 -0500
Received: by mail-ua0-f193.google.com with SMTP id r11so3910840uah.12
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:38:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8760aeb6mn.fsf@dusky.pond.sub.org>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-2-lprosek@redhat.com>
	<8760aeb6mn.fsf@dusky.pond.sub.org>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 13 Nov 2017 15:38:30 +0100
Message-ID: <CABdb736hx3KEM__F6JB7FymJep+ZHrkA=d8ALok1MuNwaa3NYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Mon, Nov 13, 2017 at 3:22 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Ladi Prosek <lprosek@redhat.com> writes:
>
>> As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"),
>> QEMU crashes with:
>>
>>   kvm_irqchip_commit_routes: Assertion `ret == 0' failed.
>>
>> if the ivshmem device is configured with more vectors than what the server
>> supports. This is caused by the ivshmem_vector_unmask() being called on
>> vectors that have not been initialized by ivshmem_add_kvm_msi_virq().
>>
>> This commit fixes it by adding a simple check to the mask and unmask
>> callbacks.
>>
>> Note that the opposite mismatch, if the server supplies more vectors than
>> what the device is configured for, is already handled and leads to output
>> like:
>>
>>   Too many eventfd received, device has 1 vectors
>>
>> Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>
> I think I understand your description of what's wrong.  Not obvious to
> me is how it can happen.  The cover letter mentions a Windows ivshmem
> driver.  Is this a device bug a driver can trigger?  If yes, how?

I don't have a Linux guest handy but this code has existed for quite a
long time so yes, I think it's safe to assume that it can't be
(easily) triggered by the Linux driver.

The reproducer is as simple as:

ivshmem-server -n 0
qemu ... -device ivshmem-doorbell,chardev=iv -chardev
socket,path=/tmp/ivshmem_socket,id=iv

and load the Windows driver in the guest.

Maybe Linux won't enable MSI-X on the device?

Thanks!
Ladi
