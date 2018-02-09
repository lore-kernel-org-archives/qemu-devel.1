Received: from eggs.gnu.org ([2001:4830:134:3::10]:48646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ek9B8-0005VQ-HA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ek9B7-0001jN-Ju
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:57:26 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f42167b0-1e63-da16-b007-9b96d70c6c85@redhat.com>
Date: Fri, 9 Feb 2018 07:57:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/27] qcow2: Use BlockdevRef in
 qcow2_create2()
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
> Instead of passing a separate BlockDriverState* into qcow2_create2(),
> make use of the BlockdevRef that is included in BlockdevCreateOptions.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/block.h |  1 +
>   block.c               | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c         | 38 ++++++++++++++++++++++++--------------
>   3 files changed, 72 insertions(+), 14 deletions(-)
> 

> +BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
> +{
> +    BlockDriverState *bs = NULL;
> +    Error *local_err = NULL;
> +    QObject *obj = NULL;
> +    QDict *qdict = NULL;
> +    const char *reference = NULL;
> +    Visitor *v = NULL;
> +
> +    if (ref->type == QTYPE_QSTRING) {
> +        reference = ref->u.reference;
> +    } else {
> +        BlockdevOptions *options = &ref->u.definition;
> +        assert(ref->type == QTYPE_QDICT);
> +
> +        v = qobject_output_visitor_new(&obj);
> +        visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto fail;

I like calling the label 'done' or 'out'...

> +        }
> +        visit_complete(v, &obj);
> +
> +        qdict = qobject_to_qdict(obj);
> +        qdict_flatten(qdict);
> +
> +        /* bdrv_open_inherit() defaults to the values in bdrv_flags (for
> +         * compatibility with other callers) rather than what we want as the
> +         * real defaults. Apply the defaults here instead. */
> +        qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
> +        qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
> +        qdict_set_default_str(qdict, BDRV_OPT_READ_ONLY, "off");
> +    }
> +
> +    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
> +    obj = NULL;
> +
> +fail:

...since it is also reached as intentional fallthrough on the success 
path, making 'fail' a misnomer.

> +    qobject_decref(obj);
> +    visit_free(v);
> +    return bs;
> +}
> +

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
