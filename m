Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCbZ-0005Pf-9H
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCbW-0004TZ-3y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:16:49 -0400
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:33733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlCbV-0004TO-SJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:16:46 -0400
Received: by mail-ua0-x235.google.com with SMTP id d12so6746553uag.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 04:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-11-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 11:16:35 +0000
Message-ID: <CAJ+F1CKt8LyAB3rEy718+K-pwppYFm3YdAj4-S9Sb1sqWCxo0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/16] qapi-schema: Collect transaction
 stuff in qapi/transaction.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Aug 24, 2017 at 9:18 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  MAINTAINERS           |   1 +
>  Makefile              |   1 +
>  qapi-schema.json      | 151
> +----------------------------------------------
>  qapi/transaction.json | 158
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 161 insertions(+), 150 deletions(-)
>  create mode 100644 qapi/transaction.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index baa9859..8cebd79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1231,6 +1231,7 @@ S: Supported
>  F: blockdev.c
>  F: block/qapi.c
>  F: qapi/block*.json
> +F: qapi/transaction.json
>  T: git git://repo.or.cz/qemu/armbru.git block-next
>
>  Dirty Bitmaps
> diff --git a/Makefile b/Makefile
> index 18cf670..ea6de37 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -419,6 +419,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json
> $(SRC_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/run-state.json \
>                 $(SRC_PATH)/qapi/sockets.json \
>                 $(SRC_PATH)/qapi/trace.json \
> +               $(SRC_PATH)/qapi/transaction.json \
>                 $(SRC_PATH)/qapi/ui.json
>
>  qapi-types.c qapi-types.h :\
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 21f54ea..4108ef0 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -88,6 +88,7 @@
>  { 'include': 'qapi/rocker.json' }
>  { 'include': 'qapi/ui.json' }
>  { 'include': 'qapi/migration.json' }
> +{ 'include': 'qapi/transaction.json' }
>  { 'include': 'qapi/event.json' }
>  { 'include': 'qapi/trace.json' }
>  { 'include': 'qapi/introspect.json' }
> @@ -1097,156 +1098,6 @@
>  { 'command': 'balloon', 'data': {'value': 'int'} }
>
>  ##
> -# @Abort:
> -#
> -# This action can be used to test transaction failure.
> -#
> -# Since: 1.6
> -##
> -{ 'struct': 'Abort',
> -  'data': { } }
> -
> -##
> -# @ActionCompletionMode:
> -#
> -# An enumeration of Transactional completion modes.
> -#
> -# @individual: Do not attempt to cancel any other Actions if any Actions
> fail
> -#              after the Transaction request succeeds. All Actions that
> -#              can complete successfully will do so without waiting on
> others.
> -#              This is the default.
> -#
> -# @grouped: If any Action fails after the Transaction succeeds, cancel a=
ll
> -#           Actions. Actions do not complete until all Actions are ready
> to
> -#           complete. May be rejected by Actions that do not support thi=
s
> -#           completion mode.
> -#
> -# Since: 2.5
> -##
> -{ 'enum': 'ActionCompletionMode',
> -  'data': [ 'individual', 'grouped' ] }
> -
> -##
> -# @TransactionAction:
> -#
> -# A discriminated record of operations that can be performed with
> -# @transaction. Action @type can be:
> -#
> -# - @abort: since 1.6
> -# - @block-dirty-bitmap-add: since 2.5
> -# - @block-dirty-bitmap-clear: since 2.5
> -# - @blockdev-backup: since 2.3
> -# - @blockdev-snapshot: since 2.5
> -# - @blockdev-snapshot-internal-sync: since 1.7
> -# - @blockdev-snapshot-sync: since 1.1
> -# - @drive-backup: since 1.6
> -#
> -# Since: 1.1
> -##
> -{ 'union': 'TransactionAction',
> -  'data': {
> -       'abort': 'Abort',
> -       'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
> -       'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
> -       'blockdev-backup': 'BlockdevBackup',
> -       'blockdev-snapshot': 'BlockdevSnapshot',
> -       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> -       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
> -       'drive-backup': 'DriveBackup'
> -   } }
> -
> -##
> -# @TransactionProperties:
> -#
> -# Optional arguments to modify the behavior of a Transaction.
> -#
> -# @completion-mode: Controls how jobs launched asynchronously by
> -#                   Actions will complete or fail as a group.
> -#                   See @ActionCompletionMode for details.
> -#
> -# Since: 2.5
> -##
> -{ 'struct': 'TransactionProperties',
> -  'data': {
> -       '*completion-mode': 'ActionCompletionMode'
> -  }
> -}
> -
> -##
> -# @transaction:
> -#
> -# Executes a number of transactionable QMP commands atomically. If any
> -# operation fails, then the entire set of actions will be abandoned and
> the
> -# appropriate error returned.
> -#
> -# For external snapshots, the dictionary contains the device, the file t=
o
> use for
> -# the new snapshot, and the format.  The default format, if not
> specified, is
> -# qcow2.
> -#
> -# Each new snapshot defaults to being created by QEMU (wiping any
> -# contents if the file already exists), but it is also possible to reuse
> -# an externally-created file.  In the latter case, you should ensure tha=
t
> -# the new image file has the same contents as the current one; QEMU cann=
ot
> -# perform any meaningful check.  Typically this is achieved by using the
> -# current image file as the backing file for the new image.
> -#
> -# On failure, the original disks pre-snapshot attempt will be used.
> -#
> -# For internal snapshots, the dictionary contains the device and the
> snapshot's
> -# name.  If an internal snapshot matching name already exists, the
> request will
> -# be rejected.  Only some image formats support it, for example, qcow2,
> rbd,
> -# and sheepdog.
> -#
> -# On failure, qemu will try delete the newly created internal snapshot i=
n
> the
> -# transaction.  When an I/O error occurs during deletion, the user needs
> to fix
> -# it later with qemu-img or other command.
> -#
> -# @actions: List of @TransactionAction;
> -#           information needed for the respective operations.
> -#
> -# @properties: structure of additional options to control the
> -#              execution of the transaction. See @TransactionProperties
> -#              for additional detail.
> -#
> -# Returns: nothing on success
> -#
> -#          Errors depend on the operations of the transaction
> -#
> -# Note: The transaction aborts on the first failure.  Therefore, there
> will be
> -# information on only one failed operation returned in an error
> condition, and
> -# subsequent actions will not have been attempted.
> -#
> -# Since: 1.1
> -#
> -# Example:
> -#
> -# -> { "execute": "transaction",
> -#      "arguments": { "actions": [
> -#          { "type": "blockdev-snapshot-sync", "data" : { "device":
> "ide-hd0",
> -#                                      "snapshot-file":
> "/some/place/my-image",
> -#                                      "format": "qcow2" } },
> -#          { "type": "blockdev-snapshot-sync", "data" : { "node-name":
> "myfile",
> -#                                      "snapshot-file":
> "/some/place/my-image2",
> -#                                      "snapshot-node-name": "node3432",
> -#                                      "mode": "existing",
> -#                                      "format": "qcow2" } },
> -#          { "type": "blockdev-snapshot-sync", "data" : { "device":
> "ide-hd1",
> -#                                      "snapshot-file":
> "/some/place/my-image2",
> -#                                      "mode": "existing",
> -#                                      "format": "qcow2" } },
> -#          { "type": "blockdev-snapshot-internal-sync", "data" : {
> -#                                      "device": "ide-hd2",
> -#                                      "name": "snapshot0" } } ] } }
> -# <- { "return": {} }
> -#
> -##
> -{ 'command': 'transaction',
> -  'data': { 'actions': [ 'TransactionAction' ],
> -            '*properties': 'TransactionProperties'
> -          }
> -}
> -
> -##
>  # @human-monitor-command:
>  #
>  # Execute a command on the human monitor and return the output.
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> new file mode 100644
> index 0000000..bd31279
> --- /dev/null
> +++ b/qapi/transaction.json
> @@ -0,0 +1,158 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# =3D Transactions
> +##
> +
> +{ 'include': 'block.json' }
> +
> +##
> +# @Abort:
> +#
> +# This action can be used to test transaction failure.
> +#
> +# Since: 1.6
> +##
> +{ 'struct': 'Abort',
> +  'data': { } }
> +
> +##
> +# @ActionCompletionMode:
> +#
> +# An enumeration of Transactional completion modes.
> +#
> +# @individual: Do not attempt to cancel any other Actions if any Actions
> fail
> +#              after the Transaction request succeeds. All Actions that
> +#              can complete successfully will do so without waiting on
> others.
> +#              This is the default.
> +#
> +# @grouped: If any Action fails after the Transaction succeeds, cancel a=
ll
> +#           Actions. Actions do not complete until all Actions are ready
> to
> +#           complete. May be rejected by Actions that do not support thi=
s
> +#           completion mode.
> +#
> +# Since: 2.5
> +##
> +{ 'enum': 'ActionCompletionMode',
> +  'data': [ 'individual', 'grouped' ] }
> +
> +##
> +# @TransactionAction:
> +#
> +# A discriminated record of operations that can be performed with
> +# @transaction. Action @type can be:
> +#
> +# - @abort: since 1.6
> +# - @block-dirty-bitmap-add: since 2.5
> +# - @block-dirty-bitmap-clear: since 2.5
> +# - @blockdev-backup: since 2.3
> +# - @blockdev-snapshot: since 2.5
> +# - @blockdev-snapshot-internal-sync: since 1.7
> +# - @blockdev-snapshot-sync: since 1.1
> +# - @drive-backup: since 1.6
> +#
> +# Since: 1.1
> +##
> +{ 'union': 'TransactionAction',
> +  'data': {
> +       'abort': 'Abort',
> +       'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
> +       'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
> +       'blockdev-backup': 'BlockdevBackup',
> +       'blockdev-snapshot': 'BlockdevSnapshot',
> +       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> +       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
> +       'drive-backup': 'DriveBackup'
> +   } }
> +
> +##
> +# @TransactionProperties:
> +#
> +# Optional arguments to modify the behavior of a Transaction.
> +#
> +# @completion-mode: Controls how jobs launched asynchronously by
> +#                   Actions will complete or fail as a group.
> +#                   See @ActionCompletionMode for details.
> +#
> +# Since: 2.5
> +##
> +{ 'struct': 'TransactionProperties',
> +  'data': {
> +       '*completion-mode': 'ActionCompletionMode'
> +  }
> +}
> +
> +##
> +# @transaction:
> +#
> +# Executes a number of transactionable QMP commands atomically. If any
> +# operation fails, then the entire set of actions will be abandoned and
> the
> +# appropriate error returned.
> +#
> +# For external snapshots, the dictionary contains the device, the file t=
o
> use for
> +# the new snapshot, and the format.  The default format, if not
> specified, is
> +# qcow2.
> +#
> +# Each new snapshot defaults to being created by QEMU (wiping any
> +# contents if the file already exists), but it is also possible to reuse
> +# an externally-created file.  In the latter case, you should ensure tha=
t
> +# the new image file has the same contents as the current one; QEMU cann=
ot
> +# perform any meaningful check.  Typically this is achieved by using the
> +# current image file as the backing file for the new image.
> +#
> +# On failure, the original disks pre-snapshot attempt will be used.
> +#
> +# For internal snapshots, the dictionary contains the device and the
> snapshot's
> +# name.  If an internal snapshot matching name already exists, the
> request will
> +# be rejected.  Only some image formats support it, for example, qcow2,
> rbd,
> +# and sheepdog.
> +#
> +# On failure, qemu will try delete the newly created internal snapshot i=
n
> the
> +# transaction.  When an I/O error occurs during deletion, the user needs
> to fix
> +# it later with qemu-img or other command.
> +#
> +# @actions: List of @TransactionAction;
> +#           information needed for the respective operations.
> +#
> +# @properties: structure of additional options to control the
> +#              execution of the transaction. See @TransactionProperties
> +#              for additional detail.
> +#
> +# Returns: nothing on success
> +#
> +#          Errors depend on the operations of the transaction
> +#
> +# Note: The transaction aborts on the first failure.  Therefore, there
> will be
> +# information on only one failed operation returned in an error
> condition, and
> +# subsequent actions will not have been attempted.
> +#
> +# Since: 1.1
> +#
> +# Example:
> +#
> +# -> { "execute": "transaction",
> +#      "arguments": { "actions": [
> +#          { "type": "blockdev-snapshot-sync", "data" : { "device":
> "ide-hd0",
> +#                                      "snapshot-file":
> "/some/place/my-image",
> +#                                      "format": "qcow2" } },
> +#          { "type": "blockdev-snapshot-sync", "data" : { "node-name":
> "myfile",
> +#                                      "snapshot-file":
> "/some/place/my-image2",
> +#                                      "snapshot-node-name": "node3432",
> +#                                      "mode": "existing",
> +#                                      "format": "qcow2" } },
> +#          { "type": "blockdev-snapshot-sync", "data" : { "device":
> "ide-hd1",
> +#                                      "snapshot-file":
> "/some/place/my-image2",
> +#                                      "mode": "existing",
> +#                                      "format": "qcow2" } },
> +#          { "type": "blockdev-snapshot-internal-sync", "data" : {
> +#                                      "device": "ide-hd2",
> +#                                      "name": "snapshot0" } } ] } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'transaction',
> +  'data': { 'actions': [ 'TransactionAction' ],
> +            '*properties': 'TransactionProperties'
> +          }
> +}
> --
> 2.7.5
>
>
> --
Marc-Andr=C3=A9 Lureau
