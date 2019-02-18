Received: from eggs.gnu.org ([209.51.188.92]:32783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvlWo-0001Ns-3D
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvlM9-0002Eo-2v
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:01:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvlM8-0002E0-PB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:01:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87wom249zf.fsf@dusky.pond.sub.org>
	<8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com>
Date: Mon, 18 Feb 2019 17:01:16 +0100
In-Reply-To: <8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com> (Paolo
	Bonzini's message of "Thu, 14 Feb 2019 17:58:06 +0100")
Message-ID: <878syd84s3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Object instantiation vs. device realization: what
 to do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/02/19 17:21, Markus Armbruster wrote:
>>  * As an interim step, the #DeviceState:realized property can also be
>>  * set with qdev_init_nofail().
>>  * In the future, devices will propagate this state change to their chil=
dren
>>  * and along busses they expose.
>>=20
>> This sentence is five years old.  Any progress?  If not, any intentions
>> to make progress?
>
> Good news, it's done!  What we still don't do is removing
> qdev_init_nofail and realizing the whole machine in one fell swoop.
>
> Bad news, it's been done for five years:
>
>     commit 5c21ce77d7e5643089ceec556c0408445d017f32
>     Author: Bandan Das <bsd@redhat.com>
>     Date:   Wed Mar 12 21:02:12 2014 +0100
>
>     qdev: Realize buses on device realization
>
>     Integrate (un)realization of child buses with
>     realization/unrealization
>     of the device hosting them. Code in device_unparent() is reordered
>     for unrealization of buses to work as part of device unrealization.
>
>     That way no changes need to be made to bus instantiation.
>
>     Signed-off-by: Bandan Das <bsd@redhat.com>
>     Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>
> so I don't expect that the next step will ever happen...

Sigh...  can you suggest an update to the comment then?

Out of curiosity, what would have to be done?  Any particular problems
other than the practical problem of manhandling 300+ qdev_init_nofail()
calls?

>>  * The point in time will be deferred to machine creation, so that values
>>  * set in @realize will not be introspectable beforehand. Therefore devi=
ces
>>  * must not create children during @realize; they should initialize them=
 via
>>  * object_initialize() in their own #TypeInfo.instance_init and forward =
the
>>  * realization events appropriately.
>>=20
>> This is mostly greek to me.  Pity the developer who knows less about
>> qdev than I do.
>
> The first part refers to what virtio_instance_init_common does:
>
>     object_initialize(vdev, vdev_size, vdev_name);
>     object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev),
>                               NULL);
>     object_unref(OBJECT(vdev));
>
> The second part doesn't apply to virtio because it has a bus (so the
> code from the above commit handles recursive realization automatically).
>
> hw/sd/milkymist-memcard.c has an example of this:
>
>     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
>
> but it should create the device in milkymist_memcard_init rather than
> milkymist_memcard_realize, in order to obey the directives of the sacred
> book of QEMU.

I see.

Thanks!
