Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eca1j-0003eO-09
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eca1e-0005Op-IB
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:00:26 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eca1e-0005OT-D7
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:00:22 -0500
Received: by mail-qt0-x242.google.com with SMTP id f4so5386597qtj.6
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:00:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<CAFEAcA9dYzqTQTseZQfa0bm+H8tjCdhjuJOSgCx-KB14jBWDUA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c27baf83-d85c-2d9f-5d8a-7f2ecf6d5976@amsat.org>
Date: Fri, 19 Jan 2018 14:00:16 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dYzqTQTseZQfa0bm+H8tjCdhjuJOSgCx-KB14jBWDUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/19/2018 01:34 PM, Peter Maydell wrote:
> On 19 January 2018 at 16:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> We have armel/armhf/powerpc hosts failing since this pull due to commit
>> 3be98be4e9f.
>>
>> Those target are currently tested on Shippable CI, eventually adding an
>> IRC bot we could notice.
>>
>> I know companies using QEMU system in embedded armel/armhf hosts, I
>> don't know about the ppc32 hosts.
>> This is however unlikely the migration features are used there.
> 
> I have ppc64 and armhf in my test set, so clearly they don't all
> fail all the time. What are the failure symptoms ?

I misread Shippable report with the report trying to fix this,
so indeed on /master, only ppc32 is broken, the symtom is linking failing:

https://app.shippable.com/github/qemu/qemu/runs/665/10/console

../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:717: undefined
reference to `__atomic_fetch_add_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:738: undefined
reference to `__atomic_fetch_add_8'
../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin':
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:651: undefined
reference to `__atomic_exchange_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:652: undefined
reference to `__atomic_exchange_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:661: undefined
reference to `__atomic_exchange_8'
collect2: error: ld returned 1 exit status
Makefile:193: recipe for target 'qemu-system-ppc' failed
make[1]: *** [qemu-system-ppc] Error 1
Makefile:391: recipe for target 'subdir-ppc-softmmu' failed
make: *** [subdir-ppc-softmmu] Error 2

../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:717: undefined
reference to `__atomic_fetch_add_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:738: undefined
reference to `__atomic_fetch_add_8'
../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin':
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:651: undefined
reference to `__atomic_exchange_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:652: undefined
reference to `__atomic_exchange_8'
/root/src/github.com/qemu/qemu/migration/postcopy-ram.c:661: undefined
reference to `__atomic_exchange_8'
collect2: error: ld returned 1 exit status
Makefile:193: recipe for target 'qemu-system-ppcemb' failed
make[1]: *** [qemu-system-ppcemb] Error 1
Makefile:391: recipe for target 'subdir-ppcemb-softmmu' failed
make: *** [subdir-ppcemb-softmmu] Error 2

The armel/armhf failures are when I apply this patch:

http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04873.html

In file included from
/root/src/github.com/philmd/qemu/include/qemu/osdep.h:36:0,
                 from migration/postcopy-ram.c:19:
migration/postcopy-ram.c: In function 'mark_postcopy_blocktime_begin':
/root/src/github.com/philmd/qemu/include/qemu/compiler.h:86:30: error:
static assertion failed: "not expecting: sizeof(*&dc->last_begin) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
                              ^
/root/src/github.com/philmd/qemu/include/qemu/atomic.h:183:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
     ^~~~~~~~~~~~~~~~~
migration/postcopy-ram.c:651:5: note: in expansion of macro 'atomic_xchg'
     atomic_xchg(&dc->last_begin, now_ms);
     ^~~~~~~~~~~
/root/src/github.com/philmd/qemu/include/qemu/compiler.h:86:30: error:
static assertion failed: "not expecting:
sizeof(*&dc->page_fault_vcpu_time[cpu]) > ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
                              ^
/root/src/github.com/philmd/qemu/include/qemu/atomic.h:183:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
     ^~~~~~~~~~~~~~~~~
migration/postcopy-ram.c:652:5: note: in expansion of macro 'atomic_xchg'
     atomic_xchg(&dc->page_fault_vcpu_time[cpu], now_ms);
     ^~~~~~~~~~~
/root/src/github.com/philmd/qemu/include/qemu/compiler.h:86:30: error:
static assertion failed: "not expecting:
sizeof(*&dc->page_fault_vcpu_time[cpu]) > ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
                              ^
/root/src/github.com/philmd/qemu/include/qemu/atomic.h:183:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
     ^~~~~~~~~~~~~~~~~
migration/postcopy-ram.c:661:9: note: in expansion of macro 'atomic_xchg'
         atomic_xchg(&dc->page_fault_vcpu_time[cpu], 0);
         ^~~~~~~~~~~
/root/src/github.com/philmd/qemu/rules.mak:66: recipe for target
'migration/postcopy-ram.o' failed
make: *** [migration/postcopy-ram.o] Error 1
make: *** Waiting for unfinished jobs....
