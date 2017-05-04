Received: from eggs.gnu.org ([2001:4830:134:3::10]:53990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d6DoU-0005T8-Fj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d6DoQ-0004v9-D3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1d6DoQ-0004um-3Y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:16:42 -0400
Date: Thu, 4 May 2017 12:16:38 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170504101638.coz6n5vc2d33bess@eukaryote>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502203115.22233-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 02, 2017 at 05:31:15PM -0300, Eduardo Habkost wrote:

Hi,

Yet to try this series, a small question in-line.

> Introduce a new CPUFeatureSetting QAPI data type, and use it to support
> feature=force on -cpu.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi-schema.json              | 32 +++++++++++++++++++++++++
>  target/i386/cpu.h             |  2 ++
>  target/i386/cpu.c             | 55 +++++++++++++++++++++++++++++++++----------
>  tests/test-x86-cpuid-compat.c | 14 ++++++++++-
>  4 files changed, 90 insertions(+), 13 deletions(-)

[...]

> --- a/tests/test-x86-cpuid-compat.c
> +++ b/tests/test-x86-cpuid-compat.c
> @@ -98,6 +98,8 @@ typedef struct FeatureTestArgs {
>      int bitnr;
>      /* The expected value for the bit in (X86CPUFeatureWordInfo.features) */
>      bool expected_value;
> +    /* Don't look at filtered-features when checking feature value */
> +    bool ignore_filtered_features;
>  } FeatureTestArgs;
>  
>  /* Get the value for a feature word in a X86CPUFeatureWordInfo list */
> @@ -129,7 +131,9 @@ static void test_feature_flag(const void *data)
>      present = qobject_to_qlist(qom_get(path, "feature-words"));
>      filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
>      value = get_feature_word(present, args->input_eax, args->input_ecx, args->reg);
> -    value |= get_feature_word(filtered, args->input_eax, args->input_ecx, args->reg);
> +    if (!args->ignore_filtered_features) {
> +        value |= get_feature_word(filtered, args->input_eax, args->input_ecx, args->reg);
> +    }
>      qtest_end();
>  
>      g_assert(!!(value & (1U << args->bitnr)) == args->expected_value);
> @@ -336,5 +340,13 @@ int main(int argc, char **argv)
>                       "-machine accel=kvm:tcg -cpu max,mmx=off",
>                       1, 0, "EDX", 23, false);
>  
> +    {
> +    FeatureTestArgs *a;
> +    a = add_feature_test("x86/cpuid/features/monitor-force",
> +                         "-machine accel=kvm:tcg -cpu 486,monitor=force",

Following your above test example, should the 'force' boolean also work
(understood: only for testing / debugging) as below, for a recognized
CPUID flag, taking the example of 'INVPCID'?

  $ qemu-system-x86_64 [...] -cpu Haswell-noTSX,invpcid=force [...]

> +                         1, 0, "ECX",  3, true);
> +    a->ignore_filtered_features = true;
> +    }
> +
>      return g_test_run();
>  }
> -- 
> 2.11.0.259.g40922b1
> 
> 

-- 
/kashyap
