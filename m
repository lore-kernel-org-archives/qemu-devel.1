Received: from eggs.gnu.org ([209.51.188.92]:48511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqffD-0001pb-H5
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqff6-00087J-Mz
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:55:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gqff6-0007wv-2j
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:55:52 -0500
References: <154917314614.27692.2830748026894633212.malonedeb@soybean.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec5e1ddc-9eac-193e-8937-c4146fe56a8f@redhat.com>
Date: Mon, 4 Feb 2019 08:55:29 -0600
MIME-Version: 1.0
In-Reply-To: <154917314614.27692.2830748026894633212.malonedeb@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1814418] [NEW] persistent bitmap will be
 inconsistent when qemu crash,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1814418 <1814418@bugs.launchpad.net>, qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, John Snow <jsnow@redhat.com>

On 2/2/19 11:52 PM, Cheng Chen wrote:
> Public bug reported:
> 
> Follow these steps to reappear the bug:
> 
> 1. start qemu
> 2. add persistent bitmap: '{ "execute": "block-dirty-bitmap-add", "arguments": {"node": "drive-virtio-disk1","name": "bitmap0", "persistent":true }}'
> 3. kill -9 qemu (simulate Host crash, eg. lose power)
> 4. restart qemu
> 
> Now, the '{ "execute": "query-block" }' can't find the bitmap0. I can
> understand at this point, because the bitmap0 has not been synchronized
> yet.

This matches my observations here:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07700.html

I'm of the opinion that updating the qcow2 headers any time a persistent
bitmap is created or destroyed is worthwhile, even if the headers must
still mark the bitmap as in-use.  True, the crash will leave the bitmap
as inconsistent, which is no different than if the bitmap is never
written to the qcow2 header (when booting a new qemu, an inconsistent
bitmap on disk has the same status as a missing bitmap - both imply that
an incremental backup is not possible, and so a full backup is needed
instead).  But the creation of bitmaps is not a common occasion, and
having the metadata track that a persistent bitmap has been requested
seems like it would be useful information during a debugging session.


> 
> But, when I try to add persistent bitmap0 again: '{ "execute": "block-
> dirty-bitmap-add", "arguments": {"node": "drive-virtio-disk1","name":
> "bitmap0", "persistent":true }}', It failed:
> 
> {"id":"libvirt-42","error":{"class":"GenericError","desc":"Can't make
> bitmap 'bitmap0' persistent in 'drive-virtio-disk1': Bitmap with the
> same name is already stored"}}
> 
> In other word, when qemu crash, the qcow2 image remain the incomplete
> persistent bitmap.

Does Andrey's proposed patch adding persistent bitmap details to
'qemu-img info' show anything after you first kill qemu?

/me goes and tests...

Oh weird - with Andrey's patch, we get semi-duplicated information
during query-block (at least, after an initial clean shutdown prior to
attempting an abrupt shutdown):

{"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false,
"removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off",
"image": {"virtual-size": 104857600, "filename": "file5",
"cluster-size": 65536, "format": "qcow2", "actual-size": 208896,
"format-specific": {"type": "qcow2", "data": {"compat": "1.1",
"lazy-refcounts": false, "bitmaps": [{"flags": ["in-use", "auto"],
"name": "b2", "granularity": 65536}], "refcount-bits": 16, "corrupt":
false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name":
"#block172", "backing_file_depth": 0, "drv": "qcow2", "iops": 0,
"bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0,
"bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback":
true}, "file": "file5", "encryption_key_missing": false}, "qdev":
"/machine/unattached/device[18]", "dirty-bitmaps": [{"name": "b2",
"status": "active", "granularity": 65536, "count": 0}, {"name": "b",
"status": "active", "granularity": 65536, "count": 0}], "type": "unknown"}]}

Note that the "format-specific" listing has a "bitmaps" entry resulting
from Andrey's patch (which shows "auto" as one of the "flags" for any
persistent bitmap) showing the state of the persistent bitmaps on disk;
as well as the "dirty-bitmaps" entry that shows the state of the bitmaps
in memory. Annoyingly, the "dirty-bitmaps" section does NOT state which
bitmaps are persistent, and if a persistent bitmap has not yet been
flushed to disk, then there is NO way to quickly determine which bitmaps
are persistent and which are transient.

