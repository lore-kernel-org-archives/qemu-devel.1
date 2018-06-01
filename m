Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmGk-0008Fz-Ad
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOmGh-0001Ix-6P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:47:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOmGh-0001Ir-1q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:47:07 -0400
References: <20180601152746.17169-1-chen_han_xiao@126.com>
	<20180601152746.17169-2-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <170dbd1b-19ad-5e8c-5f8d-2a32ebb47525@redhat.com>
Date: Fri, 1 Jun 2018 10:47:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180601152746.17169-2-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>

On 06/01/2018 10:27 AM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
>=20
> This patch adds support for getting the usage of mounted
> filesystem.
> The usage of fs stored as used_bytes and total_bytes.
> It's very useful when we try to monitor guest's filesystem.
>=20
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
>=20

> +++ b/qga/qapi-schema.json
> @@ -840,12 +840,24 @@
>              'bus-type': 'GuestDiskBusType',
>              'bus': 'int', 'target': 'int', 'unit': 'int'} }
>  =20
> +##
> +# @GuestFsUsage:
> +#
> +# @used-bytes:  file system used bytes
> +# @total-bytes: file system total bytes for nonroot user
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'GuestFsUsage',
> +  'data': {'used-bytes': 'uint64', 'total-bytes': 'uint64'} }

That seems like pointless nesting on the wire, unless we have plans of=20
reusing this type in other API calls.  Is it any easier...

> +
>   ##
>   # @GuestFilesystemInfo:
>   #
>   # @name: disk name
>   # @mountpoint: mount point path
>   # @type: file system type string
> +# @usage: file system usage struct (since 3.0)
>   # @disk: an array of disk hardware information that the volume lies o=
n,
>   #        which may be empty if the disk type is not supported
>   #
> @@ -853,7 +865,7 @@
>   ##
>   { 'struct': 'GuestFilesystemInfo',
>     'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> -           'disk': ['GuestDiskAddress']} }
> +           '*usage': 'GuestFsUsage', 'disk': ['GuestDiskAddress']} }

...to just inline '*used-bytes' and '*total-bytes' here?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
