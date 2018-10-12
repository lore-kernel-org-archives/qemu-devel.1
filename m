Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1jH-0006WI-6S
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1jD-0008Jn-77
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:00:03 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<364642df-1e17-dbea-1cec-a5cf6c606b27@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aab53fe8-84f3-b585-7a7c-dd007e830606@redhat.com>
Date: Fri, 12 Oct 2018 12:59:53 -0500
MIME-Version: 1.0
In-Reply-To: <364642df-1e17-dbea-1cec-a5cf6c606b27@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

On 10/12/18 12:41 PM, Richard Henderson wrote:
> On 10/11/18 8:24 PM, David Gibson wrote:
>> When the balloon is inflated, we discard memory place in it using madvise()
>> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
>> sounds like it makes sense but is actually unnecessary.
>>
>> The misleadingly named MADV_DONTNEED just discards the memory in question,
>> it doesn't set any persistent state on it in-kernel; all that's necessary
>> to bring the memory back is to touch it.
> 
> 
> Isn't the point of deflate to free up host memory, for use by other guests or
> whatever?

If I remember correctly, deflate says to make the balloon smaller (that 
is, the balloon gets out of the way so that the guest can use more 
memory); inflate says to make the balloon bigger (that is, the guest has 
less memory available to use because the inflated balloon is occupying 
that memory instead - where memory occupied by the balloon is really 
memory handed back to the host).

> 
> If you do nothing upon deflate, then that doesn't actually happen.  It seems to
> me that this is backward and you should use DONTNEED on deflate and then
> inflate should do nothing.

Or rather, it sounds like your definition of deflate is opposite the one 
I recall (you are trying to argue that deflate means the guest uses less 
memory and is therefore deflating in size; while I thought deflate meant 
that the balloon shrinks in size making more memory available to the guest).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
