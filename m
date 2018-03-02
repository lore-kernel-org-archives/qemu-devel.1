Received: from eggs.gnu.org ([2001:4830:134:3::10]:56929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ermTl-0002g0-1J
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ermTh-0008Cq-2X
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:20:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ermTg-0008CW-To
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:20:09 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<20180301092046.7cb959d8@w520.home>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e768c483-5830-c044-fd61-fac43b2f6c4d@redhat.com>
Date: Fri, 2 Mar 2018 09:20:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180301092046.7cb959d8@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Cc: Jim Mussared <jim@groklearning.com>, Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>, Richard Henderson <rth@twiddle.net>

On 03/01/2018 10:20 AM, Alex Williamson wrote:
> On Thu,  1 Mar 2018 10:08:06 +0300
> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> wrote:
> 
>> basename(3) and dirname(3) modify their argument and may return
>> pointers to statically allocated memory which may be overwritten by
>> subsequent calls.
>> g_path_get_basename and g_path_get_dirname have no such issues, and
>> therefore more preferable.
> 
> I think it's quite a bit arguable whether it's preferable, afaict there
> are no bugs fixed here.  The basic functions are being used correctly
> and are more conservative of memory usage than the glib variants.  In
> several cases below the basic functions seem far more efficient and we
> don't need to worry about freeing unnecessarily allocated memory, the
> diffstat seems to attest to this.  Is the inefficiency and possibility
> of leaking unintentionally allocated memory a statistical improvement
> over the claimed perils of these absolutely standard and well known
> functions?

The standard functions may be well-known, but as currently standardized 
are not very reliably useful in a multi-threaded program.  However, the 
standard WILL be improved in the future to require a saner standardized 
implementation (the proposed changes to the standard remove the ability 
for basename()/dirname() to return NULL, remove the allowance for 
non-thread-safe returns, and document more fully that the returned 
pointer will be back to the input string in all but a few corner cases 
which return const char *):

http://austingroupbugs.net/view.php?id=1064

> 
> I know mine is a losing battle against glib, but the changelog might as
> well just say "Succumb to glib" because I fail to see that there's
> actually an improvement here.  If Paolo wants to take this,

One thing that the glib functions can do that the standardized version 
cannot do is handle drive letters on DOS-like systems (doesn't affect 
our builds on Linux or BSD, but may matter to mingw builds).  But you 
are right that the glib functions are more malloc-heavy than the (fixed) 
standardized functions, so it becomes a trade-off of how likely the libc 
functions are to comply with the tighter future standard version (that 
is actually somewhat useful) vs. the current standard version (that is a 
piece of trash because it has too many loopholes).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
