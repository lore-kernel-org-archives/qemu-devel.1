Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZJKT-0007l1-O2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZJKS-0000gM-Qf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:38:49 -0500
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
	<028f1498-d0bc-e920-1c7c-9a1f0bdded58@redhat.com>
	<20181218095334-mutt-send-email-mst@kernel.org>
	<bdc695a3-674e-b0de-690d-160146beefb8@redhat.com>
	<00f8cbcd-eccc-2e76-93be-2855d2c80a37@redhat.com>
	<20181218121457-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea702a96-50bc-22f5-d15c-08e543a4a6fa@redhat.com>
Date: Tue, 18 Dec 2018 18:38:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181218121457-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>

On 18/12/18 18:17, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 06:12:05PM +0100, Paolo Bonzini wrote:
>> On 18/12/18 17:55, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> strpadcpy will instead just silence the warning.
>>> migration/global_state.c:109:15: error: 'strlen' argument 1 declared
>>> attribute 'nonstring' [-Werror=3Dstringop-overflow=3D]
>>>      s->size =3D strlen((char *)s->runstate) + 1;
>>>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> GCC won... It is true this strlen() is buggy, indeed s->runstate migh=
t
>>> be not NUL-terminated.
>>
>> No, runstate is declared as an array of 100 bytes, which are more than
>> enough.  It's ugly code but not buggy.
>>
>> Paolo
>=20
> Yes ... but it is loaded using
>         VMSTATE_BUFFER(runstate, GlobalState),
> and parsed using qapi_enum_parse which does not get
> the buffer length.
>=20
> So unless we are lucky there's a buffer overrun
> on a remote/file input here.
>=20
> Seems buggy to me - what am I missing?

Yup.   I think we're lucky twice though.  First, the state field stops
the runaway qapi_enum_parse.  Second, in any case worst case it's a segv
on migration.  This is a bug but not a CVE.

Paolo
