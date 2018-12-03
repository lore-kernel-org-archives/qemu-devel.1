Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gTvRF-0001dl-7N
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gTvR9-0002uO-Ei
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:07:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gTvR9-0002jA-3k
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:07:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BC0F7F6A8
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 21:07:18 +0000 (UTC)
References: <20181126225620.5301-1-ehabkost@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <790ea478-b4b0-32a9-a83e-a884a20dc1bc@redhat.com>
Date: Mon, 3 Dec 2018 19:07:10 -0200
MIME-Version: 1.0
In-Reply-To: <20181126225620.5301-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] apic: Make APIC ID limit error message
 clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


On 11/26/2018 08:56 PM, Eduardo Habkost wrote:
> Remove the "apic initialization failed" prefix (it conveys no
> useful information), replace "invalid" with "too large", and add
> an error hint with two possible solutions for the problem.
>
> Before:
>
>    $ qemu-system-x86_64 -machine q35 -smp 256
>    qemu-system-x86_64: apic initialization failed. APIC ID 255 is invalid
>
> After:
>
>    $ qemu-system-x86_64 -machine q35 -smp 256 -display none
>    qemu-system-x86_64: APIC ID 255 is too large

I would keep the problem "apic initialization failed" sentence. "APIC ID 
255 is too large" is just the cause.

>    Possible solutions:
>    * Lowering the number of VCPUs on the -smp option
>    * Using accel=kvm,kernel-irqchip=on or accel=kvm,kernel-irqchip=split
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I'm not sure this is the best way to provide usage hints to the
> user.  Any suggestions?

As a noob, I can testify that this kind of suggestion is very useful 
although there seems to not have many on QEMU. On the other hand, I 
understand it can make qemu verbose and so annoy people. Thus, maybe 
those suggestions could be enabled/disabled via options (e.g. -show-hints)?

- Wainer

> ---
>   hw/intc/apic.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index 97ffdd820f..f08006334d 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -886,8 +886,11 @@ static void apic_realize(DeviceState *dev, Error **errp)
>       APICCommonState *s = APIC(dev);
>   
>       if (s->id >= MAX_APICS) {
> -        error_setg(errp, "%s initialization failed. APIC ID %d is invalid",
> -                   object_get_typename(OBJECT(dev)), s->id);
> +        error_setg(errp, "APIC ID %d is too large", s->id);
> +        error_append_hint(errp,
> +            "Possible solutions:\n"
> +            "* Lowering the number of VCPUs on the -smp option\n"
> +            "* Using accel=kvm,kernel-irqchip=on or accel=kvm,kernel-irqchip=split\n");
>           return;
>       }
>   
