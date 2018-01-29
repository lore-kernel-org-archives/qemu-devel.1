Received: from eggs.gnu.org ([2001:4830:134:3::10]:44832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1egARv-0008MW-D0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1egARr-0008My-EP
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:30:19 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1egARr-0008Lr-6n
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:30:15 -0500
Received: by mail-wr0-x244.google.com with SMTP id 16so7398000wry.12
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 06:30:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-3-pbonzini@redhat.com>
	<20180129114234.GC20446@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63f59171-ebc3-65bd-b031-d27374fc4e60@redhat.com>
Date: Mon, 29 Jan 2018 15:30:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180129114234.GC20446@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 29/01/2018 12:42, Stefan Hajnoczi wrote:
> On Thu, Jan 25, 2018 at 06:59:46PM +0100, Paolo Bonzini wrote:
>> +struct QemuLockable {
>> +    void *object;
>> +    QemuLockUnlockFunc *lock;
>> +    QemuLockUnlockFunc *unlock;
>> +};
> ...
>> +/* In C, compound literals have the lifetime of an automatic variable.
>> + * In C++ it would be different, but then C++ wouldn't need QemuLockable
>> + * either...
>> + */
>> +#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {    \
>> +        .object = (x),                               \
>> +        .lock = QEMU_LOCK_FUNC(x),                   \
>> +        .unlock = QEMU_UNLOCK_FUNC(x),               \
>> +    })
> 
> After all these tricks we still end up with a struct containing function
> pointers.  That's a little sad because the power of generics is
> specializing code at compile time.
> 
> IMO the generics usage here doesn't have a big pay-off.  The generated
> code is more or less the same as without generics!
> 
> It makes me wonder if the API would be more maintainable with:
> 
>   typedef struct {
>       QemuLockUnlockFunc *lock;
>       QemuLockUnlockFunc *unlock;
>   } LockableOps;
> 
>   extern const LockableOps co_mutex_lockable_ops;
>   extern const LockableOps qemu_spin_lockable_ops;
>   ...
> 
> The user passes in the appropriate LockableOps instance for their type
> and generics are not needed.
> 
> This approach means future changes do not require digging through the
> macros to understand how this stuff works.

The difference between the two is that, once we use it for lock guards,
the compiler is able to see constant function pointers and inline
everything.  If you use LockableOps, it doesn't.

Paolo

> Maybe I've missed something?
> 
> Stefan
> 
