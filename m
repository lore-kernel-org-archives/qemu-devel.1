Received: from eggs.gnu.org ([2001:4830:134:3::10]:46087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqcJs-0005Us-Vi
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqcJo-0006kE-DX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:17:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eqcJo-0006k6-5v
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:17:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RAH5rj005454
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:17:07 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd46x38ch-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:17:05 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 10:16:47 -0000
References: <1519725913-24852-1-git-send-email-thuth@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 11:16:44 +0100
MIME-Version: 1.0
In-Reply-To: <1519725913-24852-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <d638aa33-2102-e6a4-d79a-05591693de07@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Bail out if the network
 bootloader can not be found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 27.02.2018 11:05, Thomas Huth wrote:
> If QEMU fails to load 's390-netboot.img', the guest firmware currently
> loops forever and just floods the console with "Network boot device
> detected" messages. The code in ipl.c apparently already tried to stop
> the VM with vm_stop() in this case, but this is in vain since the run
> state is later reset due to a call to vm_start() from vl.c again.
> To avoid the ugly firmware loop, let's simply exit QEMU directly instead
> since it just does not make sense to continue if the required firmware
> image can not be loaded. While we're at it, also add the file name of
> the netboot binary to the error message, so that the user has a better
> hint about what is missing.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..ff8308e 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -322,7 +322,8 @@ static int load_netboot_image(Error **errp)
> 
>      netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netboot_fw);
>      if (netboot_filename == NULL) {
> -        error_setg(errp, "Could not find network bootloader");
> +        error_setg(errp, "Could not find network bootloader '%s'",> +                   ipl->netboot_fw);
>          goto unref_mr;
>      }
> 
> @@ -416,7 +417,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>      if (ipl->netboot) {
>          if (load_netboot_image(&err) < 0) {
>              error_report_err(err);
> -            vm_stop(RUN_STATE_INTERNAL_ERROR);
Should we print something like 'exiting' or 'terminating' here, to make
clear that the situation is terminal? Sometimes errors are reported and
processing continues nonetheless.
> +            exit(1);
>          }
>          ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
>      }
> 

-- 
Regards,
 Viktor Mihajlovski
