Received: from eggs.gnu.org ([2001:4830:134:3::10]:60917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9bb3-0000f3-Ac
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9bb2-0000qc-6H
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:53:41 -0400
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
	<CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
	<CAFEAcA8gYwFZynMyiEHf+VPbaBerA9JTUPAHsipEvOqkBjHxMQ@mail.gmail.com>
	<20181008164026.GD4604@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12068340-1ce5-7cf1-afb2-94f3cd2fd109@redhat.com>
Date: Mon, 8 Oct 2018 14:53:32 -0500
MIME-Version: 1.0
In-Reply-To: <20181008164026.GD4604@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 10/8/18 11:40 AM, Kevin Wolf wrote:
> Am 08.10.2018 um 17:43 hat Peter Maydell geschrieben:
>> Looking at the backtraces I'm wondering if this is the result of
>> an implicit reliance on the order in which per-thread destructors
>> are called (which is left unspecified by POSIX) -- the destructor
>> function qemu_thread_atexit_run() is called after some other
>> destructor, but accesses its memory.
>>
>> Specifically, the memory it's trying to read looks like
>> the __thread local variable pollfds_cleanup_notifier in
>> util/aio-posix.c. So I think what is happening is:
>>   * util/aio-posix.c calls qemu_thread_atexit_add(), passing
>>     it a pointer to a thread-local variable pollfds_cleanup_notifier
>>   * qemu_thread_atexit_add() works by arranging to run the
>>     notifiers when its 'exit_key' variable's destructor is called
>>   * the destructor for pollfds_cleanup_notifier runs before that
>>     for exit_key, and so the qemu_thread_atexit_run() function
>>     ends up touching freed memory
>>
>> I'm pretty confident this analysis of the problem is correct:
>> unfortunately I have no idea what the right way to fix it is...
> 
> Yes, I agree with your analysis. If __thread variables can be destructed
> before pthread_key_create() destructors are called (and in particular if
> the former are implemented in terms of the latter), this implies at
> least two rules:
> 
> 1. The Notfier itself can't be a TLS variable
> 
> 2. The notifier callback can't access any TLS variables
> 
> Of course, with these restrictions, qemu_thread_atexit_*() with its
> existing API is as useless as it could be.
> 
> The best I can think of at the moment would be to use a separate
> pthread_key_create() (and therefore a separate destructor) for
> registering each TLS variable, so that the destructor always gets a
> valid pointer. Maybe move all __thread variables of a file into a single
> malloced struct to make it more managable (we could then keep a __thread
> pointer to it for convenience, but only free the struct with the pointer
> passed by the pthread_key destructor so that we don't have to access
> __thread variables in the destructor).

pthread_key_create() says that a when a destructor is triggered, it sets 
the value of the key to NULL; but that you can once again set the key 
back to a non-NULL value, and that the implementation will loop at least 
PTHREAD_DESTRUCTOR_ITERATIONS over all destructors or until it has 
convinced the destructors to leave values at NULL.  Thus, while you 
cannot guarantee ordering between destructors within a single iteration 
of the cleanup loop, you CAN do some sort of witness locking or 
down-counter where a destructor purposefully calls pthread_setspecific() 
to revive the value to survive into the next iteration of destructor 
calls, for variables which are known to be referenced by other 
destructors while the witness count is still high enough, as a way of 
imposing order between loops.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
