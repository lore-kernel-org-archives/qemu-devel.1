Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csrx3-0000cB-Bg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csrx1-0004Jv-1z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csrx0-0004JL-O7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:18:22 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A6F437F7D
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 14:18:21 +0000 (UTC)
References: <1490708752-26902-1-git-send-email-armbru@redhat.com>
	<1490708752-26902-2-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3b944ed-303c-31fa-7379-78f5076086cf@redhat.com>
Date: Tue, 28 Mar 2017 16:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <1490708752-26902-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org



On 28/03/2017 15:45, Markus Armbruster wrote:
> It's been a long journey, but here we are.
> 
> The supported blockdev-add is not compatible to its experimental
> predecessors; bump all Since: tags to 2.9.

Can you document the differences in the 2.9 changelog?

Paolo

> x-blockdev-remove-medium, x-blockdev-insert-medium and
> x-blockdev-change need a bit more work, so leave them alone for now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev.c             |  4 +--
>  qapi/block-core.json   | 95 ++++++++++++++++++++------------------------------
>  tests/qemu-iotests/139 |  8 ++---
>  tests/qemu-iotests/141 |  4 +--
>  tests/qemu-iotests/147 |  2 +-
>  5 files changed, 47 insertions(+), 66 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index c5b2c2c..040c152 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2835,7 +2835,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>  
>      bs = bdrv_find_node(id);
>      if (bs) {
> -        qmp_x_blockdev_del(id, &local_err);
> +        qmp_blockdev_del(id, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>          }
> @@ -3900,7 +3900,7 @@ fail:
>      visit_free(v);
>  }
>  
> -void qmp_x_blockdev_del(const char *node_name, Error **errp)
> +void qmp_blockdev_del(const char *node_name, Error **errp)
>  {
>      AioContext *aio_context;
>      BlockDriverState *bs;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0f132fc..f938316 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2053,7 +2053,7 @@
>  # @ignore:      Ignore the request
>  # @unmap:       Forward as an unmap request
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'enum': 'BlockdevDiscardOptions',
>    'data': [ 'ignore', 'unmap' ] }
> @@ -2082,7 +2082,7 @@
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'enum': 'BlockdevAioOptions',
>    'data': [ 'threads', 'native' ] }
> @@ -2097,7 +2097,7 @@
>  # @no-flush:    ignore any flush requests for the device (default:
>  #               false)
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevCacheOptions',
>    'data': { '*direct': 'bool',
> @@ -2108,18 +2108,7 @@
>  #
>  # Drivers that are supported in block device operations.
>  #
> -# @host_device: Since 2.1
> -# @host_cdrom: Since 2.1
> -# @gluster: Since 2.7
> -# @nbd: Since 2.8
> -# @nfs: Since 2.8
> -# @replication: Since 2.8
> -# @ssh: Since 2.8
> -# @iscsi: Since 2.9
> -# @rbd: Since 2.9
> -# @sheepdog: Since 2.9
> -#
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'enum': 'BlockdevDriver',
>    'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
> @@ -2137,7 +2126,7 @@
>  # @filename:    path to the image file
>  # @aio:         AIO backend (default: threads) (since: 2.8)
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsFile',
>    'data': { 'filename': 'str',
> @@ -2153,7 +2142,7 @@
>  #              requests. Default to zero which completes requests immediately.
>  #              (Since 2.4)
>  #
> -# Since: 2.2
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsNull',
>    'data': { '*size': 'int', '*latency-ns': 'uint64' } }
> @@ -2173,7 +2162,7 @@
>  #               (since 2.4)
>  # @rw:          whether to allow write operations (default: false)
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsVVFAT',
>    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> @@ -2187,7 +2176,7 @@
>  #
>  # @file:        reference to or definition of the data source block device
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsGenericFormat',
>    'data': { 'file': 'BlockdevRef' } }
> @@ -2201,7 +2190,7 @@
>  #              the decryption key (since 2.6). Mandatory except when
>  #              doing a metadata-only probe of the image.
>  #
> -# Since: 2.6
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsLUKS',
>    'base': 'BlockdevOptionsGenericFormat',
> @@ -2219,7 +2208,7 @@
>  #               allowed to pass an empty string here in order to disable the
>  #               default backing file.
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsGenericCOWFormat',
>    'base': 'BlockdevOptionsGenericFormat',
> @@ -2240,7 +2229,7 @@
>  #
>  # @all:         Perform all available overlap checks
>  #
> -# Since: 2.2
> +# Since: 2.9
>  ##
>  { 'enum': 'Qcow2OverlapCheckMode',
>    'data': [ 'none', 'constant', 'cached', 'all' ] }
> @@ -2255,7 +2244,7 @@
>  # @template: Specifies a template mode which can be adjusted using the other
>  #            flags, defaults to 'cached'
>  #
> -# Since: 2.2
> +# Since: 2.9
>  ##
>  { 'struct': 'Qcow2OverlapCheckFlags',
>    'data': { '*template':       'Qcow2OverlapCheckMode',
> @@ -2279,7 +2268,7 @@
>  #
>  # @mode:    named mode which chooses a specific set of flags
>  #
> -# Since: 2.2
> +# Since: 2.9
>  ##
>  { 'alternate': 'Qcow2OverlapChecks',
>    'data': { 'flags': 'Qcow2OverlapCheckFlags',
> @@ -2320,7 +2309,7 @@
>  #                         caches. The interval is in seconds. The default value
>  #                         is 0 and it disables this feature (since 2.5)
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsQcow2',
>    'base': 'BlockdevOptionsGenericCOWFormat',
> @@ -2347,7 +2336,7 @@
>  #
>  # TODO: Expose the host_key_check option in QMP
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsSsh',
>    'data': { 'server': 'InetSocketAddress',
> @@ -2360,7 +2349,7 @@
>  #
>  # Trigger events supported by blkdebug.
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
>    'data': [ 'l1_update', 'l1_grow_alloc_table', 'l1_grow_write_table',
> @@ -2400,7 +2389,7 @@
>  #
>  # @immediately: fail immediately; defaults to false
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'struct': 'BlkdebugInjectErrorOptions',
>    'data': { 'event': 'BlkdebugEvent',
> @@ -2423,7 +2412,7 @@
>  # @new_state:   the state identifier blkdebug is supposed to assume if
>  #               this event is triggered
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'struct': 'BlkdebugSetStateOptions',
>    'data': { 'event': 'BlkdebugEvent',
> @@ -2446,7 +2435,7 @@
>  #
>  # @set-state:       array of state-change descriptions
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsBlkdebug',
>    'data': { 'image': 'BlockdevRef',
> @@ -2464,7 +2453,7 @@
>  #
>  # @raw:     raw image used for verification
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsBlkverify',
>    'data': { 'test': 'BlockdevRef',
> @@ -2479,7 +2468,7 @@
>  #
>  # @fifo: read only from the first child that has not failed
>  #
> -# Since: 2.2
> +# Since: 2.9
>  ##
>  { 'enum': 'QuorumReadPattern', 'data': [ 'quorum', 'fifo' ] }
>  
> @@ -2501,7 +2490,7 @@
>  # @read-pattern: choose read pattern and set to quorum by default
>  #                (Since 2.2)
>  #
> -# Since: 2.0
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsQuorum',
>    'data': { '*blkverify': 'bool',
> @@ -2526,7 +2515,7 @@
>  #
>  # @logfile:     libgfapi log file (default /dev/stderr) (Since 2.8)
>  #
> -# Since: 2.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsGluster',
>    'data': { 'volume': 'str',
> @@ -2685,7 +2674,7 @@
>  #
>  # @secondary: Secondary mode, receive the vm's state from primary QEMU.
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
>  
> @@ -2700,7 +2689,7 @@
>  #          node who owns the replication node chain. Must not be given in
>  #          primary mode.
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsReplication',
>    'base': 'BlockdevOptionsGenericFormat',
> @@ -2714,7 +2703,7 @@
>  #
>  # @inet:        TCP transport
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'enum': 'NFSTransport',
>    'data': [ 'inet' ] }
> @@ -2728,7 +2717,7 @@
>  #
>  # @host:        host address for NFS server
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'NFSServer',
>    'data': { 'type': 'NFSTransport',
> @@ -2763,7 +2752,7 @@
>  # @debug:                   set the NFS debug level (max 2) (defaults
>  #                           to libnfs default)
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsNfs',
>    'data': { 'server': 'NFSServer',
> @@ -2782,7 +2771,7 @@
>  #
>  # @filename:    path to the image file
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurl',
>    'data': { 'filename': 'str' } }
> @@ -2798,7 +2787,7 @@
>  #
>  # @tls-creds:   TLS credentials ID
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsNbd',
>    'data': { 'server': 'SocketAddress',
> @@ -2813,7 +2802,7 @@
>  # @offset:      position where the block device starts
>  # @size:        the assumed size of the device
>  #
> -# Since: 2.8
> +# Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsRaw',
>    'base': 'BlockdevOptionsGenericFormat',
> @@ -2837,7 +2826,7 @@
>  #
>  # Remaining options are determined by the block driver.
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'union': 'BlockdevOptions',
>    'base': { 'driver': 'BlockdevDriver',
> @@ -2894,7 +2883,7 @@
>  #                   empty string means that no block device should be
>  #                   referenced.
>  #
> -# Since: 1.7
> +# Since: 2.9
>  ##
>  { 'alternate': 'BlockdevRef',
>    'data': { 'definition': 'BlockdevOptions',
> @@ -2907,11 +2896,7 @@
>  # BlockBackend will be created; otherwise, @node-name is mandatory at the top
>  # level and no BlockBackend will be created.
>  #
> -# Note: This command is still a work in progress.  It doesn't support all
> -# block drivers among other things.  Stay away from it unless you want
> -# to help with its development.
> -#
> -# Since: 1.7
> +# Since: 2.9
>  #
>  # Example:
>  #
> @@ -2957,7 +2942,7 @@
>  { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
>  
>  ##
> -# @x-blockdev-del:
> +# @blockdev-del:
>  #
>  # Deletes a block device that has been added using blockdev-add.
>  # The command will fail if the node is attached to a device or is
> @@ -2965,11 +2950,7 @@
>  #
>  # @node-name: Name of the graph node to delete.
>  #
> -# Note: This command is still a work in progress and is considered
> -# experimental. Stay away from it unless you want to help with its
> -# development.
> -#
> -# Since: 2.5
> +# Since: 2.9
>  #
>  # Example:
>  #
> @@ -2985,13 +2966,13 @@
>  #    }
>  # <- { "return": {} }
>  #
> -# -> { "execute": "x-blockdev-del",
> +# -> { "execute": "blockdev-del",
>  #      "arguments": { "node-name": "node0" }
>  #    }
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'x-blockdev-del', 'data': { 'node-name': 'str' } }
> +{ 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>  
>  ##
>  # @blockdev-open-tray:
> diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
> index 6d98e4f..175d8f0 100644
> --- a/tests/qemu-iotests/139
> +++ b/tests/qemu-iotests/139
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env python
>  #
> -# Test cases for the QMP 'x-blockdev-del' command
> +# Test cases for the QMP 'blockdev-del' command
>  #
>  # Copyright (C) 2015 Igalia, S.L.
>  # Author: Alberto Garcia <berto@igalia.com>
> @@ -79,7 +79,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
>      # Delete a BlockDriverState
>      def delBlockDriverState(self, node, expect_error = False):
>          self.checkBlockDriverState(node)
> -        result = self.vm.qmp('x-blockdev-del', node_name = node)
> +        result = self.vm.qmp('blockdev-del', node_name = node)
>          if expect_error:
>              self.assert_qmp(result, 'error/class', 'GenericError')
>          else:
> @@ -173,7 +173,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
>          self.wait_until_completed(id)
>  
>      # Add a BlkDebug node
> -    # Note that the purpose of this is to test the x-blockdev-del
> +    # Note that the purpose of this is to test the blockdev-del
>      # sanity checks, not to create a usable blkdebug drive
>      def addBlkDebug(self, debug, node):
>          self.checkBlockDriverState(node, False)
> @@ -191,7 +191,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
>          self.checkBlockDriverState(debug)
>  
>      # Add a BlkVerify node
> -    # Note that the purpose of this is to test the x-blockdev-del
> +    # Note that the purpose of this is to test the blockdev-del
>      # sanity checks, not to create a usable blkverify drive
>      def addBlkVerify(self, blkverify, test, raw):
>          self.checkBlockDriverState(test, False)
> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 6d8f0a1..27fb1cc 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141
> @@ -65,7 +65,7 @@ test_blockjob()
>  
>      # We want this to return an error because the block job is still running
>      _send_qemu_cmd $QEMU_HANDLE \
> -        "{'execute': 'x-blockdev-del',
> +        "{'execute': 'blockdev-del',
>            'arguments': {'node-name': 'drv0'}}" \
>          'error' | _filter_generated_node_ids
>  
> @@ -75,7 +75,7 @@ test_blockjob()
>          "$3"
>  
>      _send_qemu_cmd $QEMU_HANDLE \
> -        "{'execute': 'x-blockdev-del',
> +        "{'execute': 'blockdev-del',
>            'arguments': {'node-name': 'drv0'}}" \
>          'return'
>  }
> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> index 45469c9..cca75c5 100755
> --- a/tests/qemu-iotests/147
> +++ b/tests/qemu-iotests/147
> @@ -57,7 +57,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
>                                                      filename)
>                  break
>  
> -        result = self.vm.qmp('x-blockdev-del', node_name='nbd-blockdev')
> +        result = self.vm.qmp('blockdev-del', node_name='nbd-blockdev')
>          self.assert_qmp(result, 'return', {})
>  
>  
> 
