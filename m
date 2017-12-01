Received: from eggs.gnu.org ([2001:4830:134:3::10]:56989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnxj-000168-J3
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnwo-0003UI-9r
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:14:51 -0500
References: <20171130164401.29221-1-kwolf@redhat.com>
	<ce174622-1df0-bf86-452e-280dd3f7e068@redhat.com>
	<20171130182746.GF4039@localhost.localdomain>
	<cb98da75-ca77-edce-6384-d612380e4e3c@redhat.com>
	<20171201124131.GD4147@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <092b8064-40b3-d8fb-45d1-fccb13d2d497@redhat.com>
Date: Fri, 1 Dec 2017 07:42:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171201124131.GD4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Formats don't need CONSISTENT_READ
 with NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On 12/01/2017 06:41 AM, Kevin Wolf wrote:
>>
>> I guess it is the block of writes/resizes that prevents metadata from
>> getting inconsistent; CONSISTENT_READ does indeed make more sense if
>> interpreted solely in light of will the guest read consistent data
>> (and not will the format layer see consistent contents from the
>> protocol layer).
> 
> Yes, that's what the write/resize locks are meant for.
> 
> Consistent read is more about "this image may not contain the useful
> data you're expecting".
> 

> 
>> I'm not opposed to your patch, but am trying to make sure that I'm not
>> overlooking any problem before giving R-b.  Maybe it's just that the
>> comment needs updating in v2.
> 
> Do you have a suggestion for the comment?

Perhaps:

Commit 1f4ad7d fixed 'qemu-img info' for raw images that are currently
in use as a mirror target. It is not enough for image formats, though,
as these still unconditionally request BLK_PERM_CONSISTENT_READ.

As this permission is geared towards whether the guest-visible data is 
consistent, and has no impact on whether the metadata is sane, and 
'qemu-img info' does not read guest-visible data (except for the raw 
format), it makes sense to not require BLK_PERM_CONSISTENT_READ if there 
is not going to be any guest I/O performed, regardless of image format.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
