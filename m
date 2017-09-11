Received: from eggs.gnu.org ([2001:4830:134:3::10]:59182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drNHC-0002aa-BN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drNH9-00070i-Lr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drNH9-0006zy-G3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:53:15 -0400
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<CAFEAcA9oOmX1u2zYHJ28AYFDUXVUs=8i04fC05TsxopbvxPmBQ@mail.gmail.com>
	<afe815b5-d5a6-8b22-b30f-50f52dbe540e@redhat.com>
	<20170911135129.365b3cdf.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <881f38b7-0c5c-74aa-2bd5-912a6cfb14d0@redhat.com>
Date: Mon, 11 Sep 2017 13:53:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170911135129.365b3cdf.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/09/2017 13:51, Cornelia Huck wrote:
> On Mon, 11 Sep 2017 13:48:46 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 06/09/2017 16:35, Peter Maydell wrote:
>>>>>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
>>>>>      if (accel == NULL) {
>>>>> -        /* Use the default "accelerator", tcg */
>>>>> -        accel = "tcg";
>>>>> +        accel = default_accelerator();  
>>>> It actually may be easier to just switch the default to
>>>> "tcg:kvm:xen:hax". Haven't tested that, though.  
>>> Does it make sense to include Xen in the default list?
>>> I don't know much about Xen but I was under the impression
>>> that it's a special purpose thing that you can only use
>>> as part of a Xen setup, whereas tcg, kvm, hax are all
>>> more-or-less interchangeable ways to run a VM under a
>>> Linux/etc host. Do I have the wrong end of the Xen stick?  
>>
>> Yes, that is correct (in fact, -xen-domid is required too).
> 
> OK, so we should use "tcg:kvm:hax"?
> 
> (Not sure how useful the hax statement is, I'm not familiar with that
> one.)

Yes.  When we move KVM to the front, however, HAX and the upcoming HVF
accelerator probably should stay in the back because they are less
tested than TCG (e.g. HAX doesn't support -cpu, HVF will not support
live migration in the first iteration, etc.).

Paolo
