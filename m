Received: from eggs.gnu.org ([2001:4830:134:3::10]:36391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZxJH-0008UW-Cl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZxJF-00077r-O0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:15:43 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZxJF-00076b-EQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:15:41 -0500
Received: by mail-wr0-x241.google.com with SMTP id p6so5014277wrd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:15:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJhQ2H5D9tpBO7oxOwhFVeFQ3sn=wUN1bjZ_o8uJWq0GQ@mail.gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-16-marcandre.lureau@redhat.com>
	<8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
	<CAJ+F1CJhQ2H5D9tpBO7oxOwhFVeFQ3sn=wUN1bjZ_o8uJWq0GQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 12:15:39 +0100
Message-ID: <CAJ+F1C+ZCAcVM++VBsYSdkU5uMS=tZHfKFkZdc-ByvHNgqnXZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/18] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi,

On Tue, Jan 9, 2018 at 12:23 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Tue, Jan 9, 2018 at 12:09 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>> Hi Marc-Andr=C3=A9,
>>
>> On 01/04/2018 01:05 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> It helps ASAN to detect more leaks on coroutine stacks, as found in
>>> the following patch.
>>>
>>> A similar work would need to be done for sigaltstack & windows fibers
>>> to have similar coverage. Since ucontext is preferred, I didn't bother
>>> checking the other coroutine implementations for now.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  include/qemu/compiler.h   |  4 ++++
>>>  util/coroutine-ucontext.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>>  2 files changed, 50 insertions(+)
>>>
>>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>>> index 340e5fdc09..5fcc4f7ec7 100644
>>> --- a/include/qemu/compiler.h
>>> +++ b/include/qemu/compiler.h
>>> @@ -111,4 +111,8 @@
>>>  #define GCC_FMT_ATTR(n, m)
>>>  #endif
>>>
>>> +#ifndef __has_feature
>>> +#define __has_feature(x) 0 /* compatibility with non-clang compilers *=
/
>>> +#endif
>>> +
>>>  #endif /* COMPILER_H */
>>> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
>>> index 6621f3f692..e78eae8766 100644
>>> --- a/util/coroutine-ucontext.c
>>> +++ b/util/coroutine-ucontext.c
>>> @@ -31,6 +31,11 @@
>>>  #include <valgrind/valgrind.h>
>>>  #endif
>>>
>>> +#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
>>> +#define CONFIG_ASAN 1
>>> +#include <sanitizer/asan_interface.h>
>>> +#endif
>>
>> Sadly this fails on Travis:
>>
>> $ export CONFIG=3D"--enable-debug --enable-debug-tcg
>> --enable-trace-backends=3Dlog"
>> $ export CC=3Dgcc
>> $ ./configure ${CONFIG}
>> C compiler        gcc
>> Host C compiler   cc
>> C++ compiler      c++
>> Objective-C compiler clang
>> CFLAGS            -Wno-maybe-uninitialized -Og -fsanitize=3Daddress -g
>> [...]
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/coroutine-ucontext.o
>> util/coroutine-ucontext.c:36:38: fatal error:
>> sanitizer/asan_interface.h: No such file or directory
>>  #include <sanitizer/asan_interface.h>
>>                                       ^
>> compilation terminated.
>> make: *** [util/coroutine-ucontext.o] Error 1
>>
>> You simply need to update the .travis.yml, but does that mean your
>
> I think we need libgcc-6-dev.
>
>> previous patch "Enable ASAN/UBSan by default if the compiler supports
>> it." isn't correct?
>
> No, the problematic patch is "ucontext: annotate coroutine stack for
> ASAN", it should probably check for asan_interface.h before using it.
>
> Print a warning if it's not there during configure, as ASAN
> experience/reports will be inferior.
>

This should fix it:

(Paolo, would you like me to resend or will you review the diff &
squash? thanks)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index e78eae8766..62fce888fd 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -32,9 +32,11 @@
 #endif

 #if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#if HAVE_ASAN_IFACE_H
 #define CONFIG_ASAN 1
 #include <sanitizer/asan_interface.h>
 #endif
