Received: from eggs.gnu.org ([2001:4830:134:3::10]:45289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqNv5-0007Km-DQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqNv4-0002wO-PY
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:26:55 -0400
References: <20180530003550.21531-1-eblake@redhat.com>
	<40c5a402-9137-aff7-2622-85ab62b5fa36@virtuozzo.com>
	<085ca5bd-a90b-4e3a-27db-0563858c77bf@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ef6b3d2-bedc-758c-065e-b0994cb57dd3@redhat.com>
Date: Thu, 16 Aug 2018 14:26:46 -0500
MIME-Version: 1.0
In-Reply-To: <085ca5bd-a90b-4e3a-27db-0563858c77bf@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] doc: Permit BLOCK_STATUS reply to extend
 beyond request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, nbd@other.debian.org
Cc: w@uter.be, Paolo Bonzini <pbonzini@redhat.com>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On 08/15/2018 04:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> ping.
> 
> Finally, Qemu 3.0 released, and it is incompatible with current NBD 
> protocol. Please, commit this patch.

Indeed, qemu 3.0 with the qemu:dirty-bitmap:NAME context does exceed the 
final length when REQ_ONE is not in force.

As I recall, there was no complaint about the concept, only the wording; 
so I think this updated wording satisfies everyone:


    If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
-  then every reply chunk MUST NOT contain more than one descriptor.
+  then every reply chunk MUST contain exactly one descriptor, and that
+  descriptor MUST NOT exceed the *length* of the original request.  If
+  the client did not use the flag, and the server replies with N
+  extents, then the sum of the *length* fields of the first N-1
+  extents (if any) MUST be less than the requested length, while the
+  *length* of the final extent MAY result in a sum larger than the
+  original requested length, if the server has that information anyway
+  as a side effect of reporting the status of the requested region.

I've gone ahead and pushed this.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
