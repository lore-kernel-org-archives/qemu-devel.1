Received: from eggs.gnu.org ([2001:4830:134:3::10]:60700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQFM-0005iM-Lt
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQFI-0000u9-BZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:25:36 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQFI-0000sp-3l
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:25:32 -0500
Received: by mail-ot1-x344.google.com with SMTP id v23so11360437otk.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:25:30 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
	<20181210051730.GQ4261@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <051b02d7-0b82-3224-9780-4192ef10b9ba@linaro.org>
Date: Mon, 10 Dec 2018 12:25:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181210051730.GQ4261@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/9/18 11:17 PM, David Gibson wrote:
> On Fri, Dec 07, 2018 at 08:56:30AM +0000, Mark Cave-Ayland wrote:
>> These helpers allow us to move FP register values to/from the specified TCGv_i64
>> argument.
>>
>> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
>> temporaries as required.
> 
> It's not obvious to me why that's a desirable thing.  I'm assuming
> it's somehow necessary for the stuff later in the series, but I think
> we need a brief rationale here to explain why this isn't just adding
> extra reg copies for the sake of it.

Note that while this introduces extra opcodes, in many cases it does not change
the number of machine instructions that are generated.  Recall that accessing
cpu_fpr[N] implies a load from env.  This change makes the load explicit.

The change does currently prevent caching cpu_fpr[N] in a host register.  That
can and will be fixed by optimizing on memory operations instead.  (There is a
patch that has been outstanding for 13 months to do this.  I intend to finally
get around to merging it during the 4.0 cycle.)


r~
