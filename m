Received: from eggs.gnu.org ([2001:4830:134:3::10]:54585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBGX-0005KX-In
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBGW-0006CJ-Ih
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:15:17 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<fab0dc0858ef58dd2e58ddcac3c38f9ab39d045f.1504111803.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb493e5c-0604-e572-c7e4-2276e29a6bdb@redhat.com>
Date: Wed, 30 Aug 2017 18:15:05 -0400
MIME-Version: 1.0
In-Reply-To: <fab0dc0858ef58dd2e58ddcac3c38f9ab39d045f.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qemu-iotests: set TEST_DIR to a
 unique dir for each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, stefanha@redhat.com



On 08/30/2017 12:52 PM, Jeff Cody wrote:
> Right now, all qemu-iotests output data into the same scratch directory,
> and so each test needs to be responsible for cleaning up its own files.
> 
> Have each test use 'scratch/$seq' as its temp directory, so the check
> script can do simple cleanup of removing the whole temporary directory.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index d504b6e..f6ca85d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -243,6 +243,7 @@ seq="check"
>  
>  for seq in $list
>  do
> +    TEST_DIR_SEQ=$TEST_DIR/$seq
>      err=false
>      printf %s "$seq"
>      if [ -n "$TESTS_REMAINING_LOG" ] ; then
> @@ -289,13 +290,23 @@ do
>          fi
>          export OUTPUT_DIR=$PWD
>          if $debug; then
> -            (cd "$source_iotests";
> +            (
> +            export TEST_DIR=$TEST_DIR_SEQ
> +            . "$source_iotests/common.config"
> +            . "$source_iotests/common.rc"

What purpose do these serve?

> +            cd "$source_iotests" &&
>              MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
> -                    $run_command -d 2>&1 | tee $tmp.out)
> +                    $run_command -d 2>&1 | tee $tmp.out
> +            )
>          else
> -            (cd "$source_iotests";
> +            (
> +            export TEST_DIR=$TEST_DIR_SEQ
> +            . "$source_iotests/common.config"
> +            . "$source_iotests/common.rc"
> +             cd "$source_iotests" &&
>              MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
> -                    $run_command >$tmp.out 2>&1)
> +                    $run_command >$tmp.out 2>&1
> +            )
>          fi
>          sts=$?
>          $timestamp && _timestamp
> @@ -359,6 +370,8 @@ do
>              fi
>          fi
>  
> +        rm -rf "$TEST_DIR_SEQ"
> +
>      fi
>  
>      # come here for each test, except when $showme is true
> 

Seems OK to me, though I am not able to answer all doubts about exactly
how this may effect the strange pipe/subshell arrangements that occur
deeper in the bowels of the included files for launching QEMU and so
on.. I suppose that might be related to the inclusion of those
common.XYZ files?

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