At any rate, with qemu.git master + Andrey's patches for qemu-img info,
I was able to reproduce a related oddity: attempting to
block-dirty-bitmap-add a transient bitmap that has the same name as an
existing in-use persistent bitmap succeeds; when it should have failed:

$ qemu-img create -f qcow2 file5 100m
$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
file5
{'execute':'qmp_capabilities'}
{'execute':'query-block'} # learn the node name...
{'execute':'block-dirty-bitmap-add','arguments':{'node':'#block111','name':'b1','persistent':true}}
{'execute':'quit'}
$ ./qemu-img info -U file5
image: file5
file format: qcow2
virtual size: 100M (104857600 bytes)
disk size: 204K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    bitmaps:
        [0]:
            flags:
                [0]: auto
            name: b1
            granularity: 65536
    refcount bits: 16
    corrupt: false
$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
file5
{'execute':'qmp_capabilities'}
{'execute':'query-block'}
{"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false,
"removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off",
"image": {"virtual-size": 104857600, "filename": "file5",
"cluster-size": 65536, "format": "qcow2", "actual-size": 208896,
"format-specific": {"type": "qcow2", "data": {"compat": "1.1",
"lazy-refcounts": false, "bitmaps": [{"flags": ["in-use", "auto"],
"name": "b1", "granularity": 65536}], "refcount-bits": 16, "corrupt":
false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name":
"#block157", "backing_file_depth": 0, "drv": "qcow2", "iops": 0,
"bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0,
"bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback":
true}, "file": "file5", "encryption_key_missing": false}, "qdev":
"/machine/unattached/device[18]", "dirty-bitmaps": [{"name": "b1",
"status": "active", "granularity": 65536, "count": 0}], "type": "unknown"}]}
$ kill -9 $qemupid
$ ./qemu-img info -U file5
image: file5
file format: qcow2
virtual size: 100M (104857600 bytes)
disk size: 204K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    bitmaps:
        [0]:
            flags:
                [0]: in-use
                [1]: auto
            name: b1
            granularity: 65536
    refcount bits: 16
    corrupt: false
$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
file5
{'execute':'qmp_capabilities'}
{'execute':'query-block'}
{"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false,
"removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off",
"image": {"virtual-size": 104857600, "filename": "file5",
"cluster-size": 65536, "format": "qcow2", "actual-size": 208896,
"format-specific": {"type": "qcow2", "data": {"compat": "1.1",
"lazy-refcounts": false, "bitmaps": [{"flags": ["in-use", "auto"],
"name": "b1", "granularity": 65536}], "refcount-bits": 16, "corrupt":
false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name":
"#block141", "backing_file_depth": 0, "drv": "qcow2", "iops": 0,
"bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0,
"bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback":
true}, "file": "file5", "encryption_key_missing": false}, "qdev":
"/machine/unattached/device[18]", "type": "unknown"}]}

Note - after the unclean death, the "dirty-bitmaps" entry in query-block
is NOT present, and as a result:

{'execute':'block-dirty-bitmap-add','arguments':{'node':'#block141','name':'b1'}}
{"return": {}}

Oops - we were able to add a temporary bitmap that overrides the still
in-use persistent bitmap (which we properly ignored on loading, because
it was marked in-use).


> 
> ---
> 
> qemu version: 2.12.0 and 3.1.0, other version I does not test yet.

qemu 4.0 promotes various dirty bitmap interfaces from experimental to
supported; flaws in 3.1 are somewhat expected, but we want to make sure
4.0 fixes such problems, so we indeed have a bug here.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
