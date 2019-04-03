Received: from eggs.gnu.org ([209.51.188.92]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBbeT-0006de-JN
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBbeS-0002Ok-IQ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBbeS-0002Nm-9c
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:53:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87h8c82woh.fsf@dusky.pond.sub.org>
	<875zs3dkq6.fsf@dusky.pond.sub.org>
Date: Wed, 03 Apr 2019 10:53:39 +0200
In-Reply-To: <875zs3dkq6.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 28 Mar 2019 17:31:13 +0100")
Message-ID: <87v9zv1ncc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Issues around TYPE_INTERFACE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

I figure what I wrote was too long to read, so let me try again,
focusing on just the main issue, leaving the bonus messes for later.

Here's the main issue in a nutshell: (1) our interfaces can't have state
(but that's okay), (2) our conversions to interface types actually
convert to "an Object that has this interface" (and that's anything but
obvious).


Why (1) our interfaces can't have state:

Since interfaces are abstract, there's no such thing as an interface
instance.

Okay, but WTF does a conversion to an interface type *mean* then?
Recall, interface TYPE_MY_IFACE commonly defines struct type MyIface and
macro MY_IFACE(), which is a checked conversion from any instance of
Object to MyIface.  What *is* MyIface?


What (2) our conversions to interface types do:

MY_IFACE(obj) either fails its assertion or returns (MyIface *)obj.

When @obj points to an instance of MyFrob, then we can safely cast it to
any supertype of MyFrob.

MyIface is not a supertype of MyFrob, it's an interface.  WTF?

Turns out we only ever define MyIface in one of two ways:

    typedef struct MyIface MyIface;     // incomplete

    typedef struct MyIface {            // fake subtype of Object
        Object parent;
    } MyIface;

If we somehow know that only subtypes of SuperFrob have interface
MyIface, then we can exploit that and safely cast to SuperFrob * or any
of its supertypes.

If we don't (want to) know, then we can only cast to Object *.

The "fake subtype of Object" kind could save casts to Object *, but we
don't seem to use that.  Cargo cult?  Fear of not completing your types?

Regardless of how we cast or convert, we still know the object has
interface TYPE_MY_IFACE.


Example of how we actually use this: TYPE_MEMORY_DEVICE and unplug

pc_memory_unplug() converts DeviceState * to subtype PCDIMMDevice *,
checked.  Okay.

pc_dimm_unplug() converts PCDIMMDevice * to interface MemoryDeviceState
*.  Ooookay.  Note that MemoryDeviceState is incomplete.

memory_device_unplug() passes it on to its get_memory_region() method.
Since it's actually a PCDIMMDevice, this is
pc_dimm_md_get_memory_region().

pc_dimm_md_get_memory_region() converts the MemoryDeviceState * right
back to PCDIMMDevice *, checked.  This works even though
MemoryDeviceState is incomplete, because the checked conversion
PC_DIMM() accepts *any* pointer type.  It casts to Object * below the
hood, and if it isn't one, we get undefined behavior.
