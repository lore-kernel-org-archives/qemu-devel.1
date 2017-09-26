Received: from eggs.gnu.org ([2001:4830:134:3::10]:41988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhAq-0007Gz-KS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhAp-0002mD-M9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:08:44 -0400
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<5ad72536402da2879d49b58753cc709a8ff22de9.1506384415.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <adae1793-1a4a-7107-7676-f6dbaa26a9f4@redhat.com>
Date: Tue, 26 Sep 2017 06:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <5ad72536402da2879d49b58753cc709a8ff22de9.1506384415.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, alistair23@gmail.com, Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 26.09.2017 02:09, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> @@ -9281,18 +9281,19 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>          case POWERPC_FLAG_PMM:
>              break;
>          default:
> -            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> -                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n");
> +            error_report("PowerPC MSR definition inconsistency");
> +            error_printf("Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM");
>              exit(1);
>          }
>      } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
> -        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> -                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n");
> +        error_report("PowerPC MSR definition inconsistency");
> +        error_printf("Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM");
>          exit(1);
>      }
>      if ((env->flags & (POWERPC_FLAG_RTC_CLK | POWERPC_FLAG_BUS_CLK)) == 0) {
> -        fprintf(stderr, "PowerPC flags inconsistency\n"
> -                "Should define the time-base and decrementer clock source\n");
> +        error_report("PowerPC MSR definition inconsistency");
> +        error_printf("Should define the time-base and decrementer clock"
> +                     " source");
>          exit(1);
>      }

Replacing fprintf with error_report+error_printf is kind of very ugly.
While error_report adds newline to the output, error_printf does not (as
far as I can see) ... did you check how such a message looks like when
it is generated during runtime?
Also, the strings belong together, so printing them with two function
calls sound wrong to me... maybe they should be joined without newline
in the middle instead?

 Thomas
