Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cQseM-0001Te-B1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cQseI-0005ie-Ax
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:23:26 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cQseI-0005hq-01
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:23:22 -0500
References: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2451c5eb-4214-6cfd-31ae-bb5247decd8a@vivier.eu>
Date: Tue, 10 Jan 2017 10:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/net/dp8393x: Avoid unintentional sign
 extensions on addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

Le 09/01/2017 à 19:43, Peter Maydell a écrit :
> The dp8393x has several 32-bit values which are formed by concatenating
> two 16 bit device register values. Attempting to do these inline
> with ((s->reg[HI] << 16) | s->reg[LO]) can result in an unintended
> sign extension because "x << 16" is of type 'int' even though s->reg
> is unsigned, and so if the expression is used in a context where
> it is cast to uint64_t the value is incorrectly sign-extended.
> Fix this by using accessor functions with a uint32_t return type;
> this also makes the code a bit easier to read.
> 
> This should fix Coverity issues 1307765, 1307766, 1307767, 1307768.
> 
> (To avoid having a ctda read function only used in a DPRINTF,
> we move the DPRINTF down slightly so it can use the ttda function.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

FWIW, I've tested a port of this patch with Quadra 800 emulation, and it
works:

Tested-by: Laurent Vivier <laurent@vivier.eu>

Laurent
