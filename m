Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxALZ-0007ce-7L
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxALV-0004ai-Um
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxALV-0004aH-OO
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75583BDEA
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 11:17:40 +0000 (UTC)
References: <20170926230709.22958-1-ehabkost@redhat.com>
	<20170926230709.22958-7-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <92296b86-9676-c4a8-cf54-537e3641609a@redhat.com>
Date: Wed, 27 Sep 2017 13:17:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170926230709.22958-7-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] device-crash-test: Multi-device
 device_add test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 27.09.2017 01:07, Eduardo Habkost wrote:
> When running device_add tests, test all devices in a single run
> instead of restarting QEMU every time.
>=20
> There's a plug_all testcase argument that can be used to make the
> test code plug all devices at once.  I'm adding this mode because
> there's a crash that was detected while testing the script
> without any device_del command, but the crash goes away if we
> device_del every device immediately:
>=20
>   $ ../scripts/device-crash-test ./x86_64-softmmu/qemu-system-x86_64 --=
quick -t method=3Ddevice_add  --strict -t plug_all=3D1
>   INFO: running test case: binary=3D./x86_64-softmmu/qemu-system-x86_64=
 plug_all=3D1 accel=3Dkvm machine=3Dpc-0.12 device=3D* method=3Ddevice_ad=
d
>   WARNING: qemu received signal -6: ./x86_64-softmmu/qemu-system-x86_64=
 -chardev socket,id=3Dmon,path=3D/var/tmp/qemu-23578-monitor.sock -mon ch=
ardev=3Dmon,mode=3Dcontrol -display none -vga none -S -machine pc-0.12,ac=
cel=3Dkvm
>   ERROR: result: binary=3D./x86_64-softmmu/qemu-system-x86_64 plug_all=3D=
1 accel=3Dkvm machine=3Dpc-0.12 device=3D* method=3Ddevice_add
>   ERROR: cmdline: ./x86_64-softmmu/qemu-system-x86_64 -S -machine pc-0.=
12,accel=3Dkvm
>   ERROR: log: audio: Could not init `oss' audio driver
>   ERROR: log: qemu-system-x86_64: .../qemu/migration/savevm.c:721: vmst=
ate_register_with_alias_id: Assertion `!se->compat || se->instance_id =3D=
=3D 0' failed.
>   ERROR: last device_add device: usb-net

FWIW, I've seen similar crashes while working on my HMP device_add
tester, when I skipped the device_del and plugged-in the devices a
couple of times instead. I think this happens because some devices are
doing a vmstate_register() in their instance_init() or realize()
function, instead of using dc->vmsd as they should. However, with the
git master branch as of today (31bc1d8481af414cfa2857f905e), I am
currently not able anymore to reproduce the problem with the HMP
device_add tester, so one of the recent "set user_creatable =3D false"
patches might have fixed the issue for me already...

 Thomas
