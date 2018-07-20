Received: from eggs.gnu.org ([2001:4830:134:3::10]:42428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYNt-00032m-Q4
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYNt-0001Ez-33
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:36:01 -0400
References: <20180719034118.27741-1-famz@redhat.com>
	<6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
	<20180720082427.GG29900@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b2000e0-a0ed-b096-422f-ef6ac31b1578@redhat.com>
Date: Fri, 20 Jul 2018 11:35:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180720082427.GG29900@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Don't lock /dev/null
 and /dev/zero automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/20/2018 03:24 AM, Fam Zheng wrote:
> On Thu, 07/19 13:57, John Snow wrote:
>> Should we instead modify the test in this case to not attempt to take a
>> lock on a device we know cannot meaningfully store state, or is it your
>> preference to attempt to maintain such a list in the raw driver itself?
>>
>> I guess we never want QEMU to try to lock things like /dev/zero, but I
>> don't know if there are more such pseudo-devices we should never try to
>> lock and if so, what common property unifies them such that we don't
>> have to maintain a list.
> 
> They are 0 sized anyway so I only expect them to be used in test cases like the
> one we're fixing. So this really doesn't matter.  An exceptional one would be
> /dev/nullb* but that is not used in real world either.

I'm not familiar with /dev/nullb* - is that a typo?

$ ll /dev/nullb*
ls: cannot access '/dev/nullb*': No such file or directory


> 
> I'm not trying to maintain a complete list (e.g. /dev/urandom and /dev/nullb*
> are missing), this patch is just trying to make writing test code easier.

/dev/urandom is also a character device, and also fits in my heuristic 
that we likely only care about locking of block devices.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
