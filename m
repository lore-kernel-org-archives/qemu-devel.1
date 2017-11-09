Received: from eggs.gnu.org ([2001:4830:134:3::10]:57038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eCm3i-0003Ne-AS
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eCm3b-00064D-U5
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:35:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41182
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eCm3b-00063r-Nr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:35:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA9CXrMX105765
	for <qemu-devel@nongnu.org>; Thu, 9 Nov 2017 07:35:38 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e4p94txk9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 07:35:38 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 9 Nov 2017 05:35:37 -0700
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
	<20171031204330.14803-4-danielhb@linux.vnet.ibm.com>
	<3d61a96b-7dc1-81fb-f42b-ee542ce713fa@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 9 Nov 2017 10:35:30 -0200
MIME-Version: 1.0
In-Reply-To: <3d61a96b-7dc1-81fb-f42b-ee542ce713fa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d90479e2-0d31-04d1-7b79-79778dd2a186@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/4] tests: ibm,
 configure-connector RTAS call implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au



On 11/06/2017 03:46 PM, Laurent Vivier wrote:
> On 31/10/2017 21:43, Daniel Henrique Barboza wrote:
>> 'ibm,configure-connector' hypercall is used by the guest OS
>> to start the configuration of a given device, where the
>> machine configures the said device and all its sub-devices,
>> giving back FDTs to the caller for each sub-device.
>>
>> This hypercall is supposed to be called multiple times by the
>> guest OS until it returns RTAS_OUT_SUCESS (code 0), indicating
>> that the device is now properly configured and ready
>> to be used, or a return value < 0 when an error occurs.
>>
>> This patch implements the 'ibm,configure-connector' RTAS
>> hypercall in tests/libqos/rtas.c, with an extra test
>> case for it inside tests/rtas-tests.c.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   tests/libqos/rtas.c | 35 +++++++++++++++++++++++++++
>>   tests/libqos/rtas.h |  1 +
>>   tests/rtas-test.c   | 68 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   3 files changed, 104 insertions(+)
>>
>> diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
>> index ade572a84f..1cb9e2b495 100644
>> --- a/tests/libqos/rtas.c
>> +++ b/tests/libqos/rtas.c
>> @@ -184,3 +184,38 @@ int qrtas_set_indicator(QGuestAllocator *alloc, u=
int32_t type, uint32_t idx,
>>  =20
>>       return ret[0];
>>   }
>> +
>> +/*
>> + * ibm,configure-connector as defined by PAPR 2.7+, 13.5.3.5
>> + *
>> + * nargs =3D 2
>> + * nrets =3D 1
>> + *
>> + * args[0] and args[1] compose the 64 bit Work Area address.
>> + *
>> + * This call will configure not only the device reported in the first
>> + * offset of the Work Area but all of its siblingis as well, returnin=
g
>> + * the FDT of each configured sub-device as well as a return code
>> + * 'Next child', 'Next property' or 'Previous parent'. When the whole
>> + * configuration is done, 'Configuration completed' (0) is returned.
>> + *
>> + * configure-connector will always reply with status code 'Next child=
'(2)
>> + * on the first successful call. The DRC configuration will be
>> + * completed when configure-connector returns status 0. Any return
>> + * status < 0 indicates an error.
>> + */
>> +int qrtas_ibm_configure_connector(QGuestAllocator *alloc, uintptr_t w=
a_addr)
>> +{
>> +    uint32_t args[2], ret[1];
>> +    int res;
>> +
>> +    args[0] =3D (uint32_t)(wa_addr);
>> +    args[1] =3D (uint32_t)(wa_addr >> 32);
> This part looks strange to me. I agree it's what qemu does, but
> according to spec args[0] is "Address of work area" and args[1] "0 or
> address of additional page":
>
> Linux on Power Architecture Platform Reference
> Version 1.1
> 24 March 2016
>
> 13.5.3.5 ibm,configure-connector RTAS Call
> The =E2=80=9Cneed more memory=E2=80=9D status code, is similar in seman=
tics to the =E2=80=9Ccall
> again=E2=80=9D status. However, on the next ibm,configure-connector cal=
l, the OS
> will supply, via the Memory extent parameter, the address of another
> page of memory for RTAS to add to the work area in order for
> configuration to continue. On all other calls to ibm,configure-connecto=
r
> the contents of the Memory extent parameter should be 0.

Hmmmmm thinking about it, the reason why it works in QEMU is because
wa_addr >> 32 will always be zero, perhaps?

At any rate, In this test, makes sense to leave args[1] to be set by the=20
caller,
setting it to 0 in the non "need more memory" scenario.


>
>> +    res =3D qrtas_call(alloc, "ibm,configure-connector", 2, args, 1, =
ret);
>> +    if (res !=3D 0) {
>> +        return -1;
>> +    }
>> +
>> +    return ret[0];
>> +}
>> diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
>> index 9dfa18f32b..35c44fb967 100644
>> --- a/tests/libqos/rtas.h
>> +++ b/tests/libqos/rtas.h
>> @@ -16,4 +16,5 @@ int qrtas_check_exception(QGuestAllocator *alloc, ui=
nt32_t mask,
>>                             uint32_t buf_addr, uint32_t buf_len);
>>   int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint3=
2_t idx,
>>                           uint32_t new_state);
>> +int qrtas_ibm_configure_connector(QGuestAllocator *alloc, uintptr_t w=
a_addr);
>>   #endif /* LIBQOS_RTAS_H */
>> diff --git a/tests/rtas-test.c b/tests/rtas-test.c
>> index 2c34b6e83c..b3538bf878 100644
>> --- a/tests/rtas-test.c
>> +++ b/tests/rtas-test.c
>> @@ -15,6 +15,8 @@
>>   #define SPAPR_DR_ALLOCATION_STATE_USABLE  1
>>   #define SPAPR_DR_ISOLATION_STATE_UNISOLATED 1
>>  =20
>> +#define CC_WA_LEN 4096
>> +
>>   static void test_rtas_get_time_of_day(void)
>>   {
>>       QOSState *qs;
>> @@ -169,6 +171,70 @@ static void test_rtas_set_indicator(void)
>>       qtest_shutdown(qs);
>>   }
>>  =20
>> +static void test_rtas_ibm_configure_connector(void)
>> +{
>> +    QOSState *qs;
>> +    uint64_t ret;
>> +    uintptr_t guest_buf_addr, guest_drc_addr;
>> +    uint32_t drc_index;
>> +    uint8_t *buf =3D g_malloc0(EVENT_LOG_LEN);
>> +
>> +    qs =3D qtest_spapr_boot("-machine pseries -cpu POWER8_v2.0 "
>> +                          "-smp 1,sockets=3D4,cores=3D1,threads=3D1,m=
axcpus=3D4");
>> +
>> +    guest_buf_addr =3D guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(=
uint8_t));
>> +    qtest_qmp_device_add("power8_v2.0-spapr-cpu-core", "id-1",
>> +                         "'core-id':'1'");
>> +
>> +    ret =3D qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW,
>> +                                guest_buf_addr, EVENT_LOG_LEN);
>> +
>> +    memread(guest_buf_addr, buf, EVENT_LOG_LEN);
>> +    guest_free(qs->alloc, guest_buf_addr);
>> +
>> +    g_assert_cmpint(ret, =3D=3D, 0);
>> +
>> +    /*
>> +     * Same 108 bytes offset magic used and explained in
>> +     * test_rtas_set_indicator.
>> +     */
>> +    drc_index =3D be32toh(*((uint32_t *)(buf + 108)));
>> +    g_free(buf);
>> +
>> +    ret =3D qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ALLOCATIO=
N_STATE,
>> +                              drc_index, SPAPR_DR_ALLOCATION_STATE_US=
ABLE);
>> +    g_assert_cmpint(ret, =3D=3D, 0);
>> +
>> +    ret =3D qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ISOLATION=
_STATE,
>> +                              drc_index, SPAPR_DR_ISOLATION_STATE_UNI=
SOLATED);
>> +    g_assert_cmpint(ret, =3D=3D, 0);
>> +
>> +    /*
>> +     * Call ibm,configure-connector to finish the hotplugged device
>> +     * configuration, putting its DRC into 'ready' state.
>> +     *
>> +     * We're not interested in the generated FDTs during the config
>> +     * process, thus we simply keep calling configure-connector
>> +     * until it returns SUCCESS(0) or an error.
>> +     *
>> +     * The full explanation logic behind this process can be found
>> +     * at PAPR 2.7+, 13.5.3.5.
>> +     */
>> +    guest_drc_addr =3D guest_alloc(qs->alloc, CC_WA_LEN * sizeof(uint=
32_t));
> CC_WA_LEN is already 4096, why "* sizeof(uint32_t"?
> It must be aligned to a 4096 bytes boundaries.

