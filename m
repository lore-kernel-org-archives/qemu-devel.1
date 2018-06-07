Received: from eggs.gnu.org ([2001:4830:134:3::10]:33438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR42C-00089P-Ho
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR428-0004ms-Ip
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:09:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fR428-0004mH-EQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:09:32 -0400
Date: Fri, 8 Jun 2018 02:09:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608020724-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607223111.27792-2-ross.zwisler@linux.intel.com>
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Jun 07, 2018 at 04:31:08PM -0600, Ross Zwisler wrote:
> Currently if "make check" detects a mismatch in the ASL generated during
> testing, we print an error such as:
> 
>   acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
>   aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
>   aml:tests/acpi-test-data/q35/SSDT.dimmpxm].
> 
> but the testing still exits with good shell status.  This is wrong, and
> makes bisecting such a failure difficult.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Failing would also mean that any change must update the expected files
at the same time.  And that in turn is problematic because expected
files are binary and can't be merged.

In other words the way we devel ACPI right now means that bisect will
periodically produce a diff, it's not an error.


> ---
>  tests/bios-tables-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 256d463cb8..9b5db1ee8f 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -469,6 +469,7 @@ static void test_acpi_asl(test_data *data)
>                      }
>                  }
>            }
> +          g_test_fail();
>          }
>          g_string_free(asl, true);
>          g_string_free(exp_asl, true);
> -- 
> 2.14.4
