Received: from eggs.gnu.org ([209.51.188.92]:48142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvseD-0000ic-LB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvseB-0002GV-Ok
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:48:28 -0500
References: <20190213233618.22484-1-jsnow@redhat.com>
	<20190213233618.22484-3-jsnow@redhat.com>
	<c79e69af-6d00-074a-fc02-5f0808048f4d@virtuozzo.com>
	<7248815e-1fcc-ec24-6463-0467df773af5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <dfa46dbe-df0d-8c77-8f86-cc634d1b5772@redhat.com>
Date: Mon, 18 Feb 2019 18:48:16 -0500
MIME-Version: 1.0
In-Reply-To: <7248815e-1fcc-ec24-6463-0467df773af5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] block/dirty-bitmap: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/18/19 3:37 PM, Eric Blake wrote:
> On 2/18/19 12:13 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 14.02.2019 2:36, John Snow wrote:
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   block/dirty-bitmap.c         | 15 +++++++++++++
>>>   block/qcow2-bitmap.c         | 42 ++++++++++++++++++-----------------
>>>   blockdev.c                   | 43 ++++++++++++++++++++++++++++++++++++
>>>   include/block/dirty-bitmap.h |  1 +
>>>   4 files changed, 81 insertions(+), 20 deletions(-)
> 
>>> +void bdrv_dirty_bitmap_add_inconsistent_hint(Error **errp)
>>> +{
>>> +    error_append_hint(errp, "Try block-dirty-bitmap-clear to mark this "
>>> +                      "bitmap consistent again, or block-dirty-bitmap-remove "
>>> +                      "to delete it.");
>>
>> bitmaps created by libvirt (or somebody) are related to some checkpoint. And their name is
>> probably (Eric?) related to this checkpoint too. So, clear will never make them consistent..
>> Only clear :)
>>
>> So, I don't like idea of clearing in-use bitmaps.
> 
> It's always possible to delete a bitmap and then create a new one by the
> same name, to get the same effect of clearing an in-use bitmap. So let's
> start simple and declare that the only valid operation on an
> inconsistent bitmap is deletion.
> 

OK, from the viewpoint of checkpoints specifically, that's a convincing
argument against it for now.

I'll tighten this.
