Received: from eggs.gnu.org ([2001:4830:134:3::10]:47375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMK66-000150-13
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMK61-0005Py-4Z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:45:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59634
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eMK60-0005OD-UC
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:45:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5Ki6eh024002
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 15:45:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ep2j1gkx4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 15:45:39 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 13:45:38 -0700
References: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 15:45:34 -0500
MIME-Version: 1.0
In-Reply-To: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <6e60d979-30c9-700c-9958-e4fbafd96d49@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Add vTPM emulator supportfor ppc64
 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lo1@us.ibm.com, James.Bottomley@HansenPartnership.com, qemu-ppc@nongnu.org, clg@kaod.org, marcandre.lureau@redhat.com

On 12/05/2017 03:35 PM, Stefan Berger wrote:
> The following series of patches adds vTPM emulator support for the
> ppc64 platform (pSeries).
>
> It can be tested as follows with swtpm/libtpms:
>
> #> swtpm socket --tpmstate dir=/tmp/mytpm1 \
> 	--ctrl type=unixio,path=/tmp/mytpm1/ctrl.sock \
> 	--log level=2
>
> If TPM 2 is desired, add --tpm2 as parameter to the above
> and use the latest tpm2-preview branches of libtpms and swtpm.
>
> In another terminal start QEMU:
>
> #> sudo ./ppc64-softmmu/qemu-system-ppc64 -m 1024 \
> 	-monitor stdio -vnc :12 -vga std \
> 	--chardev socket,id=chrtpm,path=/tmp/mytpm1/ctrl.sock \
> 	-tpmdev emulator,id=tpm0,chardev=chrtpm \
> 	-device tpm-spapr,tpmdev=tpm0 \
> 	-L /tmp -bios boot_rom.bin \
> 	myimage.raw
>
> Links:
>   - libtpms: https://github.com/stefanberger/libtpms/wiki
>   - swtpm: https://github.com/stefanberger/swtpm/wiki

The migration patch builds on a series of previous patches. These and 
this series of patches can be found in my working branch:

https://github.com/stefanberger/qemu-tpm/commits/tpm-next+


>
> Regards,
>      Stefan
>
>
> Stefan Berger (2):
>    tpm_spapr: Support TPM for ppc64 using CRQ based interface
>    tpm_spapr: Support suspend and resume
>
>   hw/tpm/Makefile.objs |   1 +
>   hw/tpm/tpm_spapr.c   | 433 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/sysemu/tpm.h |   3 +
>   qapi/tpm.json        |   5 +-
>   4 files changed, 440 insertions(+), 2 deletions(-)
>   create mode 100644 hw/tpm/tpm_spapr.c
>
