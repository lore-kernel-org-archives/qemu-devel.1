Received: from eggs.gnu.org ([2001:4830:134:3::10]:58687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3TS-0000mk-7Z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3TO-0002MR-UD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:16:14 -0500
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-R0aq7Sp6P2TYrMDE0p0ewwpuXPp6=RzF1bU11FQwJxA@mail.gmail.com>
	<8d49363d-7569-e95d-1d06-17a572c922db@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab218589-ebb1-b7dd-0e99-3db89d6a2f28@redhat.com>
Date: Wed, 14 Feb 2018 14:15:53 -0600
MIME-Version: 1.0
In-Reply-To: <8d49363d-7569-e95d-1d06-17a572c922db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 02/14/2018 02:00 PM, Thomas Huth wrote:
> On 14.02.2018 19:33, Peter Maydell wrote:
>> On 14 February 2018 at 17:31, Thomas Huth <thuth@redhat.com> wrote:
>>> When running configure with --with-pkgversion=foo there is no
>>> space anymore between the version number and the parentheses:
>>>
>>> $ m68k-softmmu/qemu-system-m68k -version
>>> QEMU emulator version 2.11.50(foo)

It would be nice to document this as '--version' rather than '-version' 
(both work; but see our BiteSized task: 
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation)

>>
>> -- does this patch change the QMP reported string
>> unexpectedly?
> 
> Without my patch and with --with-pkgversion=foo :
> 
> { "execute": "query-version" }
> {"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": "(foo)"}}

Looks nice.  And the version info is ALSO passed as part of the initial 
handshake, even before you call query-version.

> 
> With my patch and with --with-pkgversion=foo :
> 
> { "execute": "query-version" }
> {"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": " (foo)"}}

Potential regression (arguably cosmetic, though)

> 
> Without my patch and without --with-pkgversion :
> 
> { "execute": "query-version" }
> {"return": {"qemu": {"micro": 50, "minor": 11, "major": 2}, "package": " (v2.11.0-1512-g02f4fbe)"}}

And that means we're already inconsistent, so your patch at least made 
things consistent,

> 
> Using the old QEMU version 67a1de0d19~1 with  --with-pkgversion=foo :
> 
> { "execute": "query-version" }
> {"return": {"qemu": {"micro": 50, "minor": 6, "major": 2}, "package": " (foo)"}}

and that means we've already "regressed", which further means:
- it definitely is cosmetic, if no one is complaining
- changing it to look nicer won't break anyone

> 
> So yes, this patch changes the behavior of query-version, but the new
> behavior is now the same behavior that you get without --with-pkgversion
> (i.e. a space is included) and it is the same as the behavior that we had
> in the past, before commit 67a1de0d19 has been merged. So I think this
> is the right way to go.
> Alternatively, we could maybe change query-version to always skip the
> initial space?

Yes, I like that option.

So, if I'm summarizing correctly, your v2 patch will have:

$ qemu --version
QEMU emulator version 2.11.50 (foo)

QMP query-version
{"return": {"qemu": {"micro": 50, "minor": 6, "major": 2}, "package": 
"(foo)"}}

regardless of whether --with-pkgversion was used during configure.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
