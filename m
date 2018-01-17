Received: from eggs.gnu.org ([2001:4830:134:3::10]:58359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebp5R-0001yx-WB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebp5P-0003Ah-BM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:53:10 -0500
Date: Wed, 17 Jan 2018 15:52:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180117155249.2dd01cae.cohuck@redhat.com>
In-Reply-To: <20180117141849.65757-4-borntraeger@de.ibm.com>
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-4-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/cpumodel: fix transparency for
 non-hyp STFL features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Wed, 17 Jan 2018 15:18:49 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Before cpu-models were introduced to QEMU with 2.8 the so called
> non-hypervisor-managed STFL facilities (aka transparent facilities) were
> handled transparently.
> 
> With the advent cpu models, for host model (means -cpu host), we started

s/the advent/the advent of/

s/means//

> fencing these of using the identified full model. The full models however

s/of/off/

> did not include all non-hypervisor-managed facilities, thus we end up
> fencing some of these off.
> 
> New (non-hypervisor managed) facilities can be introduced with hardware
> or firmware upgrades. Requiring a code change and thus a QEMU upgrade to
> leverage such facilities is not acceptable. Namely the semantic of the host
> model is 'give me all you can'.
> 
> Let us add non-hypervisor managed STFL facility bits to QEMU and to all
> the full models. For now first two doublewords should be sufficient.
> 
> With this, when using host model, transparent facilities are presented to
> the guest. Regarding default (and base)  models however, nothing really
> changes, except that user can specify any non-hypervisor facility now.
> 
> Thus the so called transparent facilities, aren't handled transparently
> with the default nor with the base models (because of migration
> considerations).  For example -cpu z13 will not enable (and mandate) any
> of the features added with this change for any compat machine types.
> 
> Emerging non-hypervisor managed facilities that are expected to be
> present in any sane environment (in the context of the machine type)
> should be added to the default model (for non-compat machine types).

I agree with this change in principle, but would like feedback from
David.

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     |  54 +++++++++++++++++++++
>  target/s390x/cpu_features_def.h |  54 +++++++++++++++++++++
>  target/s390x/gen-features.c     | 103 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 5d1c210..407864a 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -51,6 +51,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("parseh", S390_FEAT_TYPE_STFL, 26, "Parsing-enhancement facility"),
>      FEAT_INIT("mvcos", S390_FEAT_TYPE_STFL, 27, "Move-with-optional-specification facility"),
>      FEAT_INIT("tods-base", S390_FEAT_TYPE_STFL, 28, "TOD-clock-steering facility (excluding subfunctions)"),
> +    FEAT_INIT("stfle29", S390_FEAT_TYPE_STFL, 29, "Facility that is provided by STFLE facility 29"),
>      FEAT_INIT("etf3eh", S390_FEAT_TYPE_STFL, 30, "ETF3-enhancement facility"),
>      FEAT_INIT("ectg", S390_FEAT_TYPE_STFL, 31, "Extract-CPU-time facility"),
>      FEAT_INIT("csst", S390_FEAT_TYPE_STFL, 32, "Compare-and-swap-and-store facility"),
> @@ -60,12 +61,14 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("emon", S390_FEAT_TYPE_STFL, 36, "Enhanced-monitor facility"),
>      FEAT_INIT("fpe", S390_FEAT_TYPE_STFL, 37, "Floating-point extension facility"),
>      FEAT_INIT("opc", S390_FEAT_TYPE_STFL, 38, "Order Preserving Compression facility"),
> +    FEAT_INIT("stfle39", S390_FEAT_TYPE_STFL, 39, "Facility that is provided by STFLE facility 39"),
>      FEAT_INIT("sprogp", S390_FEAT_TYPE_STFL, 40, "Set-program-parameters facility"),
>      FEAT_INIT("fpseh", S390_FEAT_TYPE_STFL, 41, "Floating-point-support-enhancement facilities"),
>      FEAT_INIT("dfp", S390_FEAT_TYPE_STFL, 42, "DFP (decimal-floating-point) facility"),
>      FEAT_INIT("dfphp", S390_FEAT_TYPE_STFL, 43, "DFP (decimal-floating-point) facility has high performance"),
>      FEAT_INIT("pfpo", S390_FEAT_TYPE_STFL, 44, "PFPO instruction"),
>      FEAT_INIT("stfle45", S390_FEAT_TYPE_STFL, 45, "Various facilities introduced with z196"),
> +    FEAT_INIT("stfle46", S390_FEAT_TYPE_STFL, 46, "Facility that is provided by STFLE facility 46"),
>      FEAT_INIT("cmpsceh", S390_FEAT_TYPE_STFL, 47, "CMPSC-enhancement facility"),
>      FEAT_INIT("dfpzc", S390_FEAT_TYPE_STFL, 48, "Decimal-floating-point zoned-conversion facility"),
>      FEAT_INIT("stfle49", S390_FEAT_TYPE_STFL, 49, "Various facilities introduced with zEC12"),
> @@ -74,10 +77,15 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("iacc2", S390_FEAT_TYPE_STFL, 52, "Interlocked-access facility 2"),
>      FEAT_INIT("stfle53", S390_FEAT_TYPE_STFL, 53, "Various facilities introduced with z13"),
>      FEAT_INIT("eec", S390_FEAT_TYPE_STFL, 54, "Entropy encoding compression facility"),
> +    FEAT_INIT("stfle55", S390_FEAT_TYPE_STFL, 55, "Facility that is provided by STFLE facility 55"),
> +    FEAT_INIT("stfle56", S390_FEAT_TYPE_STFL, 56, "Facility that is provided by STFLE facility 56"),
>      FEAT_INIT("msa5-base", S390_FEAT_TYPE_STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)"),
>      FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruction-extensions facility 2"),
>      FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
>      FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
> +    FEAT_INIT("stfle61", S390_FEAT_TYPE_STFL, 61, "Facility that is provided by STFLE facility 61"),
> +    FEAT_INIT("stfle62", S390_FEAT_TYPE_STFL, 62, "Facility that is provided by STFLE facility 62"),
> +    FEAT_INIT("stfle63", S390_FEAT_TYPE_STFL, 63, "Facility that is provided by STFLE facility 63"),
>      FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
>      FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
>      FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
> @@ -89,7 +97,53 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
> +    FEAT_INIT("stfle81", S390_FEAT_TYPE_STFL, 81, "Facility that is provided by STFLE facility 81"),
>      FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
> +    FEAT_INIT("stfle83", S390_FEAT_TYPE_STFL, 83, "Facility that is provided by STFLE facility 83"),
> +    FEAT_INIT("stfle84", S390_FEAT_TYPE_STFL, 84, "Facility that is provided by STFLE facility 84"),
> +    FEAT_INIT("stfle85", S390_FEAT_TYPE_STFL, 85, "Facility that is provided by STFLE facility 85"),
> +    FEAT_INIT("stfle86", S390_FEAT_TYPE_STFL, 86, "Facility that is provided by STFLE facility 86"),
> +    FEAT_INIT("stfle87", S390_FEAT_TYPE_STFL, 87, "Facility that is provided by STFLE facility 87"),
> +    FEAT_INIT("stfle88", S390_FEAT_TYPE_STFL, 88, "Facility that is provided by STFLE facility 88"),
> +    FEAT_INIT("stfle89", S390_FEAT_TYPE_STFL, 89, "Facility that is provided by STFLE facility 89"),
> +    FEAT_INIT("stfle90", S390_FEAT_TYPE_STFL, 90, "Facility that is provided by STFLE facility 90"),
> +    FEAT_INIT("stfle91", S390_FEAT_TYPE_STFL, 91, "Facility that is provided by STFLE facility 91"),
> +    FEAT_INIT("stfle92", S390_FEAT_TYPE_STFL, 92, "Facility that is provided by STFLE facility 92"),
> +    FEAT_INIT("stfle93", S390_FEAT_TYPE_STFL, 93, "Facility that is provided by STFLE facility 93"),
> +    FEAT_INIT("stfle94", S390_FEAT_TYPE_STFL, 94, "Facility that is provided by STFLE facility 94"),
> +    FEAT_INIT("stfle95", S390_FEAT_TYPE_STFL, 95, "Facility that is provided by STFLE facility 95"),
> +    FEAT_INIT("stfle96", S390_FEAT_TYPE_STFL, 96, "Facility that is provided by STFLE facility 96"),
> +    FEAT_INIT("stfle97", S390_FEAT_TYPE_STFL, 97, "Facility that is provided by STFLE facility 97"),
> +    FEAT_INIT("stfle98", S390_FEAT_TYPE_STFL, 98, "Facility that is provided by STFLE facility 98"),
> +    FEAT_INIT("stfle99", S390_FEAT_TYPE_STFL, 99, "Facility that is provided by STFLE facility 99"),
> +    FEAT_INIT("stfle100", S390_FEAT_TYPE_STFL, 100, "Facility that is provided by STFLE facility 100"),
> +    FEAT_INIT("stfle101", S390_FEAT_TYPE_STFL, 101, "Facility that is provided by STFLE facility 101"),
> +    FEAT_INIT("stfle102", S390_FEAT_TYPE_STFL, 102, "Facility that is provided by STFLE facility 102"),
> +    FEAT_INIT("stfle103", S390_FEAT_TYPE_STFL, 103, "Facility that is provided by STFLE facility 103"),
> +    FEAT_INIT("stfle104", S390_FEAT_TYPE_STFL, 104, "Facility that is provided by STFLE facility 104"),
> +    FEAT_INIT("stfle105", S390_FEAT_TYPE_STFL, 105, "Facility that is provided by STFLE facility 105"),
> +    FEAT_INIT("stfle106", S390_FEAT_TYPE_STFL, 106, "Facility that is provided by STFLE facility 106"),
> +    FEAT_INIT("stfle107", S390_FEAT_TYPE_STFL, 107, "Facility that is provided by STFLE facility 107"),
> +    FEAT_INIT("stfle108", S390_FEAT_TYPE_STFL, 108, "Facility that is provided by STFLE facility 108"),
> +    FEAT_INIT("stfle109", S390_FEAT_TYPE_STFL, 109, "Facility that is provided by STFLE facility 109"),
> +    FEAT_INIT("stfle110", S390_FEAT_TYPE_STFL, 110, "Facility that is provided by STFLE facility 110"),
> +    FEAT_INIT("stfle111", S390_FEAT_TYPE_STFL, 111, "Facility that is provided by STFLE facility 111"),
> +    FEAT_INIT("stfle112", S390_FEAT_TYPE_STFL, 112, "Facility that is provided by STFLE facility 112"),
> +    FEAT_INIT("stfle113", S390_FEAT_TYPE_STFL, 113, "Facility that is provided by STFLE facility 113"),
> +    FEAT_INIT("stfle114", S390_FEAT_TYPE_STFL, 114, "Facility that is provided by STFLE facility 114"),
> +    FEAT_INIT("stfle115", S390_FEAT_TYPE_STFL, 115, "Facility that is provided by STFLE facility 115"),
> +    FEAT_INIT("stfle116", S390_FEAT_TYPE_STFL, 116, "Facility that is provided by STFLE facility 116"),
> +    FEAT_INIT("stfle117", S390_FEAT_TYPE_STFL, 117, "Facility that is provided by STFLE facility 117"),
> +    FEAT_INIT("stfle118", S390_FEAT_TYPE_STFL, 118, "Facility that is provided by STFLE facility 118"),
> +    FEAT_INIT("stfle119", S390_FEAT_TYPE_STFL, 119, "Facility that is provided by STFLE facility 119"),
> +    FEAT_INIT("stfle120", S390_FEAT_TYPE_STFL, 120, "Facility that is provided by STFLE facility 120"),
> +    FEAT_INIT("stfle121", S390_FEAT_TYPE_STFL, 121, "Facility that is provided by STFLE facility 121"),
> +    FEAT_INIT("stfle122", S390_FEAT_TYPE_STFL, 122, "Facility that is provided by STFLE facility 122"),
> +    FEAT_INIT("stfle123", S390_FEAT_TYPE_STFL, 123, "Facility that is provided by STFLE facility 123"),
> +    FEAT_INIT("stfle124", S390_FEAT_TYPE_STFL, 124, "Facility that is provided by STFLE facility 124"),
> +    FEAT_INIT("stfle125", S390_FEAT_TYPE_STFL, 125, "Facility that is provided by STFLE facility 125"),
> +    FEAT_INIT("stfle126", S390_FEAT_TYPE_STFL, 126, "Facility that is provided by STFLE facility 126"),
> +    FEAT_INIT("stfle127", S390_FEAT_TYPE_STFL, 127, "Facility that is provided by STFLE facility 127"),

The "stfle<n>" naming is probably the sanest thing to do here :/

>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
>      FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),
