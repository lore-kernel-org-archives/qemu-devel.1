Received: from eggs.gnu.org ([2001:4830:134:3::10]:34087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZSC-0000vV-Nm
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZSB-00080v-Aa
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:27:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15beee04-e005-e78e-2304-4acb5935e486@amsat.org>
Date: Wed, 9 Aug 2017 19:27:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170809215510.22802-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/12] qemu-iotests: move "check" code out
 of common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 08/09/2017 06:55 PM, Paolo Bonzini wrote:
> Some functions in common.rc are never used by the tests.  Move
> them out of that file and into common, which is already included
> only by "check".
> 
> Code that actually *is* common to "check" and tests can be placed in
> common.config.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/qemu-iotests/common        | 30 ++++++++++++++++++++++++++-
>   tests/qemu-iotests/common.config | 12 +++++++++++
>   tests/qemu-iotests/common.rc     | 45 ----------------------------------------
>   3 files changed, 41 insertions(+), 46 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> index 130f647a4d..50720f080f 100644
> --- a/tests/qemu-iotests/common
> +++ b/tests/qemu-iotests/common
> @@ -19,6 +19,29 @@
>   # common procedures for QA scripts
>   #
>   
> +_full_imgfmt_details()
> +{
> +    if [ -n "$IMGOPTS" ]; then
> +        echo "$IMGFMT ($IMGOPTS)"
> +    else
> +        echo "$IMGFMT"
> +    fi
> +}
> +
> +_full_imgproto_details()
> +{
> +    echo "$IMGPROTO"
> +}
> +
> +_full_platform_details()
> +{
> +    os=`uname -s`
> +    host=`hostname -s`
> +    kernel=`uname -r`
> +    platform=`uname -m`
> +    echo "$os/$platform $host $kernel"
> +}
> +
>   diff="diff -u"
>   verbose=false
>   debug=false
> @@ -404,7 +427,12 @@ if [ "$IMGOPTSSYNTAX" != "true" ]; then
>   fi
>   
>   # Set default options for qemu-img create -o if they were not specified
> -_set_default_imgopts
> +if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
> +    IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
> +fi
> +if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
> +    IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
> +fi
>   
>   if [ -s $tmp.list ]
>   then
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
> index 0f571d46eb..91da65f3dc 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -27,6 +27,9 @@ export PWD=`pwd`
>   
>   export _QEMU_HANDLE=0
>   
> +# make sure we have a standard umask
> +umask 022
> +
>   # $1 = prog to look for, $2* = default pathnames if not found in $PATH
>   set_prog_path()
>   {
> @@ -49,6 +52,15 @@ set_prog_path()
>       return 1
>   }
>   
> +_optstr_add()
> +{
> +    if [ -n "$1" ]; then
> +        echo "$1,$2"
> +    else
> +        echo "$2"
> +    fi
> +}
> +
>   _fatal()
>   {
>       echo "$*"
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index dd91a2b79a..6f6e03366f 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -50,9 +50,6 @@ then
>       fi
>   fi
>   
> -# make sure we have a standard umask
> -umask 022
> -
>   if [ "$IMGOPTSSYNTAX" = "true" ]; then
>       DRIVER="driver=$IMGFMT"
>       if [ "$IMGFMT" = "luks" ]; then
> @@ -94,25 +91,6 @@ else
>   fi
>   ORIG_TEST_IMG="$TEST_IMG"
>   
> -_optstr_add()
> -{
> -    if [ -n "$1" ]; then
> -        echo "$1,$2"
> -    else
> -        echo "$2"
> -    fi
> -}
> -
> -_set_default_imgopts()
> -{
> -    if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
> -        IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
> -    fi
> -    if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
> -        IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
> -    fi
> -}
> -
>   _use_sample_img()
>   {
>       SAMPLE_IMG_FILE="${1%\.bz2}"
> @@ -428,28 +406,5 @@ _require_command()
>       [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
>   }
>   
> -_full_imgfmt_details()
> -{
> -    if [ -n "$IMGOPTS" ]; then
> -        echo "$IMGFMT ($IMGOPTS)"
> -    else
> -        echo "$IMGFMT"
> -    fi
> -}
> -
> -_full_imgproto_details()
> -{
> -    echo "$IMGPROTO"
> -}
> -
> -_full_platform_details()
> -{
> -    os=`uname -s`
> -    host=`hostname -s`
> -    kernel=`uname -r`
> -    platform=`uname -m`
> -    echo "$os/$platform $host $kernel"
> -}
> -
>   # make sure this script returns success
>   true
> 
