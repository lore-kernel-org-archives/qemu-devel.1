Received: from eggs.gnu.org ([2001:4830:134:3::10]:51058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eb64z-0006Vp-87
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eb64v-0002KJ-B6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:49:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53400
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eb64v-0002JN-5f
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:49:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FEibHH124592
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:49:35 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgupdqy80-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:49:35 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:49:34 -0500
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 09:49:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b38364c9-6ffd-e065-8867-43566f48545a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tpm: Implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, kevin@koconnor.net, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/2018 09:55 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Jan 10, 2018 at 7:35 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>
>>   }
>>
>>   static void tpm_tis_class_init(ObjectClass *klass, void *data)
>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> index 6d516c6..d9b7452 100644
>> --- a/include/hw/acpi/tpm.h
>> +++ b/include/hw/acpi/tpm.h
>> @@ -31,4 +31,10 @@
>>
>>   #define TPM2_START_METHOD_MMIO      6
>>
>> +/*
>> + * Physical Presence Interface
>> + */
>> +#define TPM_PPI_ADDR_SIZE           0x100
>> +#define TPM_PPI_ADDR_BASE           0xffff0000

I tried to extend the memory size to be able to store per opcode flags=20
into this area to de-couple the ACPI code from the firmware code as far=20
as possible. I ended up seeing crashes. The following comment is in SeaBI=
OS:

./src/fw/shadow.c:// On the emulators, the bios at 0xf0000 is also at=20
0xffff0000

Following this, I am moving this base address to 0xfffe_f000 and=20
extending it to 0x400 bytes. Besides that there will be a QEMU ACPI=20
table with OEM 'QEMU' and oem_table_id 'CONF' for which the firmware has=20
to look for. It holds the base address and the TPM version.

    Stefan
