Received: from eggs.gnu.org ([209.51.188.92]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEZGk-0002ks-GY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEZ9p-000506-FA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:50:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:57964)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEZ9p-0004yG-1C
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:50:21 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190411123911.GR3641@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
MIME-Version: 1.0
Date: Thu, 11 Apr 2019 15:50:16 +0300
Message-Id: <226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>

11.04.2019, 15:39, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> On Thu, Apr 11, 2019 at 03:31:43PM +0300, Yury Kotov wrote:
>> =C2=A011.04.2019, 15:04, "Daniel P. Berrang=C3=A9" <berrange@redhat.co=
m>:
>> =C2=A0> On Wed, Apr 10, 2019 at 12:26:52PM +0300, Yury Kotov wrote:
>> =C2=A0>> =C2=A0Currently such case is possible for incoming:
>> =C2=A0>> =C2=A0QMP: add-fd (fdset =3D 0, fd of some file):
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adds fd to fdset 0 and returns =
QEMU's fd (e.g. 33)
>> =C2=A0>> =C2=A0QMP: migrate-incoming (uri =3D "fd:33"): fd is stored i=
n QIOChannel *ioc
>> =C2=A0>> =C2=A0...
>> =C2=A0>> =C2=A0Incoming migration completes and unrefs ioc -> close(33=
)
>> =C2=A0>> =C2=A0QMP: remove-fd (fdset =3D 0, fd =3D 33):
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0removes fd from fdset 0 and qem=
u_close() -> close(33) =3D> double close
>> =C2=A0>
>> =C2=A0> IMHO this is user error.
>> =C2=A0>
>> =C2=A0> You've given the FD to QEMU and told it to use it for migratio=
n.
>> =C2=A0>
>> =C2=A0> Once you've done that you should not be calling remove-fd.
>> =C2=A0>
>> =C2=A0> remove-fd should only be used in some error code path. ie if y=
ou
>> =C2=A0> have called add-fd, and then some failure means you've decided=
 you
>> =C2=A0> can't invoke 'migrate-incoming'. Now you should call "remove-f=
d".
>> =C2=A0>
>> =C2=A0> AFAIK, we have never documented that 'add-fd' must be paired
>> =C2=A0> with 'remove-fd'.
>> =C2=A0>
>> =C2=A0> IOW, I think this "fix" is in fact not a fix - it is instead
>> =C2=A0> changing the semantics of when "remove-fd" should be used.
>> =C2=A0>
>>
>> =C2=A0I think it might be user's error but fd is still in cur_mon->fds=
 (in getfd case)
>> =C2=A0or in mon_fdsets (in add-fd case). So if fd is still exists in t=
he lists why
>> =C2=A0user can't close/remove it?
>>
>> =C2=A0So, there are 2 valid options:
>> =C2=A01) fd is still valid after migration (dup)
>
> If we do this then existing mgmt apps using QEMU who don't expect to ne=
ed
> to call remove-fd are going to be leaking FDs forever.
>

Ok, so what do you think about modifying qemu_close to remove fd from the=
se two
lists? Currently it tryes to remove fd only from mon_fdsets->dup_fds.

Regards,
Yury

>> =C2=A02) fd is closed but also removed from the appropriate list
>
> monitor_get_fd currently leaves the FD on the list.
>
> if all current users of that API are closing the FD
> themselves, then we could change that method to remove
> it from the list.
>
> Either way the requirements in this area are pooly documented
> both from QEMU's internal POV and from mgmt app public QMP pov.
>
> Regards,
> Daniel
> --
> |: https://berrange.com -o- https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org -o- https://fstop138.berrange.com :|
> |: https://entangle-photo.org -o- https://www.instagram.com/dberrange :=
|
