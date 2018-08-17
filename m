Received: from eggs.gnu.org ([2001:4830:134:3::10]:43678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgFe-0007tT-NW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgFZ-0006eB-0X
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:01:22 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<20180802144834.520904-5-eblake@redhat.com>
	<760e8c65-c74b-7c22-37cc-50638f03a3b8@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73f458e5-e2fa-df8a-6a21-085f89dd594a@redhat.com>
Date: Fri, 17 Aug 2018 10:01:10 -0500
MIME-Version: 1.0
In-Reply-To: <760e8c65-c74b-7c22-37cc-50638f03a3b8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] nbd/client: Deal with unaligned size
 from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/17/2018 08:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 02.08.2018 17:48, Eric Blake wrote:
>> When a server advertises an unaligned size but no block sizes,
>> the code was rounding up to a sector-aligned size (a known
>> limitation of bdrv_getlength()), then assuming a request_alignment
>> of 512 (the recommendation of the NBD spec for maximum portability).
>> However, this means that qemu will actually attempt to access the
>> padding bytes of the trailing partial sector.
>>
>> An easy demonstration, using nbdkit as the server:
>> $ nbdkit -fv random size=1023
>> $ qemu-io -r -f raw -c 'r -v 0 1023' nbd://localhost:10809
>> read failed: Invalid argument
>>
>> because the client rounded the request up to 1024 bytes, which
>> nbdkit then rejected as beyond the advertised size of 1023.
>>
>> Note that qemu as the server refuses to send an unaligned size, as
>> it has already rounded the unaligned image up to sector size, and
>> then happily resizes the image on access (at least when serving a
>> POSIX file over NBD).
>>
>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

This patch is not a full solution. It fixes things so that a client 
accessing the first half of the final sector no longer rounds things up 
and chokes the server, but does not prevent a client from attempting to 
access the second half of the final sector (where that access still 
reaches the server).  I probably need yet another patch, similar to 
Rich's 'nbdkit --filter truncate', where reads of the trailing hole 
created by qemu's rounding are padded to NUL without asking the server, 
and where writes are ignored if all zero or cause ENOSPACE if nonzero.

Or, a much bigger patch series to make qemu quit rounding size up :) 
(I'd like to get there someday, but it's faster to kick out the quick 
patch for just NBD than to audit the entire block stack)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
