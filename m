Received: from eggs.gnu.org ([2001:4830:134:3::10]:54526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboxX-0003I2-Kl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboxU-00029d-DC
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:44:59 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboxU-00029D-7y
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:44:56 -0500
Received: by mail-qt0-x244.google.com with SMTP id o35so12657563qtj.13
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:44:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180117131821.18700-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6fcfee84-e022-b6fd-12bc-61173e52eb06@amsat.org>
Date: Wed, 17 Jan 2018 11:44:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180117131821.18700-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] add QEMU_WARN_NONNULL_ARGS() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Weil <sw@weilnetz.de>

On 01/17/2018 10:18 AM, Philippe Mathieu-Daudé wrote:
> Some old PoC series I remember after reading
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03545.html
> 
> I had few more changes but then I found the code was harder to read
> so I didn't continue further.
> Only 2 patches are included as example.
> 
> This might still be useful in few cases, so I'm still sending as RFC
> to have different thoughts.
> 
> This macro is, however, helpful to the Clang static analizer (reducing
> false positive).
> 
> BTW another useful macro for the static analizer I used is:
> 
>     #define QEMU_FALLTHROUGH __attribute__((fallthrough))

and:

#define QEMU_STATIC_ANALYSIS_ASSERT(expression) assert(expression)

i.e.:

linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer value
        if (*host_rt_dev_ptr != 0) {
            ^~~~~~~~~~~~~~~~

This can safely be silenced using:

     unlock_user(argptr, arg, 0);
+    QEMU_STATIC_ANALYSIS_ASSERT(host_rt_dev_ptr);
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
     if (*host_rt_dev_ptr != 0) {
         ...

Or:

target/mips/msa_helper.c:1008:23: warning: The result of the '<<'
expression is undefined
        int64_t r_bit = 1 << (DF_BITS(df) - 2);
                        ~~^~~~~~~~~~~~~~~~~~~~

Using:

static inline int64_t msa_mulr_q_df(uint32_t df, int64_t arg1, int64_t arg2)
{
     int64_t q_min = DF_MIN_INT(df);
     int64_t q_max = DF_MAX_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit;

+    QEMU_STATIC_ANALYSIS_ASSERT(DF_BITS(df) < 32);
+    r_bit = 1 << (DF_BITS(df) - 2);

Similar:

target/arm/helper.c:4283:25: warning: The result of the '>>' expression
is undefined
            len = cto32(bas >> basstart);
                        ~~~~^~~~~~~~~~~

Using:

 basstart = ctz32(bas);
+QEMU_STATIC_ANALYSIS_ASSERT(basstart <= 8); /* bas is at most 8-bit */
 len = cto32(bas >> basstart);

Another:

monitor.c:1481:26: warning: Access to field 'name' results in a
dereference of a null pointer (loaded from variable 'mr')
                       addr, mr->name, ptr);
                             ^~~~~~~~

Using:

     if (local_err) {
         error_report_err(local_err);
         return;
+    } else {
+        QEMU_STATIC_ANALYSIS_ASSERT(ptr != NULL);
     }
     physaddr = vtop(ptr, &local_err);
     if (local_err) {
         error_report_err(local_err);
     } else {
         monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
                        " (%s) is 0x%" PRIx64 "\n",
                        addr, mr->name, (uint64_t) physaddr);

etc..

Too many false positive leads to unused report,
but personally I still prefer readable code.

> 
> It replaces the /* fall through */ comment, i.e.:
> 
>     switch (rap) {
>     case BCR_SWS:
>         if (!(CSR_STOP(s) || CSR_SPND(s)))
>             return;
>         val &= ~0x0300;
>         QEMU_FALLTHROUGH;
>     case BCR_LNKST:
>     case BCR_LED1:
>     case BCR_LED2:
>     case BCR_LED3:
>     case BCR_MC:
>     case BCR_FDC:
>     case BCR_BSBC:
>     case BCR_EECAS:
>     case BCR_PLAT:
>         s->bcr[rap] = val;
>         break;
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>   compiler: add QEMU_WARN_NONNULL_ARGS()
>   virtio: let virtio_add/clear_feature() use QEMU_WARN_NONNULL_ARGS()
>   utils: let qemu_find_file() use QEMU_WARN_NONNULL_ARGS()
> 
>  include/hw/virtio/virtio.h | 2 ++
>  include/qemu-common.h      | 2 +-
>  include/qemu/compiler.h    | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
