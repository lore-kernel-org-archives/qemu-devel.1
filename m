Received: from eggs.gnu.org ([209.51.188.92]:48023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glpIT-00041v-H1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glpIQ-00054y-No
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glpII-0004yT-2V
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 01:12:21 -0500
References: <154809778688.10764.12505763850198799463.reportbug@deadeye.wl.decadent.org.uk>
	<16ee5e20-e61b-7242-7d80-39a06fb8fd4f@msgid.tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d4f70494-732f-1013-291c-c56566d10c57@redhat.com>
Date: Tue, 22 Jan 2019 07:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <16ee5e20-e61b-7242-7d80-39a06fb8fd4f@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Bug#920032: qemu-user uses wrong struct timeval on
 sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: Michael Tokarev <mjt@tls.msk.ru>, 920032@bugs.debian.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

 Hi Ben,

could you please submit this as a proper patch to the qemu-devel mailing
list, with Signed-off-by line?
(see https://wiki.qemu.org/Contribute/SubmitAPatch for details)

 Thanks,
  Thomas


On 2019-01-22 06:42, Michael Tokarev wrote:
> Forwarding to qemu-devel@.
> http://bugs.debian.org/920032
>=20
> Thanks!
>=20
> 21.01.2019 22:09, Ben Hutchings wrote:
>> Package: qemu-user
>> Version: 1:3.1+dfsg-2
>> Severity: important
>> Tags: patch
>>
>> On sparc (only) Linux defines timeval::tv_usec with type int, not
>> long.=C2=A0 However qemu-user's definition of struct target_timeval us=
es
>> abi_long unconditionally.=C2=A0 This results in the syscall translatio=
n
>> layer effectively multiplying tv_usec by 2**32.=C2=A0 All sparc syscal=
ls
>> passing non-zero values for this field fail with -EINVAL.=C2=A0 The
>> following patch seems to fix this.
>>
>> Ben.
>>
>> --- a/linux-user/syscall_defs.h
>> +++ b/linux-user/syscall_defs.h
>> @@ -210,7 +210,11 @@ struct target_linger {
>> =C2=A0 =C2=A0 struct target_timeval {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_long tv_sec;
>> +#if defined (TARGET_SPARC)
>> +=C2=A0=C2=A0=C2=A0 abi_int tv_usec;
>> +#else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_long tv_usec;
>> +#endif
>> =C2=A0 };
>> =C2=A0 =C2=A0 struct target_timespec {
>> --- END ---
>>
>> -- System Information:
>> Debian Release: buster/sid
>> =C2=A0=C2=A0 APT prefers unstable-debug
>> =C2=A0=C2=A0 APT policy: (500, 'unstable-debug'), (500, 'stable-update=
s'), (500,
>> 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
>> Architecture: amd64 (x86_64)
>> Foreign Architectures: i386
>>
>> Kernel: Linux 4.19.0-1-amd64 (SMP w/4 CPU cores)
>> Locale: LANG=3Den_GB.UTF-8, LC_CTYPE=3Den_GB.UTF-8 (charmap=3DUTF-8),
>> LANGUAGE=3Den_GB.UTF-8 (charmap=3DUTF-8)
>> Shell: /bin/sh linked to /bin/dash
>> Init: systemd (via /run/systemd/system)
>> LSM: AppArmor: enabled
>>
>> Versions of packages qemu-user depends on:
>> ii=C2=A0 libc6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.28-3
>> ii=C2=A0 libcapstone3=C2=A0 3.0.5-3
>> ii=C2=A0 libgcc1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:8.2.0-13
>> ii=C2=A0 libglib2.0-0=C2=A0 2.58.1-2
>> ii=C2=A0 libstdc++6=C2=A0=C2=A0=C2=A0 8.2.0-13
>> ii=C2=A0 zlib1g=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:1.2.11.dfs=
g-1
>>
>> Versions of packages qemu-user recommends:
>> ii=C2=A0 qemu-user-static [qemu-user-binfmt]=C2=A0 1:3.1+dfsg-2
>>
>> Versions of packages qemu-user suggests:
>> ii=C2=A0 sudo=C2=A0 1.8.26-2
>>
>> -- no debconf information
>>
>=20
