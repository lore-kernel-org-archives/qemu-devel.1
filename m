Received: from eggs.gnu.org ([2001:4830:134:3::10]:51888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK4Et-0000Lh-Qg
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK4Es-0004ac-Ti
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:20:59 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cK4Es-0004aS-Nf
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:20:58 -0500
Received: by mail-oi0-x243.google.com with SMTP id f201so32700443oib.0
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 06:20:58 -0800 (PST)
Reply-To: minyard@acm.org
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <84800dca-907f-453b-c693-8ebf3d7b1e59@gmail.com>
Date: Thu, 22 Dec 2016 08:20:55 -0600
MIME-Version: 1.0
In-Reply-To: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1651167] [NEW] hw/ipmi/isa_ipmi_bt.c:283:
 suspect use of macro ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org

On 12/19/2016 09:47 AM, dcb wrote:
> Public bug reported:
>
> I just had a go at compiling qemu trunk with
> llvm trunk. It said:
>
> hw/ipmi/isa_ipmi_bt.c:283:31: warning: logical not is only applied to
> the left hand side of this bitwise operator [-Wlogical-not-parentheses]
>
> Source code is
>
>             IPMI_BT_SET_HBUSY(ib->control_reg,
>                                !IPMI_BT_GET_HBUSY(ib->control_reg));
>
> That use of ! causes trouble. The SET and GET
> macros are defined as:
>
> #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
> #define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
>                                         (((v & 1) << IPMI_BT_HBUSY_BIT)))
>
> I can make the compiler shut up by adding extra () in the last
> use of v in the SET macro, like this:
>
> #define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
>                                         ((((v) & 1) << IPMI_BT_HBUSY_BIT)))
>
> I think this is standard good practice when using macro parameters
> anyway.

Yeah, that's the way things are supposed to be done.  I'll get a patch 
out on this.
There were a bunch of them.

Thanks,

-corey

>
> ** Affects: qemu
>       Importance: Undecided
>           Status: New
>
