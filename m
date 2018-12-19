Received: from eggs.gnu.org ([2001:4830:134:3::10]:57577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZb8S-0007ub-VH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZb8Q-0004Ur-6l
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:39:36 -0500
Date: Wed, 19 Dec 2018 12:39:26 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181219123926.GA1288@perard.uk.xensource.com>
References: <20181217133011.31433-1-paul.durrant@citrix.com>
	<20181217133011.31433-17-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217133011.31433-17-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v6 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Dec 17, 2018 at 01:30:09PM +0000, Paul Durrant wrote:
> +static char *xen_block_blockdev_add(const char *id, QDict *qdict,
> +                                    Error **errp)
> +{
> +    const char *driver = qdict_get_try_str(qdict, "driver");
> +    BlockdevOptions *options = NULL;
> +    Error *local_err = NULL;
> +    char *str = NULL;
> +    char *node_name;
> +    Visitor *v;
> +
> +    if (!driver) {
> +        error_setg(errp, "no 'driver' parameter");
> +        return NULL;
> +    }
> +
> +    node_name = g_strdup_printf("%s-%s", id, driver);
> +    qdict_put_str(qdict, "node-name", node_name);
> +
> +    qdict_iter(qdict, add_item, &str);
> +
> +    trace_xen_block_blockdev_add(str);
> +    g_free(str);
> +
> +    v = qobject_input_visitor_new_flat_confused(qdict, errp);

Kevin seems to say that this could be done without the _flat_confused
version. The flat_confused version seems to be useful just because
the key "cache.direct" is used earlier, and because everything in qdict
is a string.

I think instead, qobject_input_visitor_new could be used. You would just
need to replace
    qdict_put_str(qdict, "cache.direct", "on");
by
    QDict *cache = qdict_new();
    qdict_put_str(cache, "direct", "on");
    qdict_put_obj(qdict, "cache", QOBJECT(cache));

And also the property "read-only" which seems to be a bool as well. I've
check all property in the qdict, and I think that the only two that
needs to be changes. And then, we can use:
    v = qobject_input_visitor_new(qdict); which never fails.

You'll just need "qapi/qobject-input-visitor.h" instead of "block/qdict.h"

> +    if (!v) {
> +        goto fail;
> +    }
> +
> +    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> +    visit_free(v);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    qmp_blockdev_add(options, &local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    qapi_free_BlockdevOptions(options);
> +
> +    return node_name;
> +
> +fail:
> +    if (options) {
> +        qapi_free_BlockdevOptions(options);
> +    }
> +    g_free(node_name);
> +
> +    return NULL;
> +}
[...]
> +static XenBlockDrive *xen_block_drive_create(const char *id,
> +                                             const char *device_type,
> +                                             QDict *opts, Error **errp)
> +{
> +    const char *params = qdict_get_try_str(opts, "params");
> +    const char *mode = qdict_get_try_str(opts, "mode");
> +    const char *direct_io_safe = qdict_get_try_str(opts, "direct-io-safe");
> +    const char *discard_enable = qdict_get_try_str(opts, "discard-enable");
> +    char *driver = NULL;
> +    char *filename = NULL;
> +    XenBlockDrive *drive = NULL;
> +    Error *local_err = NULL;
> +    QDict *qdict;
> +
> +    if (params) {
> +        char **v = g_strsplit(params, ":", 2);
> +
> +        if (v[1] == NULL) {
> +            filename = g_strdup(v[0]);
> +            driver = g_strdup("file");
> +        } else {
> +            if (strcmp(v[0], "aio") == 0) {
> +                driver = g_strdup("file");
> +            } else if (strcmp(v[0], "vhd") == 0) {
> +                driver = g_strdup("vpc");
> +            } else {
> +                driver = g_strdup(v[0]);
> +            }
> +            filename = g_strdup(v[1]);
> +        }
> +
> +        g_strfreev(v);
> +    }
> +
> +    if (!filename) {
> +        error_setg(errp, "no filename");
> +        goto done;
> +    }
> +    assert(driver);
> +
> +    drive = g_new0(XenBlockDrive, 1);
> +    drive->id = g_strdup(id);
> +
> +    qdict = qdict_new();
> +
> +    qdict_put_str(qdict, "driver", "file");
> +    qdict_put_str(qdict, "filename", filename);
> +
> +    if (mode && *mode != 'w') {
> +        qdict_put_str(qdict, "read-only", "on");
> +    }
> +
> +    if (direct_io_safe) {
> +        unsigned long value;
> +
> +        if (!qemu_strtoul(direct_io_safe, NULL, 2, &value) && !!value) {
> +            qdict_put_str(qdict, "cache.direct", "on");
> +            qdict_put_str(qdict, "aio", "native");
> +        }
> +    }
> +
> +    if (discard_enable) {
> +        unsigned long value;
> +
> +        if (!qemu_strtoul(discard_enable, NULL, 2, &value) && !!value) {
> +            qdict_put_str(qdict, "discard", "unmap");
> +        }
> +    }
> +
> +    /*
> +     * It is necessary to turn file locking off as an emulated device
> +     * may have already opened the same image file.
> +     */
> +    qdict_put_str(qdict, "locking", "off");
> +
> +    xen_block_drive_layer_add(drive, qdict, &local_err);
> +    qobject_unref(qdict);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto done;
> +    }
> +
> +    /* If the image is a raw file then we are done */

I don't think that is true, as I have this warning in QEMU:
qemu-system-i386: warning: Opening a block device as a file using the 'file' driver is deprecated

We would need a "raw" driver.

> +    if (!strcmp(driver, "file")) {
> +        goto done;
> +    }
> +
> +    qdict = qdict_new();
> +
> +    qdict_put_str(qdict, "driver", driver);
> +
> +    xen_block_drive_layer_add(drive, qdict, &local_err);
> +    qobject_unref(qdict);
> +
> +done:
> +    g_free(driver);
> +    g_free(filename);
> +
> +    if (local_err) {
> +        xen_block_drive_destroy(drive, NULL);
> +        return NULL;
> +    }
> +
> +    return drive;
> +}

-- 
Anthony PERARD
