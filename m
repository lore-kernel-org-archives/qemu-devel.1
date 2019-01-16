Received: from eggs.gnu.org ([209.51.188.92]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjiV9-0008Dh-3B
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjiV7-0007iz-5A
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjiV6-0007XO-Pv
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:49 -0500
Date: Wed, 16 Jan 2019 11:32:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190116113227.47ebdea2@redhat.com>
In-Reply-To: <15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On Tue, 15 Jan 2019 21:31:54 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/15/19 16:41, Igor Mammedov wrote:
> > once FW provides a pointer to SMBIOS entry point like it does for
> > RSDP it should be possible to enable this one the same way.  
> 
> Good point, I didn't think of SMBIOS.
> 
> We have the following options:
> 
> (1) Use just one "test support" structure, and add more fields (such as
> the SMBIOS entry point) to it, beyond the RSDP1.0/RSDP2.0. For this, we
> should also introduce a "size" field to the table, so we don't have to
> extend the table between firmware and QEMU in lock-step.
> 
> (2) Use a different table (with a different GUID) for exposing the
> SMBIOS entry point.
> 
> On the firmware side, (1) would be more work now, but it would keep
> things simpler (and better separated) in the future. (2) would be more
> lazy ^W convenient now, but it would introduce more churn / possibly
> some code duplication in the future.
> 
> In QEMU, which one would you prefer?
I'd prefer #1 to minimize # of memory scans.
However with size (i.e. implicit versioning) and who know what else in
the future complexity grows up and dependency this approach causes
between firmware and QEMU (I dislike special build instead of reusing
shipped images).

So I've dug a little bit into the history why we've chosen including
structure into the firmware itself instead of writing EFI application
as part of QEMU that would provide the same test structure but won't
require special firmware build.
If I sum it up, it was issue with distros are shipping (if they do it at all)
only a version that matches distro's architecture and a need for cross
compiling EFI test app.

Could we revisit EFI app approach (I'd prefer it over firwmare hack if it's
possible)? We can try to avoid dependency on gnu-efi and cross compiling on
regular builds and ship along with efi app source code several prebuild app
binaries (boot disk images), that one would rebuild only when efi app
is changed, and it could be done manually (the same like special fw build
but contained withing QEMU). As for gnu-efi, is it possible to use striped
down gnu-efi stubs to drop external library dependency, something along of
lines https://github.com/tqh/efi-example ?


> Thanks,
> Laszlo
> 
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/bios-tables-test.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index d9efe59..a64d0c2 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -562,8 +562,11 @@ static void test_acpi_one(const char *params, test_data *data)
> >          }
> >      }
> >  
> > -    test_smbios_entry_point(data);
> > -    test_smbios_structs(data);
> > +    /* TODO: make SMBIOS tests work with UEFI firmware */
> > +    if (!use_uefi) {
> > +        test_smbios_entry_point(data);
> > +        test_smbios_structs(data);
> > +    }
> >  
> >      assert(!global_qtest);
> >      qtest_quit(data->qts);
> >   
> 
> 
