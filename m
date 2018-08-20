Received: from eggs.gnu.org ([2001:4830:134:3::10]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frq9w-0006bV-V0
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frq9l-0008TO-Mv
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:15 -0400
References: <20180818025653.21192-1-f4bug@amsat.org>
	<66dfe354-9c2c-8642-a905-03155555fe99@redhat.com>
	<a812530c-ad1b-f5ff-6e15-82227cb76c79@redhat.com>
	<2fd04596-a8a0-889f-239d-92853c12c6aa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d91d7e2-938d-dbbe-5a11-edf48d4e0fc8@redhat.com>
Date: Mon, 20 Aug 2018 14:48:01 -0500
MIME-Version: 1.0
In-Reply-To: <2fd04596-a8a0-889f-239d-92853c12c6aa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 08/20/2018 12:16 PM, Thomas Huth wrote:

>>
>> Maybe really set it to zero (memset) before using the g_strlcpy? I am
>> not a fan of disabling warnings, but if you think this is
>> easier/cleaner, let's go for that.

I'm not a fan of strlcpy in general (by the time you've properly set it 
up to detect/report/avoid truncation errors, you've added more 
boilerplate code than you would have by just doing memcpy() yourself).

> 
> FWIW, that new warning from GCC is IMHO just annoying. I had the same
> problem in the SLOF sources, too:
> 
> https://github.com/aik/SLOF/commit/d8a9354c2a35136
> 
> The code with strncpy was perfectly valid before, but to get rid of the
> warning, I replaced it with a more cumbersome memcpy instead (and mad
> sure that the memory is already cleared earlier in that function). Now
> seeing that the problem with strncpy pops up here, too, I think it would
> maybe be better to shut up the warning of GCC, since it's clearly GCC
> who's wrong here.

gcc is not necessarily wrong, as it CAN catch real erroneous uses of 
strncpy().  It's just that 99% of the time, strncpy() is the WRONG 
function to use, and so the remaining few cases where it actually does 
what you want are so rare that you have to consult the manual anyways. 
If nothing else, the gcc warning is making people avoid strncpy() even 
where it is safe (which is not a bad thing, in my opinion, because the 
contract of strncpy() is so counter-intuitive).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
