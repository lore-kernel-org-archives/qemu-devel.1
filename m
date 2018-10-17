Received: from eggs.gnu.org ([2001:4830:134:3::10]:34075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCj7I-0008CS-DC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCj7E-0001JI-DM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCj7E-0001Ij-3A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:31:48 -0400
References: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
	<1539795177-21038-4-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32bbd4a7-94eb-1f0a-7f2f-d59d5e47dda6@redhat.com>
Date: Wed, 17 Oct 2018 12:31:39 +0200
MIME-Version: 1.0
In-Reply-To: <1539795177-21038-4-git-send-email-peng.hao2@zte.com.cn>
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
To: Peng Hao <peng.hao2@zte.com.cn>, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On 17/10/2018 18:52, Peng Hao wrote:
> +    /* register rtc 0x70 port as coalesced_pio */
> +    memory_region_set_flush_coalesced(&s->io);
> +    memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
> +                          s, "rtc1", 1);
> +    isa_register_ioport(isadev, &s->coalesced_io, base);

I think instead of isa_register_ioport you can use
memory_region_add_subregion, so that s->coalesced_io is added below s->io?

This way, you don't rely on the behavior of overlapping regions.

Paolo

> +    memory_region_add_coalescing(&s->coalesced_io, 0, 1);
> +
