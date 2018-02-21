Received: from eggs.gnu.org ([2001:4830:134:3::10]:35417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoXku-0003IT-0P
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoXkt-0000rP-2o
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:00:32 -0500
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<20180221165116.GB4196@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aed232fa-af26-5994-0bed-ec84a514b645@redhat.com>
Date: Wed, 21 Feb 2018 10:59:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180221165116.GB4196@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com

On 02/21/2018 10:51 AM, Kevin Wolf wrote:
> Am 20.02.2018 um 23:24 hat Eric Blake geschrieben:
>> When reading a compressed image, we were allocating s->cluster_data
>> to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
>> with 2M clusters).  Let's check out the history:
>>

>> Much later, in commit de82815d (v2.2), we noticed that a 64M
>> allocation is prone to failure, so we switched over to a graceful
>> memory allocation error message.  But note that elsewhere in the
>> code, we do g_malloc(2 * cluster_size) without ever checking for
>> failure.
>>

>> -        }
>> -        if (!s->cluster_cache) {
>> -            s->cluster_cache = g_malloc(s->cluster_size);
>> +            assert(!s->cluster_cache);
> 
> Wouldn't it be better to assert (!!s->cluster_cache ==
> !!s->cluster_data) unconditionally?
> 

Sure.

>> +            s->cluster_data = g_try_malloc(s->cluster_size);
> 
> Why are you going from qemu_try_blockalign() to simple malloc here? This
> buffer is used with bdrv_read() (or bdrv_pread() after patch 1), so we
> should avoid unnecessary use of a bounce buffer.

But does bdrv_pread() actually need to use a bounce buffer if we don't 
have an aligned buffer to read into?  Either the underlying protocol 
already supports byte-aligned reads (direct into our buffer, regardless 
of alignment, no bouncing required), or it already has do to a full 
sector read into a bounce buffer anyways (and it doesn't matter whether 
we aligned our buffer).  blockalign() made sense when we had multiple 
clients for the buffer, but ever since v1.1, when we have only a single 
client, and that single client is most likely not going to read 
sector-aligned data in the first place, aligning the buffer doesn't buy 
us anything.

> 
>> +            s->cluster_cache = g_try_malloc(s->cluster_size);
> 
> As you already said, either g_malloc() or check the result. I actually
> think that g_try_malloc() and checking the result is nicer, we still
> allocate up to 2 MB here.

See my commit message comment - we have other spots in the code base 
that blindly g_malloc(2 * s->cluster_size).  And I intended (but sent 
the email without amending my commit) to use g_malloc().  But as Berto 
has convinced me that an externally produced image can convince us to 
read up to 4M (even though we don't need that much to decompress), I 
suppose that the try_ variant plus checking is reasonable (and care in 
NULL'ing out if one but not both allocations succeed).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
