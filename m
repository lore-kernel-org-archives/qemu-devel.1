Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea2Zl-0007OU-Qe
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea2Zh-0005UU-Uk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:53:05 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:45271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ea2Zh-0005TZ-OH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:53:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id i186so13325864wmi.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:53:01 -0800 (PST)
References: <2465248.BadtJazF69@wirbelwind>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2177d773-9d69-f432-9353-4553e098cf1f@redhat.com>
Date: Fri, 12 Jan 2018 17:52:57 +0100
MIME-Version: 1.0
In-Reply-To: <2465248.BadtJazF69@wirbelwind>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net, qemu-devel@nongnu.org

On 12/01/2018 17:19, Steven Seeger wrote:
> A good example of this would be that say I have an interrupt that occurs every 
> second. If I were to print out the virtual time that interrupt occurs in the 
> device model, I should see a time of:
> 
> 1.000000
> 2.000000
> 3.000000
> 4.000000
> 
> etc
> 
> Instead, I see:
> 
> 1.000000
> 2.000013
> 3.000074
> 4.000022

What is the guest doing in the meanwhile?

> When the timer function is called in the device model, I arm the timer again 
> with qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL + 1000000000ULL) and expect this 
> time to be exaclty 1 second of virtual time later.
> 
> Either the virtual time is increasing without instructions executing or the 
> granularity of when the timer is serviced relative to virtual time is not 
> exact. I think the latter is happening. Is this because a tcg codeblock must 
> execute completely and this causes increases in virtual time based on the 
> number of instructions in that block, and the number of instructions varies?

virtual time increases only when instructions are executed, or when the
CPUs are idle (in the latter case, behavior depends on "-icount sleep":
if on, it increases at the same pace as real time, if off, it jumps
immediately to the next deadline).

Paolo
