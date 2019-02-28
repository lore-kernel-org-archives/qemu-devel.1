Received: from eggs.gnu.org ([209.51.188.92]:58781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzLGZ-00013v-MT
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzLGU-0006yy-3C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:58:21 -0500
Received: from mail-yw1-xc34.google.com ([2607:f8b0:4864:20::c34]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gzLGT-0006xa-9V
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:58:17 -0500
Received: by mail-yw1-xc34.google.com with SMTP id s204so10953291ywg.2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 04:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20190225203233.3439-1-jcmvbkbc@gmail.com>
	<CAFEAcA_oanfMXGd1cD=+ypL5N32Hm8JR064LWdW09WCVwZXVRg@mail.gmail.com>
In-Reply-To: <CAFEAcA_oanfMXGd1cD=+ypL5N32Hm8JR064LWdW09WCVwZXVRg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Feb 2019 04:58:02 -0800
Message-ID: <CAMo8Bf+KRECi8dKUiBqSHTJk6UD-XayjDGS6mxOy_eeU2-dL2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On Thu, Feb 28, 2019 at 2:27 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Mon, 25 Feb 2019 at 20:32, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > please pull the following batch of target/xtensa updates:
>
> Hi -- I'm afraid this fails to build on some clang compilers:
>
> /Users/pm215/src/qemu-for-merges/target/xtensa/translate.c:967:14:
> error: result of comparison of constant 256 with expression of type
> 'enum resource_type' is always true
> [-Werror,-Wtautological-constant-out-of-range-compare]
>     assert(r < 256 && g < 256 && n < 65536);
>            ~ ^ ~~~

Thanks. I've fixed it up with the following:

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 616ed8f57972..bda4e9469b86 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -865,11 +865,12 @@ struct slot_prop {
 enum resource_type {
     RES_REGFILE,
     RES_STATE,
+    RES_MAX,
 };

 static uint32_t encode_resource(enum resource_type r, unsigned g, unsigned n)
 {
-    assert(r < 256 && g < 256 && n < 65536);
+    assert(r < RES_MAX && g < 256 && n < 65536);
     return (r << 24) | (g << 16) | n;
 }

and pushed the updated tag 20190228-xtensa.

-- 
Thanks.
-- Max
