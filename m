Received: from eggs.gnu.org ([2001:4830:134:3::10]:38075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkZhl-0004xk-KE
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkZhk-0002AD-OK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:44:37 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<39bf15aa-70e0-45ad-e368-fb489ee30a7c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6fd08a23-a4f1-527f-6665-d1dbeb51a64a@redhat.com>
Date: Wed, 23 Aug 2017 13:44:23 -0400
MIME-Version: 1.0
In-Reply-To: <39bf15aa-70e0-45ad-e368-fb489ee30a7c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 08/23/2017 01:31 PM, Max Reitz wrote:
> On 2017-08-22 21:07, John Snow wrote:
> 
> [...]
> 
>> (3) Add either a new flag that turns qcow2's backing file into a full
>> R/W backing file, or add a new extension to qcow2 entirely (bypassing
>> the traditional backing file mechanism to avoid confusion for older
>> tooling) that adds a new read-write backing file field.
>>
>> This RW backing file field will be used for all reads AND writes; the
>> qcow2 in question becomes a metadata container on top of the BDS chain.
>> We can re-use Vladimir's bitmap persistence extension to save bitmaps in
>> a qcow2 shell.
>>
>> The qcow2 becomes effectively a metadata cache for a new (essentially)
>> filter node that handles features such as bitmaps. This could also be
>> used to provide allocation map data for RAW files and other goodies down
>> the road.
>>
>> Hopefully this achieves our desire to not create new formats AND our
>> desire to concentrate features (and debugging, testing, etc) into qcow2,
>> while allowing users to "have bitmaps with raw files."
>>
>> Of course, in this scenario, users now have two files: a qcow2 wrapper
>> and the actual raw file in question; but regardless of how we were going
>> to solve this, a raw file necessitates an external file of some sort,
>> else we give up the idea that it was a raw file.
>>
>>
>> Sound good?
> 
> While I don't quite like the idea of R/W backing files, I guess "don't
> quite like" is still rather good.
> 

Yeah, it's not necessarily my first pick, but it might be the least bad.
If you have any suggestions or alternatives for a way to accomplish the
same in a way that does not leave any, even faint, bad taste in your
mouth you are more than welcome to suggest it.

> I like how this idea would allow us to use the existing code without
> putting just arbitrary binary data into the qcow2 file; the data still
> relates to the virtual disk represented by the qcow2 image.
> 
> So design-wise, I don't think I have any complaints.
> 
> As for Kevin, he's on PTO, though. ;-)
> 
> Max
> 

Ah, right. Well... I'll just have to have something fun for him to look at.
