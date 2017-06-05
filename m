Received: from eggs.gnu.org ([2001:4830:134:3::10]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHs7z-0004Gr-Ud
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHs7w-0004G6-RW
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHs7w-0004FU-LF
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:33:00 -0400
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com>
Date: Mon, 5 Jun 2017 15:32:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 05/06/2017 15:10, Peter Maydell wrote:
> I perpetually get confused about qdev properties vs QOM object
> properties.
>=20
> Why do we have both of these APIs?
> How do they interact?

qdev properties are just a wrapper around QOM object properties, taking
care of:

- not allowing to set the property after realize

- providing default values

- letting people use the familiar DEFINE_PROP_* array syntax

- pretty printing for "info qtree" (which right now is only used by PCI
devfn and vlan properties)

> Which is the recommended one for new device code?
> Do we have a transition plan for old code?
> Where should I be looking for the documentation on this?

There is no transition plan, qdev properties are not going to go away
soon unless someone actually makes a plan.

Now that there are QOM class properties, it would actually be feasible
to make qdev_property_add_static define QOM properties on the class
rather than the object.  In other words, instead of

    dc->props =3D virtio_serial_pci_properties;

you'd have something like:

    qdev_add_class_properties(klass, usb_tablet_properties);

or even inlined calls like the following:

    QDEV_DEFINE_CLASS_PROP_UINT32(klass, "usb_version", USBHIDState,
                                  usb_version, 2);
    QDEV_DEFINE_CLASS_PROP_STRING(klass, "display", USBHIDState,
                                  display);
    QDEV_DEFINE_CLASS_PROP_UINT32(klass, "head", USBHIDState, head, 0);

> For a specific example, I see that target/arm is the only code
> using qdev_property_add_static(), but there's no indication
> that the function is deprecated or what the right thing to be
> doing instead is. Any suggestions?

The weird thing in ARM code is that the set of properties depends on the
CPU model.  That's the only reason why it uses
qdev_property_add_static() as far as I can see.

Paolo
