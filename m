Received: from eggs.gnu.org ([2001:4830:134:3::10]:45790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1it-0002jd-9v
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1iq-0001t5-68
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:30:43 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1iq-0001t0-0v
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:30:40 -0400
Received: by mail-qk0-x242.google.com with SMTP id b66-v6so8951711qkj.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:30:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-10-alex.bennee@linaro.org>
	<19661f74-d44b-590f-2226-cdcab27ab82b@amsat.org>
Message-ID: <9c899d98-3ee4-9315-f0d4-92a047bfddd0@amsat.org>
Date: Mon, 2 Jul 2018 13:30:32 -0300
MIME-Version: 1.0
In-Reply-To: <19661f74-d44b-590f-2226-cdcab27ab82b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/20] linux-user: introduce
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: cota@braap.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 07/02/2018 01:22 PM, Philippe Mathieu-Daudé wrote:
> Using:
> 
> 'configure' '--enable-gprof' '--enable-gcov' '--disable-pie' --static
> [...]
> C compiler        gcc-8
> CFLAGS            -fprofile-arcs -ftest-coverage -g -g
> LDFLAGS           -Wl,--warn-common -fprofile-arcs -ftest-coverage -m64
> -static -g
> gprof enabled     yes
> static build      yes
> PIE               no
> gcov              gcov
> gcov enabled      yes
> docker            yes
> 
> I get:
> 
> $ make subdir-ppc-linux-user
> [...]
>   CC      ppc-linux-user/linux-user/exit.o
> linux-user/exit.c: In function ‘preexit_cleanup’:
> linux-user/exit.c:29:9: error: implicit declaration of function
> ‘_mcleanup’ [-Werror=implicit-function-declaration]
>          _mcleanup();
>          ^~~~~~~~~
> linux-user/exit.c:29:9: error: nested extern declaration of ‘_mcleanup’
> [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> make[1]: *** [rules.mak:69: linux-user/exit.o] Error 1
> make: *** [Makefile:481: subdir-ppc-linux-user] Error 2
> 
> I suppose gprof and static builds are exclusive.

I just noticed we don't have --static builds covered by our continuous
integration.
Yet too many matrix cases to cover?
We could ignore it for 'system' builds, but we should enable it for
--linux-user which is used by various distributions for with the binfmt
packages.

Regards,

Phil.
