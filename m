Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dHps1-0002FB-CT
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 07:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dHps0-0001sh-Af
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 07:08:25 -0400
Date: Mon, 5 Jun 2017 12:08:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170605110809.GA2666@work-vm>
References: <20170605104851.61818-1-haoqf@linux.vnet.ibm.com>
	<20170605104851.61818-2-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605104851.61818-2-haoqf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, liujbjl@linux.vnet.ibm.com, peterx@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com

* QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
> In load_vmstate, mis->from_src_file is freed twice, the first free is by
> qemu_fclose, the second is by migration_incoming_state_destroy and
> it causes Illegal instruction exception. The fix is just to remove the
> first free.
> 
> This problem is found by qemu-iotests case 068 since commit
> "660819b migration: shut src return path unconditionally". The error is:
> 068 1s ... - output mismatch (see 068.out.bad)
>     --- tests/qemu-iotests/068.out	2017-05-06 01:00:26.417270437 +0200
>     +++ 068.out.bad	2017-06-03 13:59:55.360274640 +0200
>     @@ -6,6 +6,8 @@
>      QEMU X.Y.Z monitor - type 'help' for more information
>      (qemu) savevm 0
>      (qemu) quit
>     +./common.config: line 107: 242472 Illegal instruction     (core dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
>     +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
>     +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
>      QEMU X.Y.Z monitor - type 'help' for more information
>     -(qemu) quit
>     -*** done
>     +(qemu) *** done
> 
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> ---
>  migration/savevm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9c320f59d0..853e14e34e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2290,7 +2290,6 @@ int load_snapshot(const char *name, Error **errp)
>  
>      aio_context_acquire(aio_context);
>      ret = qemu_loadvm_state(f);
> -    qemu_fclose(f);
>      aio_context_release(aio_context);

Thanks!

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  
>      migration_incoming_state_destroy();
> -- 
> 2.11.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
