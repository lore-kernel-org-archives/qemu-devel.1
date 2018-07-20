Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYMP-0001l6-BZ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYMO-0008Fb-BH
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:34:29 -0400
References: <20180719034118.27741-1-famz@redhat.com>
	<6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f214e17-0daa-d865-f67e-576930e2ba87@redhat.com>
Date: Fri, 20 Jul 2018 11:34:19 -0500
MIME-Version: 1.0
In-Reply-To: <6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
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
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/19/2018 12:57 PM, John Snow wrote:
> 
> Should we instead modify the test in this case to not attempt to take a
> lock on a device we know cannot meaningfully store state, or is it your
> preference to attempt to maintain such a list in the raw driver itself?
> 
> I guess we never want QEMU to try to lock things like /dev/zero, but I
> don't know if there are more such pseudo-devices we should never try to
> lock and if so, what common property unifies them such that we don't
> have to maintain a list.

One potential common property: /dev/zero and /dev/null are character 
devices, rather than block devices.  Character devices in general don't 
make much sense for holding stateful images, so it may be as simple as 
gating our locking based on fstat() distinguishing which type of file we 
are accessing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
