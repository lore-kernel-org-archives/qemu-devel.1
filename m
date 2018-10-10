Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAI95-0001dW-2M
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAI90-0007pD-DA
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gAI8u-0007m4-37
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:19:30 -0400
References: <cover.1538652143.git.tgolembi@redhat.com>
	<b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
	<CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7bff59d-6087-0517-b859-44be0681dfee@redhat.com>
Date: Wed, 10 Oct 2018 12:19:20 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] qga-win: demystify namespace
 striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10/4/18 8:20 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgole=
mbi@redhat.com> wrote:
>>
>> It was not obvious what exactly the cryptic string copying does to the
>> GUID. This change makes the intent clearer.

In the subject line, s/striping/stripping/ (this is about performing a=20
'strip' operation on a prefix, but I read the subject as an instance of=20
'stripe' as in drawing a line or fragmenting data in a RAID).

>> +++ b/qga/commands-win32.c
>> @@ -507,7 +507,14 @@ static GuestPCIAddress *get_pci_info(char *guid, =
Error **errp)
>>       char dev_name[MAX_PATH];
>>       char *buffer =3D NULL;
>>       GuestPCIAddress *pci =3D NULL;
>> -    char *name =3D g_strdup(&guid[4]);
>> +    char *name =3D NULL;
>> +
>> +    if ((g_str_has_prefix(guid, "\\\\.\\") =3D=3D TRUE) ||
>> +        (g_str_has_prefix(guid, "\\\\?\\") =3D=3D TRUE)) {

I find that 'cond =3D=3D true' is redundant to just writing 'cond'. And t=
hat=20
sentiment applies to both the <stdbool.h> 'bool' and to the glib=20
abomination TRUE (why they had to invent their own boolean names, worse=20
in every way compared to <stdbool.h>, is beyond me).

>> +        name =3D g_strdup(&guid[4]);
>=20
> I find "guid + 4" easier to read though

Concur.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
