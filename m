Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eNMsp-0002wn-SR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eNMsm-0004vZ-Qr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:56:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eNMsm-0004uX-Jq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:56:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id h1so11526608wre.12
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 09:56:19 -0800 (PST)
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
	<20171208153010.GD8998@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
Date: Fri, 8 Dec 2017 18:56:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171208153010.GD8998@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 08/12/2017 16:30, Stefan Hajnoczi wrote:
> On Fri, Dec 08, 2017 at 11:55:50AM +0100, Paolo Bonzini wrote:
> 
> The implementation is somewhat complex.  Please structure the header
> file so the public interfaces are clear and documented.  Move the
> implementation out of the way and mark it private.  That will make it
> easier for someone to figure out "how do I use lock-guard.h".

Right, unfortunately you pretty much have to place it in the header to
guarantee that everything is inlined.

>> diff --git a/include/qemu/lock-guard.h b/include/qemu/lock-guard.h
>> new file mode 100644
>> index 0000000000..e6a83bf9ee
>> --- /dev/null
>> +++ b/include/qemu/lock-guard.h
>> @@ -0,0 +1,103 @@
>> +#ifndef QEMU_LOCK_GUARD_H
>> +#define QEMU_LOCK_GUARD_H 1
>> +
>> +typedef void QemuLockGuardFunc(void *);
>> +typedef struct QemuLockGuard {
>> +    QemuLockGuardFunc *p_lock_fn, *p_unlock_fn;
>> +    void *lock;
>> +    int locked;
> 
> bool?

Yes.

>> +#define QEMU_WITH_LOCK(type, name, lock)                                   \
>> +    for (QEMU_LOCK_GUARD(type, name, lock);                                \
>> +         qemu_lock_guard_is_taken(&name);                                  \
>> +         qemu_lock_guard_unlock(&name))
> 
> I don't understand the need for the qemu_lock_guard_is_taken(&name)
> condition, why not do the following?
> 
>   for (QEMU_LOCK_GUARD(type, name, lock);
>        ;
>        qemu_lock_guard_unlock(&name))

Because that would be an infinite loop. :)

Paolo

> Also, the for loop means that break statements do not work inside
> QEMU_WITH_LOCK() { ... }.  This needs to be documented.
