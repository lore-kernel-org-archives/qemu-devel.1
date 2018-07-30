Received: from eggs.gnu.org ([2001:4830:134:3::10]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3QC-0007ZB-Kn
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3QB-0007eP-Al
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:20:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180728042308.GB1325070@localhost.localdomain>
Date: Mon, 30 Jul 2018 10:20:36 +0200
In-Reply-To: <20180728042308.GB1325070@localhost.localdomain> (Jeff Cody's
	message of "Sat, 28 Jul 2018 00:23:08 -0400")
Message-ID: <87600xyw17.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Jeff Cody <jcody@redhat.com> writes:

> On Wed, Jul 25, 2018 at 10:56:48AM -0500, Eric Blake wrote:
>> On 07/25/2018 10:10 AM, Markus Armbruster wrote:
>> >qemu_rbd_parse_filename() builds a keypairs QList, converts it to JSON, and
>> >stores the resulting QString in a QDict.
>> >
>> >qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from the
>> >QDict, pass it to qemu_rbd_set_keypairs(), which converts it back into
>> >a QList.
>> >
>> >Drop both conversions, store the QList instead.
>> >
>> >This affects output of qemu-img info.  Before this patch:
>> >
>> >     $ qemu-img info rbd:rbd/testimg.raw:mon_host=192.168.15.180:rbd_cache=true:conf=/tmp/ceph.conf
>> >     [junk printed by Ceph library code...]
>> >     image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
>> >     [more output, not interesting here]
>> >
>> >After this patch, we get
>> >
>> >     image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}
>> >
>> >The value of member "=keyvalue-pairs" changes from a string containing
>> >a JSON array to that JSON array.  That's an improvement of sorts.  However:
>> >
>> >* Should "=keyvalue-pairs" even be visible here?  It's supposed to be
>> >   purely internal...
>> 
>> I'd argue that since it is supposed to be internal (as evidenced by the
>> leading '=' that does not name a normal variable), changing it doesn't hurt
>> stability. But yes, it would be nicer if we could filter it entirely so that
>> it does not appear in json: output, if it doesn't truly affect the contents
>> that the guest would see.
>> 
>> >
>> >* Is this a stable interface we need to preserve, warts and all?
>> 
>> I hope not.
>> 
>> >
>> >Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >---
>> >  block/rbd.c | 50 ++++++++++++++++++++++----------------------------
>> >  1 file changed, 22 insertions(+), 28 deletions(-)
>> 
>> I'm not yet convinced if we want this patch for 3.0 without more comments
>> from the RBD experts, nor do I see too much of an issue if this doesn't go
>> in until 3.1.  But as to the code changes itself, I find them nice.
>
> Based on my IRC discussions with Markus, I believe the target for this patch
> is indeed 3.1, not 3.0.

Unless we conclude we want to change qemu-img info sooner rather than
later, which seems unlikely.
