Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8vE-0000TN-QH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8vD-00076w-UO
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:28:52 -0500
References: <20180126193439.20219-1-eblake@redhat.com>
	<20180129110844.GB20446@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d9471a0-bdb4-6988-c926-62f6bdb7e39d@redhat.com>
Date: Tue, 6 Feb 2018 13:28:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180129110844.GB20446@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Simplify
 bdrv_can_write_zeroes_with_unmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, pbonzini@redhat.com

On 01/29/2018 05:08 AM, Stefan Hajnoczi wrote:
> On Fri, Jan 26, 2018 at 01:34:39PM -0600, Eric Blake wrote:
>> We don't need the can_write_zeroes_with_unmap field in
>> BlockDriverInfo, because it is redundant information with
>> supported_zero_flags & BDRV_REQ_MAY_UNMAP.  Note that
>> BlockDriverInfo and supported_zero_flags are both per-device
>> settings, rather than global state about the driver as a
>> whole, which means one or both of these bits of information
>> can already be conditional.  Let's audit how they were set:
>>
...
>> Simplify the code by moving the conditional into
>> supported_zero_flags for all drivers, then dropping the
>> now-unused BDI field.  For callers that relied on
>> bdrv_can_write_zeroes_with_unmap(), we return the same
>> per-device settings for drivers that had conditions (no
>> observable change in behavior there); and can now return
>> true (instead of false) for drivers that support passthrough
>> (for example, the commit driver) which gives those drivers
>> the same fix as nbd just got in bca80059e.  For callers that
>> relied on supported_zero_flags, we now have a few more places
>> that can avoid a wasted call to pwrite_zeroes() that will
>> just fail with ENOTSUP.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> The commit id mentioned above is dependent on me not having to respin
>> my latest NBD pull request:
>>
>> Based-on: <20180126160411.4033-1-eblake@redhat.com>
>> ([PULL 0/8] NBD patches through 26 Jan)

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Thanks.

Since this patch was discovered in relation to NBD code, I'm fine taking 
it through my NBD queue; but it's also more generic to the block layer, 
so I'm also fine if one of the other block maintainers grabs it first 
through their tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
