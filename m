Received: from eggs.gnu.org ([2001:4830:134:3::10]:32869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drlsF-0004AE-4d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drls9-0008SR-7F
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1drls9-0008RT-0Z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8130D5D685
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:09:03 +0000 (UTC)
Message-ID: <1505223085.31639.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Sep 2017 15:31:25 +0200
In-Reply-To: <20170912123744.14730-4-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<20170912123744.14730-4-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/12] ui: convert key events to
 QKeyCodes immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue, 2017-09-12 at 13:37 +0100, Daniel P. Berrange wrote:
> Always use QKeyCode in the InputKeyEvent struct, by converting key
> numbers to QKeyCode at the time the event is created.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

qmp_input_send_event() must be handled too as patches later in this
series depend on never seeing any KEY_VALUE_KIND_NUMBER key events.

cheers,
  Gerd

@@ -157,9 +157,16 @@ void qmp_input_send_event(bool has_device, const
char *device,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (e =3D events; e !=3D NULL; e =3D e->ne=
xt) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0InputEvent *event =3D e-=
>value;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0InputEvent *evt =3D e->v=
alue;
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_input_event_send(co=
n, event);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (evt->type =3D=3D INP=
UT_EVENT_KIND_KEY &&
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
evt->u.key.data->key->type =3D=3D KEY_VALUE_KIND_NUMBER) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
KeyValue *key =3D evt->u.key.data->key;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
QKeyCode code =3D qemu_input_key_number_to_qcode(key-
>u.qcode.data);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
qemu_input_event_send_key_qcode(con, code, evt-
>u.key.data->down);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
qemu_input_event_send(con, evt);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
