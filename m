Received: from eggs.gnu.org ([2001:4830:134:3::10]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPZk-0008QM-8F
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPZj-0003Rc-6V
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:52:12 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37346cfc-965d-44c5-0c30-f8a22dd14883@redhat.com>
Date: Thu, 15 Feb 2018 13:51:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/27] qcow2: Use visitor for options in
 qcow2_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c              | 219 ++++++++++++++++-----------------------------
>   tests/qemu-iotests/049.out |   8 +-
>   tests/qemu-iotests/112.out |   4 +-
>   3 files changed, 84 insertions(+), 147 deletions(-)
> 

>       BlockDriverState *bs = NULL;
> -    Error *local_err = NULL;
> +    const char *val;
>       int ret;
> +    Error *local_err = NULL;
>   

Worth the churn on the local_err declaration position?

> -    /* Read out options */
> -    size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                    BDRV_SECTOR_SIZE);
> -    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> -    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
> -    backing_drv = qapi_enum_parse(&BlockdevDriver_lookup, backing_fmt,
> -                                  0, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    /* Only the keyval visitor supports the dotted syntax needed for
> +     * encryption, so go through a QDict before getting a QAPI type. Ignore
> +     * options meant for the protocol layer so that the visitor doesn't
> +     * complain. */
> +    qdict = qemu_opts_to_qdict_filtered(opts, NULL, bdrv_qcow2.create_opts,
> +                                        true);

Glue code at its finest ;)

> +    /* Convert compat=0.10/1.1 into compat=v2/v3, to be renamed into
> +     * version=v2/v3 below. */
> +    val = qdict_get_try_str(qdict, BLOCK_OPT_COMPAT_LEVEL);
> +    if (val && !strcmp(val, "0.10")) {
> +        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v2");
> +    } else if (val && !strcmp(val, "1.1")) {
> +        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
> +    }

Not only does this map the old 'qemu-img create -o' spellings into the 
QMP form, but it means that we now also accept the new spelling via 
qemu-img command line.  Might be worth mentioning in the commit message 
as an intentional enhancement.

> +
> +    /* Change legacy command line options into QMP ones */
> +    static const QDictRenames opt_renames[] = {
> +        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
> +        { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
> +        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
> +        { BLOCK_OPT_LAZY_REFCOUNTS,     "lazy-refcounts" },
> +        { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
> +        { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
> +        { BLOCK_OPT_COMPAT_LEVEL,       "version" },
> +        { NULL, NULL },
> +    };

Looks reasonable to me.

> -
> -    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        ret = -EINVAL;
> +    /* Create and open the file (protocol layer) */
> +    ret = bdrv_create_file(filename, opts, errp);
> +    if (ret < 0) {
>           goto finish;

Git got lost on producing a sane diff.  Oh well.

> -    version = qcow2_opt_get_version_del(opts, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    /* Set 'driver' and 'node' options */
> +    qdict_put_str(qdict, "driver", "qcow2");
> +    qdict_put_str(qdict, "file", bs->node_name);
> +
> +    /* Now get the QAPI type BlockdevCreateOptions */
> +    qobj = qdict_crumple(qdict, errp);
> +    QDECREF(qdict);
> +    qdict = qobject_to_qdict(qobj);
> +    if (qdict == NULL) {

Fun with round trips.  Maybe someday we can improve things, but for now, 
I'm glad that it at least works.

>           ret = -EINVAL;
>           goto finish;
>       }
>   
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_LAZY_REFCOUNTS, false)) {
> -        flags |= BLOCK_FLAG_LAZY_REFCOUNTS;
> -    }
> +    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
> +    visit_free(v);

But this part is definitely the payout of what we wanted to get to!


>       /* Create the qcow2 image (format layer) */
> -    create_options = (BlockdevCreateOptions) {
> -        .driver         = BLOCKDEV_DRIVER_QCOW2,
> -        .u.qcow2        = {
> -            .file               = &(BlockdevRef) {

And using the visitor is a lot nicer than populating the struct by hand.

> +++ b/tests/qemu-iotests/049.out
> @@ -166,11 +166,11 @@ qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
>   Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
>   
>   qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
> -qemu-img: TEST_DIR/t.qcow2: Invalid compatibility level: '0.42'
> +qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
>   Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16

Yep, the visitor has slightly different messages, but I'm fine with the 
fallout.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
