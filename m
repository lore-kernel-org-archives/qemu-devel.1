Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPtkx-0007wp-IK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPtP9-0005SR-8y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:31:56 -0400
Date: Tue, 27 Jun 2017 18:31:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170627163145.GC4792@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] QMP design: Fixing query-block and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, stefanha@redhat.com, eblake@redhat.com

Hi,

I haven't really liked query-block for a long time, but now that
blockdev-add and -blockdev have settled, it might finally be the time to
actually do something about it. In fact, if used together with these
modern interfaces, our query commands are simply broken, so we have to
fix something.

Just for reference, I'll start with a copy of the most important part of
the schema of our current QMP commands here:

> { 'command': 'query-block', 'returns': ['BlockInfo'] }
> 
> { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
> 
> { 'struct': 'BlockInfo',
>   'data': {'device': 'str', 'type': 'str', 'removable': 'bool',
>            'locked': 'bool', '*inserted': 'BlockDeviceInfo',
>            '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
>            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> 
> { 'struct': 'BlockDeviceInfo',
>   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
>             '*backing_file': 'str', 'backing_file_depth': 'int',
>             'encrypted': 'bool', 'encryption_key_missing': 'bool',
>             'detect_zeroes': 'BlockdevDetectZeroesOptions',
>             'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
>             'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
>             'image': 'ImageInfo',
>             '*bps_max': 'int', '*bps_rd_max': 'int',
>             '*bps_wr_max': 'int', '*iops_max': 'int',
>             '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>             '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>             '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
>             'write_threshold': 'int' } }
> 
> { 'struct': 'ImageInfo',
>   'data': {'filename': 'str', 'format': 'str', '*dirty-flag': 'bool',
>            '*actual-size': 'int', 'virtual-size': 'int',
>            '*cluster-size': 'int', '*encrypted': 'bool', '*compressed': 'bool',
>            '*backing-filename': 'str', '*full-backing-filename': 'str',
>            '*backing-filename-format': 'str', '*snapshots': ['SnapshotInfo'],
>            '*backing-image': 'ImageInfo',
>            '*format-specific': 'ImageInfoSpecific' } }
> 
> { 'union': 'ImageInfoSpecific',
>   'data': {
>       'qcow2': 'ImageInfoSpecificQCow2',
>       'vmdk': 'ImageInfoSpecificVmdk',
>       # If we need to add block driver specific parameters for
>       # LUKS in future, then we'll subclass QCryptoBlockInfoLUKS
>       # to define a ImageInfoSpecificLUKS
>       'luks': 'QCryptoBlockInfoLUKS'
>   } }

So what's wrong with this? Quite a few things, let's do a quick review
of the commands:

* query-block only returns BlockBackends that are owned by the monitor
  (i.e. they have a name). This used to be true for all BlockBackends
  that were attached to a guest device, but it's not the case any more:
  We want to use -blockdev/-device only with node names, which means
  that the devices create the BB internally - and they aren't visible in
  query-block any more.

* Even if we included those BBs in query-block, they would be missing
  the connection to their qdev device. The BB should really be
  considered part of the device, and if we had a way to query the state
  of a device, query-block would ideally be included there.

* query-named-block-nodes is a bad name. All block nodes are named these
  days. Which also means that it returns all block nodes, so its output
  becomes rather large and includes a lot of redundant information (as
  you'll see below).

* The good news: BlockInfo contains only fields that actually belong to
  BlockBackends, apart from a @type attribute that always contains the
  string "unknown".

  The bad news: A BlockBackend has a lot more information attached, this
  is by far not a full query command for BlockBackends.

* What is BlockDeviceInfo supposed to be? query-named-block-nodes
  returns it, so you would expect that it's a description of a
  BlockDriverState. But it's not. It's a mix of BB and BDS descriptions.
  The BB part just stays zeroed in query-named-block-nodes.

  In other words, if you do query-block, you'll see I/O limits and
  whether a writeback mode is used. But do query-named-block-nodes and
  look at the root node of the same device and it will always tell you
  that the limits are 0 and writeback is on.

  So BlockDeviceInfo contains many things that should really be in
  BlockInfo. Both together appear to be relatively complete for BBs.

* BlockDeviceInfo doesn't really describe the graph. It gives you the
  backing file name as a special case, but it won't tell you anything
  about other child nodes, and even for backing files it doesn't tell
  you which node is actually used.

  Instead, we should have a description of all attached children with
  the link name, the child node name and probably also the permissions
  attached to it (in other words, a description of BdrvChild).

* BlockDeviceInfo misses important information about nodes. For example,
  I often see a query-block output in bug reports and can't decide from
  it if we were using Linux AIO.

  Ideally it should include the currently active set of options
  (BlockdevOptions) that would result in the same block node. References
  would always be by name, so that this doesn't become recursive.

* Speaking of recursion: ImageInfo recursively includes information
  about all images in the backing chain. This is what makes the output
  of query-named-block-nodes so redundant. It is also inconsistent
  because the runtime information (BlockInfo/BlockDeviceInfo) isn't
  recursive.

* I'm also not quite sure if getting ImageInfo for an image shouldn't be
  a separate operation. It doesn't really seem related to getting the
  runtime state of a block device.

* ImageInfoSpecific exists only for a few drivers and doesn't contain
  all the information it could contain. Similar to what I said about
  BlockDeviceInfo, I think it should contain all the create options that
  you need to create the same image, apart from the data stored in it.

  'qemu-img create' still needs to improve its option handling, too, but
  I imagine that in the end it could be using the same QAPI struct that
  ImageInfo should contain.


So how do we go forward from here?

I guess we could add a few hacks o fix the really urgent things, and
just adding more information is always possible (at the cost of even
more duplication).

However, it appears to me that I dislike so many thing about our current
query commands that I'm tempted to say: Throw it all away and start
over.

If that's what we're going to do, I think I can figure out something
nice for block nodes. That shouldn't be too hard. The only question
would be whether we want a command to query one node or whether we would
keep returning all of them.

I am, however, a bit less confident about BBs. As I said above, I
consider them part of the qdev devices. As far as I know, there is no
high-level infrastructure to query runtime state of devices and qdev
properties are supposed to be read-only. Maybe non-qdev QOM properties
can be used somehow? But QOM isn't really nice to use as you need to
query each property individually.

Another option would be to have a QMP command that takes a qdev ID of a
block device and queries its BB. Or maybe it should stay like
query-block and return an array of all of them, but include the qdev
device name. Actually, maybe query-block can stay as it contains only
two fields that are useless in the new world.


I think this has become long enough now, so any opinions? On anything I
said above, but preferably also about what a new interface should look
like?

Kevin
