Received: from eggs.gnu.org ([2001:4830:134:3::10]:55948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqguV-0004fY-Di
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqguS-0004iH-9h
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqguS-0004i5-1D
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:06:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35431C00B915
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 14:06:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Date: Wed, 22 Mar 2017 15:06:39 +0100
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Tue, 21 Mar 2017 17:57:53 +0100")
Message-ID: <87h92ljths.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> It's been a long journey, but here we are.
>
> x-blockdev-remove-medium, x-blockdev-insert-medium and
> x-blockdev-change need a bit more work, so leave them alone for now.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0f132fc..5d913d4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2907,11 +2907,7 @@
>  # BlockBackend will be created; otherwise, @node-name is mandatory at the top
>  # level and no BlockBackend will be created.
>  #
> -# Note: This command is still a work in progress.  It doesn't support all
> -# block drivers among other things.  Stay away from it unless you want
> -# to help with its development.
> -#
> -# Since: 1.7
> +# Since: 2.9

I update this because older versions of blockdev-add are incompatible.
I neglected to update the BlockdevOptionsFOO and other related types
similarly.  Let's squash in the appended patch.

>  #
>  # Example:
>  #
> @@ -2957,7 +2953,7 @@
>  { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
>  
>  ##
> -# @x-blockdev-del:
> +# @blockdev-del:
>  #
>  # Deletes a block device that has been added using blockdev-add.
>  # The command will fail if the node is attached to a device or is
[...]

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5d913d4..60a5ed7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2108,18 +2108,7 @@
 #
 # Drivers that are supported in block device operations.
 #
-# @host_device: Since 2.1
-# @host_cdrom: Since 2.1
-# @gluster: Since 2.7
-# @nbd: Since 2.8
-# @nfs: Since 2.8
-# @replication: Since 2.8
-# @ssh: Since 2.8
-# @iscsi: Since 2.9
-# @rbd: Since 2.9
-# @sheepdog: Since 2.9
-#
-# Since: 2.0
+# Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
@@ -2137,7 +2126,7 @@
 # @filename:    path to the image file
 # @aio:         AIO backend (default: threads) (since: 2.8)
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsFile',
   'data': { 'filename': 'str',
@@ -2153,7 +2142,7 @@
 #              requests. Default to zero which completes requests immediately.
 #              (Since 2.4)
 #
-# Since: 2.2
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNull',
   'data': { '*size': 'int', '*latency-ns': 'uint64' } }
@@ -2173,7 +2162,7 @@
 #               (since 2.4)
 # @rw:          whether to allow write operations (default: false)
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsVVFAT',
   'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
@@ -2187,7 +2176,7 @@
 #
 # @file:        reference to or definition of the data source block device
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsGenericFormat',
   'data': { 'file': 'BlockdevRef' } }
@@ -2201,7 +2190,7 @@
 #              the decryption key (since 2.6). Mandatory except when
 #              doing a metadata-only probe of the image.
 #
-# Since: 2.6
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
@@ -2219,7 +2208,7 @@
 #               allowed to pass an empty string here in order to disable the
 #               default backing file.
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsGenericCOWFormat',
   'base': 'BlockdevOptionsGenericFormat',
@@ -2320,7 +2309,7 @@
 #                         caches. The interval is in seconds. The default value
 #                         is 0 and it disables this feature (since 2.5)
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsQcow2',
   'base': 'BlockdevOptionsGenericCOWFormat',
@@ -2347,7 +2336,7 @@
 #
 # TODO: Expose the host_key_check option in QMP
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSsh',
   'data': { 'server': 'InetSocketAddress',
@@ -2446,7 +2435,7 @@
 #
 # @set-state:       array of state-change descriptions
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsBlkdebug',
   'data': { 'image': 'BlockdevRef',
@@ -2464,7 +2453,7 @@
 #
 # @raw:     raw image used for verification
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsBlkverify',
   'data': { 'test': 'BlockdevRef',
@@ -2501,7 +2490,7 @@
 # @read-pattern: choose read pattern and set to quorum by default
 #                (Since 2.2)
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsQuorum',
   'data': { '*blkverify': 'bool',
@@ -2526,7 +2515,7 @@
 #
 # @logfile:     libgfapi log file (default /dev/stderr) (Since 2.8)
 #
-# Since: 2.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsGluster',
   'data': { 'volume': 'str',
@@ -2700,7 +2689,7 @@
 #          node who owns the replication node chain. Must not be given in
 #          primary mode.
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsReplication',
   'base': 'BlockdevOptionsGenericFormat',
@@ -2763,7 +2752,7 @@
 # @debug:                   set the NFS debug level (max 2) (defaults
 #                           to libnfs default)
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNfs',
   'data': { 'server': 'NFSServer',
@@ -2782,7 +2771,7 @@
 #
 # @filename:    path to the image file
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurl',
   'data': { 'filename': 'str' } }
@@ -2798,7 +2787,7 @@
 #
 # @tls-creds:   TLS credentials ID
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
@@ -2813,7 +2802,7 @@
 # @offset:      position where the block device starts
 # @size:        the assumed size of the device
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsRaw',
   'base': 'BlockdevOptionsGenericFormat',
@@ -2837,7 +2826,7 @@
 #
 # Remaining options are determined by the block driver.
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'union': 'BlockdevOptions',
   'base': { 'driver': 'BlockdevDriver',
@@ -2894,7 +2883,7 @@
 #                   empty string means that no block device should be
 #                   referenced.
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'alternate': 'BlockdevRef',
   'data': { 'definition': 'BlockdevOptions',
