Received: from eggs.gnu.org ([2001:4830:134:3::10]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6f9a-0006Pm-GW
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6f9Z-0005LD-Sl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:28:22 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6f9Z-0005Kn-Mx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:28:21 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 142so9663277wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:28:21 -0700 (PDT)
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-4-alex.bennee@linaro.org>
	<8b648c73-ecfc-7a13-fc98-be349dcfceac@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8b648c73-ecfc-7a13-fc98-be349dcfceac@redhat.com>
Date: Fri, 05 May 2017 16:28:59 +0100
Message-ID: <87shkjmif8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 3/9] cpus: only take BQL for
 sleeping threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/05/2017 12:38, Alex Bennée wrote:
>>
>>      while (qemu_tcg_should_sleep(cpu)) {
>> +        qemu_mutex_lock_iothread();
>>          stop_tcg_kick_timer();
>>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>> +        qemu_mutex_unlock_iothread();
>>      }
>
> This is racy.  You need to recheck the condition under the lock, or to
> switch from QemuCond to QemuEvent (then you still need to check the
> condition twice, the second between qemu_event_reset and qemu_event_wait).


Doh of course, being a bit too eager there ;-)

--
Alex Bennée
