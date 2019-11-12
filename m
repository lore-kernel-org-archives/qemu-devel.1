Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759492196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759492196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZL5-00080z-Lx
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iUZKP-0007aq-Ek
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iUZKN-0005Z4-7b
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:47:40 -0500
Received: from relay64.bu.edu ([128.197.228.104]:54642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iUZKN-0005YQ-41
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:47:39 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.162.lightower.net [144.121.20.162] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id xACGkvbj029061
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Tue, 12 Nov 2019 11:46:57 -0500
Subject: Re: [PATCH v4 01/20] softmmu: split off vl.c:main() into main.c
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-2-alxndr@bu.edu>
 <20191105164140.gts3ratgxwa4z2jg@starbug-mbp>
From: Alexander Bulekov <alxndr@bu.edu>
Message-ID: <737fcde0-53bb-c0c4-452a-738a188b1c81@bu.edu>
Date: Tue, 12 Nov 2019 11:46:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191105164140.gts3ratgxwa4z2jg@starbug-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay64.bu.edu id
 xACGkvbj029061
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.104
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 11:41 AM, Darren Kenny wrote:
> On Wed, Oct 30, 2019 at 02:49:48PM +0000, Oleinik, Alexander wrote:
>> From: Alexander Oleinik <alxndr@bu.edu>
>>
>> A program might rely on functions implemented in vl.c, but implement i=
ts
>> own main(). By placing main into a separate source file, there are no
>> complaints about duplicate main()s when linking against vl.o. For
>> example, the virtual-device fuzzer uses a main() provided by libfuzzer=
,
>> and needs to perform some initialization before running the softmmu
>> initialization. Now, main simply calls three vl.c functions which
>> handle the guest initialization, main loop and cleanup.
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>> Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
>> include/sysemu/sysemu.h |=C2=A0 4 ++++
>> main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 +++++++++++++++++++++++++++++++=
++++++++++
>> vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++------------=
---------
>> 5 files changed, 68 insertions(+), 27 deletions(-)
>> create mode 100644 main.c
>>
>> diff --git a/Makefile b/Makefile
>> index 0e994a275d..d2b2ecd3c4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -474,6 +474,7 @@ $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
>> $(SOFTMMU_ALL_RULES): $(io-obj-y)
>> $(SOFTMMU_ALL_RULES): config-all-devices.mak
>> $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
>> +$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
>>
>> .PHONY: $(TARGET_DIRS_RULES)
>> # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 11ba1a36bd..9ff9b0c6f9 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -86,6 +86,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>> # qapi
>>
>> common-obj-y +=3D qapi/
>> +
>> +softmmu-main-y =3D main.o
>> endif
>>
>> ######################################################################=
#
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 44f18eb739..03f9838b81 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -114,6 +114,10 @@ QemuOpts *qemu_get_machine_opts(void);
>>
>> bool defaults_enabled(void);
>>
>> +void main_loop(void);
>> +void qemu_init(int argc, char **argv, char **envp);
>> +void qemu_cleanup(void);
>> +
>> extern QemuOptsList qemu_legacy_drive_opts;
>> extern QemuOptsList qemu_common_drive_opts;
>> extern QemuOptsList qemu_drive_opts;
>> diff --git a/main.c b/main.c
>> new file mode 100644
>> index 0000000000..ecd6389424
>> --- /dev/null
>> +++ b/main.c
>> @@ -0,0 +1,52 @@
>> +/*
>> + * QEMU System Emulator
>> + *
>> + * Copyright (c) 2003-2008 Fabrice Bellard
>> + *
>> + * Permission is hereby granted, free of charge, to any person=20
>> obtaining a copy
>> + * of this software and associated documentation files (the=20
>> "Software"), to deal
>> + * in the Software without restriction, including without limitation=20
>> the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense,=20
>> and/or sell
>> + * copies of the Software, and to permit persons to whom the Software=
 is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be=20
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,=20
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF=20
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT=20
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=20
>> OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,=20
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER=20
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +#ifdef CONFIG_SDL
>> +#if defined(__APPLE__) || defined(main)
>> +#include <SDL.h>
>> +int main(int argc, char **argv)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return qemu_main(argc, argv, NULL);
>> +}
>> +#undef main
>> +#define main qemu_main
>=20
> This /looks/ wrong, you're defining a function main(), and then
> immediately #undef and #define main again.
>=20
> Maybe this could be written differently, or add a comment here as to
> why you need to do this.
>=20
>> +#endif
>> +#endif /* CONFIG_SDL */
>> +
>> +#ifdef CONFIG_COCOA
>> +#undef main
>> +#define main qemu_main
>> +#endif /* CONFIG_COCOA */
>=20
> I don't really know the combinations that might exist, but it looks
> like if CONFIG_SDL is not defined, then we're redefining main() to be
> qemi_main() - so what main() function will actually be used here?

I tried to copy this straight from vl.c. It seems that this was=20
originally added for similar reasons that I added this patch - similarly=20
to libfuzzer, SDL has its own main function, and I'm guessing its=20
similar for cocoa. With some  preprocessor flags, the result looks like:
int SDL_main(int argc, char **argv)
{
     return qemu_main(argc, argv,
                                 ((void *)0)
                                     );
}
int qemu_main(int argc, char **argv, char **envp)
{
     qemu_init(argc, argv, envp);
     main_loop();
     qemu_cleanup();
     return 0;
}

So it looks like this is there since SDL expects main to have two args.=20
Maybe this is something that can be solved by adding separate main-sdl.c=20
and main-cocoa.c files and tweaks to the build system, which should be=20
possible now that qemu_init is separate from main().

-Alex

> Thanks,
>=20
> Darren.
>=20
>> +
>> +int main(int argc, char **argv, char **envp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 qemu_init(argc, argv, envp);
>> +=C2=A0=C2=A0=C2=A0 main_loop();
>> +=C2=A0=C2=A0=C2=A0 qemu_cleanup();
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> diff --git a/vl.c b/vl.c
>> index c389d24b2c..472f09e12a 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -36,25 +36,6 @@
>> #include "sysemu/seccomp.h"
>> #include "sysemu/tcg.h"
>>
>> -#ifdef CONFIG_SDL
>> -#if defined(__APPLE__) || defined(main)
>> -#include <SDL.h>
>> -int qemu_main(int argc, char **argv, char **envp);
>> -int main(int argc, char **argv)
>> -{
>> -=C2=A0=C2=A0=C2=A0 return qemu_main(argc, argv, NULL);
>> -}
>> -#undef main
>> -#define main qemu_main
>> -#endif
>> -#endif /* CONFIG_SDL */
>> -
>> -#ifdef CONFIG_COCOA
>> -#undef main
>> -#define main qemu_main
>> -#endif /* CONFIG_COCOA */
>> -
>> -
>> #include "qemu/error-report.h"
>> #include "qemu/sockets.h"
>> #include "sysemu/accel.h"
>> @@ -1797,7 +1778,7 @@ static bool main_loop_should_exit(void)
>> =C2=A0=C2=A0=C2=A0 return false;
>> }
>>
>> -static void main_loop(void)
>> +void main_loop(void)
>> {
>> #ifdef CONFIG_PROFILER
>> =C2=A0=C2=A0=C2=A0 int64_t ti;
>> @@ -2824,7 +2805,7 @@ static void user_register_global_props(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global_init_func, =
NULL, NULL);
>> }
>>
>> -int main(int argc, char **argv, char **envp)
>> +void qemu_init(int argc, char **argv, char **envp)
>> {
>> =C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0 int snapshot, linux_boot;
>> @@ -3404,7 +3385,7 @@ int main(int argc, char **argv, char **envp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cas=
e QEMU_OPTION_watchdog:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (watchdog) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("only one watchdo=
g option may be=20
>> given");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 watchdog =3D optarg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
>> @@ -4440,7 +4421,7 @@ int main(int argc, char **argv, char **envp)
>> =C2=A0=C2=A0=C2=A0 if (vmstate_dump_file) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* dump and exit */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump_vmstate_json_to_file(v=
mstate_dump_file);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0);
>> =C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0 if (incoming) {
>> @@ -4457,8 +4438,11 @@ int main(int argc, char **argv, char **envp)
>> =C2=A0=C2=A0=C2=A0 accel_setup_post(current_machine);
>> =C2=A0=C2=A0=C2=A0 os_setup_post();
>>
>> -=C2=A0=C2=A0=C2=A0 main_loop();
>> +=C2=A0=C2=A0=C2=A0 return;
>> +}
>>
>> +void qemu_cleanup(void)
>> +{
>> =C2=A0=C2=A0=C2=A0 gdbserver_cleanup();
>>
>> =C2=A0=C2=A0=C2=A0 /*
>> @@ -4495,6 +4479,4 @@ int main(int argc, char **argv, char **envp)
>> =C2=A0=C2=A0=C2=A0 qemu_chr_cleanup();
>> =C2=A0=C2=A0=C2=A0 user_creatable_cleanup();
>> =C2=A0=C2=A0=C2=A0 /* TODO: unref root container, check all devices ar=
e ok */
>> -
>> -=C2=A0=C2=A0=C2=A0 return 0;
>> }
>> --=20
>> 2.23.0
>>
>>


--=20
=3D=3D=3D
I recently changed my last name from Oleinik to Bulekov
=3D=3D=3D

