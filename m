Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIE79-00058B-25
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIE0s-0002F7-8F
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:32:01 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIE0s-0002Ev-1c
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:31:58 -0400
Received: by mail-wr1-f44.google.com with SMTP id z16-v6so2403207wrv.2
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 07:31:57 -0700 (PDT)
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>
Date: Thu, 1 Nov 2018 15:31:54 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fredrik Noring <noring@nocrew.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Cc'ing Fredrik.

On 1/11/18 12:06, Aleksandar Markovic wrote:
> Hi, Fridrik,
> 
> I did some closer code inspection of R5900 in last few days, and I noticed some sub-optimal implementation in the area where R5900-specific opcodes overlap with the rest-of-MIPS-CPUs opcodes.
> 
> The right implementation should be based on the principle that all such cases are covered with if statements involving INSN_R5900 flag, like this:
> 
>          if (ctx->insn_flags & INSN_R5900) {
>              <R5900-specific handling>
>          } else {
>              <rest-of-MIPS-handling>
>          }
> 
> You followed that principle for OPC_SPECIAL2 and OPC_SPECIAL3, but for some other opcodes not. For example, there are lines:
> 
>      if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
>                       opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
> 
> or
> 
>       switch (opc) {
>       case OPC_MFHI:
>       case TX79_MMI_MFHI1:
> 
> Such implementation makes it difficult to discern R5900 and non-R5900 cases. Potentialy allows bugs to sneak in and affect non-R5900 support.
> 
> The correction is not that difficult, I gather. Worse comme to worst, you can remove R5900 MFLO1 and MFHI1 altogether, they are not that essential at this moment, but do try correcting the decoding stuff as I described. Can you please make these changes in next few days or so (given that 3.1 release is getting closer and closer), and send them to the list?
> 
> It is my bad that I didn't spot this during review, but in any case, I think this should be fixed in 3.1 to make sure that non-R5900 functionalities are intact.
> 
> Thanks,
> Aleksandar
> 
> 
