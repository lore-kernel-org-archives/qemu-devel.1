Received: from eggs.gnu.org ([2001:4830:134:3::10]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdK5i-0002Si-Sj
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdK5i-0000Hi-2s
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:43:54 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <163e1c54-c953-e5fe-3142-eab18e0362b8@redhat.com>
Date: Wed, 11 Jul 2018 20:43:44 +0200
MIME-Version: 1.0
In-Reply-To: <ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 11.07.2018 19:20, Paolo Bonzini wrote:
> On 09/07/2018 23:03, Thomas Huth wrote:
>>
>> The problem is that qdev_set_parent_bus() from instance_init adds a li=
nk
>> to the child devices which is not valid anymore after the device init
>> failed. Thus the qdev_set_parent_bus() must rather be done in the real=
ize
>> function instead.
>=20
> The theoretical behavior should be:
>=20
> - realize fails

In this case, the failure is before realize is attempted,
qdev_device_add() already stop with "Device '%s' can not be hotplugged
on this machine".

> - object_unparent is called on the device that failed to realize (see
> qdev_device_add).  object_unparent calls device_unparent

Hmm, are you sure? I can see that object_unparent calls device_unparent
indirectly for the *child* nodes of the device, but not for the device
itself...

 Thomas
