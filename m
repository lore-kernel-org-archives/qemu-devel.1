Received: from eggs.gnu.org ([2001:4830:134:3::10]:47754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eClP8-0003pU-5W
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eClP4-0001E9-PT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:53:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eClP4-0001Dc-Fx
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:53:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA9Bprbj032678
	for <qemu-devel@nongnu.org>; Thu, 9 Nov 2017 06:53:48 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e4pb5rn9v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 06:53:47 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 9 Nov 2017 04:53:47 -0700
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
	<20171031204330.14803-3-danielhb@linux.vnet.ibm.com>
	<51f58725-912c-9f63-1205-74e3095210a8@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 9 Nov 2017 09:53:40 -0200
MIME-Version: 1.0
In-Reply-To: <51f58725-912c-9f63-1205-74e3095210a8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <76eeb94d-2050-2a8b-4756-ea479ec0c4cd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/4] tests: adding
 'set_indicator' RTAS call
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

Hi Laurent,

On 11/06/2017 02:54 PM, Laurent Vivier wrote:
> On 31/10/2017 21:43, Daniel Henrique Barboza wrote:
>> 'set_indicator' is a RTAS hypercall that is used to change
>> the state of both physical and logical devices DRCs by setting
>> allocation-state, isolation-state and dr-indicator.
>>
>> This patch implements the set_indicator RTAS call in
>> tests/libqos/rtas.c, adding its test in tests/rtas-test.c.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   tests/libqos/rtas.c | 33 ++++++++++++++++++++++++
>>   tests/libqos/rtas.h |  2 ++
>>   tests/rtas-test.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 108 insertions(+)
>>
>> diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
>> index fdeab448f7..ade572a84f 100644
>> --- a/tests/libqos/rtas.c
>> +++ b/tests/libqos/rtas.c
>> @@ -151,3 +151,36 @@ int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
>>   
>>       return ret[0];
>>   }
>> +
>> +/*
>> + * set_indicator as defined by PAPR 2.7+, 7.3.5.4
>> + *
>> + * nargs = 3
>> + * nrets = 1
>> + *
>> + * arg[0] = the type of the indicator
>> + * arg[1] = index of the specific indicator
>> + * arg[2] = desired new state
>> + *
>> + * Depending on the input, set_indicator will call set_isolation_state,
>> + * set_allocation_state or set_dr_indicator in hw/ppc/spapr_drc.c.
>> + * These functions allows the guest to control the state of hotplugged
>> + * and hot unplugged devices.
>> + */
>> +int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t idx,
>> +                        uint32_t new_state)
>> +{
>> +    uint32_t args[3], ret[1];
>> +    int res;
>> +
>> +    args[0] = type;
>> +    args[1] = idx;
>> +    args[2] = new_state;
>> +
>> +    res = qrtas_call(alloc, "set-indicator", 3, args, 1, ret);
>> +    if (res != 0) {
>> +        return -1;
>> +    }
>> +
>> +    return ret[0];
>> +}
>> diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
>> index 330ecfd397..9dfa18f32b 100644
>> --- a/tests/libqos/rtas.h
>> +++ b/tests/libqos/rtas.h
>> @@ -14,4 +14,6 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
>>                                  uint32_t addr, uint32_t size, uint32_t val);
>>   int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
>>                             uint32_t buf_addr, uint32_t buf_len);
>> +int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t idx,
>> +                        uint32_t new_state);
>>   #endif /* LIBQOS_RTAS_H */
>> diff --git a/tests/rtas-test.c b/tests/rtas-test.c
>> index c5a6080043..2c34b6e83c 100644
>> --- a/tests/rtas-test.c
>> +++ b/tests/rtas-test.c
>> @@ -8,6 +8,13 @@
>>   #define EVENT_MASK_EPOW (1 << 30)
>>   #define EVENT_LOG_LEN 2048
>>   
>> +#define RTAS_SENSOR_TYPE_ISOLATION_STATE 9001
>> +#define RTAS_SENSOR_TYPE_ALLOCATION_STATE 9003
>> +#define SPAPR_DR_ISOLATION_STATE_ISOLATED 0
>> +#define SPAPR_DR_ALLOCATION_STATE_UNUSABLE 0
>> +#define SPAPR_DR_ALLOCATION_STATE_USABLE  1
>> +#define SPAPR_DR_ISOLATION_STATE_UNISOLATED 1
>> +
>>   static void test_rtas_get_time_of_day(void)
>>   {
>>       QOSState *qs;
>> @@ -97,6 +104,71 @@ static void test_rtas_check_exception_hotplug_event(void)
>>       qtest_shutdown(qs);
>>   }
>>   
>> +/*
>> + * To test the 'set-indicator' RTAS call we will hotplug a device
>> + * (in this case a CPU) and then make its DRC state go from
>> + * the starting state UNUSABLE(1) to UNISOLATE(3). These DRC
>> + * states transitions are described in further detail in
>> + * PAPR 2.7+ 13.4.
>> + */
>> +static void test_rtas_set_indicator(void)
>> +{
>> +    QOSState *qs;
>> +    uint64_t ret;
>> +    uintptr_t guest_buf_addr;
>> +    uint32_t drc_index;
>> +    uint8_t *buf = g_malloc0(EVENT_LOG_LEN);
>> +
>> +    qs = qtest_spapr_boot("-machine pseries -cpu POWER8_v2.0 "
>> +                          "-smp 1,sockets=4,cores=1,threads=1,maxcpus=4");
>> +
>> +    guest_buf_addr = guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(uint8_t));
>> +    qtest_qmp_device_add("power8_v2.0-spapr-cpu-core", "id-1",
>> +                         "'core-id':'1'");
>> +
>> +    ret = qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW,
>> +                                guest_buf_addr, EVENT_LOG_LEN);
>> +
>> +    memread(guest_buf_addr, buf, EVENT_LOG_LEN);
>> +    guest_free(qs->alloc, guest_buf_addr);
>> +
>> +    g_assert_cmpint(ret, ==, 0);
>> +
>> +    /*
>> +     * This time we can't ignore the event log written in the
>> +     * check_exception call - we need the DRC index of the
>> +     * recently added CPU to make the state changes using set_indicator.
>> +     *
>> +     * A bit of magic to go straight to the DRC index by checking the
>> +     * error log format in hw/ppc/spapr_events.c:
>> +     *
>> +     * - rtas_error_log size = 8 bytes
>> +     * - all other structures until the hotplug event log = 88 bytes
>> +     * - inside the hotplug event log, skip 8 + 4 bytes to get to
>> +     *   the drc_id union.
>> +     *
>> +     * This gives us a 108 bytes skip to get the drc info, which is
>> +     * written in be32.
>> +     */
>> +    drc_index = be32toh(*((uint32_t *)(buf + 108)));
>> +    g_free(buf);
> It's test program, so I think you should really check the content of
> rtas_error_log (initiator field), the content of the extended (check Log
> Valid, Log Format identifier, Company identifier, ...) and the content
> of the Platform Event Log (Logical Resource Identitifcation: Section Id,
> Resource Type). Then you can get Logical CPU Id. You should also check
> you can hotplug memory (perhaps in the previous patch too).
Yeah, after reading your reviews in the 3 patches I realized that I need to
do more checks to fully assert the hypercall behavior. My mindset when 
making
this was "what do I need to make device hotplug tests" and I ended up
overlooking/ignoring the checks that makes sense for the hypercalls but
not necessarily related to the device hotplug process.

