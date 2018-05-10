Received: from eggs.gnu.org ([2001:4830:134:3::10]:55691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fGgTh-00041J-NU
	for qemu-devel@nongnu.org; Thu, 10 May 2018 03:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fGgTg-00081H-KS
	for qemu-devel@nongnu.org; Thu, 10 May 2018 03:59:05 -0400
Date: Thu, 10 May 2018 08:58:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180510075854.GC23581@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509165530.29561-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/13] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, May 09, 2018 at 06:55:21PM +0200, Max Reitz wrote:
> Currently, you can give no encryption format for a qcow2 file while
> still passing a key-secret.  That does not conform to the schema, so
> this patch changes the schema to allow it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 71c9ab8538..092a1aba2d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -43,6 +43,19 @@
>  { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
>    'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
>  
> +##
> +# @ImageInfoSpecificQCow2EncryptionNoInfo:
> +#
> +# Only used for the qcow2 encryption format "from-image" in which the
> +# actual encryption format is determined from the image header.
> +# Therefore, this encryption format will never be reported in
> +# ImageInfoSpecificQCow2Encryption.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
> +  'data': { } }
> +
>  ##
>  # @ImageInfoSpecificQCow2Encryption:
>  #
> @@ -52,7 +65,8 @@
>    'base': 'ImageInfoSpecificQCow2EncryptionBase',
>    'discriminator': 'format',
>    'data': { 'aes': 'QCryptoBlockInfoQCow',
> -            'luks': 'QCryptoBlockInfoLUKS' } }
> +            'luks': 'QCryptoBlockInfoLUKS',
> +            'from-image': 'ImageInfoSpecificQCow2EncryptionNoInfo' } }
>  
>  ##
>  # @ImageInfoSpecificQCow2:
> @@ -2739,10 +2753,30 @@
>  # @BlockdevQcow2EncryptionFormat:
>  # @aes: AES-CBC with plain64 initialization venctors
>  #
> +# @from-image:      Determine the encryption format from the image
> +#                   header.  This only allows the use of the
> +#                   key-secret option.  (Since: 2.13)
> +#
>  # Since: 2.10
>  ##
>  { 'enum': 'BlockdevQcow2EncryptionFormat',
> -  'data': [ 'aes', 'luks' ] }
> +  'data': [ 'aes', 'luks', 'from-image' ] }
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
> +# Since: 2.13
> +##
> +{ 'struct': 'BlockdevQcow2EncryptionSecret',
> +  'data': { '*key-secret': 'str' } }
>  
>  ##
>  # @BlockdevQcow2Encryption:
> @@ -2750,10 +2784,12 @@
>  # Since: 2.10
>  ##
>  { 'union': 'BlockdevQcow2Encryption',
> -  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
> +  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
>    'discriminator': 'format',
> +  'default-variant': 'from-image',
>    'data': { 'aes': 'QCryptoBlockOptionsQCow',
> -            'luks': 'QCryptoBlockOptionsLUKS'} }
> +            'luks': 'QCryptoBlockOptionsLUKS',
> +            'from-image': 'BlockdevQcow2EncryptionSecret' } }

Bike-shedding on name, how about "auto" or "probe" ?

IIUC, this schema addition means the QAPI parser now allows

   encrypt.format=from-image,encrypt.key-secret=sec0,...other opts...

but the code will not accept "from-image" as a valid string.

eg qcow2_update_options_prepare() will do

    case QCOW_CRYPT_AES:
        if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
            error_setg(errp,
                       "Header reported 'aes' encryption format but "
                       "options specify '%s'", encryptfmt);
            ret = -EINVAL;
            goto fail;
        }

       ...snip....

    case QCOW_CRYPT_LUKS:
        if (encryptfmt && !g_str_equal(encryptfmt, "luks")) {
            error_setg(errp,
                       "Header reported 'luks' encryption format but "
                       "options specify '%s'", encryptfmt);
            ret = -EINVAL;
            goto fail;
        }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
