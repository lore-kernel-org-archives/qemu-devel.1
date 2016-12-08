Received: from eggs.gnu.org ([2001:4830:134:3::10]:57230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cF2lV-0007Ja-RO
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cF2lS-0002EC-NQ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <duanj@linux.vnet.ibm.com>)
	id 1cF2lS-0002Dt-Gt
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:50 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB8HjYY3134834
	for <qemu-devel@nongnu.org>; Thu, 8 Dec 2016 12:45:49 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 277bvx93c9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 12:45:49 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <duanj@linux.vnet.ibm.com>;
	Thu, 8 Dec 2016 10:45:48 -0700
References: <1479923640-8423-1-git-send-email-duanj@linux.vnet.ibm.com>
	<1479923640-8423-4-git-send-email-duanj@linux.vnet.ibm.com>
	<20161207194922.GC2073@work-vm>
	<d4db7b13-9729-5faa-bb0f-93e148346ee4@linux.vnet.ibm.com>
	<20161208090330.GA2054@work-vm>
From: Jianjun Duan <duanj@linux.vnet.ibm.com>
Date: Thu, 8 Dec 2016 09:45:37 -0800
MIME-Version: 1.0
In-Reply-To: <20161208090330.GA2054@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <96ac7d12-ccef-5c6c-fc90-783615cee957@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU PATCH v14 3/4] tests/migration:
 Add test for QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dmitry@daynix.com, peter.maydell@linaro.org, kraxel@redhat.com, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, veroniabahaa@gmail.com, quintela@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, rth@twiddle.net, aurelien@aurel32.net, leon.alrae@imgtec.com, blauwirbel@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com



