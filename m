Received: from eggs.gnu.org ([2001:4830:134:3::10]:56451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywHC-0006Fn-18
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywH7-0007aw-2h
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:12:49 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eywH6-0007ah-SS
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:12:45 -0400
Received: by mail-wr0-f171.google.com with SMTP id f14so7867275wre.8
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 02:12:44 -0700 (PDT)
References: <dca9a53.33fd5.1624c84a277.Coremail.suhang16@mails.ucas.ac.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e75a8366-3a44-6e2d-fc95-f5c795991013@redhat.com>
Date: Thu, 22 Mar 2018 10:12:41 +0100
MIME-Version: 1.0
In-Reply-To: <dca9a53.33fd5.1624c84a277.Coremail.suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Should we check arguments for function `from_bcd`
 and `to_bcd`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 22/03/2018 08:03, Su Hang wrote:
> When I was reading 'qemu/hw/timer/m48t59.c'(Line:328) and run with
> `make check-qtest-ppc`,
> I found when write an invalid value 0xc to address 0x1FFF,
> `from_bcd` return 12 instead of raising an exception(or error).

Each device probably has a different behavior when a wrong value is
written to a register that expects valid BCD.  Therefore, if you want to
model that, you have to fix it in hw/timer/m48t59.c, not in from_bcd and
to_bcd.

However, note that anything that the guest does should never cause an
assertion.

Thanks,

Paolo

> """(qemu/hw/timer/m48t59.c)
>     case 0x1FFF:
>     case 0x07FF:
>         /* year */
>     tmp = from_bcd(val);
>     if (tmp >= 0 && tmp <= 99) {
> """
> 
> 
> """(qemu/include/qemu/bcd.h)
> /* Convert a byte between binary and BCD.  */
> static inline uint8_t to_bcd(uint8_t val)
> {
>     return ((val / 10) << 4) | (val % 10);
> }
> 
> static inline uint8_t from_bcd(uint8_t val)
> {
>     return ((val >> 4) * 10) + (val & 0x0f);
> }
> """
> 
> Su Hang
> 
