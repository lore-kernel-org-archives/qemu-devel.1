Received: from eggs.gnu.org ([209.51.188.92]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJZn-0007pz-5T
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJZl-0002BM-7W
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:01:19 -0400
References: <20190503143904.31211-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <408aeb3a-efd9-68a7-c5f0-08993084ec09@redhat.com>
Date: Sun, 5 May 2019 18:01:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190503143904.31211-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
> This attempts to clean-up the output to better match the output of the
> rest of the QEMU check system. This includes:
>=20
>   - formatting as "  TEST    iotest: nnn"
>   - calculating time diff at the end
>   - only dumping config on failure
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 922c5d1d3d..2ffc14113e 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -633,12 +633,6 @@ _wallclock()
>      date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
>  }
> =20
> -_timestamp()
> -{
> -    now=3D$(date "+%T")
> -    printf %s " [$now]"
> -}
> -
>  _wrapup()
>  {
>      if $showme
> @@ -709,19 +703,6 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
>  FULL_IMGFMT_DETAILS=3D$(_full_imgfmt_details)
>  FULL_HOST_DETAILS=3D$(_full_platform_details)
> =20
> -cat <<EOF
> -QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
> -QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
> -QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
> -QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
> -IMGFMT        -- $FULL_IMGFMT_DETAILS
> -IMGPROTO      -- $IMGPROTO
> -PLATFORM      -- $FULL_HOST_DETAILS
> -TEST_DIR      -- $TEST_DIR
> -SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
> -
> -EOF

Maybe turn it into a function instead, so that it could also always be
printed when the script is run with the "-v" parameter?

>  seq=3D"check"
> =20
>  [ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
> @@ -729,7 +710,9 @@ seq=3D"check"
>  for seq in $list
>  do
>      err=3Dfalse
> -    printf %s "$seq"
> +    reason=3D""
> +    times=3D""
> +
>      if [ -n "$TESTS_REMAINING_LOG" ] ; then
>          sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_L=
OG > $TESTS_REMAINING_LOG.tmp
>          mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
> @@ -738,7 +721,7 @@ do
> =20
>      if $showme
>      then
> -        echo
> +        echo "  TEST    iotest: $seq (not actually run)"

I wonder whether some other scripts depend on the output of "check -n"
... in that case, it make sense to only print the numbers, without the
additional strings here.

>          continue
>      elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" =
expunged >/dev/null
>      then
> @@ -753,17 +736,11 @@ do
>          # really going to try and run this one
>          #
>          rm -f $seq.out.bad
> -        lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
> -        if [ "X$lasttime" !=3D X ]; then
> -                printf %s " ${lasttime}s ..."
> -        else
> -                printf "        "        # prettier output with timest=
amps.
> -        fi
>          rm -f core $seq.notrun
>          rm -f $seq.casenotrun
> =20
>          start=3D$(_wallclock)
> -        $timestamp && printf %s "        [$(date "+%T")]"
> +        $timestamp && times=3D"[$(date "+%T")]"
> =20
>          if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/=
env python" ]; then
>              run_command=3D"$PYTHON $seq"
> @@ -781,26 +758,26 @@ do
>                      $run_command >$tmp.out 2>&1)
>          fi
>          sts=3D$?
> -        $timestamp && _timestamp
> +        $timestamp && times=3D"$times -> [$(date "+%T")]"
>          stop=3D$(_wallclock)
> =20
>          if [ -f core ]
>          then
> -            printf " [dumped core]"
>              mv core $seq.core
> +            reason=3D"dumped core $seq.core"
>              err=3Dtrue
>          fi
> =20
>          if [ -f $seq.notrun ]
>          then
> -            $timestamp || printf " [not run] "
> -            $timestamp && echo " [not run]" && printf %s "        $seq=
 -- "
> +            $timestamp || reason=3D"[not run]"
> +            $timestamp && reason=3D"[not run] $seq -- "
>              cat $seq.notrun
>              notrun=3D"$notrun $seq"
>          else
>              if [ $sts -ne 0 ]
>              then
> -                printf %s " [failed, exit status $sts]"
> +                reason=3D$(printf %s "[failed, exit status $sts]")
>                  err=3Dtrue
>              fi
> =20
> @@ -821,22 +798,27 @@ do
> =20
>              if [ ! -f "$reference" ]
>              then
> -                echo " - no qualified output"
> +                reason=3D" - no qualified output"
>                  err=3Dtrue
>              else
>                  if diff -w "$reference" $tmp.out >/dev/null 2>&1
>                  then
> -                    echo ""
>                      if $err
>                      then
>                          :
>                      else
> -                        echo "$seq $(expr $stop - $start)" >>$tmp.time
> +                        lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TI=
MESTAMP_FILE)
> +                        thistime=3D$(expr $stop - $start)
> +                        echo "$seq $thistime" >>$tmp.time
> +
> +                        if [ "X$lasttime" !=3D X ]; then
> +                            times=3D"$times ${thistime}s (last ${lastt=
ime}s)"
> +                        fi
>                      fi
>                  else
> -                    echo " - output mismatch (see $seq.out.bad)"
>                      mv $tmp.out $seq.out.bad
>                      $diff -w "$reference" "$PWD"/$seq.out.bad
> +                    reason=3D" - output mismatch (see $seq.out.bad)"
>                      err=3Dtrue
>                  fi
>              fi
> @@ -852,9 +834,24 @@ do
>      #
>      if $err
>      then
> +        echo "  TEST    iotest: $seq FAILED $reason"
> +        cat <<EOF
> +QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
> +QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
> +QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
> +QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
> +IMGFMT        -- $FULL_IMGFMT_DETAILS
> +IMGPROTO      -- $IMGPROTO
> +PLATFORM      -- $FULL_HOST_DETAILS
> +TEST_DIR      -- $TEST_DIR
> +SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
> +
> +EOF
>          bad=3D"$bad $seq"
>          n_bad=3D$(expr $n_bad + 1)
>          quick=3Dfalse
> +    else
> +        echo "  TEST    iotest: $seq $times"
>      fi
>      [ -f $seq.notrun ] || try=3D$(expr $try + 1)

Output is much nicer indeed (especially when this is running in parallel
with the other tests), thus:

Tested-by: Thomas Huth <thuth@redhat.com>
