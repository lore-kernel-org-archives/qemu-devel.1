Received: from eggs.gnu.org ([2001:4830:134:3::10]:38184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYv3F-0007sB-F0
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYv3D-0003YF-Ky
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:43:25 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-19-eblake@redhat.com>
	<20181215154231.GC27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b749c0b-aff3-458a-1f49-2337f29706c4@redhat.com>
Date: Mon, 17 Dec 2018 09:43:12 -0600
MIME-Version: 1.0
In-Reply-To: <20181215154231.GC27120@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 18/22] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/15/18 9:42 AM, Richard W.M. Jones wrote:
> On Sat, Dec 15, 2018 at 07:53:20AM -0600, Eric Blake wrote:
>> We want to be able to detect whether a given qemu NBD server is
>> exposing the right export(s) and dirty bitmaps, at least for
>> regression testing.  We could use 'nbd-client -l' from the upstream
>> NBD project to list exports, but it's annoying to rely on
>> out-of-tree binaries; furthermore, nbd-client doesn't necessarily
>> know about all of the qemu NBD extensions.  Thus, we plan on adding
>> a new mode to qemu-nbd that merely sniffs all possible information
>> from the server during handshake phase, then disconnects and dumps
>> the information.
>>
>> This patch adds the low-level client code for grabbing the list
>> of exports.  It benefits from the recent refactoring patches, as
>> well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_or_go()=
,
>> in order to share as much code as possible when it comes to doing
>> validation of server replies.  The resulting information is stored
>> in an array of NBDExportInfo which has been expanded to any
>> description string, along with a convenience function for freeing
>> the list.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---

>> +        while (1) {
>> +            char *name;
>> +            char *desc;
>> +
>> +            rc =3D nbd_receive_list(ioc, &name, &desc, errp);
>> +            if (rc < 0) {
>> +                goto out;
>> +            } else if (rc =3D=3D 0) {
>> +                break;
>> +            }
>> +            array =3D g_renew(NBDExportInfo, array, ++count);
>> +            memset(&array[count - 1], 0, sizeof(*array));
>> +            array[count - 1].name =3D name;
>> +            array[count - 1].description =3D desc;
>> +            array[count - 1].structured_reply =3D result =3D=3D 3;
>> +        }
>=20
> Do we care about limiting =E2=80=98count=E2=80=99 to some reasonable va=
lue here?

Maybe.

>=20
> I tried to look at the protocol document to see if there's a limit on
> the number of exports that a server can have, but if there is I cannot
> find it.  I don't know how much we care about malicious NBD servers --
> mostly I'm interested in malicious NBD clients :-)

You brought up the same question earlier in the series, and we already=20
have a pre-existing repeat of the situation with NBD_OPT_LIST for=20
servers that lack NBD_OPT_GO.

A client can always hang up on a server that it doesn't like; so maybe=20
we could set our own limit - but what is a good limit?  An NBD server=20
set up to export every file in a given directory, where that directory=20
has over 1k files, doesn't seem too far-fetched.  Having 1000 contexts=20
available in NBD_OPT_LIST_META_CONTEXT, on the other hand, is less likely=
.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
