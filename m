Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTAY1-0001Zd-Ts
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTAXw-0000Zz-UP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTAXw-0000Ze-O6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:26:32 -0400
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6861810e-0546-d1e4-4573-7cdb18696c03@redhat.com>
Date: Thu, 6 Jul 2017 19:26:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 06/07/2017 19:13, Peter Maydell wrote:
> Slightly awkward because owner is an Object but vmstate_register_ram()
> needs a DeviceState. Is this OK, or too much magic?
> 
>     DeviceState *owner_dev;
>     Error *err = NULL;
> 
>     memory_region_init_ram(mr, owner, name, ram_size, &err);
>     if (err) {
>         error_propagate(errp, err);
>         return;
>     }
>     /* Note that owner_dev may be NULL if owner is not a DeviceState;
>      * in that case this is equivalent to calling vmstate_register_ram_global().
>      */
>     owner_dev = object_dynamic_cast(owner, TYPE_DEVICE);
>     vmstate_register_ram(mr, owner_dev);

Maybe, for memory_region_init_ram only, the owner argument can be made a
DeviceState (or NULL)?

Paolo
