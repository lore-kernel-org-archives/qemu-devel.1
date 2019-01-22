Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gm12s-0002pZ-0H
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gm12o-0003wF-5E
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gm12l-0003ri-TZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:05 -0500
Date: Tue, 22 Jan 2019 18:08:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190122180828.GB2241@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110201124.GJ2589@work-vm>
	<2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
	<20190111200943.GJ2738@work-vm>
	<3429361548079742@iva8-f16495710718.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3429361548079742@iva8-f16495710718.qloud-c.yandex.net>
Subject: Re: [Qemu-devel] [PATCH 0/4] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>, "clg@kaod.org" <clg@kaod.org>, jiangshanlai@gmail.com

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi,
> 
> Just want to clarify your suggestions.
> 
> 1) migrate=off/share=on
> 
> I'm not sure that adding new flag 'migrate=off' is a good idea. I think that
> share=on as you suggested at first is enough.
> * It's a new flag which has sense only with share=on
> * It seems to that the meaning of this flag isn't clear. migrate=off isn't
>   RAM_MIGRATABLE, it's rather RAM_IGNORABLE. I.e. it means that we don't migrate
>   such block only if the capability is enabled.
> If you don't mind, I'll prefer share=on and ignore-shared capability.

Yes, I'm OK with that, just check with Lai Jiangshan (cc'd) that it
meets their requirement as well.

> 2) Keep RAM migration version
> 
> It's more complicated question. To validate GPAs for ignored blocks I have to
> change the stream format. I can do this conditionally (if (cap_enabled) { ... })
> but in this case, I want to make sure that the capability is enabled or disabled
> on both source and target. Otherwise, there is an undefined behavior on the
> target side (most likely some error during deserialization).
> To fix that I can add a capability validation feature.
> 
> For example, add a new section to vmstate_configuration (not complete):
> +static const VMStateDescription vmstate_capabilites = {
> +    .name = "configuration/capabilities",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_capabilites_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_V(caps_count, SaveState, 1),
> +        VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count, 1,
> +                                    vmstate_info_bool, bool),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_configuration = {
>      .name = "configuration",
>      .version_id = 1,
> @@ -404,6 +456,7 @@ static const VMStateDescription vmstate_configuration = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_target_page_bits,
> +        &vmstate_capabilites,
>          NULL
>      }
>  };
> 
> It seems too complicated. If I should change the migration stream anyway, maybe
> it's better to increment the version?
> 
> What do you think?

Never break compatibility!

There's three separate things here:
  a) Skipping the shared blocks
  b) Adding a check that skipped blocks actually match
  c) Adding a check for matching capabilities

Lets solve them separately.

I think (a) we've discussed.
(b) If you only enable the checking when your ignore-shared is enabled
then it doesn't break any compatibility.  But watch out, if they're
skipped for some other reason then you might not want to check them;
for example some of the things Peter Maydell was talking about for ARM
was that the block may or may not be present, so there's no requirement
it's on the destination.

(c) That's a nice to have; you'd have to create a list of capabilities
you care about including; if they're only new capabilities then you
can just enable the fields when any are set and it doesn't break old
things; if you want to include some other capabilities then tie
it to the machine type and it wont break old setups.

Dave

> Regards,
> Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
