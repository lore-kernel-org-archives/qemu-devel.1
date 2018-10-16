Received: from eggs.gnu.org ([2001:4830:134:3::10]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCURR-00081D-LR
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCURQ-0007R2-S9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:51:41 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-4-kwolf@redhat.com>
	<e61301c2-5865-fb02-c45b-56b4a3622dc3@redhat.com>
	<20181016141243.GH5620@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4c232b8-dfd4-46ca-e582-3c74d990c9ba@redhat.com>
Date: Tue, 16 Oct 2018 13:51:27 -0500
MIME-Version: 1.0
In-Reply-To: <20181016141243.GH5620@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] block: Require auto-read-only for
 existing fallbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/16/18 9:12 AM, Kevin Wolf wrote:
> Am 12.10.2018 um 19:02 hat Eric Blake geschrieben:
>> On 10/12/18 6:55 AM, Kevin Wolf wrote:
>>> Some block drivers have traditionally changed their node to read-only
>>> mode without asking the user. This behaviour has been marked deprecated
>>> since 2.11, expecting users to provide an explicit read-only=on option.
>>>
>>> Now that we have auto-read-only=on, enable these drivers to make use of
>>> the option.
>>>
>>> This is the only use of bdrv_set_read_only(), so we can make it a bit
>>> more specific and turn it into a bdrv_apply_auto_read_only() that is
>>> more convenient for drivers to use.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>

>> Worth documenting the -EINVAL (copy-on-read prevents setting read-only)
>> failure as well?  (The -EPERM failure of bdrv_can_set_read_only() is not
>> reachable, since this new function never clears readonly).
> 
> In fact, -EINVAL and the error string from bdrv_can_set_read_only() may
> be confusing because the user didn't explicitly request a read-only
> image. Maybe it would be better to just turn this case into -EACCES with
> the same error message.
> 
> What do you think?

So, how would it trigger in practice? The user requests a copy-on-read 
action with the BDS as destination (thus the BDS must be writable, and 
can't be set to readonly); they omitted read-only (because they know 
they want copy-on-read); they supplied auto-read-only=true (because they 
are lazy and want to always use that flag if it is available); but the 
particular BDS they selected is not writable (whether read-only file 
system, read-only NBD server, etc).  In short, we can't grant them 
read-write to begin with, and can't gracefully fall back to read-only 
because it would violate their request for copy-on-read, so as long as 
we give them a sane error message about their request being impossible, 
we're good.  Yes, -EACCES sounds reasonable, if you want to code that in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
