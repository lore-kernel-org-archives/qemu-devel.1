Received: from eggs.gnu.org ([209.51.188.92]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1Xa0-0005eo-Ej
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1XZz-0005AF-F0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:31:32 -0500
Date: Wed, 6 Mar 2019 15:31:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306143117.GG6818@localhost.localdomain>
References: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1551694120-768127-3-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551694120-768127-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: ask QEMU for supported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com

Am 04.03.2019 um 11:08 hat Andrey Shinkevich geschrieben:
> Supported formats listed by 'qemu' may differ from those listed by
> 'qemu-img' due to whitelists. Some test cases require specific formats
> that may be used with qemu. They can be inquired directly by running
> 'qemu -drive format=help'. The response takes whitelists into account.
> The method supported_formats() serves for that. The method decorator
> skip_if_unsupported() checks if all requested formats are whitelisted.
> If not, the test case will be skipped. That has been implemented in
> the 'check' file in the way similar to the 'test notrun' mechanism.
> 
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/check      | 16 +++++++++++++-
>  tests/qemu-iotests/iotests.py | 50 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 895e1e3..b9d539c 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -25,6 +25,7 @@ try=0
>  n_bad=0
>  bad=""
>  notrun=""
> +casenotrun=""
>  interrupt=true
>  
>  # by default don't output timestamps
> @@ -664,6 +665,11 @@ END        { if (NR > 0) {
>              echo "Not run:$notrun"
>              echo "Not run:$notrun" >>check.log
>          fi
> +        if [ ! -z "$casenotrun" ]
> +        then
> +            echo "Some cases not run in:$casenotrun"
> +            echo "Some cases not run in:$casenotrun" >>check.log
> +        fi
>          if [ ! -z "$n_bad" -a $n_bad != 0 ]
>          then
>              echo "Failures:$bad"
> @@ -743,6 +749,10 @@ do
>                  printf "        "        # prettier output with timestamps.
>          fi
>          rm -f core $seq.notrun
> +        if [ -f $seq.casenotrun ]
> +        then
> +            rm -f $seq.casenotrun
> +        fi

The if is unnecessary here, 'rm -f' doesn't print an error if the file
doesn't exist.

>          start=$(_wallclock)
>          $timestamp && printf %s "        [$(date "+%T")]"
> @@ -823,7 +833,11 @@ do
>                  fi
>              fi
>          fi
> -
> +        if [ -f $seq.casenotrun ]
> +        then
> +            cat $seq.casenotrun
> +            casenotrun="$casenotrun $seq"
> +        fi
>      fi
>  
>      # come here for each test, except when $showme is true
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index b461f53..8fe1620 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -728,6 +728,56 @@ def verify_quorum():
>      if not supports_quorum():
>          notrun('quorum support missing')
>  
> +def qemu_pipe(*args):
> +    '''Run qemu with an option to print something and exit (e.g. a help option),
> +    and return its output'''
> +    args = [qemu_prog] + qemu_opts + list(args)
> +    subp = subprocess.Popen(args, stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT)
> +    exitcode = subp.wait()
> +    if exitcode < 0:
> +        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
> +            ' '.join(args)))
> +    return subp.communicate()[0]
> +
> +def supported_formats(read_only=False):
> +    '''Set 'read_only' to True to check ro-whitelist
> +       Otherwise, rw-whitelist is checked'''
> +    format_message = qemu_pipe("-drive", "format=help")
> +    available = []
> +
> +    if read_only:
> +        # Check read-only whitelist
> +        available = format_message.splitlines()[1].split(":")[1].split()
> +    else:
> +        # Check read-write whitelist
> +        available = format_message.splitlines()[0].split(":")[1].split()
> +
> +    return available

What do you need available for when you only assign it and then
immediately return it without using it before? I think I would write
it much shorter like this:

line = 1 if read_only else 0
return format_message.splitlines()[line].split(":")[1].split()

> +def case_notrun(reason):
> +    '''Skip this test case'''
> +    # Each test in qemu-iotests has a number ("seq")
> +    seq = os.path.basename(sys.argv[0])
> +
> +    open('%s/%s.casenotrun' % (output_dir, seq), 'ab').write(
> +        '    [case not run] ' + reason + '\n')

Maybe move this next to notrun(), which is similar?

Kevin