Good catch. I'll fix it.

>
>> +    writel(guest_drc_addr, drc_index);
>> +    writel(guest_drc_addr + sizeof(uint32_t), 0)> +
>> +    do {
>> +        ret =3D qrtas_ibm_configure_connector(qs->alloc, guest_drc_ad=
dr);
>> +    } while (ret > 0);
> I think it would be interesting to check the result of the call (return
> value, node name, property name,...)
>
> And you should also exit with error in the case of ret =3D=3D 5 (need m=
ore
> memory).
>
>> +    guest_free(qs->alloc, guest_drc_addr);
>> +
>> +    g_assert_cmpint(ret, =3D=3D, 0);
>> +
>> +    qtest_shutdown(qs);
>> +}
>> +
>>   int main(int argc, char *argv[])
>>   {
>>       const char *arch =3D qtest_get_arch();
>> @@ -185,6 +251,8 @@ int main(int argc, char *argv[])
>>       qtest_add_func("rtas/rtas-check-exception-hotplug-event",
>>                      test_rtas_check_exception_hotplug_event);
>>       qtest_add_func("rtas/test_rtas_set_indicator", test_rtas_set_ind=
icator);
>> +    qtest_add_func("rtas/test_rtas_ibm_configure_connector",
>> +                   test_rtas_ibm_configure_connector);
>>  =20
>>       return g_test_run();
>>   }
>>
> Thanks,
> Laurent
>
