Received: from eggs.gnu.org ([2001:4830:134:3::10]:40003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eb9tZ-0006Ci-3U
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eb9tU-0001wi-To
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:54:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eb9tU-0001uZ-Lh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:54:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FIqvZp106370
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 13:54:01 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fh0a5mjm9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 13:54:01 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 15 Jan 2018 18:53:58 -0000
References: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 15 Jan 2018 19:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <58a90a3a-2d90-15b0-dc7a-2523fab5c3d3@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] s390x: fix storage attributes
 migration for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x <qemu-s390x@nongnu.org>

CCing qemu-s390x.

On 01/15/2018 05:52 PM, Claudio Imbrenda wrote:
> Fix storage attribute migration so that it does not fail for guests
> with more than a few GB of RAM. Migration itself was successful, but
> storage attributes were not migrated completely.
> 
> This patch fixes the migration of all storage attributes, even when the
> guest have large amounts of memory.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
> ---
>  hw/s390x/s390-stattrib-kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 41770a7..480551c 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -116,7 +116,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>          for (cx = 0; cx + len <= max; cx += len) {
>              clog.start_gfn = cx;
>              clog.count = len;
> -            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
> +            clog.values = (uint64_t)(sas->incoming_buffer + cx);
>              r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
>              if (r) {
>                  error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
> @@ -126,7 +126,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>          if (cx < max) {
>              clog.start_gfn = cx;
>              clog.count = max - cx;
> -            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
> +            clog.values = (uint64_t)(sas->incoming_buffer + cx);
>              r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
>              if (r) {
>                  error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
> 
