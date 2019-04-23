Received: from eggs.gnu.org ([209.51.188.92]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hJ2wH-0007bM-Hx
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hJ2wF-0002jB-Ae
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1hJ2wF-0002g3-0Q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:51 -0400
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
From: Jag Raman <jag.raman@oracle.com>
Message-ID: <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
Date: Tue, 23 Apr 2019 17:26:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com



On 3/26/2019 6:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>> Please share the SELinux policy files, containerization scripts, etc.
>>>> There is probably a home for them in qemu.git, libvirt.git, or elsew=
here
>>>> upstream.
>>>>
>>>> We need to find a way to make the sandboxing improvements available =
to
>>>> users besides yourself and easily reusable for developers who wish t=
o
>>>> convert additional device models.
>>
>=20
> Also for testing this series.

Hi,

We are wondering how to deliver the example SELinux policies. I have
posted on Fedora's SELinux mailing list to get info. on how to upstream
SElinux policy.

We are developing SELinux Type Enforcements and MCS labels to sandbox
the emulation process. Details regarding example Type Enforcement is
available below.

We are also working on changes to libvirt, to launch the remote process
and apply MCS labels. Libvirt changes will be posted separately in the
future.

The Type Enforcements for SElinux is available in the pastebin location
below (also copied at the end of this email):
https://pastebin.com/t1bpS6MY

An RPM package which installs this policy as a SELinux module, and
configures the file contexts for the executables, is available for
download in the link below:
http://wikisend.com/download/156700/mpqemu-selinux-example-1.0-1.fc29.noa=
rch.rpm

The README for RPM could be obtained by running the following commands:
# rpm2cpio ./packagecloud-test-1.1-1.x86_64.rpm | cpio -idmv
# cat opt/mpqemu-selinux-example/doc/README

Thanks!
--
Jag


----------
mpqemu.te:
----------

module mpqemu 1.0;


require {
	class process transition;
	class file { execute read };
	class file entrypoint;
	class dir search;
	class file { getattr open read };
	class file { getattr map open read };
	class file { execute map read };
	class lnk_file read;
	class chr_file { lock open read write };
	class file { getattr ioctl lock open read write };
	class process fork;
	class fd use;
	class unix_stream_socket { read write };
	class file open;
	class process { noatsecure rlimitinh siginh };
	class file write;
	class dir { getattr search };
	class file { open read };
	class process getattr;
	type qemu_t;
	type qemu_exec_t;
	type virtd_t;
	type ld_so_cache_t;
	type ld_so_t;
	type lib_t;
	type null_device_t;
	type virt_image_t;
	type shell_exec_t;
	type init_t;
	attribute domain;
	attribute entry_type;
	attribute exec_type;
	attribute application_exec_type;
	attribute file_type, non_security_file_type, non_auth_file_type;
	attribute virt_domain;
	attribute virt_image_type;
=09
};


type qemu_lsi53c895a_exec_t;
type qemu_lsi53c895a_img_t;
type qemu_lsi53c895a_t;

typeattribute qemu_lsi53c895a_t virt_domain;

typeattribute qemu_lsi53c895a_exec_t file_type, non_security_file_type,=20
non_auth_file_type;
typeattribute qemu_lsi53c895a_exec_t exec_type;
typeattribute qemu_lsi53c895a_exec_t application_exec_type;
typeattribute qemu_lsi53c895a_exec_t entry_type;
typeattribute qemu_lsi53c895a_img_t file_type, non_security_file_type,=20
non_auth_file_type;
typeattribute qemu_lsi53c895a_img_t virt_image_type;
type_transition qemu_t qemu_lsi53c895a_exec_t : process qemu_lsi53c895a_t=
;
type_transition virtd_t qemu_exec_t : process qemu_t;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D init_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
allow init_t qemu_lsi53c895a_t:dir search;
allow init_t qemu_lsi53c895a_t:file { getattr open read };

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D qemu_lsi53c895a_t =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
allow qemu_lsi53c895a_t ld_so_cache_t : file { getattr map open read };
allow qemu_lsi53c895a_t ld_so_t : file { execute map read };
allow qemu_lsi53c895a_t lib_t : lnk_file read;
allow qemu_lsi53c895a_t null_device_t : chr_file { lock open read write }=
;
allow qemu_lsi53c895a_t qemu_lsi53c895a_exec_t : file { execute map read =
};
allow qemu_lsi53c895a_t qemu_lsi53c895a_img_t : file { getattr ioctl=20
lock open read write };
allow qemu_lsi53c895a_t self : process fork;
allow qemu_lsi53c895a_t qemu_t : fd use;
allow qemu_lsi53c895a_t qemu_t : unix_stream_socket { read write };
allow qemu_lsi53c895a_t qemu_lsi53c895a_exec_t : file entrypoint;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D qemu_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
allow qemu_t qemu_lsi53c895a_exec_t : file open;
allow qemu_t qemu_lsi53c895a_t : process { noatsecure rlimitinh siginh };
allow qemu_t virt_image_t : file write;
allow qemu_t qemu_lsi53c895a_t : process transition;
allow qemu_t qemu_lsi53c895a_exec_t : file { execute read };

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D virtd_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
allow virtd_t shell_exec_t : file entrypoint;



>>> Stefan
>>>
>>
>>
