Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIB3a-0004sq-6A
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIB3Z-0003QH-3b
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:45:46 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bru.dominguez@gmail.com>)
	id 1dIB3Y-0003Q7-TI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:45:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id x3so6791830wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 02:45:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606092831.GA8013@stefanha-x1.localdomain>
References: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
	<20170606092831.GA8013@stefanha-x1.localdomain>
From: Bruno Dominguez <bru.dominguez@gmail.com>
Date: Tue, 6 Jun 2017 10:45:43 +0100
Message-ID: <CALfaEa0T+rcZjmehm=Rdr+NOApTOKsizpCWcQ6ssErhU=nuUTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

2017-06-06 10:28 GMT+01:00 Stefan Hajnoczi <stefanha@gmail.com>:
> On Fri, Jun 02, 2017 at 02:07:26PM +0100, Bruno Dominguez wrote:
>> There was no possibility to add specific cxx flags using the configure
>> file. So A new entrance has been created to support it.
>>
>> Duplication of information in configure and rules.mak. Taking
>> QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
>> QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
>> it.
>>
>> The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
>> QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
>> adding them where it should be.
>>
>> -----
>> Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
>> -----
>
> Please follow the code submission guidelines:
> http://wiki.qemu.org/Contribute/SubmitAPatch
>
>  * The commit message (email subject) should have a prefix describing
>    the affected component.  Use "git log ./configure" for inspiration.
>    I suggest the following:
>
>      configure: split c and cxx extra flags
>
>  * Use git-format-patch(1) so that your patch applies cleanly.  Your
>    email has:
>
>    ----
>    Signed-off-by: ...
>    ----
>
>    This is not the format recognized by tools.  Instead the
>    Signed-off-by: should be part of the commit description (no '----')
>    and then a line with just three hyphens ('---') denotes the end of
>    the commit description:
>
>    Signed-off-by: ...
>    ---
>
>  * The email must not be line-wrapped since that breaks the patch.  If
>    you use git-send-email(1) to submit patches then this is taken care
>    of automatically.
>

ok, will give it another go.

>> @@ -1304,6 +1312,7 @@ Advanced options (experts only):
>>    --cxx=CXX                use C++ compiler CXX [$cxx]
>>    --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
>>    --extra-cflags=CFLAGS    append extra C compiler flags QEMU_CFLAGS
>> +  --extra-cxxflags=CXXFLAGS append extra CXX compiler flags QEMU_CXXFLAGS
>
> For consistency with the --cxx= option description:
>
> s/CXX compiler/C++ compiler/
>

will do.

>> @@ -1489,37 +1498,6 @@ if test "$bogus_os" = "yes"; then
>>      error_exit "Unrecognized host OS $targetos"
>>  fi
>>
>> -# Check that the C++ compiler exists and works with the C compiler
>> -if has $cxx; then
>> -    cat > $TMPC <<EOF
>> -int c_function(void);
>> -int main(void) { return c_function(); }
>> -EOF
>> -
>> -    compile_object
>> -
>> -    cat > $TMPCXX <<EOF
>> -extern "C" {
>> -   int c_function(void);
>> -}
>> -int c_function(void) { return 42; }
>> -EOF
>> -
>> -    update_cxxflags
>> -
>> -    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
>> -        # C++ compiler $cxx works ok with C compiler $cc
>> -        :
>> -    else
>> -        echo "C++ compiler $cxx does not work with C compiler $cc"
>> -        echo "Disabling C++ specific optional code"
>> -        cxx=
>> -    fi
>> -else
>> -    echo "No C++ compiler available; disabling C++ specific optional code"
>> -    cxx=
>> -fi
>> -
>
> Why move this code?
>

the configure file adds "-fPIE -DPIE" to QEMU_CFLAGS around line 1570.
Where QEMU_CXXFLAGS is placed is not taken it, hence this flag is not
tested with the c++ compiler and breaks the build later on for not
existing. Because QEMU_CXXFLAGS was reassigned again in rules.mak this
was hidden.
