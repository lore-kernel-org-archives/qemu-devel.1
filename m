Received: from eggs.gnu.org ([209.51.188.92]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1tMj-0002O8-NF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1tMi-0004ds-SR
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:47:17 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1tMi-0004cs-9v
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:47:16 -0500
Received: by mail-wm1-f54.google.com with SMTP id g20so9211667wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:47:15 -0800 (PST)
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-nGLVySjjK65Bfedr5H-6XP1_t1rpnupjL89KB-HN8wQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <646bf94e-66da-5083-d2b7-b96633bb5acf@redhat.com>
Date: Thu, 7 Mar 2019 14:47:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nGLVySjjK65Bfedr5H-6XP1_t1rpnupjL89KB-HN8wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3/7/19 2:25 PM, Peter Maydell wrote:
> On Mon, 4 Mar 2019 at 19:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 1ba530a4ecba6015d52d8f392fd327cfa07bc37a:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190304' into staging (2019-03-04 13:38:54 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>>
>> for you to fetch changes up to b1d8b9a6cc37e33dde1873379174de78957830ca:
>>
>>   kconfig: add documentation (2019-03-04 19:09:35 +0100)
>>
>> ----------------------------------------------------------------
>> Initial Kconfig work, excluding ARM and MIPS
> 
> Build failure for the Windows builds:
> 
> In file included from /home/petmay01/qemu-for-merges/hw/tpm/tpm_emulator.c:37:0:
> /home/petmay01/qemu-for-merges/hw/tpm/tpm_ioctl.h:11:21: fatal error:
> sys/uio.h: No such file or directory
> 
> I'm not sure what's happened here. It looks like the Kconfig machinery
> is putting CONFIG_TPM_EMULATOR in build/x86-64-softmmu/config-devices.mak,
> but configure is trying to put it into config-host.mak. The configure
> code is where the "don't do TPM on windows" check is, but the Kconfig
> entry in config-devices.mak overrides that and tries to build this
> code on Windows anyway.

Paolo, we might need:

-- >8 --
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,7 @@ MINIKCONF_ARGS = \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
     CONFIG_TPM=$(CONFIG_TPM) \
+    CONFIG_TPM_EMULATOR=$(CONFIG_TPM_EMULATOR) \
     CONFIG_XEN=$(CONFIG_XEN) \
     CONFIG_OPENGL=$(CONFIG_OPENGL) \
     CONFIG_X11=$(CONFIG_X11) \
---

I'm not sure about CONFIG_TPM_PASSTHROUGH.

> 
> All the other builds seemed to run ok (I'm just rerunning one lot
> which failed due to an issue on my end; will follow up if there's
> any failure there).
> 
> thanks
> -- PMM
> 
