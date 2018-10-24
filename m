Received: from eggs.gnu.org ([2001:4830:134:3::10]:52074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFHiI-0007NK-9M
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFHiE-0008Ik-6l
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:52:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gFHiD-0008AT-FG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:52:34 -0400
References: <20181021165542.8692-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9edbf1fc-9401-f6c9-e487-bc3c0d4afd02@vivier.eu>
Date: Wed, 24 Oct 2018 12:52:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181021165542.8692-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] scripts/qemu-binfmt-conf.sh: add bFLT
 handler registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 21/10/2018 17:55, Max Filippov wrote:
> bFLT format header doesn't have enough information to register a handler
> for a specific architecture. Add switch -f / --flat that registers one
> of the qemu binaries as a handler for bFLT executable images.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - fix bFLT in the patch subject
> 
> Changes v1->v2:
> - drop unintended changes to dtc;
> 
>  scripts/qemu-binfmt-conf.sh | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a149..39f61065c698 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -132,6 +132,9 @@ or1k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\
>  or1k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>  or1k_family=or1k
>  
> +flat_magic='bFLT\x00\x00\x00\x04'
> +flat_mask='\xff\xff\xff\xff\xff\xff\xff\xff'
> +
>  qemu_get_family() {
>      cpu=${HOST_ARCH:-$(uname -m)}
>      case "$cpu" in
> @@ -170,6 +173,7 @@ usage() {
>  Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                             [--help][--credential yes|no][--exportdir PATH]
>                             [--persistent yes|no][--qemu-suffix SUFFIX]
> +                           [--flat CPU]
>  
>         Configure binfmt_misc to use qemu interpreter
>  
> @@ -188,7 +192,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                        calculated according to the binary to interpret
>         --persistent:  if yes, the interpreter is loaded when binfmt is
>                        configured and remains in memory. All future uses
> -                      are cloned from the open file.
> +                      are cloned from the open file
> +       --flat:        register QEMU for this CPU architecture as a handler
> +                      for the bFLT executable format.
>  
>      To import templates with update-binfmts, use :
>  
> @@ -311,6 +317,13 @@ qemu_set_binfmts() {
>              $BINFMT_SET
>          fi
>      done
> +    if [ -n "$QEMU_FLAT" ] ; then
> +        cpu="${QEMU_FLAT}_bflt"

I think you don't need this, you can let the user to use "--qemu-suffix"
for that.

Thanks,
Laurent
