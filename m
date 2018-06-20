Received: from eggs.gnu.org ([2001:4830:134:3::10]:47259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVeID-0004iG-63
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVeI9-0001hW-6S
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:41:05 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fVeI8-0001hG-RR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:41:01 -0400
Received: by mail-wm0-x22e.google.com with SMTP id j15-v6so201183wme.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:41:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f16bb8b-2061-847e-9e17-0a8f80b18197@redhat.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
	<4f16bb8b-2061-847e-9e17-0a8f80b18197@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 20 Jun 2018 17:40:59 +0300
Message-ID: <CAKPgXcG-VU1rQA+MYPJ3Cba7HKvyRwktNnfyYf63CWxAYN9kAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Wed, Jun 20, 2018 at 11:13 AM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B406=E6=9C=8819=E6=97=A5 21:21, Sameeh Jubran wrote:
>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> The Berkeley Packet Filter has been in the kernel for a while now and I
>> think it is time that it is introduced to Qemu. This patch is an
>> infrastructure for any future usage of the BPF in Qemu.
>>
>> It is important to note that the tun driver had started supporting using
>> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
>>
>> At first, instead of adding the syscall wrappers, I wanted to integrate
>> libbpf
>> library which resides in the Linux source tree under tools/lib/bpf. It
>> appears
>> to be that by default it compiles to x64 on x64 arch - which can't be
>> integrated into Qemu  - and my attempts to compile the 32 bit versions
>> have
>> failed. What's more interesting is that the vendors don't provide this
>> library
>> in any package, which makes this library a nasty dependency.
>>
>> Please share your thoughts :)
>>
>
> I wonder, instead of a generic eBPF support, can we have a limited but
> sufficient eBPF suppor for TAP only (see dpdk tap driver)? E.g if we only
> do bytecode loading, there's no need for e.g map update helpers.
>
That can do, I am actually using the map update helpers in the code as I am
using it to pass RSS configuration to the kernel program. The motive behind
adding the code this way is to add it as an infrastructure that others can
use in the future.

BTW I think I made a mistake, as it turns out I can add libbpf and it is
much neater than adding the syscall wrappers this way as the code is taken
straight from the linux kernel and can be updated easily using the
scripts's tool - update-linux-headers.sh. I'll prepare the patches and send
them soon.

>
> Thanks
>
>
>
>> Sameeh Jubran (1):
>>    Add BPF support to qemu
>>
>>   MAINTAINERS                     |   7 +
>>   bpf/Makefile.objs               |   1 +
>>   bpf/bpf_syscall.c               |  98 ++++++
>>   include/bpf/bpf_syscall.h       |  35 +++
>>   linux-headers/linux/bpf.h       | 673 ++++++++++++++++++++++++++++++
>> ++++++++++
>>   scripts/update-linux-headers.sh |   3 +-
>>   6 files changed, 816 insertions(+), 1 deletion(-)
>>   create mode 100644 bpf/Makefile.objs
>>   create mode 100644 bpf/bpf_syscall.c
>>   create mode 100644 include/bpf/bpf_syscall.h
>>   create mode 100644 linux-headers/linux/bpf.h
>>
>>
>


--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
