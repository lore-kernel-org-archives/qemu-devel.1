Received: from eggs.gnu.org ([2001:4830:134:3::10]:32958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGmY-0002ff-GM
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGmT-0000cG-M0
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:07:22 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGmT-0000bb-FG
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:07:17 -0400
Received: by mail-qk0-x244.google.com with SMTP id m84so1315996qki.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 07:07:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
	<48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
Date: Thu, 3 Aug 2017 11:07:13 -0300
MIME-Version: 1.0
In-Reply-To: <48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 08/03/2017 10:55 AM, Eric Blake wrote:
> On 08/03/2017 08:34 AM, Philippe Mathieu-Daudé wrote:
>> Hi Greg,
>>
>> On 08/02/2017 11:47 AM, Greg Kurz wrote:
>>> Building QEMU on fedora26 with the latest gcc package fails:
>>>
>>>     CC      ppc64-softmmu/target/ppc/kvm.o
>>> In file included from include/sysemu/hw_accel.h:16:0,
>>>                    from target/ppc/kvm.c:31:
>>> target/ppc/kvm.c: In function ‘kvmppc_booke_watchdog_enable’:
>>> include/sysemu/kvm.h:449:35: error: ‘args_tmp[i]’ may be used
>>> uninitialized
> 
>>
>> This sizeof() use looks unnatural to me. I wonder why not use size_t,
>> since this is about sizeof()/ARRAY_SIZE(). The problem seems to come
>> from the commit this cast was introduced (61c7bbd236):
>>
>> target-ppc/kvm.c:1302:21: error: comparison of unsigned expression < 0
>> is always false [-Werror=type-limits]
>>
>> So I'd rather suggest this code, which looks more natural to read to me:
>>
>>      if (ARRAY_SIZE(args_tmp)) {
>>          for (i = 0; i < ARRAY_SIZE(args_tmp) && ...

Oops I forgot to suggest size_t i.

> 
> For that matter, the existing code is doing:
> 
> int i;
> i < (int)ARRAY_SIZE(args_tmp)
> 
> but wouldn't that be better as:
> 
> size_t i;
> i < ARRAY_SIZE(args_temp)
> 
> I guess we have both the old compilers (per commit 61c7bbd2) and the new
> to worry about; although I was unable to reproduce it on Fedora 26 on
> x86_64 (is this an architecture-dependent compiler bug?)
> 

Ok so let's stop losing time about compiler incoherent warnings, using 
-Wno-type-limits for GCC < 5...
So we can keep a sane/understandable codebase, using size_t and no (int) 
cast.

Phil.
