Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXn17-0003QE-LJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXn16-0000GY-Ol
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:17 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fXn16-0000G7-HH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:16 -0400
Received: by mail-wr0-x244.google.com with SMTP id a12-v6so17068563wro.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 05:24:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621132730.GA3345@debian>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-5-marcandre.lureau@redhat.com>
	<20180621123320.GA19274@debian>
	<CAJ+F1CKPbdXx5sAA1ershQ_YeSOupocjfZsFWqha8-7ObkvUTg@mail.gmail.com>
	<20180621132730.GA3345@debian>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Jun 2018 14:24:14 +0200
Message-ID: <CAJ+F1CL8nVijdSvJK5dNtBgFGq-iXXgmgbM09fbF0a-WFVae5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/26] vhost-user: simplify
 vhost_user_init/vhost_user_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Jun 21, 2018 at 3:27 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Thu, Jun 21, 2018 at 02:48:08PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> On Thu, Jun 21, 2018 at 2:33 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
>> > On Mon, Jun 18, 2018 at 06:17:07PM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> > [...]
>> >> diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
>> >> index 049089b5e2..323dfcc46a 100644
>> >> --- a/hw/virtio/vhost-stub.c
>> >> +++ b/hw/virtio/vhost-stub.c
>> >> @@ -7,7 +7,7 @@ bool vhost_has_free_slot(void)
>> >>      return true;
>> >>  }
>> >>
>> >> -VhostUserState *vhost_user_init(void)
>> >> +bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error *=
*errp)
>> >>  {
>> >>      return NULL;
>> >
>> > It would be better to return false.
>> >
>>
>> Good catch, fixed.
>>
>> Except that, would you give a reviewed-by?
>
> Sorry, I missed something previously. In below diff:
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a39f9c9974..5e5b8f3fc9 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -291,14 +291,14 @@ static int net_vhost_user_init(NetClientState *peer=
, const char *device,
>  {
>      Error *err =3D NULL;
>      NetClientState *nc, *nc0 =3D NULL;
> -    VhostUserState *user =3D NULL;
>      NetVhostUserState *s =3D NULL;
> +    VhostUserState *user;
>      int i;
>
>      assert(name);
>      assert(queues > 0);
>
> -    user =3D vhost_user_init();
> +    user =3D g_new0(struct VhostUserState, 1);
>      if (!user) {
>          error_report("failed to init vhost_user");
>          goto err;
>
> It might be better to change the error message
> to something like:
>
> "failed to allocate vhost-user state".
>
> Except that, it looks good to me and you can add
> my reviewed-by.

Good point, g_new() aborts on failure, so we can simply remove the error re=
port.

Thanks

>
> Best regards,
> Tiwei Bie
>
>>
>> > Best regards,
>> > Tiwei Bie
>> >
>> >>  }
>> > [...]
>> >
>>
>>
>>
>> --
>> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
