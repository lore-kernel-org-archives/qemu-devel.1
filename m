Received: from eggs.gnu.org ([2001:4830:134:3::10]:43727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccAl2-0000U6-M2
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccAkx-0002cP-RV
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:57:00 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccAkx-0002c4-Kh
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:56:55 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so259360693wmi.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:56:55 -0800 (PST)
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
	<87zihuw86q.fsf@linaro.org>
	<239d2e0e-2087-9135-8946-797d006968f9@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <239d2e0e-2087-9135-8946-797d006968f9@redhat.com>
Date: Fri, 10 Feb 2017 12:57:07 +0000
Message-ID: <87wpcyw6e4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/02/2017 13:18, Alex Bennée wrote:
>>> I think you can unlock/lock the iothread here, and also call
>>
>> The iothread is already unlocked by this point (see tcg_cpu_exec).
>
> Is this patch on top of the MTTCG branch?  If not, cpu_handle_exception
> runs with the iothread lock taken doesn't it?
>
>>> cpu_exec_end/start to work around the limitation in start_exclusive.
>>
>> While that seems right it also seems very messy as it inverts the calls
>> so far. I fear we may end up very confused in special casing. Is there a
>> cleaner way we can unwind this?
>
> I'm not sure what is messy...  cpu_exec_start/end and
> start/end_exclusive are fundamentally a rwlock.
>
> Doing
>
> 	cpu_exec_end
> 	start_exclusive
> 	...
> 	end_exclusive
> 	cpu_exec_start
>
> simply means temporarily upgrading the lock from read to write.

I mean messy from the point of reading the code where we reverse a
sequence done from higher up in the call chain. Maybe I'm being overly
picky because we aren't exactly on a hot path here anyway.

--
Alex Bennée
