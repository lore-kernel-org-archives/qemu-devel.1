Received: from eggs.gnu.org ([2001:4830:134:3::10]:59101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d6FsA-0008Kx-UW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d6Fs1-0004Fp-Ec
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45373
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d6Fs1-0004Fd-7y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:28:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44CPanH144131
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 08:28:32 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7wnv1xv1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 08:28:31 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 4 May 2017 06:28:31 -0600
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 08:28:26 -0400
MIME-Version: 1.0
In-Reply-To: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <05c17619-e5df-7615-73e9-64b4b57fd570@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Provide support for the software
 TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com

On 05/02/2017 07:52 AM, Amarnath Valluri wrote:
> Briefly, Theses set of patches introduces:
>    - new TPM backend driver to support software TPM emulators(swtpm(1)).
>    - and few supported fixes/enhancements/cleanup to existing tpm backend code.
>
>    The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
>    different approach, using CUSE. As swtpm has excellent support for unix domain
>    sockets, hence this implementation uses unix domain sockets to communicate
>    with
>    swtpm.

I think you would need something like this as well:

https://github.com/stefanberger/qemu-tpm/commit/9d8c9c3f0df288242d03f78d3b103099c1910574
https://github.com/stefanberger/qemu-tpm/commit/b9ea09d2e26eac92b4a1604a7afa695c4fc2735e



>
>    When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
>    communicates its via Unix domain sockets.
>
>    1) https://github.com/stefanberger/swtpm
>    2) https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00089.html
>
> ** Changes in V2:
> - Made spawnning swtpm optional
> - used QIOChannel instead of plain unix sockets
> - incorporated other fixes pointed in v1 review
>
> ** Changes in v3:
> - Addressed review comments made by Stefan Berger and Deniel P Berrange
>
> Amarnath Valluri (8):
>    tpm-backend: Remove unneeded member variable from backend class
>    tpm-backend: Move thread handling inside TPMBackend
>    tpm-backend: Initialize and free data members in it's own methods
>    tpm-backend: Made few interface methods optional
>    tmp backend: Add new api to read backend TpmInfo
>    tpm-backend: Move realloc_buffer() implementation to base class
>    tpm-passthrough: move reusable code to utils
>    tpm: Added support for TPM emulator
>
>   backends/tpm.c                   | 121 +++--
>   configure                        |  15 +-
>   hmp.c                            |  31 +-
>   hw/tpm/Makefile.objs             |   1 +
>   hw/tpm/tpm_emulator.c            | 943 +++++++++++++++++++++++++++++++++++++++
>   hw/tpm/tpm_ioctl.h               | 243 ++++++++++
>   hw/tpm/tpm_passthrough.c         | 221 +++------
>   hw/tpm/tpm_util.c                |  25 ++
>   hw/tpm/tpm_util.h                |   4 +
>   include/sysemu/tpm_backend.h     |  65 ++-
>   include/sysemu/tpm_backend_int.h |  41 --
>   qapi-schema.json                 |  67 ++-
>   qemu-options.hx                  |  53 ++-
>   tpm.c                            |  36 +-
>   14 files changed, 1545 insertions(+), 321 deletions(-)
>   create mode 100644 hw/tpm/tpm_emulator.c
>   create mode 100644 hw/tpm/tpm_ioctl.h
>   delete mode 100644 include/sysemu/tpm_backend_int.h
>
