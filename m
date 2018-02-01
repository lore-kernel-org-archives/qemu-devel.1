Received: from eggs.gnu.org ([2001:4830:134:3::10]:34279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehBWq-0005Hs-RN
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehBWk-00027F-Rf
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:51:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4361f774-7d2e-1a67-bde9-da421df554f9@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<e2cb85926f1f4910c7d18fcc902be60109592381.1516978645.git.berto@igalia.com>
	<4361f774-7d2e-1a67-bde9-da421df554f9@redhat.com>
Date: Thu, 01 Feb 2018 10:51:26 +0100
Message-ID: <w51wozx597l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 13/39] qcow2: Add l2_slice_size field to
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed 31 Jan 2018 08:48:08 PM CET, Max Reitz wrote:
> On 2018-01-26 15:59, Alberto Garcia wrote:
>> The BDRVQcow2State structure contains an l2_size field, which stores
>> the number of 64-bit entries in an L2 table.
>> 
>> For efficiency reasons we want to be able to load slices instead of
>> full L2 tables, so we need to know how many entries an L2 slice can
>> hold.
>> 
>> An L2 slice is the portion of an L2 table that is loaded by the qcow2
>> cache. At the moment that cache can only load complete tables,
>> therefore an L2 slice has the same size as an L2 table (one cluster)
>> and l2_size == l2_slice_size.
>> 
>> Later we'll allow smaller slices, but until then we have to use this
>> new l2_slice_size field to make the rest of the code ready for that.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block/qcow2.c | 3 +++
>>  block/qcow2.h | 1 +
>>  2 files changed, 4 insertions(+)
>
> Am I missing something or does this patch miss setting l2_slice_size
> in qcow2_do_open()?

qcow2_do_open() calls qcow2_update_options() which is what reads
l2-cache-entry-size and sets s->l2_slice_size.

Berto
