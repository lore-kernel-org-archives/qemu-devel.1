Received: from eggs.gnu.org ([2001:4830:134:3::10]:49743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeI6w-0004nQ-NK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeI6w-0005pQ-0w
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:16:54 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
	<20171229013140.GA13004@lemon>
	<9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
	<78110cb5-b69c-a35a-17ed-9bb1f121bc06@virtuozzo.com>
	<c7273453-a480-c041-8b42-6275a6182f46@redhat.com>
	<e8635926-315b-d454-73ab-0875203e9b7c@virtuozzo.com>
	<41e11a98-98e9-1766-17e9-8bb5182f4b91@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2cc67d0-4594-8cb3-875a-396738ecc1ef@redhat.com>
Date: Wed, 24 Jan 2018 11:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <41e11a98-98e9-1766-17e9-8bb5182f4b91@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

On 22/01/2018 13:14, Vladimir Sementsov-Ogievskiy wrote:
>> so, accessing the bitmap needs mutex lock?
>>
>> Then what do you mean under accessing the bitmap? Any touch of
>> BdrvDirtyBitmap fields? Then "reading the list" will require bitmap
>> mutex too.
>> Or accessing the bitmap is accessing any field except
>> BdrvDirtyBitmap.list? Then in (2), what do you mean? For example
>> query-block will go through
>> the list, but it touches other fields too, so it should lock mutex.

The bitmap mutex is internal to block/dirty-bitmap.c.

> and one more question:
> 
> What about qmp transactions? Should we lock mutex during the whole
> transaction?

Transactions hold the BQL, but you don't need to lock the bitmap mutex.

Paolo
