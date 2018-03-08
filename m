Received: from eggs.gnu.org ([2001:4830:134:3::10]:38365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etwnY-0002GK-LT
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etwnX-0006qv-F0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:45:36 -0500
References: <20180307225732.155835-1-eblake@redhat.com>
	<1651749911.5944222.1520491852256.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b5bee3a-c30b-38da-b861-bceebad9b57e@redhat.com>
Date: Thu, 8 Mar 2018 08:45:20 -0600
MIME-Version: 1.0
In-Reply-To: <1651749911.5944222.1520491852256.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com

On 03/08/2018 12:50 AM, Paolo Bonzini wrote:
> 
>> The NBD spec states that since trim requests can affect disk contents,
>> then they should allow for FUA semantics just like writes for ensuring
>> the disk has settled before returning.  As bdrv_[co_]pdiscard() does
>> not (yet?) support a flags argument, we can't pass FUA down the block
>> layer stack, and must therefore emulate it with a flush at the NBD
>> layer.
> 
> TRIM requests should not need FUA since they're just advisory.  On
> the other hand, WRITE ZEROES requests need to support FUA.

It looks like qemu's NBD implementation properly supports FUA on WRITE 
ZEROES requests.  The block layer in bdrv_co_do_pwrite_zeroes checks for 
FUA support for both an actual zero request to the driver, as well as 
any fallback write requests, and does a followup flush if any driver 
request did not support BDRV_REQ_FUA.  Even when BDRV_REQ_MAY_UNMAP is 
passed through to the driver and allows the zeroes to be written by a 
trim, then either that trim must also honor FUA semantics 
(block/nbd{,-client}.c does this), or the driver can't advertise FUA 
support on zeroes (block/iscsi.c does this) and the block layer fallback 
kicks in.  So I think we're fine on that front.

Still, while you argue that TRIM is advisory (which I agree), if it does 
nothing, then you've (implicitly) honored FUA (that transaction didn't 
affect persistent storage, so you didn't have to wait any longer for 
anything to land); but if it DOES change the disk contents, then waiting 
for that change to land IS worth supporting, hence why the NBD protocol 
requires the FUA flag to be honored on trim.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
