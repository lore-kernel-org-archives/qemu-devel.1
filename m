Received: from eggs.gnu.org ([2001:4830:134:3::10]:46307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSTx6-0001rO-Mc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSTx5-0006E4-Ie
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:12 -0400
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b47ba7b8-9771-ab66-591e-2c73451f709d@redhat.com>
Date: Mon, 11 Jun 2018 16:02:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180611205203.2624-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/10] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

On 06/11/2018 03:51 PM, Max Reitz wrote:
> Currently, you can give no encryption format for a qcow2 file while
> still passing a key-secret.  That does not conform to the schema, so
> this patch changes the schema to allow it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++----
>   block/qcow2.c        |  3 +++
>   2 files changed, 43 insertions(+), 4 deletions(-)

> +##
> +# @ImageInfoSpecificQCow2EncryptionNoInfo:
> +#
> +# Only used for the qcow2 encryption format "auto" in which the actual
> +# encryption format is determined from the image header.  Therefore,
> +# this encryption format will never be reported in
> +# ImageInfoSpecificQCow2Encryption.
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
> +  'data': { } }

Do we actually need this type, given Anton's work on making omitted 
branches automatically use an empty struct?

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06836.html

> +
>   ##
>   # @ImageInfoSpecificQCow2Encryption:
>   #
> @@ -53,7 +66,8 @@
>     'base': 'ImageInfoSpecificQCow2EncryptionBase',
>     'discriminator': 'format',
>     'data': { 'aes': 'QCryptoBlockInfoQCow',
> -            'luks': 'QCryptoBlockInfoLUKS' } }
> +            'luks': 'QCryptoBlockInfoLUKS',
> +            'auto': 'ImageInfoSpecificQCow2EncryptionNoInfo' } }

If Anton's patches go in first, you don't even have to change this type;

>   
>   ##
>   # @ImageInfoSpecificQCow2:
> @@ -2658,10 +2672,30 @@
>   # @BlockdevQcow2EncryptionFormat:
>   # @aes: AES-CBC with plain64 initialization venctors
>   #
> +# @auto:            Determine the encryption format from the image
> +#                   header.  This only allows the use of the
> +#                   key-secret option.  (Since: 3.0)
> +#
>   # Since: 2.10
>   ##
>   { 'enum': 'BlockdevQcow2EncryptionFormat',
> -  'data': [ 'aes', 'luks' ] }
> +  'data': [ 'aes', 'luks', 'auto' ] }

the changed enum would be sufficient.

> +
> +##
> +# @BlockdevQcow2EncryptionSecret:
> +#
> +# Allows specifying a key-secret without specifying the exact
> +# encryption format, which is determined automatically from the image
> +# header.
> +#
> +# @key-secret:      The ID of a QCryptoSecret object providing the
> +#                   decryption key.  Mandatory except when probing
> +#                   image for metadata only.
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'BlockdevQcow2EncryptionSecret',
> +  'data': { '*key-secret': 'str' } }
>   
>   ##
>   # @BlockdevQcow2Encryption:
> @@ -2669,10 +2703,12 @@
>   # Since: 2.10
>   ##
>   { 'union': 'BlockdevQcow2Encryption',
> -  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
> +  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
>     'discriminator': 'format',
> +  'default-variant': 'auto',
>     'data': { 'aes': 'QCryptoBlockOptionsQCow',
> -            'luks': 'QCryptoBlockOptionsLUKS'} }
> +            'luks': 'QCryptoBlockOptionsLUKS',
> +            'auto': 'BlockdevQcow2EncryptionSecret' } }

This part is necessary, though, and looks correct.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
