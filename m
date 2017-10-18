Received: from eggs.gnu.org ([2001:4830:134:3::10]:58193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4otZ-00049S-9P
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4otT-000738-27
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:00:29 -0400
Date: Wed, 18 Oct 2017 09:59:57 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018135957.GD17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/10] qemu-iotests: change qemu pid and
 fd tracking / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

On Tue, Oct 17, 2017 at 12:31:50PM -0400, Jeff Cody wrote:
> So that later patches can cleanup running qemu processes called from
> different subshells, track resources to cleanup in pid and fd list
> files.
> 
> In subsquent patches, ./check will kill all QEMU processes launched with
> the common.qemu framework, and the tests will not need to cleanup
> manually (unless they want to do so as part of the test, e.g. wait for
> a process to end such as migration).
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu | 82 ++++++++++++++++++++++++++++++++----------
>  tests/qemu-iotests/common.rc   |  3 +-
>  2 files changed, 64 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
> index 7b3052d..35a08a6 100644
> --- a/tests/qemu-iotests/common.qemu
> +++ b/tests/qemu-iotests/common.qemu
> @@ -33,6 +33,10 @@ QEMU_FIFO_OUT="${QEMU_TEST_DIR}/qmp-out-$$"
>  QEMU_HANDLE=0
>  export _QEMU_HANDLE=0
>  
> +QEMU_PID_LIST="${QEMU_TEST_DIR}"/qemu-pid.lst
> +QEMU_OUT_FD_LIST="${QEMU_TEST_DIR}"/qemu-out-fd.lst
> +QEMU_IN_FD_LIST="${QEMU_TEST_DIR}"/qemu-in-fd.lst
> +QEMU_FIFO_LIST="${QEMU_TEST_DIR}"/qemu-fifo.lst
>  # If bash version is >= 4.1, these will be overwritten and dynamic
>  # file descriptor values assigned.
>  _out_fd=3
> @@ -193,6 +197,10 @@ function _launch_qemu()
>      QEMU_OUT[${_QEMU_HANDLE}]=${_out_fd}
>      QEMU_IN[${_QEMU_HANDLE}]=${_in_fd}
>      QEMU_STATUS[${_QEMU_HANDLE}]=0
> +    echo ${_out_fd} >> "$QEMU_OUT_FD_LIST"
> +    echo ${_in_fd} >> "$QEMU_IN_FD_LIST"
> +    echo ${fifo_in} >> "$QEMU_FIFO_LIST"
> +    echo ${fifo_out} >> "$QEMU_FIFO_LIST"
>  
>      if [ "${qemu_comm_method}" == "qmp" ]
>      then
> @@ -209,35 +217,71 @@ function _launch_qemu()
>  
>  # Silenty kills the QEMU process
>  #
> +# This is able to kill and clean up after QEMU processes without the
> +# need for any subshell-specific variables, so long as the qemu-pidlist
> +# and qemu-out-fd.list and qemu-in-fd.list files are properly maintained.
> +#
>  # If $wait is set to anything other than the empty string, the process will not
>  # be killed but only waited for, and any output will be forwarded to stdout. If
>  # $wait is empty, the process will be killed and all output will be suppressed.
>  function _cleanup_qemu()
>  {
> -    # QEMU_PID[], QEMU_IN[], QEMU_OUT[] all use same indices
> -    for i in "${!QEMU_OUT[@]}"
> +    local fifo_path=
> +    local testdir_path=
> +
> +    if [ ! -e "${QEMU_PID_LIST}" ]; then
> +        return
> +    fi
> +
> +    # get line count, and therefore number of processes to kill
> +    numproc=$(wc -l "${QEMU_PID_LIST}" | sed 's/\s.*//')
> +
> +    for i in $(seq 1 $numproc)
>      do
>          local QEMU_PID
> -        if [ -f "${QEMU_TEST_DIR}/qemu-${i}.pid" ]; then
> -            read QEMU_PID < "${QEMU_TEST_DIR}/qemu-${i}.pid"
> -            rm -f "${QEMU_TEST_DIR}/qemu-${i}.pid"
> -            if [ -z "${wait}" ] && [ -n "${QEMU_PID}" ]; then
> -                kill -KILL ${QEMU_PID} 2>/dev/null
> -            fi
> -            if [ -n "${QEMU_PID}" ]; then
> -                wait ${QEMU_PID} 2>/dev/null # silent kill
> -            fi
> +        local OUT_FD
> +        local IN_FD
> +        j=$(expr $i - 1)
> +
> +        QEMU_PID=$(tail -n+${i} "${QEMU_PID_LIST}" | head -n1)
> +        OUT_FD=$(tail -n+${i} "${QEMU_OUT_FD_LIST}" | head -n1)
> +        IN_FD=$(tail -n+${i} "${QEMU_IN_FD_LIST}" | head -n1)
> +
> +        if [ -z "${wait}" ] && [ -n "${QEMU_PID}" ]; then
> +            kill -KILL ${QEMU_PID} 2>/dev/null
> +        fi
> +        if [ -n "${QEMU_PID}" ]; then
> +            wait ${QEMU_PID} 2>/dev/null # silent kill
>          fi
>  
> -        if [ -n "${wait}" ]; then
> -            cat <&${QEMU_OUT[$i]} | _filter_testdir | _filter_qemu \
> -                                  | _filter_qemu_io | _filter_qmp | _filter_hmp
> +        if [ -n "${wait}" ] && [ -n "${OUT_FD}" ]; then
> +            cat <&${OUT_FD} | _filter_testdir | _filter_qemu \
> +                            | _filter_qemu_io | _filter_qmp | _filter_hmp
> +        fi
> +
> +        if [ -n "${IN_FD}" ]; then
> +            eval "exec ${IN_FD}<&-"   # close file descriptors
> +        fi
> +        if [ -n "${OUT_FD}" ]; then
> +            eval "exec ${OUT_FD}<&-"
>          fi
> -        rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
> -        eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
> -        eval "exec ${QEMU_OUT[$i]}<&-"
>  
> -        unset QEMU_IN[$i]
> -        unset QEMU_OUT[$i]
> +        unset QEMU_IN[$j]
> +        unset QEMU_OUT[$j]
>      done
> +
> +    # The FIFOs do not correspond to process entry in the pidlist, so
> +    # just clean them up afterwards
> +    while read fifo_name
> +    do
> +        # make sure entries are inside the $TEST_DIR
> +        fifo_path=$(dirname -z $(realpath "$fifo_name"))

Pointing out another issue I noticed after testing on a different machine:
in Bash > 4.4, this generates a warning, which breaks diff stats.  The fix
is to drop the '-z':
        fifo_path=$(dirname $(realpath "$fifo_name"))

> +        testdir_path=$(realpath "$QEMU_TEST_DIR")
> +        if [ "$fifo_path" == "$testdir_path" ]
> +        then
> +            rm -f "$fifo_name"
> +        fi
> +    done < "${QEMU_FIFO_LIST}"
> +
> +    rm -f "${QEMU_PID_LIST}" "${QEMU_OUT_FD_LIST}" "${QEMU_IN_FD_LIST}" "$QEMU_FIFO_LIST}"
>  }
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index a345ffd..b26b02f 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -40,7 +40,6 @@ poke_file()
>      printf "$3" | dd "of=$1" bs=1 "seek=$2" conv=notrunc &>/dev/null
>  }
>  
> -
>  if ! . ./common.config
>      then
>      echo "$0: failed to source common.config"
> @@ -51,7 +50,7 @@ _qemu_wrapper()
>  {
>      (
>          if [ -n "${QEMU_NEED_PID}" ]; then
> -            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
> +            echo $BASHPID >> "${QEMU_TEST_DIR}/qemu-pid.lst"
>          fi
>          exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
>      )
> -- 
> 2.9.5
> 
