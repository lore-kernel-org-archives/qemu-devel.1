Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVHxK-0002h9-Kr
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVHxI-0000Zq-Ir
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:22:18 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-13-eblake@redhat.com>
	<13a090e9-ef18-4215-6726-453251b76560@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a8e30be-505d-77d8-2201-390bad247de2@redhat.com>
Date: Fri, 7 Dec 2018 09:21:58 -0600
MIME-Version: 1.0
In-Reply-To: <13a090e9-ef18-4215-6726-453251b76560@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/14] nbd/client: Work around 3.0 bug for
 listing meta contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/7/18 5:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> Commit 3d068aff forgot to advertise available qemu: contexts
>> when the client requests a list with 0 queries. Furthermore,
>> 3.0 shipped with a qemu-img hack of x-dirty-bitmap (commit
>> 216ee365) that _silently_ acts as though the entire image is
>> clean if a requested bitmap is not present.  Both bugs have
>> been recently fixed to give full output from the start, and
>> to refuse a connection if a requested x-dirty-bitmap was not
>> found.
>>
>> Still, it is likely that there will be users that have to
>> work with a mix of old and new qemu versions, depending on
>> which features get backported where, at which point being
>> able to rely on 'qemu-img --list' output to know for sure
>> whether a given NBD export has the desired dirty bitmap is
>> much nicer than blindly connecting and risking that the
>> entire image may appear clean.  We can make our --list code
>> smart enough to work around buggy servers by tracking
>> whether we've seen any qemu: replies in the original 0-query
>> list; if not, recurse to a single query on "qemu:" (which
>> may still have no replies, but then we know for sure we
>> didn't trip up on the server bug).
> 
> related thing:
> should we document these bugs with corresponding version numbers in docs/interop/nbd.txt?

Might be useful.  I'll add that as another patch in my v2 series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
