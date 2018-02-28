Received: from eggs.gnu.org ([2001:4830:134:3::10]:55863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2Il-0002lK-54
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2Ik-0000FN-7J
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:01:47 -0500
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-2-eblake@redhat.com>
	<w51vaehpfzw.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
Date: Wed, 28 Feb 2018 08:01:33 -0600
MIME-Version: 1.0
In-Reply-To: <w51vaehpfzw.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

On 02/28/2018 04:26 AM, Alberto Garcia wrote:
> On Tue 27 Feb 2018 05:29:41 PM CET, Eric Blake wrote:
>> +The refcount table has implications on the maximum host file size; a
>> +larger cluster size is required for the refcount table to cover
>> larger +offsets.
> 
> Why is this? Because of the refcount_table_clusters field ?
> 
> I think the maximum offset allowed by that is ridiculously high,
> exceeding any other limit imposed by the L1/L2 tables.

Good point.  I was basing my comment off of qcow2.h:

/* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
#define QCOW_MAX_REFTABLE_SIZE 0x800000

But that's our implementation choice (we put a maximum amount of memory 
on the size of the refcount table we are willing to support, while the 
qcow2 spec would allow an implementation willing to reserve more memory 
to access even larger sizing).

> 
> If my numbers are right, with the default values that's 64 ZB.
> 
> In addition to that, the size that can be covered by the refcount table
> also depends on the size of refcount entries (refcount_order).

True.

> 
> With 512 byte clusters and 64 bit refcount entries I still get 8 PB, way
> over what's limited by the L1/L2 tables (128 GB).

Do I need to make any modifications to the sentence, then?  Or is it 
still accurate, if vague, to leave the sentence as is because there IS 
an impact to consider, even if the impact is unlikely to matter in 
relation to other sizing impacts?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
