Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMxB9-0006lJ-F0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMxB3-0005N3-Ri
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:34:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMxB3-0005Lq-Lu
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:34:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so17746582wrx.6
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:34:01 -0800 (PST)
References: <20181114132130.27141-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <82d235bf-6af9-10b3-0b09-823973b6ce06@redhat.com>
Date: Wed, 14 Nov 2018 16:33:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181114132130.27141-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: add /vmstate/simple/array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

On 14/11/18 14:21, Marc-André Lureau wrote:
> A very simple test to show VMSTATE_*_ARRAY usage and result. It could
> be systematically extended to other primitives, but I leave that as an
> exercise for others :).

If this patch get accepted, please add this good idea to the 
BiteSizedTasks wiki entry:

https://wiki.qemu.org/Contribute/BiteSizedTasks

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/test-vmstate.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index 37a7a93784..2a960dedbe 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -284,6 +284,55 @@ static void test_simple_primitive(void)
>       FIELD_EQUAL(i64_2);
>   }
>   
> +typedef struct TestSimpleArray {
> +    uint16_t u16_1[3];
> +} TestSimpleArray;
> +
> +/* Object instantiation, we are going to use it in more than one test */
> +
> +TestSimpleArray obj_simple_arr = {
> +    .u16_1 = { 0x42, 0x43, 0x44 },
> +};
> +
> +/* Description of the values.  If you add a primitive type
> +   you are expected to add a test here */
> +
> +static const VMStateDescription vmstate_simple_arr = {
> +    .name = "simple/array",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(u16_1, TestSimpleArray, 3),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +uint8_t wire_simple_arr[] = {
> +    /* u16_1 */ 0x00, 0x42,
> +    /* u16_1 */ 0x00, 0x43,
> +    /* u16_1 */ 0x00, 0x44,
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
> +};
> +
> +static void obj_simple_arr_copy(void *target, void *source)
> +{
> +    memcpy(target, source, sizeof(TestSimpleArray));
> +}
> +
> +static void test_simple_array(void)
> +{
> +    TestSimpleArray obj, obj_clone;
> +
> +    memset(&obj, 0, sizeof(obj));
> +    save_vmstate(&vmstate_simple_arr, &obj_simple_arr);
> +
> +    compare_vmstate(wire_simple_arr, sizeof(wire_simple_arr));
> +
> +    SUCCESS(load_vmstate(&vmstate_simple_arr, &obj, &obj_clone,
> +                         obj_simple_arr_copy, 1, wire_simple_arr,
> +                         sizeof(wire_simple_arr)));
> +}
> +
>   typedef struct TestStruct {
>       uint32_t a, b, c, e;
>       uint64_t d, f;
> @@ -863,6 +912,7 @@ int main(int argc, char **argv)
>   
>       g_test_init(&argc, &argv, NULL);
>       g_test_add_func("/vmstate/simple/primitive", test_simple_primitive);
> +    g_test_add_func("/vmstate/simple/array", test_simple_array);
>       g_test_add_func("/vmstate/versioned/load/v1", test_load_v1);
>       g_test_add_func("/vmstate/versioned/load/v2", test_load_v2);
>       g_test_add_func("/vmstate/field_exists/load/noskip", test_load_noskip);
> 