On 12/08/2016 01:03 AM, Dr. David Alan Gilbert wrote:
> * Jianjun Duan (duanj@linux.vnet.ibm.com) wrote:
>>
>>
>> On 12/07/2016 11:49 AM, Dr. David Alan Gilbert wrote:
>>> * Jianjun Duan (duanj@linux.vnet.ibm.com) wrote:
>>>> Add a test for QTAILQ migration to tests/test-vmstate.c.
>>>
>>> Yes, but see comment below if you have to respin:
>>>
>>>> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
>>>> ---
>>>>  tests/test-vmstate.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 160 insertions(+)
>>>>
>>>> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
>>>> index d2f529b..88aab8c 100644
>>>> --- a/tests/test-vmstate.c
>>>> +++ b/tests/test-vmstate.c
>>>> @@ -544,6 +544,163 @@ static void test_arr_ptr_str_no0_load(void)
>>>>      }
>>>>  }
>>>>  
>>>> +/* test QTAILQ migration */
>>>> +typedef struct TestQtailqElement TestQtailqElement;
>>>> +
>>>> +struct TestQtailqElement {
>>>> +    bool     b;
>>>> +    uint8_t  u8;
>>>> +    QTAILQ_ENTRY(TestQtailqElement) next;
>>>> +};
>>>> +
>>>> +typedef struct TestQtailq {
>>>> +    int16_t  i16;
>>>> +    QTAILQ_HEAD(TestQtailqHead, TestQtailqElement) q;
>>>> +    int32_t  i32;
>>>> +} TestQtailq;
>>>> +
>>>> +static const VMStateDescription vmstate_q_element = {
>>>> +    .name = "test/queue-element",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_BOOL(b, TestQtailqElement),
>>>> +        VMSTATE_UINT8(u8, TestQtailqElement),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    },
>>>> +};
>>>> +
>>>> +static const VMStateDescription vmstate_q = {
>>>> +    .name = "test/queue",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_INT16(i16, TestQtailq),
>>>> +        VMSTATE_QTAILQ_V(q, TestQtailq, 1, vmstate_q_element, TestQtailqElement,
>>>> +                         next),
>>>> +        VMSTATE_INT32(i32, TestQtailq),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +static void test_save_q(void)
>>>> +{
>>>> +    TestQtailq obj_q = {
>>>> +        .i16 = -512,
>>>> +        .i32 = 70000,
>>>> +    };
>>>> +
>>>> +    TestQtailqElement obj_qe1 = {
>>>> +        .b = true,
>>>> +        .u8 = 130,
>>>> +    };
>>>> +
>>>> +    TestQtailqElement obj_qe2 = {
>>>> +        .b = false,
>>>> +        .u8 = 65,
>>>> +    };
>>>> +
>>>> +    uint8_t wire_q[] = {
>>>> +        /* i16 */                     0xfe, 0x0,
>>>> +        /* start of element 0 of q */ 0x01,
>>>> +        /* .b  */                     0x01,
>>>> +        /* .u8 */                     0x82,
>>>> +        /* start of element 1 of q */ 0x01,
>>>> +        /* b */                       0x00,
>>>> +        /* u8 */                      0x41,
>>>> +        /* end of q */                0x00,
>>>> +        /* i32 */                     0x00, 0x01, 0x11, 0x70,
>>>> +        QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
>>>> +    };
>>>
>>> If possible it would be great to share these structures with the ones in test_load_q.
>>>
>> The issue is that obj_q need be initialized and elements need be
>> inserted in both testing cases. It is not straightforward or a good idea
>> to construct the q in a static way. Sharing the structures would make
>> one test depending on another, since the q needs be torn down and
>> restored to the uninitialized states after one test, which has to be
>> manually done. Or we need to add a test to just init the q before these
>> two tests. That will still create dependence issue.
> 
> OK, what about sharing wire_q ?

That is doable.

Thanks,
Jianjun
> 
> Dave
> 
>> So I would leave it as it is.
>>
>> Thanks,
>> Jianjun
>>
>>> Dave
>>>
>>>> +    QTAILQ_INIT(&obj_q.q);
>>>> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe1, next);
>>>> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe2, next);
>>>> +
>>>> +    save_vmstate(&vmstate_q, &obj_q);
>>>> +    compare_vmstate(wire_q, sizeof(wire_q));
>>>> +}
>>>> +
>>>> +static void test_load_q(void)
>>>> +{
>>>> +    TestQtailq obj_q = {
>>>> +        .i16 = -512,
>>>> +        .i32 = 70000,
>>>> +    };
>>>> +
>>>> +    TestQtailqElement obj_qe1 = {
>>>> +        .b = true,
>>>> +        .u8 = 130,
>>>> +    };
>>>> +
>>>> +    TestQtailqElement obj_qe2 = {
>>>> +        .b = false,
>>>> +        .u8 = 65,
>>>> +    };
>>>> +
>>>> +    uint8_t wire_q[] = {
>>>> +        /* i16 */                     0xfe, 0x0,
>>>> +        /* start of element 0 of q */ 0x01,
>>>> +        /* .b  */                     0x01,
>>>> +        /* .u8 */                     0x82,
>>>> +        /* start of element 1 of q */ 0x01,
>>>> +        /* b */                       0x00,
>>>> +        /* u8 */                      0x41,
>>>> +        /* end of q */                0x00,
>>>> +        /* i32 */                     0x00, 0x01, 0x11, 0x70,
>>>> +    };
>>>> +
>>>> +    QTAILQ_INIT(&obj_q.q);
>>>> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe1, next);
>>>> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe2, next);
>>>> +
>>>> +    QEMUFile *fsave = open_test_file(true);
>>>> +
>>>> +    qemu_put_buffer(fsave, wire_q, sizeof(wire_q));
>>>> +    qemu_put_byte(fsave, QEMU_VM_EOF);
>>>> +    g_assert(!qemu_file_get_error(fsave));
>>>> +    qemu_fclose(fsave);
>>>> +
>>>> +    QEMUFile *fload = open_test_file(false);
>>>> +    TestQtailq tgt;
>>>> +
>>>> +    QTAILQ_INIT(&tgt.q);
>>>> +    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
>>>> +    char eof = qemu_get_byte(fload);
>>>> +    g_assert(!qemu_file_get_error(fload));
>>>> +    g_assert_cmpint(tgt.i16, ==, obj_q.i16);
>>>> +    g_assert_cmpint(tgt.i32, ==, obj_q.i32);
>>>> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
>>>> +
>>>> +    TestQtailqElement *qele_from = QTAILQ_FIRST(&obj_q.q);
>>>> +    TestQtailqElement *qlast_from = QTAILQ_LAST(&obj_q.q, TestQtailqHead);
>>>> +    TestQtailqElement *qele_to = QTAILQ_FIRST(&tgt.q);
>>>> +    TestQtailqElement *qlast_to = QTAILQ_LAST(&tgt.q, TestQtailqHead);
>>>> +
>>>> +    while (1) {
>>>> +        g_assert_cmpint(qele_to->b, ==, qele_from->b);
>>>> +        g_assert_cmpint(qele_to->u8, ==, qele_from->u8);
>>>> +        if ((qele_from == qlast_from) || (qele_to == qlast_to)) {
>>>> +            break;
>>>> +        }
>>>> +        qele_from = QTAILQ_NEXT(qele_from, next);
>>>> +        qele_to = QTAILQ_NEXT(qele_to, next);
>>>> +    }
>>>> +
>>>> +    g_assert_cmpint((uint64_t) qele_from, ==, (uint64_t) qlast_from);
>>>> +    g_assert_cmpint((uint64_t) qele_to, ==, (uint64_t) qlast_to);
>>>> +
>>>> +    /* clean up */
>>>> +    TestQtailqElement *qele;
>>>> +    while (!QTAILQ_EMPTY(&tgt.q)) {
>>>> +        qele = QTAILQ_LAST(&tgt.q, TestQtailqHead);
>>>> +        QTAILQ_REMOVE(&tgt.q, qele, next);
>>>> +        free(qele);
>>>> +        qele = NULL;
>>>> +    }
>>>> +    qemu_fclose(fload);
>>>> +}
>>>> +
>>>>  int main(int argc, char **argv)
>>>>  {
>>>>      temp_fd = mkstemp(temp_file);
>>>> @@ -562,6 +719,9 @@ int main(int argc, char **argv)
>>>>                      test_arr_ptr_str_no0_save);
>>>>      g_test_add_func("/vmstate/array/ptr/str/no0/load",
>>>>                      test_arr_ptr_str_no0_load);
>>>> +    g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
>>>> +    g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
>>>> +
>>>>      g_test_run();
>>>>  
>>>>      close(temp_fd);
>>>> -- 
>>>> 1.9.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
