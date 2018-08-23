Received: from eggs.gnu.org ([2001:4830:134:3::10]:47940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsuEp-0001oK-N0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsuEm-0007Zh-GW
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:21:42 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fsuEl-0007XQ-53
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:21:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id 89-v6so4257300qkp.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 11:21:38 -0700 (PDT)
References: <20180821210024.3587-1-danielhb413@gmail.com>
	<20180822220440.GA5287@kermit-br-ibm-com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <84eb88b2-3ec7-11e2-79dd-d191969252a3@gmail.com>
Date: Thu, 23 Aug 2018 15:21:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180822220440.GA5287@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/2] HMP/snapshot changes - do not
 use ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Hi,

On 08/22/2018 07:04 PM, Murilo Opsfelder Araujo wrote:
> Hi, Daniel.
>
> On Tue, Aug 21, 2018 at 06:00:22PM -0300, Daniel Henrique Barboza wrote:
>> I am marking the patch series as "RFC" because it was supposed to be
>> a discussion but, when I was investigating, it turned out to be
>> easier to send the patches right away.
>>
>> It is not uncommon to see bugs being opened by testers that attempt to
>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
>> common snapshot names and they trigger a lot of bugs. I gave an example
>> in the commit message of patch 1, but to sum up here: QEMU treats the
>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
>> is documented as such, but this can lead to strange situations.
>>
>> Given that it is strange for an API to consider a parameter to be 2 fields
>> at the same time, and inadvently treating them as one or the other, and
>> that removing the ID field is too drastic, my idea here is to keep the
>> ID field for internal control, but do not let the user set it.
>>
>> I guess there's room for discussion about considering this change an API
>> change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
>> but I am simplifying the meaning of the parameters of savevm/loadvm/delvm.
> What if we harden ->id_str to be a UUID?
>
> The example you mentioned is that user gave a snapshot the name "1", which was
> the ->id_str of the first snapshot created.
>
> If we harden ->id_str to be a UUID, that situation would only happen if user
> entered a UUID already in use or a tag of their preference.  It would be a bit
> harder for user to guess an ->id_str (UUID) by mistake.
>
> So, in this example, the name "1" of the second snapshot wouldn't match the
> ->id_str of the first snapshot and a second snapshot (with a different UUID)
> would be created with tag "1".
>
> Having *_snapshot_find() to still match ->id_str or ->name is good for user
> experience, where short names or tags can still be used to operate on snapshots.
>
> Internally, code could handle only UUIDs of the snapshots.  So
> *_snapshot_delete() would receive a UUID, and *_snapshot_find() would still
> match ->id_str or ->name, still allowing savevm/loadvm/delvm to operate on both
> IDs and tags.

This is a valid alternative to avoid the bug (in most cases anyway) without
changing the meaning of the APIs.

However, my idea with this series is to start a discussion about removing
the ID usage in the user side, showing that the world will not collapse if
we do it. The idea was based on an old wiki page with snapshot
improvements that were being worked on:

https://wiki.qemu.org/Features/SnapshottingImprovements#ID_and_TAG_confusion

As said there, other virtualization engines do not have this idea of 
snapshot
ids being exposed to the user. QEMU is still doing that, and in my opinion
it is actually worse than it was because now we're obscuring the ID 
information:


(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
--        running                121M 2018-08-09 18:00:57 00:21:22.444
--        vm-20180809180123      121M 2018-08-09 18:01:23 00:21:48.114
--        vm-20180809180127      121M 2018-08-09 18:01:27 00:21:51.391


Even if the user is aware of the ID/TAG duality of the savevm API, how 
can you
issue "savevm 100" without knowing if any of these snapshots has ID = 100?
And remember that user can be any management system (Libvirt uses this
API, for example) so even if we use an UUID there is no guarantee that a
collision wouldn't occur eventually. Why take the chances if we can simply
ignore the ID in these APIs?

I stand by this proposal, but I believe we need input from someone 
experienced
in this code (Kevin for example) to see if I am missing something 
trivial here.


Thanks,


Daniel



>
>>
>> Daniel Henrique Barboza (2):
>>    block/snapshot.c: eliminate use of ID input in snapshot operations
>>    qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call
>>
>>   block/qcow2-snapshot.c |  5 -----
>>   block/snapshot.c       |  5 +++--
>>   hmp-commands.hx        | 20 ++++++++++----------
>>   3 files changed, 13 insertions(+), 17 deletions(-)
>>
>> -- 
>> 2.17.1
>>
>>
