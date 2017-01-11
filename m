Received: from eggs.gnu.org ([2001:4830:134:3::10]:57452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR9Ec-0001gu-Aj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR9EY-0007Xk-Bd
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cR9EY-0007XC-69
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:05:54 -0500
References: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6125614-cdd3-bacf-b0ff-786eec007baa@redhat.com>
Date: Wed, 11 Jan 2017 11:05:40 +0800
MIME-Version: 1.0
In-Reply-To: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>



On 2017=E5=B9=B401=E6=9C=8810=E6=97=A5 02:43, Peter Maydell wrote:
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
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Disclaimer: only compile tested as this device only exists on
> the MIPS magnum/pica61 boards and I don't have an image for them.

Applied to -net.

Thanks
