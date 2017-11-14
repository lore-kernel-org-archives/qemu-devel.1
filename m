Received: from eggs.gnu.org ([2001:4830:134:3::10]:58037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEcxs-0001oi-74
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEcxr-0000hM-1L
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:17:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-3-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 16:17:18 +0100
In-Reply-To: <20171110221329.24176-3-mreitz@redhat.com> (Max Reitz's message
	of "Fri, 10 Nov 2017 23:13:28 +0100")
Message-ID: <87zi7oritd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing
 link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Instead of converting all "backing": null instances into "backing": "",
> handle a null value directly in bdrv_open_inherit().
>
> This enables explicitly null backing links for json:{} filenames.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                    |  2 +-
>  blockdev.c                 | 14 --------------
>  tests/qemu-iotests/089     | 20 ++++++++++++++++++++
>  tests/qemu-iotests/089.out |  8 ++++++++
>  4 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/block.c b/block.c
> index 85427df577..bc92ddd5a0 100644
> --- a/block.c
> +++ b/block.c
> @@ -2558,7 +2558,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>  
>      /* See cautionary note on accessing @options above */
>      backing = qdict_get_try_str(options, "backing");
> -    if (backing && *backing == '\0') {
> +    if (qdict_is_qnull(options, "backing") || (backing && *backing == '\0')) {
>          flags |= BDRV_O_NO_BACKING;
>          qdict_del(options, "backing");
>      }

Consider a comment pointing out "" is deprecated.

See also my reply to PATCH 1/3.

> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24a0b..99ef618b39 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3885,7 +3885,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
>      QObject *obj;
>      Visitor *v = qobject_output_visitor_new(&obj);
>      QDict *qdict;
> -    const QDictEntry *ent;
>      Error *local_err = NULL;
>  
>      visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> @@ -3899,19 +3898,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
>  
>      qdict_flatten(qdict);
>  
> -    /*
> -     * Rewrite "backing": null to "backing": ""
> -     * TODO Rewrite "" to null instead, and perhaps not even here
> -     */
> -    for (ent = qdict_first(qdict); ent; ent = qdict_next(qdict, ent)) {
> -        char *dot = strrchr(ent->key, '.');
> -
> -        if (!strcmp(dot ? dot + 1 : ent->key, "backing")
> -            && qobject_type(ent->value) == QTYPE_QNULL) {
> -            qdict_put(qdict, ent->key, qstring_new());
> -        }
> -    }
> -
>      if (!qdict_get_try_str(qdict, "node-name")) {
>          error_setg(errp, "'node-name' must be specified for the root node");
>          goto fail;
> diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
> index 9bfe2307b3..832eac1248 100755
> --- a/tests/qemu-iotests/089
> +++ b/tests/qemu-iotests/089
> @@ -82,6 +82,26 @@ $QEMU_IO_PROG --cache $CACHEMODE \
>  $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
>  
>  
> +echo
> +echo "=== Testing correct handling of 'backing':null ==="
> +echo
> +
> +_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
> +
> +# This should read 42
> +$QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
> +
> +# This should read 0
> +$QEMU_IO -c 'read -P 0 0 512' "json:{\
> +    'driver': '$IMGFMT',
> +    'file': {
> +        'driver': 'file',
> +        'filename': '$TEST_IMG'
> +    },
> +    'backing': null
> +}" | _filter_qemu_io
> +
> +
>  # Taken from test 071
>  echo
>  echo "=== Testing blkdebug ==="
> diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
> index 18f5fdda7a..607a9c6d9c 100644
> --- a/tests/qemu-iotests/089.out
> +++ b/tests/qemu-iotests/089.out
> @@ -19,6 +19,14 @@ Pattern verification failed at offset 0, 512 bytes
>  read 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  
> +=== Testing correct handling of 'backing':null ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
> +read 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
>  === Testing blkdebug ===
>  
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864

Reviewed-by: Markus Armbruster <armbru@redhat.com>
