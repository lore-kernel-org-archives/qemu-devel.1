Received: from eggs.gnu.org ([209.51.188.92]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjhoN-00059q-LF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjhny-0000OW-OY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjhny-0000Fp-2g
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:48:14 -0500
Date: Wed, 16 Jan 2019 10:48:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190116104804.2077439b@redhat.com>
In-Reply-To: <8bbf34cf-3e6b-5204-dd78-f8d17ce2e337@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-2-git-send-email-imammedo@redhat.com>
	<8bbf34cf-3e6b-5204-dd78-f8d17ce2e337@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] tests: acpi: add
 uefi_find_rsdp_addr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Tue, 15 Jan 2019 21:06:16 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> Hi Igor,
> 
> On 01/15/19 16:40, Igor Mammedov wrote:
> > introduce UEFI specific counterpart to acpi_find_rsdp_address()
> > that will help to find RSDP address when [OA]VMF is used as
> > firmware. It requires a [OA]VMF built with PcdAcpiTestSupport=TRUE,
> > to locate RSDP address within 1Mb aligned ACPI test structure, tagged
> > with GUID AB87A6B1-2034-BDA0-71BD-375007757785
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/acpi-utils.h |  1 +
> >  tests/acpi-utils.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)  
> 
> I'm not promising to review all of this patch set (Phil, feel free to
> chime in); I'll just make some quick comments below:
> 
> > diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> > index ef388bb..3b11f47 100644
> > --- a/tests/acpi-utils.h
> > +++ b/tests/acpi-utils.h
> > @@ -46,6 +46,7 @@ typedef struct {
> >  
> >  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> >  uint32_t acpi_find_rsdp_address(QTestState *qts);
> > +uint64_t uefi_find_rsdp_addr(QTestState *qts, uint64_t start, uint64_t size);  
> 
> I think it would make sense to keep the "acpi_find_rsdp_address" prefix
> for the new function name; maybe append "_uefi"? Because now "acpi" is
> replaced with "uefi , plus "address" is truncated to "addr"; those don't
> seem overly logical.
> 
> Anyway, up to you.
> 
> >  uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> >  void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> >  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
> > diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> > index cc33b46..b9ff9df 100644
> > --- a/tests/acpi-utils.c
> > +++ b/tests/acpi-utils.c
> > @@ -111,3 +111,46 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
> >          g_assert(!acpi_calc_checksum(*aml, *aml_len));
> >      }
> >  }
> > +
> > +#define GUID_SIZE 16
> > +static uint8_t AcpiTestSupportGuid[GUID_SIZE] =
> > +     { 0xb1, 0xa6, 0x87, 0xab,
> > +       0x34, 0x20,
> > +       0xa0, 0xbd,
> > +       0x71, 0xbd, 0x37, 0x50, 0x07, 0x75, 0x77, 0x85 };  
> 
> I think this is generally good. QEMU has some utilities/helpers for
> working with UUIDs; however, for the test infrastructure, I think this
> should be good enough.
> 
> Suggestion: make the GUID "const" as well.
> 
> > +
> > +typedef struct {
> > +    uint8_t signature_guid[16];  
> 
> s/16/GUID_SIZE/?
> 
> > +    uint64_t rsdp10;
> > +    uint64_t rsdp20;
> > +} __attribute__((packed)) UefiTestSupport;
> > +
> > +/* Wait at most 600 seconds (test is slow with TCI and --enable-debug) */  
> 
> Do you specifically mean "Tiny Code Interpreter" here?
it's typo, I've meant TCG. I'll fix it.

> > +#define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
> > +#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
> > +#define MB 0x100000ULL
> > +uint64_t uefi_find_rsdp_addr(QTestState *qts, uint64_t start, uint64_t size)
> > +{
> > +    int i, j;
> > +    uint8_t data[GUID_SIZE];
> > +
> > +    for (i = 0; i < TEST_CYCLES; ++i) {
> > +        for (j = 0; j < size / MB; j++) {
> > +            /* look for GUID at every 1Mb block */
> > +            uint64_t addr = start + j * MB;
> > +
> > +            qtest_memread(qts, addr, data, sizeof(data));
> > +            if (!memcmp(AcpiTestSupportGuid, data, sizeof(data))) {
> > +                UefiTestSupport ret;
> > +
> > +                qtest_memread(qts, addr, &ret, sizeof(ret));
> > +                ret.rsdp10 = le64_to_cpu(ret.rsdp10);
> > +                ret.rsdp20 = le64_to_cpu(ret.rsdp20);
> > +                return ret.rsdp20 ? ret.rsdp20 : ret.rsdp10;
> > +            }
> > +        }
> > +        g_usleep(TEST_DELAY);
> > +    }
> > +    g_assert_not_reached();
> > +    return 0;
> > +}
> >   
> 
> Apart from my hair-splitting, it looks good. If you update
> 16-->GUID_SIZE, then you can add
Thanks,
I'll apply all of your suggestions for v2 respin

> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks,
> Laszlo
> 
