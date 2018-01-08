Received: from eggs.gnu.org ([2001:4830:134:3::10]:46960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aneesh.kumar@linux.vnet.ibm.com>) id 1eYSub-0003ys-NH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aneesh.kumar@linux.vnet.ibm.com>) id 1eYSuW-0002qF-QN
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:36:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aneesh.kumar@linux.vnet.ibm.com>)
	id 1eYSuW-0002pi-Hx
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:36:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w088YNsJ009017
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 03:35:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fby7yc697-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 03:35:56 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Mon, 8 Jan 2018 08:35:50 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <151360476094.18806.1179096997853697345.stgit@bahia.lan>
References: <151360476094.18806.1179096997853697345.stgit@bahia.lan>
Date: Mon, 08 Jan 2018 14:05:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv1ozr1a.fsf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: deprecate handle backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>

Greg Kurz <groug@kaod.org> writes:

> This backend raise some concerns:
>
> - doesn't support symlinks
> - fails +100 tests in the PJD POSIX file system test suite [1]
> - requires the QEMU process to run with the CAP_DAC_READ_SEARCH
>   capability, which isn't recommended for security reasons
>
> For all these reasons, the handle backend is now deprecated.
>
> [1] https://www.tuxera.com/community/posix-test-suite/
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> Aneesh,
>
> Even if I see the benefit of using file handles in a userspace file
> server, the handle backend still has flaws that make it hardly usable
> IMHO. Also I haven't received anything about it in years. All users
> and contributors seem to stick to the local backend.
>
> My guess is that nobody uses the handle backend, and unless I'm missing
> something, it wouldn't hurt to drop it. My motivation is to reduce the
> number of lines that I don't really have time/motivation to maintain,
> and that could be subject to a CVE in the future.
>
> Any thoughts ?
> ---
>  hw/9pfs/9p-handle.c |    2 ++
>  qemu-doc.texi       |    8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
> index 9875f1894cc5..1291a2db6782 100644
> --- a/hw/9pfs/9p-handle.c
> +++ b/hw/9pfs/9p-handle.c
> @@ -657,6 +657,8 @@ static int handle_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
>      const char *sec_model = qemu_opt_get(opts, "security_model");
>      const char *path = qemu_opt_get(opts, "path");
>
> +    warn_report("handle backend is deprecated");
> +
>      if (sec_model) {
>          error_report("Invalid argument security_model specified with handle fsdriver");
>          return -1;
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7317dfc66cd..bf44e2752cb2 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2509,6 +2509,14 @@ default channel subsystem image for guests that do not support multiple
>  channel subsystems, all devices can be put into the default channel
>  subsystem image.
>
> +@subsection -fsdev handle (since 2.12.0)
> +
> +The ``handle'' fsdev backend does not support symlinks and causes the 9p
> +filesystem in the guest to fail a fair amount of tests from the PJD POSIX
> +filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
> +which is not the recommended way to run QEMU. This backend should not be
> +used and it will be removed with no replacement.
> +
>  @section qemu-img command line arguments
>
>  @subsection convert -s (since 2.0.0)