+#endif

 typedef struct {
     Coroutine base;
diff --git a/configure b/configure
index d033286b48..406ccd7cb4 100755
--- a/configure
+++ b/configure
@@ -5185,6 +5185,13 @@ if compile_prog "" "" ; then
     have_utmpx=3Dyes
 fi

+##########################################
+# check for asan header
+have_asan_iface_h=3Dyes
+if ! check_include "sanitizer/asan_interface.h" ; then
+    have_asan_iface_h=3Dno
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -5198,6 +5205,10 @@ elif test "$debug" =3D "yes"; then
   write_c_skeleton;
   if compile_prog "-fsanitize=3Daddress" ""; then
       CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+      if test "$have_asan_iface_h" =3D "no" ; then
+          print_error "ASAN build enabled, but ASAN header missing." \
+                      "Without code annotation, the report may be inferior=
."
+      fi
   fi
   if compile_prog "-fsanitize=3Dundefined" ""; then
       CFLAGS=3D"-fsanitize=3Dundefined $CFLAGS"
@@ -6320,6 +6331,10 @@ if test "$have_utmpx" =3D "yes" ; then
   echo "HAVE_UTMPX=3Dy" >> $config_host_mak
 fi

+if test "$have_asan_iface_h" =3D "yes" ; then
+    echo "HAVE_ASAN_IFACE_H=3Dy" >> $config_host_mak
+fi
+
 if test "$ivshmem" =3D "yes" ; then
   echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
 fi


diff --git a/.travis.yml b/.travis.yml
index f583839755..f2291e87a6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,12 +13,13 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
+      - libgcc-6-dev
       - libgnutls-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
-      - libnfs-dev
       - libncurses5-dev
+      - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
       - libpng12-dev

>
>
>>
>>> +
>>>  typedef struct {
>>>      Coroutine base;
>>>      void *stack;
>>> @@ -59,11 +64,37 @@ union cc_arg {
>>>      int i[2];
>>>  };
>>>
>>> +static void finish_switch_fiber(void *fake_stack_save)
>>> +{
>>> +#ifdef CONFIG_ASAN
>>> +    const void *bottom_old;
>>> +    size_t size_old;
>>> +
>>> +    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &siz=
e_old);
>>> +
>>> +    if (!leader.stack) {
>>> +        leader.stack =3D (void *)bottom_old;
>>> +        leader.stack_size =3D size_old;
>>> +    }
>>> +#endif
>>> +}
>>> +
>>> +static void start_switch_fiber(void **fake_stack_save,
>>> +                               const void *bottom, size_t size)
>>> +{
>>> +#ifdef CONFIG_ASAN
>>> +    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
>>> +#endif
>>> +}
>>> +
>>>  static void coroutine_trampoline(int i0, int i1)
>>>  {
>>>      union cc_arg arg;
>>>      CoroutineUContext *self;
>>>      Coroutine *co;
>>> +    void *fake_stack_save =3D NULL;
>>> +
>>> +    finish_switch_fiber(NULL);
>>>
>>>      arg.i[0] =3D i0;
>>>      arg.i[1] =3D i1;
>>> @@ -72,9 +103,13 @@ static void coroutine_trampoline(int i0, int i1)
>>>
>>>      /* Initialize longjmp environment and switch back the caller */
>>>      if (!sigsetjmp(self->env, 0)) {
>>> +        start_switch_fiber(&fake_stack_save,
>>> +                           leader.stack, leader.stack_size);
>>>          siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
>>>      }
>>>
>>> +    finish_switch_fiber(fake_stack_save);
>>> +
>>>      while (true) {
>>>          co->entry(co->entry_arg);
>>>          qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
>>> @@ -87,6 +122,7 @@ Coroutine *qemu_coroutine_new(void)
>>>      ucontext_t old_uc, uc;
>>>      sigjmp_buf old_env;
>>>      union cc_arg arg =3D {0};
>>> +    void *fake_stack_save =3D NULL;
>>>
>>>      /* The ucontext functions preserve signal masks which incurs a
>>>       * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
>>> @@ -122,8 +158,12 @@ Coroutine *qemu_coroutine_new(void)
>>>
>>>      /* swapcontext() in, siglongjmp() back out */
>>>      if (!sigsetjmp(old_env, 0)) {
>>> +        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size=
);
>>>          swapcontext(&old_uc, &uc);
>>>      }
>>> +
>>> +    finish_switch_fiber(fake_stack_save);
>>> +
>>>      return &co->base;
>>>  }
>>>
>>> @@ -169,13 +209,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine=
 *to_,
>>>      CoroutineUContext *from =3D DO_UPCAST(CoroutineUContext, base, fro=
m_);
>>>      CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, to_);
>>>      int ret;
>>> +    void *fake_stack_save =3D NULL;
>>>
>>>      current =3D to_;
>>>
>>>      ret =3D sigsetjmp(from->env, 0);
>>>      if (ret =3D=3D 0) {
>>> +        start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
>>> +                           NULL : &fake_stack_save, to->stack, to->sta=
ck_size);
>>>          siglongjmp(to->env, action);
>>>      }
>>> +
>>> +    finish_switch_fiber(fake_stack_save);
>>> +
>>>      return ret;
>>>  }
>>>
>>>
>>
>
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
