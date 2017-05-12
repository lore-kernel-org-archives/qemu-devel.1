Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d90Q2-0003f4-0N
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d90Py-0001Xq-Rw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:35:02 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:36279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d90Py-0001XZ-Nh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:34:58 -0400
Received: by mail-qt0-x22a.google.com with SMTP id m91so31965674qte.3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 19:34:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149444760825.309.73822913541673005@c05f1edc8ed1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4764de53-79b4-f447-fd5f-9c25f7b4781e@amsat.org>
Date: Thu, 11 May 2017 23:34:54 -0300
MIME-Version: 1.0
In-Reply-To: <149444760825.309.73822913541673005@c05f1edc8ed1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] optimize various tcg_gen() functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Cc: famz@redhat.com

Hi,

The patch set Patchew intented to compile is incorrect, but this error 
worried me:

On 05/10/2017 05:20 PM, no-reply@patchew.org wrote:
> This series failed build test on s390x host. Please find the details below.
[...]
>   CC      mips64-softmmu/target/mips/translate.o
> /var/tmp/patchew-tester-tmp-f7svi4g9/src/target/mips/translate.c: In function ‘gen_bshfl’:
> /var/tmp/patchew-tester-tmp-f7svi4g9/src/target/mips/translate.c:4595:43: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>              tcg_gen_extract_tl(t1, t0, 8, 0x00FF00FF00FF00FFULL);
>                                            ^~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-f7svi4g9/src/target/mips/translate.c:4606:44: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>              tcg_gen_extract_tl(t1, t0, 16, 0x0000FFFF0000FFFFULL);
>                                             ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-f7svi4g9/src/rules.mak:69: recipe for target 'target/mips/translate.o' failed
> make[1]: *** [target/mips/translate.o] Error 1
> Makefile:327: recipe for target 'subdir-mips64el-softmmu' failed

Now I tried to use this code on mips64el-softmmu target:

tcg_gen_extract_tl(t1, t0, 5, 0x7ffffffffffffff);

And got:

error: large integer implicitly truncated to unsigned type 
[-Werror=overflow]
              tcg_gen_extract_tl(t1, t0, 5, 0x7ffffffffffffff);
                                            ^~~~~~~~~~~~~~~~~

There is no need for a such operation, but it seems legit.

I think tcg-op.h would be clearer cleaning few 'unsigned/unsigned int' 
by a 'tcg_target_long'. Like:

  void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
+                         unsigned int ofs, tcg_target_long len);

What do you think Richard?

Regards,

Phil.
