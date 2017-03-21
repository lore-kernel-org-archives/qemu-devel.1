Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqG12-0007AG-Cn
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqG0z-0002Pp-7W
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:23:44 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:34771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqG0y-0002PI-Vz
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:23:41 -0400
Received: by mail-vk0-x244.google.com with SMTP id y16so5259565vky.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 02:23:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcGRS1BGfjFf2LbHgMRHB-6P9E5i717miuwtT9c1gw9eAw@mail.gmail.com>
References: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
	<20170320135708.GV17887@stefanha-x1.localdomain>
	<CAKPgXcGRS1BGfjFf2LbHgMRHB-6P9E5i717miuwtT9c1gw9eAw@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 21 Mar 2017 11:23:39 +0200
Message-ID: <CAKPgXcG92+2v3pJEGhNYwjPB5+TNJcR=E3FqXnegGjeBkp3d1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Just to make it clear,

Stefan you are going to send a patch right?

On Mon, Mar 20, 2017 at 5:44 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

>
>
> On Mon, Mar 20, 2017 at 3:57 PM, Stefan Hajnoczi <stefanha@gmail.com>
> wrote:
>
>> On Tue, Mar 14, 2017 at 06:51:37PM +0200, Sameeh Jubran wrote:
>> > I am trying to compile qemu-ga for Windows statically using the
>> following
>> > commands:
>> >
>> > ./configure --disable-docs --target-list=x86_64-softmmu
>> > --cross-prefix=x86_64-w64-mingw32- --static --enable-guest-agent-msi
>> > --with-vss-sdk=/path/to/VSSSDK72
>> >
>> > make -j8 qemu-ga
>> >
>> >
>> > And I keep getting this error:
>> >
>> > /home/sameeh/Builds/q/stubs/error-printf.c:7: undefined reference to
>> > `__imp_g_test_config_vars'
>> > collect2: error: ld returned 1 exit status
>> > Makefile:444: recipe for target 'qemu-ga.exe' failed
>> > make: *** [qemu-ga.exe] Error 1
>> >
>> >
>> > Notes to consider:
>> > * without --static I can compile it successfully
>> > * Build machine is running Fedora 25
>> > * I have upgraded all of the tools to their latest version
>> > * If I comment out the function which is causing the issue
>> > (g_test_initialized()), qemu ga compiles statically and runs
>> successfully
>> > without the need of any dlls.
>> >
>> > Can anyone reproduce this? Do you have any idea why is this happening?
>>
>> I guess GLIB_STATIC_COMPILATION is not defined in your build (see the
>> definition of GLIB_VAR in the glib headers).
>>
>> The pkg-config file for glib doesn't define GLIB_STATIC_COMPILATION for
>> pkg-config --static.  I guess we must add it manually.
>>
>> Does this work?
>>
>> diff --git a/configure b/configure
>> index 99d8bec..10f23b7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3047,6 +3047,10 @@ if test "$modules" = yes; then
>>      glib_modules="$glib_modules gmodule-2.0"
>>  fi
>>
>> +if test "$static" = yes; then
>> +    QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
>> +fi
>> +
>>
> Yes! this works thank you =)
>
>>  for i in $glib_modules; do
>>      if $pkg_config --atleast-version=$glib_req_ver $i; then
>>          glib_cflags=$($pkg_config --cflags $i)
>>
>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