About hotplugging memory: I tried making a LMB hotplug test and seeing
an error "Memory hotplug not supported for this machine". At the time I 
thought
it had something to do with not going through CAS before but now I realize
this doesn't make sense because we can do LMB hotplug when the machine
is started with -S. I'll revisit this behavior in the next spin too.

>> +
>> +    /*
>> +     * According to the DRC state diagram, the guest first sets a device
>> +     * to USABLE (2), then UNISOLATED (3). Both should return
>> +     * RTAS_OUT_SUCCESS(0).
>> +     */
>> +    ret = qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ALLOCATION_STATE,
>> +                              drc_index, SPAPR_DR_ALLOCATION_STATE_USABLE);
>> +    g_assert_cmpint(ret, ==, 0);
> According to the diagram, you need get-sensor-state to check the initial
> state (UNUSABLE).

RIght, we would need to implement the libqos version of get-sensor-state 
to do
that. I'll get it done in v3.


Thanks,


Daniel

>> +    ret = qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ISOLATION_STATE,
>> +                              drc_index, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
>> +    g_assert_cmpint(ret, ==, 0);
>> +
> And the you can also check it has moved to UNISOLATE.
>
>> +    qtest_shutdown(qs);
>> +}
>> +
>>   int main(int argc, char *argv[])
>>   {
>>       const char *arch = qtest_get_arch();
>> @@ -112,6 +184,7 @@ int main(int argc, char *argv[])
>>                      test_rtas_check_exception_no_events);
>>       qtest_add_func("rtas/rtas-check-exception-hotplug-event",
>>                      test_rtas_check_exception_hotplug_event);
>> +    qtest_add_func("rtas/test_rtas_set_indicator", test_rtas_set_indicator);
>>   
>>       return g_test_run();
>>   }
>>
> Thanks,
> Laurent
>
>
