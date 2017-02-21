Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgAvG-00089m-J1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgAvF-0002vN-Lr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:56:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
	<20170221134416.5803b3e5@nial.brq.redhat.com>
	<CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
Date: Tue, 21 Feb 2017 14:56:00 +0100
In-Reply-To: <CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 21 Feb 2017 12:55:20 +0000")
Message-ID: <87poibr6kv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 21 February 2017 at 12:44, Igor Mammedov <imammedo@redhat.com> wrote:
>> If we are to ditch legacy approach,
>> It would be cleaner for SoC to have fixed/unconfigurable
>> CPU type and each SoC being modeled as a separate
>> QOM object/type that would instantiate CPU directly
>> with QOM style, using type name, like:
>>
>>     cpu = object_new(TYPE_FOO_CPU)
>>     set props if necessary
>>     object_property_set_bool(cpu, true, "realized", &err)
>>     object_unref(cpu)
>>
>> or similar with extra check/logic on top of plain object_new()
>>
>>     prepare cpu_opts for cpu type TYPE_FOO_CPU
>>     cpu = qdev_device_add(cpu_opts)
>>     object_unref(cpu)
>>
>> instead of using cpu_init/cpu_foo_init/cpu_generic_init()
>> with cpu_model parsing logic which is not really needed
>> there as concrete SoC model knows exact CPU type.
>
> Mmm, I think that's probably best. Would the end-user
> still be able to set CPU properties if necessary via
> a -global command line switch (since -cpu type,foo=on
> wouldn't work)?

-global is a qdev thing.  It affects only instances of TYPE_DEVICE and
its subtypes.  Since TYPE_CPU is one...

> (I just worry slightly that we might have users doing
> weird things which we'd break.)

I suspect we'd hand out a foot or two of extra rope, in addition to the
miles our users already got.
