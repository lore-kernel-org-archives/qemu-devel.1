Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD5J8-0003zv-5A
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD5J4-0004TB-4d
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD5J3-0004R8-SH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:13:30 -0400
References: <201810181603210927379@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99cf25d1-3a3a-085e-8012-0a3fd8914779@redhat.com>
Date: Thu, 18 Oct 2018 12:13:20 +0200
MIME-Version: 1.0
In-Reply-To: <201810181603210927379@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 3/5] target-i386: add rtc 0x70 port as
 coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On 18/10/2018 10:03, peng.hao2@zte.com.cn wrote:
>>> +    /* register rtc 0x70 port as coalesced_pio */
>>> +    memory_region_set_flush_coalesced(&s->io);
>>> +    memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
>>> +                          s, "rtc1", 1);
>>> +    isa_register_ioport(isadev, &s->coalesced_io, base);
>> I think instead of isa_register_ioport you can use
>> memory_region_add_subregion, so that s->coalesced_io is added below s->io?
>>
> isa_register_ioport also called memory_region_add_subregion.
> modify code  like this:
>   //isa_register_ioport(isadev, &s->coalesced_io, base);
>     memory_region_add_subregion(get_system_io(),0x70,&s->coalesced_io);
> The regional distribution before and after code modification is consistent.

Right, but I'd rather add s->coalesced_io subregion as a subregion of
s->io at offset 0.

Paolo

>    0000000000000070-0000000000000070 (prio 0, i/o): rtc1
>     0000000000000070-0000000000000071 (prio 0, i/o): rtc
