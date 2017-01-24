Received: from eggs.gnu.org ([2001:4830:134:3::10]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVysp-0003jE-VV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVysm-0000gh-1y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:03:28 -0500
Date: Tue, 24 Jan 2017 11:03:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170124110315.GC2220@work-vm>
References: <1484852453-12728-1-git-send-email-duanj@linux.vnet.ibm.com>
	<1484852453-12728-4-git-send-email-duanj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484852453-12728-4-git-send-email-duanj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v17 3/4] tests/migration: Add test for
 QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jianjun Duan <duanj@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dmitry@daynix.com, peter.maydell@linaro.org, kraxel@redhat.com, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, veroniabahaa@gmail.com, quintela@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, rth@twiddle.net, aurelien@aurel32.net, leon.alrae@imgtec.com, blauwirbel@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com

* Jianjun Duan (duanj@linux.vnet.ibm.com) wrote:
> Add a test for QTAILQ migration to tests/test-vmstate.c.
> 
> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/test-vmstate.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index d2f529b..9d87faf 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -544,6 +544,150 @@ static void test_arr_ptr_str_no0_load(void)
>      }
>  }
>  
> +/* test QTAILQ migration */
> +typedef struct TestQtailqElement TestQtailqElement;
> +
> +struct TestQtailqElement {
> +    bool     b;
> +    uint8_t  u8;
> +    QTAILQ_ENTRY(TestQtailqElement) next;
> +};
> +
> +typedef struct TestQtailq {
> +    int16_t  i16;
> +    QTAILQ_HEAD(TestQtailqHead, TestQtailqElement) q;
> +    int32_t  i32;
> +} TestQtailq;
> +
> +static const VMStateDescription vmstate_q_element = {
> +    .name = "test/queue-element",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(b, TestQtailqElement),
> +        VMSTATE_UINT8(u8, TestQtailqElement),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_q = {
> +    .name = "test/queue",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT16(i16, TestQtailq),
> +        VMSTATE_QTAILQ_V(q, TestQtailq, 1, vmstate_q_element, TestQtailqElement,
> +                         next),
> +        VMSTATE_INT32(i32, TestQtailq),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +uint8_t wire_q[] = {
> +    /* i16 */                     0xfe, 0x0,
> +    /* start of element 0 of q */ 0x01,
> +    /* .b  */                     0x01,
> +    /* .u8 */                     0x82,
> +    /* start of element 1 of q */ 0x01,
> +    /* b */                       0x00,
> +    /* u8 */                      0x41,
> +    /* end of q */                0x00,
> +    /* i32 */                     0x00, 0x01, 0x11, 0x70,
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
> +};
> +
> +static void test_save_q(void)
> +{
> +    TestQtailq obj_q = {
> +        .i16 = -512,
> +        .i32 = 70000,
> +    };
> +
> +    TestQtailqElement obj_qe1 = {
> +        .b = true,
> +        .u8 = 130,
> +    };
> +
> +    TestQtailqElement obj_qe2 = {
> +        .b = false,
> +        .u8 = 65,
> +    };
> +
> +    QTAILQ_INIT(&obj_q.q);
> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe1, next);
> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe2, next);
> +
> +    save_vmstate(&vmstate_q, &obj_q);
> +    compare_vmstate(wire_q, sizeof(wire_q));
> +}
> +
> +static void test_load_q(void)
> +{
> +    TestQtailq obj_q = {
> +        .i16 = -512,
> +        .i32 = 70000,
> +    };
> +
> +    TestQtailqElement obj_qe1 = {
> +        .b = true,
> +        .u8 = 130,
> +    };
> +
> +    TestQtailqElement obj_qe2 = {
> +        .b = false,
> +        .u8 = 65,
> +    };
> +
> +    QTAILQ_INIT(&obj_q.q);
> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe1, next);
> +    QTAILQ_INSERT_TAIL(&obj_q.q, &obj_qe2, next);
> +
> +    QEMUFile *fsave = open_test_file(true);
> +
> +    qemu_put_buffer(fsave, wire_q, sizeof(wire_q));
> +    g_assert(!qemu_file_get_error(fsave));
> +    qemu_fclose(fsave);
> +
> +    QEMUFile *fload = open_test_file(false);
> +    TestQtailq tgt;
> +
> +    QTAILQ_INIT(&tgt.q);
> +    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
> +    char eof = qemu_get_byte(fload);
> +    g_assert(!qemu_file_get_error(fload));
> +    g_assert_cmpint(tgt.i16, ==, obj_q.i16);
> +    g_assert_cmpint(tgt.i32, ==, obj_q.i32);
> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
> +
> +    TestQtailqElement *qele_from = QTAILQ_FIRST(&obj_q.q);
> +    TestQtailqElement *qlast_from = QTAILQ_LAST(&obj_q.q, TestQtailqHead);
> +    TestQtailqElement *qele_to = QTAILQ_FIRST(&tgt.q);
> +    TestQtailqElement *qlast_to = QTAILQ_LAST(&tgt.q, TestQtailqHead);
> +
> +    while (1) {
> +        g_assert_cmpint(qele_to->b, ==, qele_from->b);
> +        g_assert_cmpint(qele_to->u8, ==, qele_from->u8);
> +        if ((qele_from == qlast_from) || (qele_to == qlast_to)) {
> +            break;
> +        }
> +        qele_from = QTAILQ_NEXT(qele_from, next);
> +        qele_to = QTAILQ_NEXT(qele_to, next);
> +    }
> +
> +    g_assert_cmpint((uintptr_t) qele_from, ==, (uintptr_t) qlast_from);
> +    g_assert_cmpint((uintptr_t) qele_to, ==, (uintptr_t) qlast_to);
> +
> +    /* clean up */
> +    TestQtailqElement *qele;
> +    while (!QTAILQ_EMPTY(&tgt.q)) {
> +        qele = QTAILQ_LAST(&tgt.q, TestQtailqHead);
> +        QTAILQ_REMOVE(&tgt.q, qele, next);
> +        free(qele);
> +        qele = NULL;
> +    }
> +    qemu_fclose(fload);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      temp_fd = mkstemp(temp_file);
> @@ -562,6 +706,9 @@ int main(int argc, char **argv)
>                      test_arr_ptr_str_no0_save);
>      g_test_add_func("/vmstate/array/ptr/str/no0/load",
>                      test_arr_ptr_str_no0_load);
> +    g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
> +    g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
> +
>      g_test_run();
>  
>      close(temp_fd);
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
