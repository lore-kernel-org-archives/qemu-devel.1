Received: from eggs.gnu.org ([2001:4830:134:3::10]:47268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEB9q-00009U-Ux
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 06:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEB9l-0003l3-Eo
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 06:40:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEB9j-0003iR-E0
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 06:40:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so7444366wma.3
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 03:40:21 -0700 (PDT)
References: <20181021024953.9905-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fcb254ec-254f-b7df-62b8-29ba8caa09b4@redhat.com>
Date: Sun, 21 Oct 2018 12:40:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181021024953.9905-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scripts/qemu-binfmt-conf.sh: add bFL
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
Cc: Laurent Vivier <laurent@vivier.eu>

On 21/10/18 4:49, Max Filippov wrote:
> bFLT format header doesn't have enough information to register a handler
> for a specific architecture. Add switch -f / --flat that registers one
> of the qemu binaries as a handler for bFLT executable images.

"bFLT" in patch subject

> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - drop unintended changes to dtc;
> 
>   scripts/qemu-binfmt-conf.sh | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a149..39f61065c698 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -132,6 +132,9 @@ or1k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\
>   or1k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>   or1k_family=or1k
>   
> +flat_magic='bFLT\x00\x00\x00\x04'
> +flat_mask='\xff\xff\xff\xff\xff\xff\xff\xff'
> +
>   qemu_get_family() {
>       cpu=${HOST_ARCH:-$(uname -m)}
>       case "$cpu" in
> @@ -170,6 +173,7 @@ usage() {
>   Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                              [--help][--credential yes|no][--exportdir PATH]
>                              [--persistent yes|no][--qemu-suffix SUFFIX]
> +                           [--flat CPU]
>   
>          Configure binfmt_misc to use qemu interpreter
>   
> @@ -188,7 +192,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                         calculated according to the binary to interpret
>          --persistent:  if yes, the interpreter is loaded when binfmt is
>                         configured and remains in memory. All future uses
> -                      are cloned from the open file.
> +                      are cloned from the open file
> +       --flat:        register QEMU for this CPU architecture as a handler
> +                      for the bFLT executable format.
>   
>       To import templates with update-binfmts, use :
>   
> @@ -311,6 +317,13 @@ qemu_set_binfmts() {
>               $BINFMT_SET
>           fi
>       done
> +    if [ -n "$QEMU_FLAT" ] ; then
> +        cpu="${QEMU_FLAT}_bflt"
> +        qemu="$QEMU_PATH/qemu-$QEMU_FLAT"
> +        magic=$flat_magic
> +        mask=$flat_mask
> +        $BINFMT_SET
> +    fi
>   }
>   
>   CHECK=qemu_check_bintfmt_misc
> @@ -324,7 +337,7 @@ CREDENTIAL=no
>   PERSISTENT=no
>   QEMU_SUFFIX=""
>   
> -options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
> +options=$(getopt -o ds:Q:S:e:hc:p:f: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:,flat: -- "$@")
>   eval set -- "$options"
>   
>   while true ; do
> @@ -380,6 +393,21 @@ while true ; do
>           shift
>           PERSISTENT="$1"
>           ;;
> +    -f|--flat)
> +        shift
> +        QEMU_FLAT="$1"
> +        for cpu in ${qemu_target_list} ; do
> +            if [ "$cpu" = "$1" ] ; then
> +                break
> +            fi
> +        done
> +
> +        if [ "$cpu" != "$1" ] ; then
> +            echo "ERROR: unknown CPU \"$1\"" 1>&2
> +            usage
> +            exit 1
> +        fi
> +        ;;
>       *)
>           break
>           ;;
> 
