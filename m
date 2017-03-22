Received: from eggs.gnu.org ([2001:4830:134:3::10]:37121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkuw-0003Yz-4K
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkur-0003Kz-Vd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkur-0003KK-N8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 819177F7C5
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 18:23:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490199642-5521-1-git-send-email-armbru@redhat.com>
	<01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
Date: Wed, 22 Mar 2017 19:23:21 +0100
In-Reply-To: <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com> (Max Reitz's
	message of "Wed, 22 Mar 2017 18:13:56 +0100")
Message-ID: <87h92l9nmu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

Max Reitz <mreitz@redhat.com> writes:

> On 22.03.2017 17:20, Markus Armbruster wrote:
>> It's been a long journey, but here we are.
>> 
>> The supported blockdev-add is not compatible to its experimental
>> predecessors; bump all Since: tags to 2.9.
>> 
>> x-blockdev-remove-medium, x-blockdev-insert-medium and
>> x-blockdev-change need a bit more work, so leave them alone for now.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> v2:
>> * Another "command is considered experimental" comment dropped [Max]
>> * More Since: tags updated to 2.9, commit message improved, R-bys dropped
>
> Do you want to do this recursively? There are things such as
> BlkdebugSetStateOptions or ReplicationMode which are only used by the
> corresponding BlockdevOptions*, so they too are basically only supported
> as of 2.9.

Fixup appended.

> I don't have a strong opinion, but I think I personally wouldn't bother
> with any of these structures and just update the tag for blockdev-add
> itself...

Kevin, what about you?

Since: tags on types are kind of redundant, as types become part of the
public interface only via commands and events.  The real Since: is the
oldest command or event exposing it.  But explaining that is too
complicated.  It's better to tell people to always add Since: tags.

Now if the QAPI generators could tell them when to add and when not to
add Since: tags...

> You being fine with me would be enough to convince me, so:
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!



diff --git a/qapi/block-core.json b/qapi/block-core.json
index bd39b3f..f938316 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2053,7 +2053,7 @@
 # @ignore:      Ignore the request
 # @unmap:       Forward as an unmap request
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'enum': 'BlockdevDiscardOptions',
   'data': [ 'ignore', 'unmap' ] }
@@ -2082,7 +2082,7 @@
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
   'data': [ 'threads', 'native' ] }
@@ -2097,7 +2097,7 @@
 # @no-flush:    ignore any flush requests for the device (default:
 #               false)
 #
-# Since: 1.7
+# Since: 2.9
 ##
 { 'struct': 'BlockdevCacheOptions',
   'data': { '*direct': 'bool',
@@ -2229,7 +2229,7 @@
 #
 # @all:         Perform all available overlap checks
 #
-# Since: 2.2
+# Since: 2.9
 ##
 { 'enum': 'Qcow2OverlapCheckMode',
   'data': [ 'none', 'constant', 'cached', 'all' ] }
@@ -2244,7 +2244,7 @@
 # @template: Specifies a template mode which can be adjusted using the other
 #            flags, defaults to 'cached'
 #
-# Since: 2.2
+# Since: 2.9
 ##
 { 'struct': 'Qcow2OverlapCheckFlags',
   'data': { '*template':       'Qcow2OverlapCheckMode',
@@ -2268,7 +2268,7 @@
 #
 # @mode:    named mode which chooses a specific set of flags
 #
-# Since: 2.2
+# Since: 2.9
 ##
 { 'alternate': 'Qcow2OverlapChecks',
   'data': { 'flags': 'Qcow2OverlapCheckFlags',
@@ -2349,7 +2349,7 @@
 #
 # Trigger events supported by blkdebug.
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
   'data': [ 'l1_update', 'l1_grow_alloc_table', 'l1_grow_write_table',
@@ -2389,7 +2389,7 @@
 #
 # @immediately: fail immediately; defaults to false
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'struct': 'BlkdebugInjectErrorOptions',
   'data': { 'event': 'BlkdebugEvent',
@@ -2412,7 +2412,7 @@
 # @new_state:   the state identifier blkdebug is supposed to assume if
 #               this event is triggered
 #
-# Since: 2.0
+# Since: 2.9
 ##
 { 'struct': 'BlkdebugSetStateOptions',
   'data': { 'event': 'BlkdebugEvent',
@@ -2468,7 +2468,7 @@
 #
 # @fifo: read only from the first child that has not failed
 #
-# Since: 2.2
+# Since: 2.9
 ##
 { 'enum': 'QuorumReadPattern', 'data': [ 'quorum', 'fifo' ] }
 
@@ -2674,7 +2674,7 @@
 #
 # @secondary: Secondary mode, receive the vm's state from primary QEMU.
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
 
@@ -2703,7 +2703,7 @@
 #
 # @inet:        TCP transport
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'enum': 'NFSTransport',
   'data': [ 'inet' ] }
@@ -2717,7 +2717,7 @@
 #
 # @host:        host address for NFS server
 #
-# Since: 2.8
+# Since: 2.9
 ##
 { 'struct': 'NFSServer',
   'data': { 'type': 'NFSTransport',
