Received: from eggs.gnu.org ([2001:4830:134:3::10]:47524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef7RL-0001a8-Kt
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef7RK-0004v4-Ft
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:05:23 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:36353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef7RK-0004uk-9z
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:05:22 -0500
Received: by mail-ot0-x230.google.com with SMTP id f100so987694otf.3
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 09:05:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 16:39:31 +0000
Message-ID: <CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

On 26 January 2018 at 15:47, Wei Huang <wei@redhat.com> wrote:
>
>
> On 01/25/2018 02:05 PM, Dr. David Alan Gilbert wrote:
>> * Wei Huang (wei@redhat.com) wrote:
>>> innerloop:
>>>         /* clean cache because el2 might still cache guest data under KVM */
>>>         dc      civac, x2
>>
>> Can you explain a bit more about that please;  if it's guest
>> visible acorss migration, doesn't that suggest we need the cache clear
>> in KVM or QEMU?
>
> I think this is ARM specific. This is caused by the inconsistency
> between guest VM's data accesses and userspace's accesses (in
> check_guest_ram) at the destination:
>
> 1) Because uncacheable (guest) + cacheable (host) ==> uncacheable. So
> the data accesses from guest VM go directly into memory.
> 2) QEMU user space will use the cacheable version. So it is possible
> that data can come from cache, instead of RAM. The difference between
> (1) and (2) obviously can cause check_guest_ram() to fail sometimes.

I think the correct fix here is that your test code should turn
its MMU on. Trying to treat guest RAM as uncacheable doesn't work
for Arm KVM guests (for the same reason that VGA device video memory
doesn't work). If it's RAM your guest has to arrange to map it as
Normal Cacheable, and then everything should work fine.

thanks
-- PMM
