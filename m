Received: from eggs.gnu.org ([2001:4830:134:3::10]:49239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csyLp-0001xS-Je
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csyLo-00039U-KW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:08:25 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csyLo-00038x-Dr
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:08:24 -0400
Received: by mail-wr0-x22e.google.com with SMTP id u1so115222429wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 14:08:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f39p4lv.fsf@secure.mitica>
References: <1490608126-22187-1-git-send-email-eric.auger@redhat.com>
	<1490608126-22187-3-git-send-email-eric.auger@redhat.com>
	<877f39p4lv.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 22:08:02 +0100
Message-ID: <CAFEAcA9YFWu+ZsNZWEHVgFuMOmW2tx2Hm5ewsrZ537DbySJ_hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v3 2/3] hw/intc/arm_gicv3_its: Implement
 state save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar,
	Vijaya" <Vijaya.Kumar@cavium.com>, Andrew Jones <drjones@redhat.com>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 28 March 2017 at 20:45, Juan Quintela <quintela@redhat.com> wrote:
> Let me see if I understood this correctly.
>
> We have an ARM_GICV3_ITS_COMMON.  And that has some fields.
> In particular:
>
> struct GICv3ITSState {
>     /* Registers */
>     uint32_t ctlr;
>     uint64_t cbaser;
>     uint64_t cwriter;
>     uint64_t creadr;
>     uint64_t baser[8];
>     /* lots of things removed */
> };
>
>
>
> We have this in arm_gicv3_its_common.c  (it is exactly the same for
> post_load, so we forgot about it by now).
>
>
> static void gicv3_its_pre_save(void *opaque)
> {
>     GICv3ITSState *s = (GICv3ITSState *)opaque; (*)
>                                                    /* nitpit: the cast
>                                                    is useless */
>     GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
>
>     if (c->pre_save) {
>         c->pre_save(s);
>     }
> }
>
> And then we have in the patch:
>
>
>> @@ -109,6 +203,8 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
>>
>>      dc->realize = kvm_arm_its_realize;
>>      icc->send_msi = kvm_its_send_msi;
>> +    icc->pre_save = kvm_arm_its_pre_save;
>> +    icc->post_load = kvm_arm_its_post_load;
>>  }
>
>
> struct GICv3ITSCommonClass {
> ....
>     void (*pre_save)(GICv3ITSState *s);
>     void (*post_load)(GICv3ITSState *s);
> };
>
>
> Notice that I have only found one user of this on the tree, so I don't
> know if there is a good reason for this.

This is just following the existing pattern we have for
the GICv3 itself (and the GICv2, for that matter).
At some point we'll implement the emulated ITS which
will share the base class (and the vmstate).

thanks
-- PMM
