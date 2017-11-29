Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK1NB-0006Xi-9E
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK1N8-0006Vl-GE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eK1N8-0006VM-7d
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATCJYgd011511
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:21:47 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehvcvh7b5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:21:46 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 07:21:45 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171031204330.14803-2-danielhb@linux.vnet.ibm.com>
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
	<20171031204330.14803-2-danielhb@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 18:19:08 -0600
Message-Id: <151191474870.31225.10528629905980928810@sif>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] tests: adding 'check_exception'
 RTAS implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Quoting Daniel Henrique Barboza (2017-10-31 15:43:27)
> In the sPAPR guest, events such as device hotplug/unplug are
> retrieved by the check_exception RTAS call after the guest
> receives an IRQ pulse. For both hotplug and unplug operations,
> guest intervention is required to transit the DRC state of
> the attached device to the configured state.
> =

> Without guest intervention, we are still able of qtesting hotplug
> devices in the same manner that we support device hotplug in
> early (pre-CAS) stages.
> =

> Unfortunately, hot unplugs qtests relies on callbacks that demands
> guest intervention to complete - otherwise we risk leaving the guest
> in an inconsistent state that might impact other hotplug/unplug
> operations later on. If we want to make hot unplug qtests we'll
> need to simulate the guest behavior in the scenario in which a
> hot unplug is received, allowing the hot unplug process to go
> as intended.
> =

> This patch is the first step towards hot unplug qtests in sPAPR,
> implementing the check_exception RTAS hypercall in libqos. This
> hypercall is used to fetch events such as hotplug/hot unplug from
> the sPAPR machine after the guest receives an IRQ pulse (or,
> in the case of the test implemented here, we simply know when
> there is/isn't an event to be retrieved).
> =

> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  tests/libqos/rtas.c | 37 +++++++++++++++++++++++++
>  tests/libqos/rtas.h |  2 ++
>  tests/rtas-test.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 116 insertions(+)
> =

> diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
> index 0269803ce0..fdeab448f7 100644
> --- a/tests/libqos/rtas.c
> +++ b/tests/libqos/rtas.c
> @@ -114,3 +114,40 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *allo=
c, uint64_t buid,
> =

>      return 0;
>  }
> +
> +/*
> + * check_exception as defined by PAPR 2.7+, 7.3.3.2

Now that we have a public LoPAPR I think it's better to reference that
when possible.
