Received: from eggs.gnu.org ([2001:4830:134:3::10]:55376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg8Oe-0001sT-7h
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg8Oa-0001lL-3x
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cg8OZ-0001l7-Sj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:14:12 -0500
Date: Tue, 21 Feb 2017 11:14:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221111406.GD2377@work-vm>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216121140.9061-6-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] tests/test-vmstate.c: test array of
 ptr to primitive
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
> Let's have a test for ptr arrays to some primitive type with some
> not-null and null ptrs intermixed.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> ---
> 
> Mainly for the sake of completeness and also to demonstrate that it works
> since in the previous version I wrongly stated it does not. If guys think
> we do not need this, I'm happy with just dropping it.
> ---
>  tests/test-vmstate.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index b68a0b3..82ab743 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -590,6 +590,64 @@ static void test_arr_ptr_str_0_load(void)
>      }
>  }
>  
> +typedef struct TestArrayOfPtrToInt {
> +    int32_t *ar[AR_SIZE];
> +} TestArrayOfPtrToInt;
> +
> +const VMStateDescription vmsd_arpp = {
> +    .name = "test/arps",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
> +                AR_SIZE, 0, vmstate_info_int32, int32_t*),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void test_arr_ptr_prim_0_save(void)
> +{
> +    int32_t ar[AR_SIZE] = {0 , 1, 2, 3};
> +    TestArrayOfPtrToInt  sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
> +    uint8_t wire_sample[] = {
> +        0x00, 0x00, 0x00, 0x00,
> +        VMS_NULLPTR_MARKER,
> +        0x00, 0x00, 0x00, 0x02,
> +        0x00, 0x00, 0x00, 0x03,
> +        QEMU_VM_EOF
> +    };
> +
> +    save_vmstate(&vmsd_arpp, &sample);
> +    compare_vmstate(wire_sample, sizeof(wire_sample));
> +}
> +
> +static void test_arr_ptr_prim_0_load(void)
> +{
> +    int32_t ar_gt[AR_SIZE] = {0, 1, 2, 3};
> +    int32_t ar[AR_SIZE] = {3 , 42, 1, 0};
> +    TestArrayOfPtrToInt obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
> +    int idx;
> +    uint8_t wire_sample[] = {
> +        0x00, 0x00, 0x00, 0x00,
> +        VMS_NULLPTR_MARKER,
> +        0x00, 0x00, 0x00, 0x02,
> +        0x00, 0x00, 0x00, 0x03,
> +        QEMU_VM_EOF
> +    };

Again you could share the wire_sample and ar_gt between these two functions,
other than that:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> +    save_buffer(wire_sample, sizeof(wire_sample));
> +    SUCCESS(load_vmstate_one(&vmsd_arpp, &obj, 1,
> +                          wire_sample, sizeof(wire_sample)));
> +    for (idx = 0; idx < AR_SIZE; ++idx) {
> +        /* compare the target array ar with the ground truth array ar_gt */
> +        if (idx == 1) {
> +            g_assert_cmpint(42, ==, ar[idx]);
> +        } else {
> +            g_assert_cmpint(ar_gt[idx], ==, ar[idx]);
> +        }
> +    }
> +}
> +
>  /* test QTAILQ migration */
>  typedef struct TestQtailqElement TestQtailqElement;
>  
> @@ -843,6 +901,10 @@ int main(int argc, char **argv)
>      g_test_add_func("/vmstate/array/ptr/str/0/save", test_arr_ptr_str_0_save);
>      g_test_add_func("/vmstate/array/ptr/str/0/load",
>                      test_arr_ptr_str_0_load);
> +    g_test_add_func("/vmstate/array/ptr/prim/0/save",
> +                    test_arr_ptr_prim_0_save);
> +    g_test_add_func("/vmstate/array/ptr/prim/0/load",
> +                    test_arr_ptr_prim_0_load);
>      g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
>      g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
>      g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
