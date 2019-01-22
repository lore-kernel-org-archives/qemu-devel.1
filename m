Received: from eggs.gnu.org ([209.51.188.92]:50695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1glmN2-00069p-0W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 22:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1glmGn-00046O-BV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 21:58:38 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1glmGF-0003pS-Nb
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 21:58:28 -0500
Received: by mail-pg1-x543.google.com with SMTP id g189so10330451pgc.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 18:57:57 -0800 (PST)
References: <20190116030815.27273-1-peterx@redhat.com>
	<154805952549.5550.9154893774048296420@2d3111e9616b>
	<20190121093505.GA7669@xz-x1>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2af1bd83-feca-5130-5375-45e7184aa802@ozlabs.ru>
Date: Tue, 22 Jan 2019 13:57:50 +1100
MIME-Version: 1.0
In-Reply-To: <20190121093505.GA7669@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] intel_iommu: misc fixes for error
 exposed after error_report_once()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, mst@redhat.com, jasowang@redhat.com, eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com



On 21/01/2019 20:35, Peter Xu wrote:
> On Mon, Jan 21, 2019 at 12:32:07AM -0800, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190116030815.27273-1-peterx@redhat.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-mingw@fedora build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> time make docker-test-mingw@fedora SHOW_ENV=1 J=14
>> === TEST SCRIPT END ===
>>
>>   CC      hw/block/pflash_cfi01.o
>> In function 'acpi_table_install',
>>     inlined from 'acpi_table_add' at /tmp/qemu-test/src/hw/acpi/core.c:296:5:
>> /tmp/qemu-test/src/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals destination size [-Werror=stringop-truncation]
>>          strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /tmp/qemu-test/src/hw/acpi/core.c:203:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>>          strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /tmp/qemu-test/src/hw/acpi/core.c:207:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>>          strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  sizeof ext_hdr->oem_table_id);
>>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /tmp/qemu-test/src/hw/acpi/core.c:216:9: error: 'strncpy' specified bound 4 equals destination size [-Werror=stringop-truncation]
>>          strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  sizeof ext_hdr->asl_compiler_id);
>> ---
>> make: *** [/tmp/qemu-test/src/rules.mak:69: hw/acpi/core.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
>> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/tmp/qemu-test/src/rules.mak:69: block/sheepdog.o] Error 1
>> /tmp/qemu-test/src/hw/acpi/aml-build.c: In function 'build_header':
>> /tmp/qemu-test/src/hw/acpi/aml-build.c:1535:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>>          strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /tmp/qemu-test/src/hw/acpi/aml-build.c:1541:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>>          strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_table_id));
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
> 
> I'm uncertain about these errors but it seems to be more likely to be
> caused by some configuration or compiler change instead of the series
> itself since this series never changed either acpi or sheepdog code.
> So I'll temporarily ignore them...


I am getting these too and I do not touch the mentioned files and
folders ever.



-- 
Alexey
