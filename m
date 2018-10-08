Received: from eggs.gnu.org ([2001:4830:134:3::10]:47097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1g9QMJ-0003z3-8B
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1g9Q8H-0001Eb-C3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:39:16 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:20237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1g9Q8G-0001AJ-Ty
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:39:13 -0400
References: <20181004114312.27346-1-d.csapak@proxmox.com>
	<d2ef3fb3-80ba-6edc-46fb-fa9d73542bc3@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <c2ac4b83-06a2-3879-b9fd-1a91a16456be@proxmox.com>
Date: Mon, 8 Oct 2018 09:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <d2ef3fb3-80ba-6edc-46fb-fa9d73542bc3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@redhat.com, thuth@redhat.com, sw@weilnetz.de

On 10/8/18 5:28 AM, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B410=E6=9C=8804=E6=97=A5 19:43, Dominik Csapak wrote:
>> this patch series aims to execute a script when qemu exits
>> so that one can do cleanups when using --daemonize without
>> having to use the qmp monitor
>=20
> Hi:
>=20
> Can you give a example of why it must be done through this way? It look=
s=20
> to me that we can do this by monitor the pid and behave accordingly=20
> through bash.
>=20
> Thanks

Hi,

as i said in a reply on my original patch, the reason was twofold

first, i thought having an additional process just for monitoring
the exit of qemu with qmp/pidfile was too much for some users, as=20
opposed to a simple script that executes then

ans second (more important), i wanted to know the reason qemu
exited (e.g. user initiated shutdown/reset/etc.),
especially when '-no-reboot' is set

please ignore this series (maybe the refactoring of the launch script
is interesting, i don't know), i will send a patch to be able
to distinguish the shutdown/reset with no-reboot in a seperate
patch for qmp

>=20
>>
>> changes since v1:
>>
>> * refactored as qemu_launch_script, only for non-windows platforms
>> * updated net/tap.c to use qemu_launch_script instead of launch_script
>> * fixed a small error in the option description
>>
>> Dominik Csapak (3):
>> =C2=A0=C2=A0 osdep: add qemu_launch_script for executing scripts
>> =C2=A0=C2=A0 tap: use qemu_launch_script instead of launch_script
>> =C2=A0=C2=A0 vl.c: call optional script when exiting
>>
>> =C2=A0 include/qemu/osdep.h | 12 +++++++++++
>> =C2=A0 net/tap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 56=20
>> ++++++++++------------------------------------------
>> =C2=A0 qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++=
+++++++
>> =C2=A0 util/oslib-posix.c=C2=A0=C2=A0 | 34 +++++++++++++++++++++++++++=
++++
>> =C2=A0 util/oslib-win32.c=C2=A0=C2=A0 |=C2=A0 8 ++++++++
>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 +++++++++++++++++++++++++++
>> =C2=A0 6 files changed, 113 insertions(+), 46 deletions(-)
>>
>=20
>=20
