Received: from eggs.gnu.org ([2001:4830:134:3::10]:49600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEjZ-0003sk-06
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEjX-0007bC-Ob
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:00:17 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgEjX-0007aB-J4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:00:15 -0500
Received: by mail-wr0-x229.google.com with SMTP id 97so8446067wrb.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:00:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6959c545-4b6e-423b-45f2-8e0683b08ce2@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
	<20170221134416.5803b3e5@nial.brq.redhat.com>
	<CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
	<87poibr6kv.fsf@dusky.pond.sub.org>
	<CAFEAcA-75VPiOzPauZO4ukYVYWffB1cu1-tsQs6Hs8m8Vf41OQ@mail.gmail.com>
	<6959c545-4b6e-423b-45f2-8e0683b08ce2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 17:59:53 +0000
Message-ID: <CAFEAcA8wJWXUJg1PC6rwVVuUsR7VPXwueMkyL4U_SxRSRqz3Kw@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 21 February 2017 at 16:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/02/2017 14:57, Peter Maydell wrote:
>>> -global is a qdev thing.
>> ...which reminds me to ask: is there any hope for unifying
>> our properties so we don't have both "qdev properties" and
>> "qom properties" or are we doomed to two distinct sets of
>> APIs forever?
>
> We already have one set of property APIs in some sense.  qdev properties
> *are* QOM properties; you visit them with object_property_foreach and so on.
>
> The extensions that qdev adds, and are exclusive to qdev properties, are
> the following:
>
> - defining properties via DEFINE_PROPERTY_* (qdev_property_add_static etc.)
>
> - defining default values with -global (global_props and a handful of
> functions that use it).

...I didn't realize -global only worked on qdev properties.
That's kind of awkward (but then -global syntax is awkward
in any case). What's the QOM equivalent?

> - providing alternative human-readable formatting for info qtree
> (qdev_property_add_legacy)

There's also a distinct set of functions for setting them:
qdev_prop_set_uint32() vs object_property_set_int(), etc.
These seem to be sometimes just wrappers (eg set_uint32), sometimes
wrappers with a little convenience functionality (eg set_macaddr),
and sometimes doing something more complex (eg set_enum, set_ptr).

The effect at the board code level is that code for creating,
setting properties on and realizing qdev devices tends to look
very different from that for doing so for plain QOM objects
[qdev_create / qdev_prop_set* / qdev_init_nofail vs object_new /
object_property_set_* / object_property_set_bool(... "realized" ...) ]

Can/should we just deprecate further use of the qdev_* APIs?

thanks
-- PMM
