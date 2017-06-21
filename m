Received: from eggs.gnu.org ([2001:4830:134:3::10]:32793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNoC7-0005xb-T2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNoC3-00019x-R2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:33:51 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNoC3-00019l-LY
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:33:47 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so5274679qte.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:33:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-2-git-send-email-yang.zhong@intel.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a435f804-3659-9d4f-5a24-c22a9c13fcf4@twiddle.net>
Date: Wed, 21 Jun 2017 15:33:43 -0700
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-2-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] configure: add the disable-tcg option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 06/21/2017 03:19 AM, Yang Zhong wrote:
> +case "$target_name" in
> +  alpha|arm|armeb|aarch64|cris|hppa|lm32|m68k|microblaze|microblazeel|mips|mipsel| \
> +  mipsn32|mipsn32el|mips64|mips64el|moxie|nios2|or1k|ppc|ppcemb|ppc64|ppc64le|ppc64abi32| \
> +  sh4|sh4eb|sparc|sparc64|sparc32plus|s390x|tilegx|tricore|unicore32|xtensa|xtensaeb)
> +  if test "$target_softmmu" = "yes" ; then
> +    echo "CONFIG_TCG=y" >> $config_target_mak
> +  fi
> +  ;;
> +esac
> +case "$target_name" in
> +  i386|x86_64)
> +  if test "$tcg" = "yes" -a "$target_softmmu" = "yes" ; then
> +    echo "CONFIG_TCG=y" >> $config_target_mak
> +  fi
> +  ;;
> +esac

This is definitely the wrong way around.  Test for the thing you want to 
special case -- x86, when running on x86, and softmmu -- and then everything 
else via *.

I strongly suspect this test should be

   case "$cpu-$target-$tcg" in
   x86_64-i386-softmmu-no | x86_64-x86_64-softmmu-no)
     # CONFIG_TCG disabled.
     ;;
   *)
     echo "CONFIG_TCG=y" >> $config_target_mak
   esac

This is easily extendable to allow TCG to be disabled for other KVM hosts.


r~
