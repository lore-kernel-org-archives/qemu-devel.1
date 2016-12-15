Received: from eggs.gnu.org ([2001:4830:134:3::10]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHVWt-0005JK-LW
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHVWq-0002RR-Je
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHVWq-0002Ql-A8
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:52:56 -0500
Date: Thu, 15 Dec 2016 12:52:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215125250.GI2509@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-9-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108095603.72301-9-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 8/8] tests/test-vmstate.c: add array
 of pointers to struct with NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Increase coverage by testing VMSTATE_ARRAY_OF_POINTER_TO_STRUCT
> with an array containing some NULL pointer.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  tests/test-vmstate.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index aa1ccf1..5394119 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -651,6 +651,44 @@ static void test_arr_ptr_str_no0_load(void)
>      }
>  }
>  
> +static void test_arr_ptr_str_0_save(void)
> +{
> +    TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
> +    TestArrayOfPtrToStuct sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
> +
> +    save_vmstate(&vmsd_arps, &sample); /* fails with SEGFAULT with master */

Should probably remove that comment now; but other than that.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> +
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
>  int main(int argc, char **argv)
>  {
>      temp_fd = mkstemp(temp_file);
> @@ -670,6 +708,9 @@ int main(int argc, char **argv)
>                      test_arr_ptr_str_no0_save);
>      g_test_add_func("/vmstate/array/ptr/str/no0/load",
>                      test_arr_ptr_str_no0_load);
> +    g_test_add_func("/vmstate/array/ptr/str/0/save", test_arr_ptr_str_0_save);
> +    g_test_add_func("/vmstate/array/ptr/str/0/load",
> +                    test_arr_ptr_str_0_load);
>      g_test_run();
>  
>      close(temp_fd);
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
