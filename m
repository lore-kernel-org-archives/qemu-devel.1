Received: from eggs.gnu.org ([2001:4830:134:3::10]:51048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f144c-00005Q-Jp
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f144X-0006b5-Us
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:56:38 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f144X-0006al-Ok
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:56:33 -0400
Received: by mail-ot0-x242.google.com with SMTP id m22-v6so1396678otf.10
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 22:56:33 -0700 (PDT)
References: <20180323225739.17329-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dc14f68-5275-6ab6-20dd-4e6dd74a02a4@linaro.org>
Date: Wed, 28 Mar 2018 13:56:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 00/20] linux-user: move arch
 specific parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org

On 03/24/2018 06:57 AM, Laurent Vivier wrote:
> Some files like signal.c are really hard to read
> because all architectures are mixed in the same
> file.
> 
> This series moves from signal.c these parts to
> the architecture dedicated directories in linux-user.
> Moreover, this allows to compare easier functions
> between architectures (it helps to debug problems).
> Adding new functions for a new architecture will
> be facilitated too.
> 
> checkpatch.pl is not happy... but I only want to
> move code from a file to another. I don't want
> to change the content of the parts I move.
> 
> v2:
>   - only move parts from signal.c
>   - link them instead of including them
>   - one patch by architecture
>   - add a first patch to prepare the change.
> 
> The first patch adds signal-common.h to define
> what is needed by the signal.c of the architectures.
> It adds a "do-nothing" signal.c in each arch
> directory and the rule needed to build them
> in Makefile.objs.
> 
> Then the process is simple...
> 
> for each architecture:
>   - copy the arch specific code from signal.c
>     to <arch>/signal.c
>   - add includes (including signal-common.h)
>   - export setup_rt_frame() and setup_frame()
>     (remove static in <arch>/signal.c,
>      add the declaration in <arch>/target_signal.h)
> 
> When the arch has 32bit and 64bit architectures,
> it's a little bit more complicated:
>   - ppc/ppc64: nothing special to do, all is in ppc/,
>     there is no ppc64 directory,
>   - arm/aarch64: one file for arm, one file for aarch64
>   - i386/x86_64, sparc/sparc64, mips/mips64:
>     update each target_signal.h,
>     include the 32bit signal.c file into the 64bit signal.c file
>     to avoid to duplicate code (and add a guard to not include
>     the 32bit target_signal.h)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
