Received: from eggs.gnu.org ([2001:4830:134:3::10]:46464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7lDK-0007sZ-25
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7lDJ-0003n7-7G
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:45:33 -0400
References: <20181003171947.588103-1-eblake@redhat.com>
	<07bf9075-8534-ca7b-87f5-e9f0e6442668@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baf45cbc-5710-bb6a-8d8b-e1fd1bb14654@redhat.com>
Date: Wed, 3 Oct 2018 12:45:26 -0500
MIME-Version: 1.0
In-Reply-To: <07bf9075-8534-ca7b-87f5-e9f0e6442668@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd: Flip qemu-nbd to prefer newstyle;
 add -O for old behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 10/3/18 12:38 PM, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2018 20:19, Eric Blake wrote:
>> Oldstyle NBD negotiation cannot perform any of the extensions that
>> we have recently been relying on.=C2=A0 While you can always pass -x "=
"
>> to get newstyle negotiation, these days, it is better to just default
>> to newstyle (with an empty export name) and fall back to oldstyle
>> only on an explicit request.
>>

>> +=C2=A0=C2=A0=C2=A0 if (oldstyle && (export_name || export_description=
)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("oldstyle neg=
otiation cannot set export details");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (export_name) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_set_=
name(exp, export_name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_set_=
description(exp, export_description);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newproto =3D tr=
ue;
>=20
> a bit strange, to have both newproto and oldstyle variables which are=20
> opposite by value.

Yeah. I added a function-local 'oldstyle' before noticing that there was=20
a file static 'newproto'. We could squash this in:

diff --git i/qemu-nbd.c w/qemu-nbd.c
index 8571a4f93d8..2b0f7de86d0 100644
--- i/qemu-nbd.c
+++ w/qemu-nbd.c
@@ -56,7 +56,7 @@
  #define MBR_SIZE 512

  static NBDExport *exp;
-static bool newproto;
+static bool oldstyle;
  static int verbose;
  static char *srcpath;
  static SocketAddress *saddr;
@@ -355,7 +355,7 @@ static void nbd_accept(QIONetListener *listener,=20
QIOChannelSocket *cioc,

      nb_fds++;
      nbd_update_server_watch();
-    nbd_client_new(newproto ? NULL : exp, cioc,
+    nbd_client_new(oldstyle ? exp : NULL, cioc,
                     tlscreds, NULL, nbd_client_closed);
  }

@@ -553,7 +553,6 @@ int main(int argc, char **argv)
      QDict *options =3D NULL;
      const char *export_name =3D NULL;
      const char *export_description =3D NULL;
-    bool oldstyle =3D false;
      const char *tlscredsid =3D NULL;
      bool imageOpts =3D false;
      bool writethrough =3D true;
@@ -1030,7 +1029,6 @@ int main(int argc, char **argv)
      if (export_name) {
          nbd_export_set_name(exp, export_name);
          nbd_export_set_description(exp, export_description);
-        newproto =3D true;
      }

      if (device) {


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
