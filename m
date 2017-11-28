Received: from eggs.gnu.org ([2001:4830:134:3::10]:40129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJiLi-0001Pu-Lo
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJiLh-00065d-Qa
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:03:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJiLh-00065T-LL
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:03:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASFxgFB029653
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:02:59 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ehasbgv93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:02:57 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 11:02:56 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
	<e36ef8c1-3122-9416-8f86-442387a46b6d@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 11:02:53 -0500
MIME-Version: 1.0
In-Reply-To: <e36ef8c1-3122-9416-8f86-442387a46b6d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <232a7a16-af09-d02d-f2b3-d152bb81b2dd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 11/28/2017 06:45 AM, Thomas Huth wrote:
> On 27.11.2017 21:55, Collin L. Walling wrote:
>> [...]
>>  =20
>> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_enabled,
>> +                                   uint16_t *boot_menu_timeout)
>> +{
>> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
>> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
>> +    const char *p;
>> +    long result =3D 0;
>> +
>> +    *boot_menu_enabled =3D qemu_opt_get_bool(opts, "menu", false);
>> +
>> +    if (*boot_menu_enabled) {
>> +        p =3D qemu_opt_get(opts, "splash-time");
>> +        qemu_strtol(p, NULL, 10, &result);
> It's maybe better to check the return code of qemu_strtol to see whethe=
r
> the option contained a valid number? An additional check for negative
> numbers would also be fine, I think.

Agreed.=C2=A0 I'll add some integer overflow checking as well.

>
>> [...]
>>  =20
>>   struct IplBlockCcw {
>>       uint64_t netboot_start_addr;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint8_t  boot_menu_enabled;
>> +    uint16_t boot_menu_timeout;
> Could you please try to keep the fields aligned to their natural
> alignment? I.e. swap the two new entries, so that timeout comes before
> enabled?

Can do.

>
>>       uint8_t  ssid;
>>       uint16_t devno;
>>       uint8_t  vm_flags;
>> @@ -51,7 +53,9 @@ struct IplBlockQemuScsi {
>>       uint32_t lun;
>>       uint16_t target;
>>       uint16_t channel;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint8_t  boot_menu_enabled;
>> +    uint16_t boot_menu_timeout;
> dito
>
>>       uint8_t  ssid;
>>       uint16_t devno;
>>   } QEMU_PACKED;
>   Thomas
>
>
>

--=20
- Collin L Walling
