Received: from eggs.gnu.org ([2001:4830:134:3::10]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXU4D-0003qS-3a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXU49-0006r0-Df
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dXU49-0006qR-1G
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IF55vJ101710
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 11:05:35 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsdcfqn35-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 11:05:34 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 11:05:33 -0400
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 11:05:30 -0400
MIME-Version: 1.0
In-Reply-To: <1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e048e7d8-30da-1740-981c-cfc6d5fa764b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 07/18/2017 04:49 AM, Amarnath Valluri wrote:
> This change introduces a new TPM backend driver that can communicate with
> swtpm(software TPM emulator) using unix domain socket interface.
>
> Swtpm uses two unix sockets, one for plain TPM commands and responses, and one
> for out-of-band control messages.
>
> The swtpm and associated tools can be found here:
>      https://github.com/stefanberger/swtpm
>
> The swtpm's control channel protocol specification can be found here:
>      https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification
>
> Usage:
>      # setup TPM state directory
>      mkdir /tmp/mytpm
>      chown -R tss:root /tmp/mytpm
>      /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>
>      # Ask qemu to use TPM emulator with given tpm state directory
>      qemu-system-x86_64 \
>          [...] \
>          -tpmdev emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
>          -device tpm-tis,tpmdev=tpm0 \
>          [...]


In this description ',spawn,path=/usr/bin/swtpm' is missing. I had to 
pass the path even with swtpm being in PATH on the command line but not 
for the execv(). In case it didn't find the executable I had to 
eliminate g_strfreev(argv) since it also wants to free the array itself, 
so it wouldn't end up in a crash.

    Stefan
