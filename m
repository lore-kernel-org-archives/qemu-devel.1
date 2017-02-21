Received: from eggs.gnu.org ([2001:4830:134:3::10]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg816-0004LV-91
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg811-0004R2-9L
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:49:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cg811-0004Qs-0Y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:49:51 -0500
Date: Tue, 21 Feb 2017 10:49:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221104945.GC2377@work-vm>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216121140.9061-5-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/test-vmstate.c: test array of
 ptr with null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Add test for VMSTATE_ARRAY_OF_POINTER_TO_STRUCT with an array
> containing some null pointer.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/test-vmstate.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index d0dd390..b68a0b3 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -487,6 +487,8 @@ const VMStateDescription vmsd_tst = {
>      }
>  };
>  
> +/* test array migration */
> +
>  #define AR_SIZE 4
>  
>  typedef struct {
> @@ -542,6 +544,52 @@ static void test_arr_ptr_str_no0_load(void)
>      }
>  }
>  
> +static void test_arr_ptr_str_0_save(void)
> +{
> +    TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
> +    TestArrayOfPtrToStuct sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
> +    uint8_t wire_sample[] = {
> +        0x00, 0x00, 0x00, 0x00,
> +        VMS_NULLPTR_MARKER,
> +        0x00, 0x00, 0x00, 0x02,
> +        0x00, 0x00, 0x00, 0x03,
> +        QEMU_VM_EOF
> +    };
> +
> +    save_vmstate(&vmsd_arps, &sample);
> +    compare_vmstate(wire_sample, sizeof(wire_sample));
> +}
> +
> +static void test_arr_ptr_str_0_load(void)
> +{
> +    TestStructTriv ar_gt[AR_SIZE] = {{.i = 0}, {.i = 0}, {.i = 2}, {.i = 3} };
> +    TestStructTriv ar[AR_SIZE] = {};
> +    TestArrayOfPtrToStuct obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
> +    int idx;
> +    uint8_t wire_sample[] = {
> +        0x00, 0x00, 0x00, 0x00,
> +        VMS_NULLPTR_MARKER,
> +        0x00, 0x00, 0x00, 0x02,
> +        0x00, 0x00, 0x00, 0x03,
> +        QEMU_VM_EOF
> +    };

If possible; it would be better if you could share the wire_sample, and ar_gt between
the two functions rather than copying them.

Dave

> +    save_buffer(wire_sample, sizeof(wire_sample));
> +    SUCCESS(load_vmstate_one(&vmsd_arps, &obj, 1,
> +                          wire_sample, sizeof(wire_sample)));
> +    for (idx = 0; idx < AR_SIZE; ++idx) {
> +        /* compare the target array ar with the ground truth array ar_gt */
> +        g_assert_cmpint(ar_gt[idx].i, ==, ar[idx].i);
> +    }
> +    for (idx = 0; idx < AR_SIZE; ++idx) {
> +        if (idx == 1) {
> +            g_assert_cmpint((uint64_t)(obj.ar[idx]), ==, 0);
> +        } else {
> +            g_assert_cmpint((uint64_t)(obj.ar[idx]), !=, 0);
> +        }
> +    }
> +}
> +
>  /* test QTAILQ migration */
>  typedef struct TestQtailqElement TestQtailqElement;
>  
> @@ -792,6 +840,9 @@ int main(int argc, char **argv)
>                      test_arr_ptr_str_no0_save);
>      g_test_add_func("/vmstate/array/ptr/str/no0/load",
>                      test_arr_ptr_str_no0_load);
> +    g_test_add_func("/vmstate/array/ptr/str/0/save", test_arr_ptr_str_0_save);
> +    g_test_add_func("/vmstate/array/ptr/str/0/load",
> +                    test_arr_ptr_str_0_load);
>      g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
>      g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
>      g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
