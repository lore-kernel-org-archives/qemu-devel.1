Received: from eggs.gnu.org ([2001:4830:134:3::10]:48913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebomd-0005xj-Qh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebomZ-0007Q8-Pj
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:33:43 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebomZ-0007PR-Lw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:33:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id d54so10670880qtd.4
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:33:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180117131821.18700-1-f4bug@amsat.org>
	<20180117131821.18700-2-f4bug@amsat.org>
	<20180117133201.GN19227@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
Date: Wed, 17 Jan 2018 11:33:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180117133201.GN19227@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 01/17/2018 10:32 AM, Daniel P. Berrange wrote:
> On Wed, Jan 17, 2018 at 10:18:19AM -0300, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/qemu/compiler.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 340e5fdc09..d9b2489391 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -26,6 +26,8 @@
>>  
>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>>  
>> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)))
> 
> If we take this, it should come with a warning attached to it, because
> it has really nasty behaviour with GCC. Consider code like:
> 
>   void foo(void *bar) __attribute__((nonnull(1)));
> 
>   ...
> 
>   void foo(void *bar) { if (!bar) return; }
> 
> GCC may or may not warn you about passing NULL for the 'bar'
> parameter, but it will none the less assume nothing passes
> NULL, and thus remove the 'if (!bar)' conditional during
> optimization. IOW, adding nonnull annotations can actually
> make your code less robust :-(

TIL!

> After having a number of crashes in libvirt caused by gcc
> optimizing out checks for NULL, we now only define nonnull
> when running under static analysis (coverity) and not when
> compiling normally.
> 
> https://libvirt.org/git/?p=libvirt.git;a=blob;f=src/internal.h;h=5895030415968d72200599e8a59bbf01ffc2d5a3;hb=HEAD#l162

Why do you use __attribute__(()) ? Isn't this enough:

#if defined __clang_analyzer__ || defined __COVERITY__
#define QEMU_STATIC_ANALYSIS 1
+#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)))
+#else
+#define QEMU_WARN_NONNULL_ARGS(args...)
#endif

> The 2 functions you've added nonnull attrs to look safe enough,
> but people might unwittingly use this elsewhere in QEMU in future
> not realizing the side-effect it has.
> 
> Regards,
> Daniel
> 
