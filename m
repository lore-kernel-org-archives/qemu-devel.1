Received: from eggs.gnu.org ([2001:4830:134:3::10]:43837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFlZ-0000Wl-V1
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFlT-0007i0-N1
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:02:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-3-kwolf@redhat.com>
Date: Fri, 07 Dec 2018 14:01:30 +0100
In-Reply-To: <20181207115343.6747-3-kwolf@redhat.com> (Kevin Wolf's message of
	"Fri, 7 Dec 2018 12:53:40 +0100")
Message-ID: <875zw5xzh1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/5] vmdk: Implement .bdrv_co_create
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> From: Fam Zheng <famz@redhat.com>
>
> This makes VMDK support blockdev-create. The implementation reuses the
> image creation code in vmdk_co_create_opts which now acceptes a callback
> pointer to "retrieve" BlockBackend pointers from the caller. This way we
> separate the logic between file/extent acquisition and initialization.
>
> The QAPI command parameters are mostly the same as the old create_opts
> except the dropped legacy @compat6 switch, which is redundant with
> @hwversion.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json  |  70 +++++++
>  qapi/qapi-schema.json |  16 +-
>  block/vmdk.c          | 448 ++++++++++++++++++++++++++++++------------
>  3 files changed, 400 insertions(+), 134 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d4fe710836..0793550cf2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4021,6 +4021,75 @@
>              'size':             'size',
>              '*cluster-size' :   'size' } }
>  
> +##
> +# @BlockdevVmdkSubformat:
> +#
> +# Subformat options for VMDK images
> +#
> +# @monolithicSparse:     Single file image with sparse cluster allocation
> +#
> +# @monolithicFlat:       Single flat data image and a descriptor file
> +#
> +# @twoGbMaxExtentSparse: Data is split into 2GB (per virtual LBA) sparse extent
> +#                        files, in addition to a descriptor file
> +#
> +# @twoGbMaxExtentFlat:   Data is split into 2GB (per virtual LBA) flat extent
> +#                        files, in addition to a descriptor file
> +#
> +# @streamOptimized:      Single file image sparse cluster allocation, optimized
> +#                        for streaming over network.
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'BlockdevVmdkSubformat',
> +  'data': [ 'monolithicSparse', 'monolithicFlat', 'twoGbMaxExtentSparse',
> +            'twoGbMaxExtentFlat', 'streamOptimized'] }
> +
> +##
> +# @BlockdevVmdkAdapterType:
> +#
> +# Adapter type info for VMDK images
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'BlockdevVmdkAdapterType',
> +  'data': [ 'ide', 'buslogic', 'lsilogic', 'legacyESX'] }
> +
> +##
> +# @BlockdevCreateOptionsVmdk:
> +#
> +# Driver specific image creation options for VMDK.
> +#
> +# @file         Where to store the new image file. This refers to the image
> +#               file for monolithcSparse and streamOptimized format, or the
> +#               descriptor file for other formats.
> +# @size         Size of the virtual disk in bytes
> +# @extents      Where to store the data extents. Required for monolithcFlat,
> +#               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
> +#               monolithicFlat, only one entry is required; for
> +#               twoGbMaxExtent* formats, the number of entries required is
> +#               calculated as extent_number = virtual_size / 2GB.

Doesn't quite spell out that the number of extents has to match
exactly.  I'm not sure I care.

> +# @subformat    The subformat of the VMDK image. Default: "monolithicSparse".
> +# @backing-file The path of backing file. Default: no backing file is used.
> +# @adapter-type The adapter type used to fill in the descriptor. Default: ide.
> +# @hwversion    Hardware version. The meaningful options are "4" or "6".
> +#               Default: "4".
> +# @zeroed-grain Whether to enable zeroed-grain feature for sparse subformats.
> +#               Default: false.
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'BlockdevCreateOptionsVmdk',
> +  'data': { 'file':             'BlockdevRef',
> +            'size':             'size',
> +            '*extents':          ['BlockdevRef'],
> +            '*subformat':       'BlockdevVmdkSubformat',
> +            '*backing-file':    'str',
> +            '*adapter-type':    'BlockdevVmdkAdapterType',
> +            '*hwversion':       'str',
> +            '*zeroed-grain':    'bool' } }
> +
> +
>  ##
>  # @SheepdogRedundancyType:
>  #
> @@ -4215,6 +4284,7 @@
>        'ssh':            'BlockdevCreateOptionsSsh',
>        'vdi':            'BlockdevCreateOptionsVdi',
>        'vhdx':           'BlockdevCreateOptionsVhdx',
> +      'vmdk':           'BlockdevCreateOptionsVmdk',
>        'vpc':            'BlockdevCreateOptionsVpc'
>    } }
>  
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>
