Received: from eggs.gnu.org ([2001:4830:134:3::10]:51717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo6oG-0003k0-Pl
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo6oB-00009v-Qb
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo6oB-000097-JP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:14:07 -0500
References: <20180216134516.6269-1-peter.maydell@linaro.org>
	<20180216134516.6269-2-peter.maydell@linaro.org>
	<20180216172841.2ec69b8a@redhat.com>
	<98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d4874be-fec4-39bb-9df5-bb53f17d1d74@redhat.com>
Date: Tue, 20 Feb 2018 13:13:49 +0100
MIME-Version: 1.0
In-Reply-To: <98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/sysbus.h: New sysbus_init_child()
 helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 16/02/2018 18:40, Philippe Mathieu-Daud=C3=A9 wrote:
> we can keep object_initialize() when no parent,
> and add object_initialize_child(, const char *childname, Object *parent=
)
> 'parent' last because all previous args are child-related.
>=20
>>
>>> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>> and then assuming we don't create sysbus devices, nor should be able t=
o,
>> which are not attached to sysbus_get_default() this one can go sysbus'=
 instance_init()
> good idea.
>=20

Either last or first, like

	object_initialize_child(Object *parent, const char *childname,
				void *data, size_t size,
				const char *typename);

I'm not sure about moving qdev_set_parent_bus to instance_init().  It
would be a bit different from other buses and possibly confusing.

Potentially there could be a "hierarchy" of *_initialize_child
functions, adding or removing arguments as needed for the specific kind
of bus:

	/* adds qdev_set_parent_bus */
	device_initialize_child(Object *parent, const char *childname,
				BusState *bus, void *data, size_t size,
				const char *typename);
	/* uses sysbus_get_default() */
	sysbus_initialize_child(Object *parent, const char *childname,
				void *data, size_t size,
				const char *typename);
	/* initializes "addr" property too */
	pci_initialize_child(Object *parent, const char *childname,
			     BusState *bus, int addr,
			     void *data, size_t size,
			     const char *typename);

Thanks,

Paolo
