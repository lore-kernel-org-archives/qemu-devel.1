Received: from eggs.gnu.org ([2001:4830:134:3::10]:60504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD5M3-00060S-5i
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD5Lx-0006Jh-0b
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD5Lw-0006IT-KK
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 909A74E4EE
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:39:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170522213636.11550-1-eblake@redhat.com>
Date: Tue, 23 May 2017 10:39:30 +0200
In-Reply-To: <20170522213636.11550-1-eblake@redhat.com> (Eric Blake's message
	of "Mon, 22 May 2017 16:36:36 -0500")
Message-ID: <87efvghsql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> In the process of getting rid of docs/qmp-commands.txt, we
> managed to regress on any text that changed after the point
> where the move was first branched and when the move actually
> occurred.  For example, commit 3282eca for blockdev-snapshot
> re-added the extra "options" layer which had been cleaned up
> in commit 0153d2f.
>
> While I didn't audit for all such regressions, I did scrub
> for all bogus uses of nested "options".

I figure anything that changed in qmp-commands.txt between the first
base of Marc-Andr=C3=A9's work and its merge into master is at risk.

I don't know the exact first base.  "[PATCH 00/30] Move qapi
documentation to schema (part 1/5)" was posted on 2016-09-13.  September
2016 looks like a fair guess.  With a bit of extra margin:

$ git-log --oneline --since 2016-08-01 02b351d -- docs/qmp-commands.txt
e1ff3c6 monitor: fix qmp/hmp query-memdev not reporting IDs of memory backe=
nds
23dce38 block/curl: Drop TFTP "support"
312fe09 block: Add 'base-node' parameter to the 'block-stream' command
d89e666 COLO: Add 'x-colo-lost-heartbeat' command to trigger failover
68b5359 COLO: Add checkpoint-delay parameter for migrate-set-parameters
35a6ed4 migration: Introduce capability 'x-colo' to migration
0153d2f block: Remove "options" indirection from blockdev-add
2ff3025 migrate: move max-bandwidth and downtime-limit to migrate_set_param=
eter
0f183e6 Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into=
 staging
77a6da2 docs: Belatedly update for move of QMP/* to docs/
2d76e72 block: Add qdev ID to DEVICE_TRAY_MOVED
9ec8873 block: Remove BB interface from blockdev-add/del
7a9877a block: Accept device model name for block_set_io_throttle
70e2cb3 block: Accept device model name for blockdev-change-medium
fbe2d81 block: Accept device model name for eject
00949ba block: Accept device model name for x-blockdev-remove-medium
716df21 block: Accept device model name for x-blockdev-insert-medium
b33945c block: Accept device model name for blockdev-open/close-tray
bd6092e Replace qmp-commands.hx by docs/qmp-commands.txt

We can exclude the last one, because is Marc-Andr=C3=A9's.  Let's review the
diff:

   $ git-diff bd6092e 02b351d -- docs/qmp-commands.txt
   diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
   index acebeb3..18db4cd 100644
   --- a/docs/qmp-commands.txt
   +++ b/docs/qmp-commands.txt
   @@ -20,7 +20,7 @@ Also, the following notation is used to denote data fl=
ow:
    -> data issued by the Client
    <- Server data response

   -Please, refer to the QMP specification (QMP/qmp-spec.txt) for detailed
   +Please, refer to the QMP specification (docs/qmp-spec.txt) for detailed
    information on the Server command and response formats.

    NOTE: This document is temporary and will be replaced soon.

Rebased correctly.

   @@ -72,12 +72,14 @@ Eject a removable medium.

    Arguments:

   -- force: force ejection (json-bool, optional)
   -- device: device name (json-string)
   +- "force": force ejection (json-bool, optional)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)

This is eject.

The changed part was deleted by Marc-Andr=C3=A9 because it duplicates QAPI
schema comments in block.json.   These got the change.  Okay.

    Example:

   --> { "execute": "eject", "arguments": { "device": "ide1-cd0" } }
   +-> { "execute": "eject", "arguments": { "id": "ide0-1-0" } }
    <- { "return": {} }

    Note: The "force" argument defaults to false.

Regressed, not fixed in your patch.

   @@ -552,6 +554,16 @@ Example:
    -> { "execute": "migrate_set_downtime", "arguments": { "value": 0.1 } }
    <- { "return": {} }

   +x-colo-lost-heartbeat
   +--------------------
   +
   +Tell COLO that heartbeat is lost, a failover or takeover is needed.
   +
   +Example:
   +
   +-> { "execute": "x-colo-lost-heartbeat" }
   +<- { "return": {} }
   +

qapi-schema.json got the change.

    client_migrate_info
    -------------------

   @@ -738,8 +750,11 @@ Arguments:
    - "job-id": Identifier for the newly-created block job. If omitted,
                the device name will be used. (json-string, optional)
    - "device": The device name or node-name of a root node (json-string)
   -- "base": The file name of the backing image above which copying starts
   -          (json-string, optional)
   +- "base": The file name of the backing image above which copying starts.
   +          It cannot be set if 'base-node' is also set (json-string, opt=
ional)
   +- "base-node": the node name of the backing image above which copying s=
tarts.
   +               It cannot be set if 'base' is also set.
   +               (json-string, optional) (Since 2.8)
    - "backing-file": The backing file string to write into the active laye=
r. This
                      filename is not validated.

This is block-stream.  block-core.json got the change.

   @@ -1088,11 +1103,11 @@ Arguments:
    Example:

    -> { "execute": "blockdev-add",
   -                "arguments": { "options": { "driver": "qcow2",
   -                                            "node-name": "node1534",
   -                                            "file": { "driver": "file",
   -                                                      "filename": "hd1.=
qcow2" },
   -                                            "backing": "" } } }
   +                "arguments": { "driver": "qcow2",
   +                               "node-name": "node1534",
   +                               "file": { "driver": "file",
   +                                         "filename": "hd1.qcow2" },
   +                               "backing": "" } }

    <- { "return": {} }

This is blockdev-snapshot.  Regressed, fixed in your patch.

   @@ -1457,7 +1472,9 @@ Change I/O throttle limits for a block drive.

    Arguments:

   -- "device": device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)
    - "bps": total throughput limit in bytes per second (json-int)
    - "bps_rd": read throughput limit in bytes per second (json-int)
    - "bps_wr": write throughput limit in bytes per second (json-int)

This is block_set_io_throttle.  block-core.json got the change, in
documentation of BlockIOThrottle, and ...

   @@ -1481,7 +1498,7 @@ Arguments:

    Example:

   --> { "execute": "block_set_io_throttle", "arguments": { "device": "virt=
io0",
   +-> { "execute": "block_set_io_throttle", "arguments": { "id": "ide0-1-0=
",
                                                   "bps": 1000000,
                                                   "bps_rd": 0,
                                                   "bps_wr": 0,

... block_set_io_throttle.

   @@ -1786,7 +1803,7 @@ Each json-object contain the following:
                                    "file", "file", "ftp", "ftps", "host_cd=
rom",
                                    "host_device", "http", "https",
                                    "nbd", "parallels", "qcow", "qcow2", "r=
aw",
   -                                "tftp", "vdi", "vmdk", "vpc", "vvfat"
   +                                "vdi", "vmdk", "vpc", "vvfat"
             - "backing_file": backing file name (json-string, optional)
             - "backing_file_depth": number of files in the backing file ch=
ain (json-int)
             - "encrypted": true if encrypted, false otherwise (json-bool)

This is query-block.  block-core.json got the change, in documentation
of BlockDeviceInfo.

   @@ -2857,6 +2874,7 @@ Enable/Disable migration capabilities
    - "compress": use multiple compression threads to accelerate live migra=
tion
    - "events": generate events for each migration state change
    - "postcopy-ram": postcopy mode for live migration
   +- "x-colo": COarse-Grain LOck Stepping (COLO) for Non-stop Service

    Arguments:

This is migrate-set-capabilities.  qapi-schema.json got the change, in
documentation of MigrationCapability.

   @@ -2878,6 +2896,7 @@ Query current migration capabilities
             - "compress": Multiple compression threads state (json-bool)
             - "events": Migration state change event state (json-bool)
             - "postcopy-ram": postcopy ram state (json-bool)
   +         - "x-colo": COarse-Grain LOck Stepping for Non-stop Service (j=
son-bool)

    Arguments:

This is query-migrate-capabilities.  qapi-schema.json got the change, in
MigrationCapability.


   @@ -2891,7 +2910,8 @@ Example:
         {"state": false, "capability": "zero-blocks"},
         {"state": false, "capability": "compress"},
         {"state": true, "capability": "events"},
   -     {"state": false, "capability": "postcopy-ram"}
   +     {"state": false, "capability": "postcopy-ram"},
   +     {"state": false, "capability": "x-colo"}
       ]}

Still query-migrate-capabilities.  Likewise.


    migrate-set-parameters
   @@ -2906,6 +2926,10 @@ Set migration parameters
                              throttled for auto-converge (json-int)
    - "cpu-throttle-increment": set throttle increasing percentage for
                                auto-converge (json-int)
   +- "max-bandwidth": set maximum speed for migrations (in bytes/sec) (jso=
n-int)
   +- "downtime-limit": set maximum tolerated downtime (in milliseconds) for
   +                    migrations (json-int)
   +- "x-checkpoint-delay": set the delay time for periodic checkpoint (jso=
n-int)

    Arguments:

This is migrate-set-parameters.  qapi-schema.json got the change, in
MigrationParameters.

   @@ -2927,7 +2951,10 @@ Query current migration parameters
                                        throttled (json-int)
             - "cpu-throttle-increment" : throttle increasing percentage for
                                          auto-converge (json-int)
   -
   +         - "max-bandwidth" : maximium migration speed in bytes per seco=
nd
   +                             (json-int)
   +         - "downtime-limit" : maximum tolerated downtime of migration in
   +                              milliseconds (json-int)
    Arguments:

This is query-migrate-parameters.  Likewise.

    Example:
   @@ -2939,7 +2966,9 @@ Example:
             "cpu-throttle-increment": 10,
             "compress-threads": 8,
             "compress-level": 1,
   -         "cpu-throttle-initial": 20
   +         "cpu-throttle-initial": 20,
   +         "max-bandwidth": 33554432,
   +         "downtime-limit": 300
          }
       }

Still query-migrate-parameters.  qapi-schema.json got the change.

   @@ -3119,41 +3148,37 @@ This command is still a work in progress.  It do=
esn't support all
    block drivers among other things.  Stay away from it unless you want
    to help with its development.

   -Arguments:
   -
   -- "options": block driver options
   +For the arguments, see the QAPI schema documentation of BlockdevOptions.

    Example (1):

    -> { "execute": "blockdev-add",
   -    "arguments": { "options" : { "driver": "qcow2",
   -                                 "file": { "driver": "file",
   -                                           "filename": "test.qcow2" } }=
 } }
   +    "arguments": { "driver": "qcow2",
   +                   "file": { "driver": "file",
   +                             "filename": "test.qcow2" } } }
    <- { "return": {} }

    Example (2):

    -> { "execute": "blockdev-add",
         "arguments": {
   -         "options": {
   -           "driver": "qcow2",
   -           "id": "my_disk",
   -           "discard": "unmap",
   -           "cache": {
   -               "direct": true,
   -               "writeback": true
   -           },
   -           "file": {
   -               "driver": "file",
   -               "filename": "/tmp/test.qcow2"
   -           },
   -           "backing": {
   -               "driver": "raw",
   -               "file": {
   -                   "driver": "file",
   -                   "filename": "/dev/fdset/4"
   -               }
   -           }
   +         "driver": "qcow2",
   +         "node-name": "my_disk",
   +         "discard": "unmap",
   +         "cache": {
   +             "direct": true,
   +             "writeback": true
   +         },
   +         "file": {
   +             "driver": "file",
   +             "filename": "/tmp/test.qcow2"
   +         },
   +         "backing": {
   +             "driver": "raw",
   +             "file": {
   +                 "driver": "file",
   +                 "filename": "/dev/fdset/4"
   +             }
             }
           }
         }

This is blockdev-add.  Regressed initially, but was fixed in commit
b1660997.

   @@ -3164,18 +3189,9 @@ x-blockdev-del
    ------------
    Since 2.5

   -Deletes a block device thas has been added using blockdev-add.
   -The selected device can be either a block backend or a graph node.
   -
   -In the former case the backend will be destroyed, along with its
   -inserted medium if there's any. The command will fail if the backend
   -or its medium are in use.
   -
   -In the latter case the node will be destroyed. The command will fail
   -if the node is attached to a block backend or is otherwise being
   -used.
   -
   -One of "id" or "node-name" must be specified, but not both.
   +Deletes a block device that has been added using blockdev-add.
   +The command will fail if the node is attached to a device or is
   +otherwise being used.

    This command is still a work in progress and is considered
    experimental. Stay away from it unless you want to help with its


This is blockdev-del.  block-core.json got the change.

   @@ -3183,20 +3199,17 @@ development.

    Arguments:

   -- "id": Name of the block backend device to delete (json-string, option=
al)
   -- "node-name": Name of the graph node to delete (json-string, optional)
   +- "node-name": Name of the graph node to delete (json-string)

    Example:

    -> { "execute": "blockdev-add",
         "arguments": {
   -         "options": {
   -             "driver": "qcow2",
   -             "id": "drive0",
   -             "file": {
   -                 "driver": "file",
   -                 "filename": "test.qcow2"
   -             }
   +         "driver": "qcow2",
   +         "node-name": "node0",
   +         "file": {
   +             "driver": "file",
   +             "filename": "test.qcow2"
             }
         }
       }
   @@ -3204,7 +3217,7 @@ Example:
    <- { "return": {} }

    -> { "execute": "x-blockdev-del",
   -     "arguments": { "id": "drive0" }
   +     "arguments": { "node-name": "node0" }
       }
    <- { "return": {} }

Likewise.

   @@ -3228,7 +3241,9 @@ which no such event will be generated, these inclu=
de:

    Arguments:

   -- "device": block device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)
    - "force": if false (the default), an eject request will be sent to the=
 guest if
               it has locked the tray (and the tray will not be opened imme=
diately);
               if true, the tray will be opened regardless of whether it is=
 locked

This is blockdev-open-tray.  block-core.json got the change.

   @@ -3237,12 +3252,13 @@ Arguments:
    Example:

    -> { "execute": "blockdev-open-tray",
   -     "arguments": { "device": "ide1-cd0" } }
   +     "arguments": { "id": "ide0-1-0" } }

    <- { "timestamp": { "seconds": 1418751016,
                        "microseconds": 716996 },
         "event": "DEVICE_TRAY_MOVED",
         "data": { "device": "ide1-cd0",
   +               "id": "ide0-1-0",
                   "tray-open": true } }

    <- { "return": {} }

Likewise.

   @@ -3258,17 +3274,20 @@ If the tray was already closed before, this will=
 be a no-op.

    Arguments:

   -- "device": block device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)

    Example:

    -> { "execute": "blockdev-close-tray",
   -     "arguments": { "device": "ide1-cd0" } }
   +     "arguments": { "id": "ide0-1-0" } }

    <- { "timestamp": { "seconds": 1418751345,
                        "microseconds": 272147 },
         "event": "DEVICE_TRAY_MOVED",
         "data": { "device": "ide1-cd0",
   +               "id": "ide0-1-0",
                   "tray-open": false } }

    <- { "return": {} }

This is blockdev-close-tray.  block-core.json got the change.

   @@ -3286,29 +3305,32 @@ Stay away from it unless you want to help with i=
ts development.

    Arguments:

   -- "device": block device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)

    Example:

    -> { "execute": "x-blockdev-remove-medium",
   -     "arguments": { "device": "ide1-cd0" } }
   +     "arguments": { "id": "ide0-1-0" } }

    <- { "error": { "class": "GenericError",
   -                "desc": "Tray of device 'ide1-cd0' is not open" } }
   +                "desc": "Tray of device 'ide0-1-0' is not open" } }

    -> { "execute": "blockdev-open-tray",
   -     "arguments": { "device": "ide1-cd0" } }
   +     "arguments": { "id": "ide0-1-0" } }

    <- { "timestamp": { "seconds": 1418751627,
                        "microseconds": 549958 },
         "event": "DEVICE_TRAY_MOVED",
         "data": { "device": "ide1-cd0",
   +               "id": "ide0-1-0",
                   "tray-open": true } }

    <- { "return": {} }

    -> { "execute": "x-blockdev-remove-medium",
   -     "arguments": { "device": "ide1-cd0" } }
   +     "arguments": { "device": "ide0-1-0" } }

    <- { "return": {} }

This is x-blockdev-remove-medium.  block-core.json got the change.
However, the example still uses deprecated "device" instead of "id".

   @@ -3324,21 +3346,23 @@ Stay away from it unless you want to help with i=
ts development.

    Arguments:

   -- "device": block device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)
    - "node-name": root node of the BDS tree to insert into the block device

This is x-blockdev-insert-medium.  block-core.json got the change.

    Example:

    -> { "execute": "blockdev-add",
   -     "arguments": { "options": { "node-name": "node0",
   -                                 "driver": "raw",
   -                                 "file": { "driver": "file",
   -                                           "filename": "fedora.iso" } }=
 } }
   +     "arguments": { { "node-name": "node0",
   +                      "driver": "raw",
   +                      "file": { "driver": "file",
   +                                "filename": "fedora.iso" } } }

    <- { "return": {} }

    -> { "execute": "x-blockdev-insert-medium",
   -     "arguments": { "device": "ide1-cd0",
   +     "arguments": { "id": "ide0-1-0",
                        "node-name": "node0" } }

    <- { "return": {} }

Regressed, fixed in your patch.

   @@ -3371,10 +3395,10 @@ Example:

    Add a new node to a quorum
    -> { "execute": "blockdev-add",
   -     "arguments": { "options": { "driver": "raw",
   -                                 "node-name": "new_node",
   -                                 "file": { "driver": "file",
   -                                           "filename": "test.raw" } } }=
 }
   +     "arguments": { "driver": "raw",
   +                    "node-name": "new_node",
   +                    "file": { "driver": "file",
   +                              "filename": "test.raw" } } }
    <- { "return": {} }
    -> { "execute": "x-blockdev-change",
         "arguments": { "parent": "disk1",

This is x-blockdev-change.  Regressed, fixed in your patch.


   @@ -3448,7 +3472,9 @@ and loading a new image file which is inserted as =
the new medium.

    Arguments:

   -- "device": device name (json-string)
   +- "device": block device name (deprecated, use @id instead)
   +            (json-string, optional)
   +- "id": the name or QOM path of the guest device (json-string, optional)
    - "filename": filename of the new image (json-string)
    - "format": format of the new image (json-string, optional)
    - "read-only-mode": new read-only mode (json-string, optional)

This is blockdev-change-medium.  block-core.json got the change.

   @@ -3459,7 +3485,7 @@ Examples:
    1. Change a removable medium

    -> { "execute": "blockdev-change-medium",
   -             "arguments": { "device": "ide1-cd0",
   +             "arguments": { "id": "ide0-1-0",
                                "filename": "/srv/images/Fedora-12-x86_64-D=
VD.iso",
                                "format": "raw" } }
    <- { "return": {} }
   @@ -3467,7 +3493,7 @@ Examples:
    2. Load a read-only medium into a writable drive

    -> { "execute": "blockdev-change-medium",
   -             "arguments": { "device": "isa-fd0",
   +             "arguments": { "id": "floppyA",
                                "filename": "/srv/images/ro.img",
                                "format": "raw",
                                "read-only-mode": "retain" } }
   @@ -3477,7 +3503,7 @@ Examples:
           "desc": "Could not open '/srv/images/ro.img': Permission denied"=
 } }

    -> { "execute": "blockdev-change-medium",
   -             "arguments": { "device": "isa-fd0",
   +             "arguments": { "id": "floppyA",
                                "filename": "/srv/images/ro.img",
                                "format": "raw",
                                "read-only-mode": "read-only" } }

Likewise.

   @@ -3503,6 +3529,7 @@ Example (1):
             "policy": "bind"
           },
           {
   +         "id": "mem1",
             "size": 536870912,
             "merge": false,
             "dump": true,

This is query-memdev.  qapi-schema.json got the change, but in the
*other* element of the returned list.  I guess that's okay.

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6b974b9..3bd7fa2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1206,11 +1206,11 @@
>  # Example:
>  #
>  # -> { "execute": "blockdev-add",
> -#      "arguments": { "options": { "driver": "qcow2",
> -#                                  "node-name": "node1534",
> -#                                  "file": { "driver": "file",
> -#                                            "filename": "hd1.qcow2" },
> -#                                  "backing": "" } } }
> +#      "arguments": { "driver": "qcow2",
> +#                     "node-name": "node1534",
> +#                     "file": { "driver": "file",
> +#                               "filename": "hd1.qcow2" },
> +#                     "backing": "" } }
>  #
>  # <- { "return": {} }
>  #
> @@ -3237,10 +3237,10 @@
>  #
>  # -> { "execute": "blockdev-add",
>  #      "arguments": {
> -#          "options": { "node-name": "node0",
> -#                       "driver": "raw",
> -#                       "file": { "driver": "file",
> -#                                 "filename": "fedora.iso" } } } }
> +#          "node-name": "node0",
> +#          "driver": "raw",
> +#          "file": { "driver": "file",
> +#                    "filename": "fedora.iso" } } }
>  # <- { "return": {} }
>  #
>  # -> { "execute": "x-blockdev-insert-medium",
> @@ -3693,10 +3693,10 @@
>  # 1. Add a new node to a quorum
>  # -> { "execute": "blockdev-add",
>  #      "arguments": {
> -#          "options": { "driver": "raw",
> -#                       "node-name": "new_node",
> -#                        "file": { "driver": "file",
> -#                                  "filename": "test.raw" } } } }
> +#          "driver": "raw",
> +#          "node-name": "new_node",
> +#          "file": { "driver": "file",
> +#                    "filename": "test.raw" } } }
>  # <- { "return": {} }
>  # -> { "execute": "x-blockdev-change",
>  #      "arguments": { "parent": "disk1",

Please throw in a fix for the remaining regression of 'eject'.  Whether
you squash it into this one or keep it separate is up to you.  For this
part:

Reviewed-by: Markus Armbruster <armbru@redhat.com>
