Received: from eggs.gnu.org ([2001:4830:134:3::10]:42092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fgaoI-0006kw-TF
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fgaoF-0000XR-Mr
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:11:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fgaoF-0000Wh-GW
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:11:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6KJ3aFn176799
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:11:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kbnhr8aew-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:11:21 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 20 Jul 2018 13:11:20 -0600
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 20 Jul 2018 15:11:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180718211256.29774-1-naravamudan@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

I am seeing another issue pop up, in a different test. Even though it's 
a different assertion, it might be related based on the call trace.

Stack trace of thread 276199:
#0  0x000003ff8473e274 raise (libc.so.6)
#1  0x000003ff847239a8 abort (libc.so.6)
#2  0x000003ff847362ce __assert_fail_base (libc.so.6)
#3  0x000003ff8473634c __assert_fail (libc.so.6)
#4  0x000002aa30aba0c4 iov_memset (qemu-system-s390x)
#5  0x000002aa30aba9a6 qemu_iovec_memset (qemu-system-s390x)
#6  0x000002aa30a23e88 qemu_laio_process_completion (qemu-system-s390x)
#7  0x000002aa30a23f68 qemu_laio_process_completions (qemu-system-s390x)
#8  0x000002aa30a2418e qemu_laio_process_completions_and_submit 
(qemu-system-s390x)
#9  0x000002aa30a24220 qemu_laio_poll_cb (qemu-system-s390x)
#10 0x000002aa30ab22c4 run_poll_handlers_once (qemu-system-s390x)
#11 0x000002aa30ab2e78 aio_poll (qemu-system-s390x)
#12 0x000002aa30a29f4e bdrv_do_drained_begin (qemu-system-s390x)
#13 0x000002aa30a2a276 bdrv_drain (qemu-system-s390x)
#14 0x000002aa309d45aa bdrv_set_aio_context (qemu-system-s390x)
#15 0x000002aa3085acfe virtio_blk_data_plane_stop (qemu-system-s390x)
#16 0x000002aa3096994c virtio_bus_stop_ioeventfd.part.1 (qemu-system-s390x)
#17 0x000002aa3087d1d6 virtio_vmstate_change (qemu-system-s390x)
#18 0x000002aa308e8a12 vm_state_notify (qemu-system-s390x)
#19 0x000002aa3080ed54 do_vm_stop (qemu-system-s390x)
#20 0x000002aa307bea04 main (qemu-system-s390x)
#21 0x000003ff84723dd2 __libc_start_main (libc.so.6)
#22 0x000002aa307c0414 _start (qemu-system-s390x)


The failing assertion is:

qemu-kvm: util/iov.c:78: iov_memset: Assertion `offset == 0' failed.

On 07/18/2018 05:12 PM, Nishanth Aravamudan wrote:
> In ed6e2161 ("linux-aio: properly bubble up errors from initialzation"),
> I only added a bdrv_attach_aio_context callback for the bdrv_file
> driver. There are several other drivers that use the shared
> aio_plug callback, though, and they will trip the assertion added to
> aio_get_linux_aio because they did not call aio_setup_linux_aio first.
> Add the appropriate callback definition to the affected driver
> definitions.
> 
> Fixes: ed6e2161 ("linux-aio: properly bubble up errors from initialization")
> Reported-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>   block/file-posix.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..ad299beb38 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3158,6 +3158,7 @@ static BlockDriver bdrv_host_device = {
>       .bdrv_refresh_limits = raw_refresh_limits,
>       .bdrv_io_plug = raw_aio_plug,
>       .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>   
>       .bdrv_co_truncate       = raw_co_truncate,
>       .bdrv_getlength	= raw_getlength,
> @@ -3280,6 +3281,7 @@ static BlockDriver bdrv_host_cdrom = {
>       .bdrv_refresh_limits = raw_refresh_limits,
>       .bdrv_io_plug = raw_aio_plug,
>       .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>   
>       .bdrv_co_truncate    = raw_co_truncate,
>       .bdrv_getlength      = raw_getlength,
> @@ -3410,6 +3412,7 @@ static BlockDriver bdrv_host_cdrom = {
>       .bdrv_refresh_limits = raw_refresh_limits,
>       .bdrv_io_plug = raw_aio_plug,
>       .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>   
>       .bdrv_co_truncate    = raw_co_truncate,
>       .bdrv_getlength      = raw_getlength,
> 
