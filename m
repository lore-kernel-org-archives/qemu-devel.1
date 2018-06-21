Received: from eggs.gnu.org ([2001:4830:134:3::10]:40928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fW6z6-0002Qc-MW
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fW6z4-0008VG-Qp
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:19:16 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fW6z4-0008V5-Ec
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:19:14 -0400
Received: by mail-qt0-x241.google.com with SMTP id a18-v6so4227942qtj.4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:19:14 -0700 (PDT)
References: <20180621102153.28443-1-danielhb413@gmail.com>
	<20180621201923.GA27759@kermit-br-ibm-com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <9209353e-4867-bee1-efe5-6ba92f49ef2f@gmail.com>
Date: Thu, 21 Jun 2018 18:19:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180621201923.GA27759@kermit-br-ibm-com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] QGA: systemd
 hibernate/suspend/hybrid-sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com

Hi,

On 06/21/2018 05:19 PM, Murilo Opsfelder Araujo wrote:
> On Thu, Jun 21, 2018 at 07:21:47AM -0300, Daniel Henrique Barboza wrote:
>> changes in v2 from Marc-Andre Lureau review:
>> - use error_free() accordingly
>> - use g_spawn_sync() instead of fork() in run_process_child()
>> - previous version link:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05499.html
>>
>>
>> This series adds systemd suspend support for QGA. Some newer
>> guests don't have pmutils anymore, leaving us with just the
>> Linux state file mechanism to suspend the guest OS, which does
>> not support hybrid-sleep. With this implementation, QGA is
>> now able to hybrid suspend newer guests again.
>>
>> Most of the patches are cleanups in the existing suspend code,
>> aiming at both simplifying it and making it easier to extend
>> it with systemd.
>>
>>
>> Daniel Henrique Barboza (6):
>>    qga: refactoring qmp_guest_suspend_* functions
>>    qga: bios_supports_mode: decoupling pm-utils and sys logic
>>    qga: guest_suspend: decoupling pm-utils and sys logic
>>    qga: removing switch statements, adding run_process_child
>>    qga: systemd hibernate/suspend/hybrid-sleep support
>>    qga: removing bios_supports_mode
> Hi, Daniel.
>
> Your patches look good, just some minor comments about how they're
> organized and coding style, if you allow me.
>
> I'd suggest to introduce the new API, functions, and typedef at first
> (preferably one thing per patch to easier the review) without wiring
> them up.
>
> After the new stuff is ready to use, I'd wire them up (one per patch)
> and update/remove old API they're replacing.
>
> Introducing the new API and wiring it up later makes it easier to
> review.  For example, bios_supports_mode() is changed by patch 1/6, then
> it's moved around by patch 3/6, and finally removed by patch 6/6.

The idea was to present the patches as incremental cleanups from
the existing code up to the point where the new API can be gracefully
added.

I think there's a point to be made about squashing all cleanups patches
in a single (or fewer) patches, but I believe it would be too annoying to
review that many changes at once - things started very coupled with
QMP functions hard-wiring pmutils binaries as parameters to the callers
(bios_support_mode and guest_suspend). If you compare that to the
result up to patch 4/6 you'll see that a lot was changed, and systemd
support was yet to be added.

Following the same incremental idea, patch 6/6 was created after I've
noticed that bios_support_mode was too sub-optimal after adding systemd
support. Yes, one can say that it was already sub-optimal before and it
should be removed right at the start, but I didn't bothered with this
change at that point due to other cleanups.

Anyway, if more people feels like the series structure should be changed
I can re-send the series again.

>
> Do we need an empty line after opening a switch statement?  I'd drop it,
> as seen in other parts of the code.

Didn't noticed it. If I end up respinning this series I'll remove it.

>
> Does run_process_child() fit better under util/, or another place where
> it can be shared throughout the code, if that's the case?

As I've mentioned in the commit message of patch 5/6, one step at a
time. If the function can be used in other places inside commands-posix.c
(IMO a fair assumption, but I didn't look it up carefully), then we could
first use this new function inside commands-posix.c and, if the function
turns out to be useful elsewhere, moved it to /util.

I didn't want to sound "pretentious" by adding a new function to /util
just because it is being used by the code I'm sending and because I
have a hunch that it will be useful to everyone else.



Thanks,


Daniel

>
> Cheers
> Murilo
>
