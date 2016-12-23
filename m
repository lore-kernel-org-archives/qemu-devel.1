Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cKErJ-0006Lx-Ln
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 20:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cKErG-0003g4-Hs
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 20:41:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cKErG-0003fa-8A
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 20:41:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBN1dLuZ135867
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 20:41:15 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27gj2pjubt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 20:41:15 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 22 Dec 2016 23:41:13 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 0ECEA352005F
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 20:40:39 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	uBN1f9IR19267816
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 23:41:09 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	uBN1f9kC023212
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 23:41:09 -0200
Date: Thu, 22 Dec 2016 23:41:04 -0200
From: joserz@linux.vnet.ibm.com
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
Message-Id: <20161223014104.GA17985@pacoca>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 00/10] Record/payback patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Fri, Dec 09, 2016 at 11:48:20AM +0000, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> I did a bunch of tweaking to see if I could abstract the hackage for
> record/replay a bit more. With a little bit of light re-factoring of
> the send and recv functions I can move all the specific send/recv
> logic into the main risu.c file and avoid having copy and pasted
> functions for each architecture.
>=20
> I've also introduced a header which makes tracking where you are in
> the recorded stream a little easier when debugging.
>=20
> It should be noted the functions:
>=20
>   int send_register_info(write_fn write_fn, void *uc);
>   int recv_and_compare_register_info(read_fn read_fn, respond_fn respon=
d, void *uc);
>=20
> are pretty identical for each arch. I did consider folding even more
> of the logic into the common code but I wasn't sure if that would
> loose flexibility in the future for other architectures so I left it
> as is.
>=20
> I've make the same changes to ppc64 although I've been compiling and
> testing under a qemu linux-user environment which might explain why
> I'm seeing crashes when I try and run it. I would appreciate the PPC
> guys trying it on real hardware and debugging if needed.

Sure, I'm starting working on it. I'll try the real hardware, softmmu, an=
d linux-user. I have an idea about what leads to the crash (already have =
a fix for it). As soon as I have your feature working for ppc I'll send t=
he patches here.

Thanks Alex!

>=20
> For reference I'm using a linux-user powered docker image (built with
> the debian-bootstrap recipe in the qemu.git tree) for cross compiling:
>=20
>   docker run --rm -it -v /home/alex/lsrc/qemu/risu.git:/src --user=3Dal=
ex:alex -w /src debian:ppc64el make
>=20
> There have been some minor clean-ups to the helper scripts mainly to
> aid testing by allowing the override of the RISU binary (I have
> risu-arm, risu-arm64 and risu-ppc64 in my development directory).
> Notes in the --- comments on each patch.
>=20
> Alex Benn=C3=A9e (10):
>   risu: a bit more verbosity when running
>   aarch64: add hand-coded risu skeleton for directed testing
>   risu: paramterise send/receive functions
>   risu: add simple trace and replay support
>   risu: add support compressed tracefiles
>   risu_aarch64: it's -> it is
>   risugen: remove grocer's apostrophe from REs
>   new: generate_all.sh script
>   new: record_traces.sh helper script
>   new: run_risu.sh script
>=20
>  Makefile                      |  10 +-
>  aarch64_simd_handcoded.risu.S | 208 ++++++++++++++++++++++++++++++++++=
++++++++
>  configure                     |  55 +++++++++++
>  generate_all.sh               |  55 +++++++++++
>  record_traces.sh              |  20 ++++
>  risu.c                        | 139 ++++++++++++++++++++++++----
>  risu.h                        |  14 ++-
>  risu_aarch64.c                | 119 +++++++++++++++---------
>  risu_arm.c                    | 148 +++++++++++++++++++-----------
>  risu_ppc64le.c                | 127 ++++++++++++++++----------
>  risu_reginfo_aarch64.h        |   7 ++
>  risu_reginfo_arm.h            |   6 ++
>  risu_reginfo_ppc64le.h        |   6 ++
>  risugen                       |   2 +-
>  run_risu.sh                   |  53 +++++++++++
>  15 files changed, 805 insertions(+), 164 deletions(-)
>  create mode 100644 aarch64_simd_handcoded.risu.S
>  create mode 100755 generate_all.sh
>  create mode 100755 record_traces.sh
>  create mode 100755 run_risu.sh
>=20
> --=20
> 2.11.0
>=20
