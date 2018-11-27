Received: from eggs.gnu.org ([2001:4830:134:3::10]:36711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRhXl-0004EK-61
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRhXi-0004lo-1R
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:53:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRhXh-0004lX-Oj
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:53:01 -0500
Date: Tue, 27 Nov 2018 12:52:58 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127175258.GA8956@flamenco>
References: <20181124235553.17371-1-cota@braap.org>
	<154333946006.11458.13336720243192208101@c26723477dc9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154333946006.11458.13336720243192208101@c26723477dc9>
Subject: Re: [Qemu-devel] [PATCH v6 00/13] hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org

On Tue, Nov 27, 2018 at 09:24:21 -0800, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/fpu/softfloat.c: In function 'f32_is_inf':
> /tmp/qemu-test/src/fpu/softfloat.c:325:16: error: implicit declaration of function 'isinff' [-Werror=implicit-function-declaration]
>          return isinff(a.h);
>                 ^~~~~~
> /tmp/qemu-test/src/fpu/softfloat.c:325:16: error: incompatible implicit declaration of built-in function 'isinff' [-Werror]
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/fpu/softfloat.c: In function 'f32_is_inf':
> /tmp/qemu-test/src/fpu/softfloat.c:325:16: error: implicit declaration of function 'isinff' [-Werror=implicit-function-declaration]
>          return isinff(a.h);
>                 ^~~~~~
> /tmp/qemu-test/src/fpu/softfloat.c:325:16: error: incompatible implicit declaration of built-in function 'isinff' [-Werror]
> cc1: all warnings being treated as errors
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error 1
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error 1

This is the offender:

+static inline bool f32_is_inf(union_float32 a)
+{
+    if (QEMU_HARDFLOAT_USE_ISINF) {
+        return isinff(a.h);
+    }
+    return float32_is_infinity(a.s);
+}

I've fixed up the branch on github to use isinf here instead
of isinff.

		Emilio
