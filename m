Received: from eggs.gnu.org ([2001:4830:134:3::10]:45395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnAi6-0000Pr-D6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnAi5-00028U-6K
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:39:42 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<20170830133611.GP24565@stefanha-x1.localdomain>
	<20170830134528.GR18526@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4943b893-ff3c-317b-efef-7115bff79d49@redhat.com>
Date: Wed, 30 Aug 2017 17:39:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170830134528.GR18526@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Persistent bitmaps for non-qcow2
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 08/30/2017 09:45 AM, Daniel P. Berrange wrote:
> On Wed, Aug 30, 2017 at 02:36:11PM +0100, Stefan Hajnoczi wrote:
>> On Tue, Aug 22, 2017 at 03:07:04PM -0400, John Snow wrote:
>>> (3) Add either a new flag that turns qcow2's backing file into a full
>>> R/W backing file, or add a new extension to qcow2 entirely (bypassing
>>> the traditional backing file mechanism to avoid confusion for older
>>> tooling) that adds a new read-write backing file field.
>>>
>>> This RW backing file field will be used for all reads AND writes; the
>>> qcow2 in question becomes a metadata container on top of the BDS chain.
>>> We can re-use Vladimir's bitmap persistence extension to save bitmaps in
>>> a qcow2 shell.
>>>
>>> The qcow2 becomes effectively a metadata cache for a new (essentially)
>>> filter node that handles features such as bitmaps. This could also be
>>> used to provide allocation map data for RAW files and other goodies down
>>> the road.
>>>
>>> Hopefully this achieves our desire to not create new formats AND our
>>> desire to concentrate features (and debugging, testing, etc) into qcow2,
>>> while allowing users to "have bitmaps with raw files."
>>>
>>> Of course, in this scenario, users now have two files: a qcow2 wrapper
>>> and the actual raw file in question; but regardless of how we were going
>>> to solve this, a raw file necessitates an external file of some sort,
>>> else we give up the idea that it was a raw file.
>>
>> There is some complexity here for management tools:
>>
>> If the underlying image is resized, who resizes the qcow2 and how do
>> they know to do it?
>>
>> If QEMU's resize/truncate command it used, does first try to resize the
>> underlying image and then resize the qcow2?  This is probably the sanest
>> approach.
>>
>> If the underlying image is moved to a new location, does the qcow2 file
>> need to be modified and who does that?
>>
>> Management tools need to figure out how to represent manage this extra
>> qcow2 file.  The easiest solution is to punt it to the user and treat it
>> as part of a backing file chain.  If the management tool wants to
>> automatically manage the qcow2 so the user just specifies the underlying
>> image and enables the persistent bitmap checkbox, then it becomes more
>> complicated.
> 
> Indeed, I don't think it is practical to have libvirt / QEMU automagically
> create a qcow2 overlay on disk. Something has to decide where this would
> be stored. You might say just put it alongside the raw file, but it might
> not be a local file at all, it could be a NBD, or RBD raw "file". So do
> we create  local qcow2 file, or store a qcow2 file inside another RBD
> volume to hold the persistent bitmap. This kind of decision needs to be
> made by the mgmt app since only it knows about its storage mgmt model.

Oh, you mean to say mgmt app like VMM or something even above libvirt,
yes? Who currently makes the decision for where snapshot files and the
like goes, does libvirt not decide that, but the app using it?

> At this point you might as well just let the mgmt app take care of it
> all and not try to do anything magical with qcow2 overlays in libvirt/QEMU
> 

Might be the sanest, yes -- but say I don't offer an "automagic" way to
add a bitmap to a raw file to a running QEMU instance but rather offer a
way to qcow2ify an existing node:

We could create a wrapper:

qemu-img create -f qcow2 -o wrapper wrapper.qcow2

Then add a node:

blockdev_add driver=qcow2 node-name=foo file.driver=file
file.filename=wrapper.qcow2

(The size of the drive could perhaps remain as zero temporarily here)

Then some magic to make it the active target of whatever blockbackend
was using the old image, perhaps?:

blockdev_magic target=virtioblk0 node-name=foo

At this point, virtioblk0 is now backed by our new magic qcow2 node
which provides bitmap features for whatever kind of backing storage
virtioblk0 had, and nothing automagic happened -- we passed explicit
file references.

Any magic that we wish to provide can happen in libvirt or above.

--js
