Received: from eggs.gnu.org ([2001:4830:134:3::10]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotgA-0005ZE-43
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotg5-0004kd-4M
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cotg4-0004kJ-UG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:20:29 -0400
References: <20170227164950.15062-1-pbonzini@redhat.com>
	<20170227164950.15062-2-pbonzini@redhat.com>
	<CAFEAcA9Ec3e1CHDHRFKtfN7w3Fh4=GVuo8C-9mpwYnpYwFNNYA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ef6761f-5141-35f5-c9ff-e6279d95d633@redhat.com>
Date: Fri, 17 Mar 2017 16:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Ec3e1CHDHRFKtfN7w3Fh4=GVuo8C-9mpwYnpYwFNNYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 06/17] cpus: remove ugly cast on
 sigbus_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 17/03/2017 16:08, Peter Maydell wrote:
> On 27 February 2017 at 16:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The cast is there because sigbus_handler is invoked via sigfd_handler.
>> But it feels just wrong to use struct qemu_signalfd_siginfo in the
>> prototype of a function that is passed to sigaction.
>>
>> Instead, do a simple-minded conversion of qemu_signalfd_siginfo to
>> siginfo_t.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> +    } else if (info->ssi_signo == SIGIO) {
>> +        si.si_band = info->ssi_band;
>> +    }
> 
> This doesn't build on OpenBSD:
> 
> In file included from /usr/include/sys/signal.h:107:0,
>                  from /usr/include/signal.h:38,
>                  from /root/qemu/include/qemu/osdep.h:86,
>                  from /root/qemu/util/oslib-posix.c:29:
> /root/qemu/util/oslib-posix.c: In function 'sigaction_invoke':
> /root/qemu/util/oslib-posix.c:713:12: error: 'union <anonymous>' has
> no member named '_file'
>          si.si_band = info->ssi_band;
>             ^
> 
> I dunno how much we care.

It's marked as obsolescent in POSIX, so it is sane to remove it.  I'll
send a patch.

Paolo
