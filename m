Received: from eggs.gnu.org ([2001:4830:134:3::10]:60957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBjAv-0006VO-Af
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBjAs-0000kO-5F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBjAs-0000kB-0Z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:51:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
	<ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
	<136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
	<87vacexcir.fsf@dusky.pond.sub.org>
	<230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
Date: Thu, 26 Apr 2018 17:51:08 +0200
In-Reply-To: <230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com> (Eric Blake's
	message of "Thu, 26 Apr 2018 09:48:03 -0500")
Message-ID: <8736zix8yb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Eric Blake <eblake@redhat.com> writes:

> On 04/26/2018 09:34 AM, Markus Armbruster wrote:
>>>
>>> Acerbic discovery of the day: @CpuInfoArch has "x86", while configure
>>> produces:
>>>
>>>   TARGET_NAME  TARGET_BASE_ARCH
>>>          i386              i386
>>>        x86_64              i386
>>>
>>> Note how "i386" does not match "x86".
>> 
>> Review fail.
>> 
>> Just three weeks ago, we could still have fixed query-cpus-fast...
>
> Actually, I think we still can.  We already documented in the 2.12
> release notes that the "arch" field of query-cpus-fast is known to be
> broken for all but "s390x" (which is really the only arch field that
> MUST be correct, as that is the only time we send additional
> information).  And introspection can easily see both the enum contents
> (if we add something) as well as any other additions to the
> query-cpus-fast output union (although that is less likely), to use
> those as a witness for whether qemu is new enough to have fixed the
> bogus "arch" values.  I'd argue that if we change things right now, with
> intent to include the change in 2.12.1, before people start relying on
> the bogus "arch" of 2.12, then we should feel free to make
> query-cpus-fast output whatever we want for all architectures other than
> "s390x", even if it changes the current output of "x86".

In other words, we managed to screw up query-cpus-fast sufficiently to
let us fix it even now.  Cool, let's do it!
