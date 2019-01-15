Received: from eggs.gnu.org ([209.51.188.92]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalkakri2017@yahoo.com>) id 1gjV5e-0006OQ-JZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalkakri2017@yahoo.com>) id 1gjV5d-0001SU-JZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:13:38 -0500
Received: from sonic302-22.consmr.mail.ne1.yahoo.com ([66.163.186.148]:41539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalkakri2017@yahoo.com>)
	id 1gjV5d-0001Mu-CM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:13:37 -0500
Date: Tue, 15 Jan 2019 20:13:27 +0000 (UTC)
From: Kamal Kakri <kamalkakri2017@yahoo.com>
Message-ID: <1888836717.9067.1547583207433@mail.yahoo.com>
MIME-Version: 1.0
References: <1888836717.9067.1547583207433.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Devdax backend for vnvdimm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

Hi,

I have a namespace (backed by real nvdimm h/w) configured in devdax mode:
# ndctl list -N -n namespace0.0
[
=C2=A0 {
=C2=A0=C2=A0=C2=A0 "dev":"namespace0.0",
=C2=A0=C2=A0=C2=A0 "mode":"devdax",
=C2=A0=C2=A0=C2=A0 "map":"dev",
=C2=A0=C2=A0=C2=A0 "size":16909336576,
=C2=A0=C2=A0=C2=A0 "uuid":"e5265c0a-d902-41ce-b1d1-87a78c358aa4",
=C2=A0=C2=A0=C2=A0 "chardev":"dax0.0"
=C2=A0 }
]


When I try to configure my vm using "virsh" with something like this:
=C2=A0=C2=A0=C2=A0 <memory model=3D'nvdimm' access=3D'shared'>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <source>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <path>/dev/dax0.0</path>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <align unit=3D'KiB'>2048</align>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <pmem/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </source>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <size unit=3D'KiB'>2097152</size=
>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <node>0</node>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </target>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'nvdimm0'/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'dimm' slot=3D'0'/>
=C2=A0=C2=A0=C2=A0 </memory>


I get an error while starting my vm:
# virsh start fox22vm
start: domain(optdata): fox22vm
start: found option <domain>: fox22vm
start: <domain> trying as domain NAME
error: Failed to start domain fox22vm
error: internal error: qemu unexpectedly closed the monitor: ftruncate: Inv=
alid argument
2019-01-15T18:00:36.587467Z qemu-kvm: -object memory-backend-file,id=3Dmemn=
vdimm0,prealloc=3Dyes,mem-path=3D/dev/dax0.0,share=3Dyes,size=3D2147483648:=
 unable to map backing store for guest RAM: Invalid argument

I have tried to add "align unit" to my virsh xml but it does not seem to pa=
ss it onto qemu (as much as I can see from the qemu cmd line in the logs at=
 /var/log/libvirt/qemu)


Can anyone pls hint as to what possibly could be the issue ? Is this alignm=
ent related or something else ?

Here are my versions:
# virsh --version
4.5.0
[root@fox22hv libexec]# /usr/libexec/qemu-kvm --version
QEMU emulator version 2.12.0 (qemu-kvm-rhev-2.12.0-18.el7_6.1)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
# uname -a
Linux fox22hv 4.19.0-1.el7.elrepo.x86_64 #1 SMP Mon Oct 22 10:40:32 EDT 201=
8 x86_64 x86_64 x86_64 GNU/Linux
