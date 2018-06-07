Received: from eggs.gnu.org ([2001:4830:134:3::10]:60329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fR3In-0006zV-8c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fR3Im-0004bU-91
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:22:41 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fR3Im-0004ac-2G
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:22:40 -0400
Received: by mail-wm0-x242.google.com with SMTP id x6-v6so11228wmc.3
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 15:22:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604085830.awobv45jz4nyrcx2@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-10-marcandre.lureau@redhat.com>
	<20180604085830.awobv45jz4nyrcx2@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 8 Jun 2018 00:22:38 +0200
Message-ID: <CAJ+F1CLqwx4VU-Aa71L0VUj=dPvRJu7MEk+jnt6TYys1hwRdrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 09/12] Add vhost-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jun 4, 2018 at 10:58 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> +#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"
>
> Patch $subject mismatch.
>
>> +struct VHostUserInput {
>> +    VirtIOInput                       parent_obj;
>> +
>> +    VhostUserBackend                  *vhost;
>> +};
>
> Nothing input specific here ...

Except VirtIOInput

>
>> +static void vhost_input_change_active(VirtIOInput *vinput)
>> +{
>> +    VHostUserInput *vhi =3D VHOST_USER_INPUT(vinput);
>> +
>> +    if (!vhi->vhost) {
>> +        return;
>> +    }
>> +
>> +    if (vinput->active) {
>> +        vhost_user_backend_start(vhi->vhost);
>> +    } else {
>> +        vhost_user_backend_stop(vhi->vhost);
>> +    }
>> +}
>
> ... and here ...

Except it's a VirtIOInputClass callback
>
>> +static const VMStateDescription vmstate_vhost_input =3D {
>> +    .name =3D "vhost-user-input",
>> +    .unmigratable =3D 1,
>> +};
>
> ... and here ...
>
>> +static void vhost_input_is_busy(const Object *obj, const char *name,
>> +                                Object *val, Error **errp)
>> +{
>> +    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
>> +
>> +    if (vhi->vhost) {
>> +        error_setg(errp, "can't use already busy vhost-user");
>> +    } else {
>> +        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
>> +    }
>> +}
>
> ... likewise ...
>
> So, maybe it makes sense to have a abstact base class for vhost-user
> devices?  And possibly move the vhost-backend code to the base class
> then?

The device inherits from virtio-input type. So we could somehow not
expose -object vhost-user and instead have internal vhost-user object
& properties aliased & duplicated on each -device vhost-user*. I would
rather keep the -object solution, since it's somehow cleaner, more
flexible and simpler to document that way. Or do you have a better
idea?

--=20
Marc-Andr=C3=A9 Lureau
