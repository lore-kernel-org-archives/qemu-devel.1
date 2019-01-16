Received: from eggs.gnu.org ([209.51.188.92]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gji2H-0000yy-2Z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gji2F-0007Vj-MJ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:03:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gji2F-0007Q5-1O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:02:59 -0500
Date: Wed, 16 Jan 2019 11:02:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190116110249.7c194dfc@redhat.com>
In-Reply-To: <21a83c4e-056b-f749-1b66-abaa5fe51e32@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-9-git-send-email-imammedo@redhat.com>
	<21a83c4e-056b-f749-1b66-abaa5fe51e32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/14] tests: acpi: introduce an abilty
 start tests with UEFI firmware
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

On Tue, 15 Jan 2019 21:18:18 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/15/19 16:41, Igor Mammedov wrote:
> > For testcase to use UEFI firmware, one needs to provide and specify
> > firmware and varstore blobs names in test_data { uefi_fl1, uefi_fl2) }
> > fields respectively.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/bios-tables-test.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 8887319..d290dd2 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -26,6 +26,8 @@
> >  typedef struct {
> >      const char *machine;
> >      const char *variant;
> > +    const char *uefi_fl1;
> > +    const char *uefi_fl2;
> >      uint64_t rsdp_addr;
> >      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
> >      GArray *tables;
> > @@ -519,21 +521,35 @@ static void test_smbios_structs(test_data *data)
> >  static void test_acpi_one(const char *params, test_data *data)
> >  {
> >      char *args;
> > -
> > -    /* Disable kernel irqchip to be able to override apic irq0. */
> > -    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> > -                           "-net none -display none %s "
> > -                           "-drive id=hd0,if=none,file=%s,format=raw "
> > -                           "-device ide-hd,drive=hd0 ",
> > -                           data->machine, "kvm:tcg",
> > -                           params ? params : "", disk);
> > +    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
> > +
> > +    if (use_uefi) {
> > +        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
> > +            "-drive if=pflash,format=raw,file=%s/%s,readonly "
> > +            "-drive if=pflash,format=raw,file=%s/%s,snapshot=on %s",  
> 
> Today I Learned: about "snapshot=on". Thanks :) The command line looks good.
This way one doesn't have to make images in C (which is messy), keep track of
temporary images and clean up (which isn't reliable when test crashes).
Makefile magic can to all of that and in a much cleaner way.

> > +            data->machine, "kvm:tcg", data_dir, data->uefi_fl1, data_dir,  
> 
> You could open-code "kvm:tcg" in the format string at once (unless you
> turn that into a parameter in a later patch in the series). But, I see
> the pre-patch code passes "kvm:tcg" as an argument too.
That was my line of reasoning as well, so I've kept it for consistence
with original code. If someone would insist I can throw in a separate
patch to open-code it before this one.

> > +            data->uefi_fl2, params ? params : "");
> > +
> > +    } else {
> > +        /* Disable kernel irqchip to be able to override apic irq0. */
> > +        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> > +            "-net none -display none %s "
> > +            "-drive id=hd0,if=none,file=%s,format=raw "
> > +            "-device ide-hd,drive=hd0 ",
> > +             data->machine, "kvm:tcg", params ? params : "", disk);
> > +    }
> >  
> >      data->qts = qtest_init(args);
> >  
> > -    boot_sector_test(data->qts);
> > +    if (use_uefi) {
> > +        data->rsdp_addr = uefi_find_rsdp_addr(data->qts,
> > +            0x40000000ULL, 128ULL * 1024 * 1024);  
> 
> I think open-coding the DRAM size is valid; after all, it depends on the
> QEMU command line, and you control the QEMU command line above. However,
> do we really want to open-code the DRAM base here? That's
> board-specific. Should we pass that too through the "test_data" structure?
I've missed this one. In addition to your suggestion, RAM size is also
a good candidate for "test_data" structure.

> 
> > +    } else {
> > +        boot_sector_test(data->qts);
> > +        test_acpi_rsdp_address(data);
> > +    }
> >  
> >      data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> > -    test_acpi_rsdp_address(data);
> >      test_acpi_rsdp_table(data);
> >      test_acpi_rxsdt_table(data);
> >      test_acpi_fadt_table(data);
> >   
> 
> Thanks,
> Laszlo
