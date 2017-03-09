Received: from eggs.gnu.org ([2001:4830:134:3::10]:60566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clmJe-0005gv-SB
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clmJb-0007yb-Qg
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:52:26 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1clmJb-0007yP-Ip
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:52:23 -0500
Received: by mail-pf0-x243.google.com with SMTP id o126so5397241pfb.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 16:52:23 -0800 (PST)
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
Date: Thu, 9 Mar 2017 11:52:17 +1100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 09/03/17 01:21, Peter Maydell wrote:
> On 8 March 2017 at 13:49, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> After 6e85fce0225f "dtc: Update requirement to v1.4.2" QEMU stopped
>> compiling in CentOS7:
>>
>> In file included from /home/aik/p/qemu/dtc/libfdt/libfdt.h:54:0,
>>                  from /home/aik/p/qemu/device_tree.c:30:
>> /home/aik/p/qemu/dtc/libfdt/libfdt_env.h:64:0: error: "__bitwise" redefined [-Werror]
>>  #define __bitwise
>>  ^
>> In file included from /usr/include/asm/ptrace.h:27:0,
>>                  from /usr/include/asm/sigcontext.h:11,
>>                  from /usr/include/bits/sigcontext.h:27,
>>                  from /usr/include/signal.h:340,
>>                  from /home/aik/p/qemu/include/qemu/osdep.h:86,
>>                  from /home/aik/p/qemu/device_tree.c:14:
>> /usr/include/linux/types.h:21:0: note: this is the location of the previous definition
>>  #define __bitwise __bitwise__
>>  ^
>> cc1: all warnings being treated as errors
>> make: *** [device_tree.o] Error 1
>> make: *** Waiting for unfinished jobs....
>>
>> The reason is that CentOS7 comes with libfdt 1.4.0 so QEMU tries using
>> the internal one which does not compile as CentOS7 comes with gcc v4.8.5
>> which reports warnings which it would not if the OS's libfdt was used
>> (libfdt_env.h has not changed between 1.4.0 and 1.4.2).
>>
>> gcc 6.2.0 from Ubuntu v16.10 handles this fine.
>>
>> This replaces -I with -isystem to suppress the warning (which turns
>> to an error because of -Werror).
> 
> Thanks for the bug report. I think it would be cleaner to fix this

Agree.

> by fixing the problem upstream in libfdt and then moving our
> submodule forward to the fixed version. (libfdt should not be
> defining __ prefixed symbols as these are reserved for the
> system.)

Also agree, regardless my proposal, libfdt should be fixed. However v2.9
won't compile on CentOS7 (and I suppose on RHEL7) which is a bit annoying.
And having "-isystem" makes some sense as these headers are normally system
ones and I'd think they should be treated the same way (i.e. path should be
included via -isystem vs. -I).



-- 
Alexey
