Received: from eggs.gnu.org ([2001:4830:134:3::10]:53463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg9yq-0001Xf-6C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg9yo-0005CG-SQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:55:44 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg9yo-0005Bw-IV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:55:42 -0500
Received: by mail-wr0-x230.google.com with SMTP id z61so81304112wrc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 04:55:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221134416.5803b3e5@nial.brq.redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
	<20170221134416.5803b3e5@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 12:55:20 +0000
Message-ID: <CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@gmail.com>

On 21 February 2017 at 12:44, Igor Mammedov <imammedo@redhat.com> wrote:
> If we are to ditch legacy approach,
> It would be cleaner for SoC to have fixed/unconfigurable
> CPU type and each SoC being modeled as a separate
> QOM object/type that would instantiate CPU directly
> with QOM style, using type name, like:
>
>     cpu = object_new(TYPE_FOO_CPU)
>     set props if necessary
>     object_property_set_bool(cpu, true, "realized", &err)
>     object_unref(cpu)
>
> or similar with extra check/logic on top of plain object_new()
>
>     prepare cpu_opts for cpu type TYPE_FOO_CPU
>     cpu = qdev_device_add(cpu_opts)
>     object_unref(cpu)
>
> instead of using cpu_init/cpu_foo_init/cpu_generic_init()
> with cpu_model parsing logic which is not really needed
> there as concrete SoC model knows exact CPU type.

Mmm, I think that's probably best. Would the end-user
still be able to set CPU properties if necessary via
a -global command line switch (since -cpu type,foo=on
wouldn't work)?

(I just worry slightly that we might have users doing
weird things which we'd break.)

thanks
-- PMM
