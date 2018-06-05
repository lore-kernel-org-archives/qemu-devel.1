Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQ7s8-0006ZF-FA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQ7s3-0007X5-A6
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:03:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQ7s3-0007WW-1y
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:03:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so3386188wmd.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 02:03:14 -0700 (PDT)
References: <1528143278-247932-1-git-send-email-imammedo@redhat.com>
	<20180605010413.GF3184@localhost.localdomain>
	<20180605102703.6fdee3c5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10655fde-934e-7762-4114-f3b19a7319e2@redhat.com>
Date: Tue, 5 Jun 2018 11:02:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180605102703.6fdee3c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: make default main_loop_wait()
 timeout independed of slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, jan.kiszka@siemens.com, mreitz@redhat.com, mprivozn@redhat.com

On 05/06/2018 10:27, Igor Mammedov wrote:
>> I don't get this part.  Why default infinite timeout doesn't make
>> sense?  Why would a 1 second timeout make sense?
>
> I've meant that there is no reason for infinite timeout,
> and 1sec is good as any other finite one.
> Hence we can unify timeout with/without -nodefaults, by moving 1sec
> constant from slirp to main_loop_wait() and simplify code a bit.

The event loop is supposed to wake up when there is an event.  If there
is no event, the timeout should be infinite, otherwise you're just
introducing unnecessary BQL contention and/or papering over bugs.  So I
agree with Eduardo, I'm not sure what you mean when you say that the
infinite timeout makes no sense.

In fact, the 1-second limit on the SLIRP timeout was introduced in
commit a42e9c4188 ("slirp: set mainloop timeout with more precise
value", 2013-09-17) with no justification in the commit message.  The
desirable fix would be to remove that limit, not to push it up the stack
and actrivate it for all executions of QEMU.

Paolo
