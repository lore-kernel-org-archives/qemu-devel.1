Received: from eggs.gnu.org ([2001:4830:134:3::10]:47362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faO8S-0001i3-TY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faO8O-0001F6-Tl
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:26:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faO8O-0001En-Pa
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:26:32 -0400
References: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
	<20180703125408.623d77fc@fiorina>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdd1abc6-989c-f20a-169c-2ea71ebd2eb7@redhat.com>
Date: Tue, 3 Jul 2018 11:26:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180703125408.623d77fc@fiorina>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: report disk size and free space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 07/03/2018 05:54 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> On Tue,  3 Jul 2018 10:31:20 +0200
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
>=20
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 70ee5379f6..6d6ca05281 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -706,6 +706,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(ch=
ar *guid, Error **errp)
>>       }
>>       fs->type =3D g_strdup(fs_name);
>>       fs->disk =3D build_guest_disk_info(guid, errp);
>> +
>> +    if (len > 0) {
>> +        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs->si=
ze,
>> +                (PULARGE_INTEGER)&fs->free) !=3D 0) {
>=20
> Btw, it seems to me that checkpatch.pl returns some false positives
> here. See:
>=20
>      ERROR: spaces required around that '&' (ctx:VxV)
>      #72: FILE: qga/commands-win32.c:711:
>      +        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs=
->size,
>                                                                  ^

Yes. PULARGE_INTEGER is not the normal qemu spelling for a typedef, so=20
it confuses checkpatch into thinking you are doing a binary operator=20
instead of a cast of a unary operator, hence a false positive not worth=20
worrying about.

> Also, checkpatch.pl itself suggest to look into MAINTAINERS to find out
> whom to report false positives, but there is no maintainer there. :)

Yes, that's an unfortunate problem - no one has volunteered to maintain=20
checkpatch, so it just gets sporadic patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
