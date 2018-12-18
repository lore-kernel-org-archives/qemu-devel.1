Received: from eggs.gnu.org ([2001:4830:134:3::10]:36572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZMrB-0001Pw-RB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZMrA-0004b6-NR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:24:49 -0500
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-6-philmd@redhat.com>
	<42d9f6f7-617d-db80-1cda-b079416ec995@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <427fa674-304d-74eb-ff8b-9f5fac9d98ca@redhat.com>
Date: Tue, 18 Dec 2018 22:24:19 +0100
MIME-Version: 1.0
In-Reply-To: <42d9f6f7-617d-db80-1cda-b079416ec995@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] migration: Use strnlen() for
 fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On 18/12/18 20:33, Eric Blake wrote:
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 6e19333422..c19030ef62 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -106,7 +106,7 @@ static int global_state_pre_save(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GlobalState *s =3D opaque;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_migrate_global_state_pre_s=
ave((char *)s->runstate);
>> -=C2=A0=C2=A0=C2=A0 s->size =3D strlen((char *)s->runstate) + 1;
>=20
> The old code sets s->size to the string length + space for the NUL byte
> (by assuming that a NUL byte was present), and accidentally sets it
> beyond the s->runstate array if there was no NUL byte (our existing
> runstate names are shorter than 100 bytes, so this could only happen on
> a malicious stream).

It cannot---this is a pre_save hook.  A possible overflow bug exists,
but it is in the call to qapi_enum_parse.

Paolo
