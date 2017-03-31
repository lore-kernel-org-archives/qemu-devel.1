Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1kM-0005HI-3j
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1kL-0000aC-5I
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:58:06 -0400
Date: Fri, 31 Mar 2017 14:57:57 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170331185757.GF1135@localhost.localdomain>
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331120431.1767-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9 1/2] qapi/curl: Extend
 and fix blockdev-add schema
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

On Fri, Mar 31, 2017 at 02:04:30PM +0200, Max Reitz wrote:
> The curl block driver accepts more options than just "filename"; also,
> the URL is actually expected to be passed through the "url" option
> instead of "filename".
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  qapi/block-core.json | 103 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b5f0e9958c..033457ce86 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2737,16 +2737,101 @@
>              '*debug': 'int' } }
>  
>  ##
> -# @BlockdevOptionsCurl:
> +# @BlockdevOptionsCurlBase:
>  #
> -# Driver specific block device options for the curl backend.
> +# Driver specific block device options shared by all protocols supported by the
> +# curl backend.
>  #
> -# @filename:    path to the image file
> +# @url:                     URL of the image file
> +#
> +# @readahead:               Size of the read-ahead cache; must be a multiple of
> +#                           512 (defaults to 256 kB)
> +#
> +# @timeout:                 Timeout for connections, in seconds (defaults to 5)
> +#
> +# @username:                Username for authentication (defaults to none)
> +#
> +# @password-secret:         ID of a QCryptoSecret object providing a password
> +#                           for authentication (defaults to no password)
> +#
> +# @proxy-username:          Username for proxy authentication (defaults to none)
> +#
> +# @proxy-password-secret:   ID of a QCryptoSecret object providing a password
> +#                           for proxy authentication (defaults to no password)
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsCurlBase',
> +  'data': { 'url': 'str',
> +            '*readahead': 'int',
> +            '*timeout': 'int',
> +            '*username': 'str',
> +            '*password-secret': 'str',
> +            '*proxy-username': 'str',
> +            '*proxy-password-secret': 'str' } }
> +
> +##
> +# @BlockdevOptionsCurlHttp:
> +#
> +# Driver specific block device options for HTTP connections over the curl
> +# backend.  URLs must start with "http://".
> +#
> +# @cookie:      List of cookies to set; format is
> +#               "name1=content1; name2=content2;" as explained by
> +#               CURLOPT_COOKIE(3). Defaults to no cookies.
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsCurlHttp',
> +  'base': 'BlockdevOptionsCurlBase',
> +  'data': { '*cookie': 'str' } }
> +
> +##
> +# @BlockdevOptionsCurlHttps:
> +#
> +# Driver specific block device options for HTTPS connections over the curl
> +# backend.  URLs must start with "https://".
> +#
> +# @cookie:      List of cookies to set; format is
> +#               "name1=content1; name2=content2;" as explained by
> +#               CURLOPT_COOKIE(3). Defaults to no cookies.
> +#
> +# @sslverify:   Whether to verify the SSL certificate's validity (defaults to
> +#               true)
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsCurlHttps',
> +  'base': 'BlockdevOptionsCurlBase',
> +  'data': { '*cookie': 'str',
> +            '*sslverify': 'bool' } }
> +
> +##
> +# @BlockdevOptionsCurlFtp:
> +#
> +# Driver specific block device options for FTP connections over the curl
> +# backend.  URLs must start with "ftp://".
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsCurlFtp',
> +  'base': 'BlockdevOptionsCurlBase',
> +  'data': { } }
> +
> +##
> +# @BlockdevOptionsCurlFtps:
> +#
> +# Driver specific block device options for FTPS connections over the curl
> +# backend.  URLs must start with "ftps://".
> +#
> +# @sslverify:   Whether to verify the SSL certificate's validity (defaults to
> +#               true)
>  #
>  # Since: 2.9
>  ##
> -{ 'struct': 'BlockdevOptionsCurl',
> -  'data': { 'filename': 'str' } }
> +{ 'struct': 'BlockdevOptionsCurlFtps',
> +  'base': 'BlockdevOptionsCurlBase',
> +  'data': { '*sslverify': 'bool' } }
>  
>  ##
>  # @BlockdevOptionsNbd:
> @@ -2815,13 +2900,13 @@
>        'cloop':      'BlockdevOptionsGenericFormat',
>        'dmg':        'BlockdevOptionsGenericFormat',
>        'file':       'BlockdevOptionsFile',
> -      'ftp':        'BlockdevOptionsCurl',
> -      'ftps':       'BlockdevOptionsCurl',
> +      'ftp':        'BlockdevOptionsCurlFtp',
> +      'ftps':       'BlockdevOptionsCurlFtps',
>        'gluster':    'BlockdevOptionsGluster',
>        'host_cdrom': 'BlockdevOptionsFile',
>        'host_device':'BlockdevOptionsFile',
> -      'http':       'BlockdevOptionsCurl',
> -      'https':      'BlockdevOptionsCurl',
> +      'http':       'BlockdevOptionsCurlHttp',
> +      'https':      'BlockdevOptionsCurlHttps',
>        'iscsi':      'BlockdevOptionsIscsi',
>        'luks':       'BlockdevOptionsLUKS',
>        'nbd':        'BlockdevOptionsNbd',
> -- 
> 2.12.1
> 
> 
