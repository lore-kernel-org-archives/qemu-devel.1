Received: from eggs.gnu.org ([2001:4830:134:3::10]:54861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgvX-0003DA-Ba
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgvW-0002Ck-Ib
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:52:07 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-5-jsnow@redhat.com>
	<a98f8075-4c26-7c2a-a24a-94e833867717@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2687d555-9b3a-5201-672f-a187a11a9083@redhat.com>
Date: Tue, 15 May 2018 16:52:00 -0400
MIME-Version: 1.0
In-Reply-To: <a98f8075-4c26-7c2a-a24a-94e833867717@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/12] qcow2/dirty-bitmaps: load IN_USE
 bitmaps if disk is RO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/14/2018 08:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2018 04:25, John Snow wrote:
>> For the purposes of qemu-img manipulation and querying of bitmaps, load
>> bitmaps that are "in use" -- if the image is read only. This will allow
>> us to diagnose problems with this flag using the qemu-img tool.
> 
> It looks unsafe.. We can load them, then reopen rw and then store them
> on vm close, the result would be unpredictable. And they become
> available for qmp commands..
> 
> If we want to load them, we may need some additional state for such
> dirty bitmaps, something like "invalid", to be sure, that they will not
> be used like normal bitmap. And we may
> need some additional flag to load or not load them, and this behavior
> will be unrelated to can_write().
> 

Yeah, you're right -- reopening is scary. I'll see what I can do.

The goal is just to get them in memory so that qemu-img can use the
standard BdrvDirtyBitmap API to print various info about them for the user.

Since 'info' and 'dump' don't need RW access, it'd be nicest for these
commands to work in RO mode, hence the patch.
