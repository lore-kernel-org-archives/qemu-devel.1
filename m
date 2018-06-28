Received: from eggs.gnu.org ([2001:4830:134:3::10]:50151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYc7O-0007KE-FH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYc7N-0002MP-MB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:58:10 -0400
References: <20180508212718.1482663-1-eblake@redhat.com>
	<b8dc8a66-b179-41b2-b447-f3cba5e1d544@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ad236f5-efec-c228-2bac-45b74c26b097@redhat.com>
Date: Thu, 28 Jun 2018 13:58:01 -0500
MIME-Version: 1.0
In-Reply-To: <b8dc8a66-b179-41b2-b447-f3cba5e1d544@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iscsi: Avoid potential for get_status
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>

On 05/10/2018 08:28 AM, Paolo Bonzini wrote:
> On 08/05/2018 23:27, Eric Blake wrote:
>> Detected by Coverity: Multiplying two 32-bit int and assigning
>> the result to a 64-bit number is a risk of overflow.  Prior to
>> the conversion to byte-based interfaces, the block layer took
>> care of ensuring that a status request never exceeded 2G in
>> the driver; but after that conversion, the block layer expects
>> drivers to deal with any size request (the driver can always
>> truncate the request size back down, as long as it makes
>> progress).  So, in the off-chance that someone makes a large
>> request, we are at the mercy of whether iscsi_get_lba_status_task()
>> will cap things to at most INT_MAX / iscsilun->block_size when
>> it populates lbasd->num_blocks; since I could not easily audit
>> that, it's better to be safe than sorry by just forcing a 64-bit
>> multiply.
>>
>> Fixes: 92809c36
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

> 
> Queued, thanks.

It's been more than a month since this was queued but it is still not on 
mainline - did it get lost?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
