Received: from eggs.gnu.org ([2001:4830:134:3::10]:38563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebqM7-0005tn-OH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebqM4-0003H0-HT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:14:27 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <99e8633c-828c-ccf5-334a-6d081d329878@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
	<a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
	<w51fu741nuo.fsf@maestria.local.igalia.com>
	<99e8633c-828c-ccf5-334a-6d081d329878@redhat.com>
Date: Wed, 17 Jan 2018 17:13:45 +0100
Message-ID: <w51d1281n0m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 17 Jan 2018 05:06:04 PM CET, Eric Blake wrote:
>>>>      /* allocate a new entry in the l2 cache */
>>>>  
>>>> +    slice_size = s->l2_slice_size * sizeof(uint64_t);
>>>
>>> Would this read any better if the earlier patch named it
>>> s->l2_slice_entries?
>> 
>> I had doubts with this. Like you, when I see size I tend to think about
>> bytes. However both s->l1_size and s->l2_size indicate entries, and the
>> documentation of the qcow2 format even describes the header field like
>> this:
>> 
>>          36 - 39:   l1_size
>>                     Number of entries in the active L1 table
>
> We're free to rename the field in the qcow2 format specification if it
> makes things easier to understand.  If l1_entries reads better than
> l1_size, maybe it's worth doing.

In my opinion it reads much better. We mix both kinds of meanings in the
BDRVQcow2State structure already, there's for example cluster_size
(bytes), and refcount_table_size (entries). With the latter we actually
have the exact same problem we're discussing here:

    refcount_table_size2 = s->refcount_table_size * sizeof(uint64_t);
    s->refcount_table = g_try_malloc(refcount_table_size2);

So yeah, we can change those variables but it won't be a small patch. I
can do that if everyone thinks that it's a good idea.

Berto
