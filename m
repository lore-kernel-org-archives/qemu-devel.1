Received: from eggs.gnu.org ([2001:4830:134:3::10]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jason.vas.dias@gmail.com>) id 1cwrIg-0001II-Gq
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jason.vas.dias@gmail.com>) id 1cwrIf-0006yS-GK
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:25:14 -0400
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jason.vas.dias@gmail.com>)
	id 1cwrIf-0006yD-AH
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:25:13 -0400
Received: by mail-ua0-x231.google.com with SMTP id 49so8460569uau.2
	for <qemu-devel@nongnu.org>; Sat, 08 Apr 2017 07:25:13 -0700 (PDT)
MIME-Version: 1.0
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Sat, 8 Apr 2017 14:25:11 +0000
Message-ID: <CALyZvKyt=dddquvi4exc1vcJ0w=mN4qBb032RWmfER_VDW8hGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] v2.8.1 configure / build fails - just to let you know :
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Good day -

After checking the v2.8.1 GIT tag into $SRC/qemu  and configuring in a
separate $BLD/qemu directory :

  $ $SRC/qemu/configure --prefix=/usr --libdir=/usr/lib64 \
       --sysconfdir=/etc --localstatedir=/var \
       --target-list=x86_64-linux-user,x86_64-softmmu,i386-linux-user,\
i386-softmmu,aarch64-linux-user,aarch64-softmmu \
       2>&1 | tee configure.log

& doing:

$ make -j4 V=1 2>&1 | tee make.log

The build fails for 2 reasons :

1. I had '-std=gnu11' in my $CFLAGS   , while CXXFLAGS contained
'-std=gnu++11'
   (CC was set to 'gcc', while CXX was set to 'g++' - these are both
from GCC 5.4.0
   )  ;
   however, the qemu build scripts incorrectly used $CFLAGS instead of
   $CXXFLAGS, so the build fails without '--disable-werror' because
  '-std=gnu11' applies only to '--lang=c' compiles, not '--lang=c++' compiles -
  there is no way to separately disable this warning (converted to an error).
  Why is qemu's build scripts not using $CXXFLAGS instead of $CFLAGS here ?

2. With --disable-werror added to configure flags to overcome (1) , the build
    fails because 'cpp' gets a '-c' flag .
    No '-c' flag was in any $CFLAGS, $CXXFLAGS, or $CPPFLAGS setting -
    here are the flags settings I used for configure  -
    ( I actually ran 'c_env $SRC/qemu/configure ...') :
    $ c_env "bash -c 'declare -p CFLAGS CPPFLAGS CXXFLAGS'"
declare -x CFLAGS="-std=gnu11 -march=x86-64 -mtune=native -O2 -g -fPIC -pipe"
declare -x CPPFLAGS=""
declare -x CXXFLAGS="-std=gnu++11 -march=x86-64 -mtune=native -O2 -g
-fPIC -pipe"

$ make -j4 V=1
...
cpp -m32 -I/usr/os_src/qemu/tcg -I/usr/os_src/qemu/tcg/i386
-I/usr/os_src/qemu/linux-headers
-I/usr/build/linux/qemu-v2.8.1/linux-headers -I. -I/usr/os_src/qemu
-I/usr/os_src/qemu/include -I/usr/os_src/qemu/pc-bios/optionrom -I.
-I/usr/os_src/qemu -MMD -MP -MT kvmvapic.o -MF ./kvmvapic.d -c -o -
/usr/os_src/qemu/pc-bios/optionrom/kvmvapic.S | as -32 -o kvmvapic.o
cpp: fatal error: '-c' is not a valid option to the preprocessor
compilation terminated.

Now I have to dig out in which Makefile variable that erroneous '-c' is - nice!

notes from the front ... just thought I should let you know!

I don't think these are unreasonable options to be passing to the build.
Maybe the build might succeed if I configured with no *FLAGS settings
at all - but that is not the way autoconf systems are meant to work -
they are meant to honor one's CFLAGS & CXXFLAGS settings,  however
mistaken they may appear to be - that is the user's responsibility! - and use
CFLAGS for C programs, and CXXFLAGS for C++ programs, IMHO .

Thanks & Regards,
Jason
