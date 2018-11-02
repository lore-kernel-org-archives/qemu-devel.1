Received: from eggs.gnu.org ([2001:4830:134:3::10]:59625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIcMa-0005ai-1U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIcMV-000709-Os
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:31:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gIcMQ-0006uG-Au
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:31:52 -0400
References: <20181019165735.22511-1-peter.maydell@linaro.org>
	<20181019165735.22511-40-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f5fc8aec-cbda-33fa-d644-a998177c5aa2@vivier.eu>
Date: Fri, 2 Nov 2018 17:31:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181019165735.22511-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 39/45] target/arm: Reorg NEON VLD/VST all
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 19/10/2018 18:57, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Instead of shifts and masks, use direct loads and stores from the neon
> register file.  Mirror the iteration structure of the ARM pseudocode
> more closely.  Correct the parameters of the VLD2 A2 insn.
> 
> Note that this includes a bugfix for handling of the insn
> "VLD2 (multiple 2-element structures)" -- we were using an
> incorrect stride value.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20181011205206.3552-19-richard.henderson@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 170 ++++++++++++++++++-----------------------
>  1 file changed, 74 insertions(+), 96 deletions(-)
> 

This commit breaks qemu-arm in a debian/stretch/armhf chroot.

When I try to run the ltp-full-20180515 test suite it hangs at the end
of the configuration phase, in config.status:

...
config.status: creating include/mk/config.mk
config.status: creating include/mk/config-openposix.mk
config.status: creating include/mk/features.mk
config.status: creating lib/ltp.pc
config.status: creating m4/Makefile
config.status: creating execltp

# ps -ef|grep qemu
...
root     21961 21959  2 17:16 pts/0    00:00:04 //qemu-arm /bin/bash
./config.status
root     22354 21961 97 17:18 pts/0    00:00:32 //qemu-arm /usr/bin/mawk
-f ./confneVYre/subs.awk

Any idea?

Thanks,
Laurent
