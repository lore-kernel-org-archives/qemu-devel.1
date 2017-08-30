Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBdL-0005ql-KZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBdK-0005a6-Lz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:38:51 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c5a2ea74-7c0b-0596-f07c-3b1ab00aa9b5@redhat.com>
Date: Wed, 30 Aug 2017 18:38:40 -0400
MIME-Version: 1.0
In-Reply-To: <e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qemu-iotests: add option to save
 temp files on error
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
> Now that ./check takes care of cleaning up after each tests, it
> can also selectively not clean up.  Add option to leave all output from
> tests intact if that test encountered an error.
> 
> Note: this currently only works for bash tests, as the python tests
> still clean up after themselves manually.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check  | 10 +++++++++-
>  tests/qemu-iotests/common |  6 ++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f6ca85d..8a5fc0d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -370,7 +370,15 @@ do
>              fi
>          fi
>  
> -        rm -rf "$TEST_DIR_SEQ"
> +        #TODO: There is some intial work to save intermediate files
> +        #      in python tests, but it is imperfect.  Having each
> +        #      test record its test name, and the tearDown function
> +        #      just move intermediate images to a subdirectory with
> +        #      the test name may prove more useful.
> +        if [ "$save_on_err" != "true" ] || [ "$err" != "true" ]
> +        then
> +            rm -rf "$TEST_DIR_SEQ"
> +        fi
>  
>      fi
>  
> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> index d34c11c..d08b233 100644
> --- a/tests/qemu-iotests/common
> +++ b/tests/qemu-iotests/common
> @@ -42,6 +42,7 @@ expunge=true
>  have_test_arg=false
>  randomize=false
>  cachemode=false
> +save_on_err=false
>  rm -f $tmp.list $tmp.tmp $tmp.sed
>  
>  export IMGFMT=raw
> @@ -172,6 +173,7 @@ other options
>      -T                  output timestamps
>      -r                  randomize test order
>      -c mode             cache mode
> +    -s                  save test scratch directory on test failure
>  
>  testlist options
>      -g group[,group...]        include tests from these groups
> @@ -349,6 +351,10 @@ testlist options
>              xgroup=true
>              xpand=false
>              ;;
> +        -s)
> +            save_on_err=true
> +            xpand=false
> +            ;;
>          '[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
>              echo "No tests?"
>              status=1
> 

This, however, is definitely awesome.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
