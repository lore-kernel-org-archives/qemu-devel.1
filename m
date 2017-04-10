Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxVzH-0000SO-RY
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxVzD-0007zd-Cm
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:55 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxVzD-0007zR-5y
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:51 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l28so15515659wre.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:51:51 -0700 (PDT)
References: <20170410081217.2897-1-nikunj@linux.vnet.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170410081217.2897-1-nikunj@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 10:51:57 +0100
Message-ID: <87mvbok2te.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10] tcg: enable MTTCG by default for
 PPC64 on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, qemu-devel@nongnu.org, intermediadc@hotmail.com, programmingkidx@gmail.com, clg@kaod.org


Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> This enables the multi-threaded system emulation by default for PPC64
> guests using the x86_64 TCG back-end.

Technically this enables it for all backends that can meet the guests
default memory model requirements. So far only the x86 backend defines
one as:

  #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)

>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>
> Depends on following patch which fixes the define name:
>
> https://patchwork.ozlabs.org/patch/748840/
>
> ---
>  configure        | 2 ++
>  target/ppc/cpu.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/configure b/configure
> index 4b3b5cd..2a87495 100755
> --- a/configure
> +++ b/configure
> @@ -6008,12 +6008,14 @@ case "$target_name" in
>    ppc64)
>      TARGET_BASE_ARCH=ppc
>      TARGET_ABI_DIR=ppc
> +    mttcg=yes
>      gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
>    ;;
>    ppc64le)
>      TARGET_ARCH=ppc64
>      TARGET_BASE_ARCH=ppc
>      TARGET_ABI_DIR=ppc
> +    mttcg=yes
>      gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
>    ;;
>    ppc64abi32)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e0ff041..ece535d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -30,6 +30,8 @@
>  #define TARGET_LONG_BITS 64
>  #define TARGET_PAGE_BITS 12
>
> +#define TCG_GUEST_DEFAULT_MO 0
> +
>  /* Note that the official physical address space bits is 62-M where M
>     is implementation dependent.  I've not looked up M for the set of
>     cpus we emulate at the system level.  */


--
Alex Bennée
