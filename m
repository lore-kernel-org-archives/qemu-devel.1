Received: from eggs.gnu.org ([2001:4830:134:3::10]:53483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1fVwkh-0003jL-Fw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1fVwke-0001z0-7P
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:23:43 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-6-vsementsov@virtuozzo.com>
	<45f6544a-d384-f3cc-5fd4-c3d5f0268f25@redhat.com>
	<f92c42cd-d5ed-b89d-5381-f220fdd4aa02@virtuozzo.com>
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <ca14a2d4-f268-686a-01a1-3faa28561358@virtuozzo.com>
Date: Thu, 21 Jun 2018 13:23:31 +0300
MIME-Version: 1.0
In-Reply-To: <f92c42cd-d5ed-b89d-5381-f220fdd4aa02@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/6] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org



On 20.06.2018 17:13, Vladimir Sementsov-Ogievskiy wrote:
> 20.06.2018 14:26, Eric Blake wrote:
>> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 qapi/block.json | 23 +++++++++++++++++++++++
>>> =C2=A0 blockdev-nbd.c=C2=A0 | 23 +++++++++++++++++++++++
>>> =C2=A0 2 files changed, 46 insertions(+)
>>
>> I'm tempted to temporarily name this x-nbd-server-add-bitmap, until I ha=
ve the counterpart Libvirt patches tested, just in case testing turns up an=
y tweaks we need to the interface.
>>
>>>
>>> diff --git a/qapi/block.json b/qapi/block.json
>>> index c694524002..ddbca2e286 100644
>>> --- a/qapi/block.json
>>> +++ b/qapi/block.json
>>> @@ -269,6 +269,29 @@
>>> =C2=A0=C2=A0=C2=A0 'data': {'name': 'str', '*mode': 'NbdServerRemoveMod=
e'} }
>>> =C2=A0 =C2=A0 ##
>>> +# @nbd-server-add-bitmap:
>>> +#
>>> +# Expose a dirty bitmap associated with the selected export. The bitma=
p search
>>> +# starts at the device attached to the export, and includes all backin=
g files.
>>> +# The exported bitmap is then locked until the NBD export is removed.
>>
>> The fact that you search the backing chain is at least consistent with y=
our code.
>>
>>> +#
>>> +# @name: Export name.
>>> +#
>>> +# @bitmap: Bitmap name to search for.
>>> +#
>>> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (default @bitmap)
>>
>> Do we really need the flexibility of naming the bitmap differently to th=
e NBD client than we do in qemu?
>=20
> It was needed for our backup-api implementation. Nikolay?

Hi.

In case of checkpoints A, B, C in my implementation I created bitmaps A, B,=
 C
respectively with A tracking changes from time A to time B for example. Lat=
er
if somebody needs to export CBT from A to last snapshot(checkpotin) I need =
to
merge A and B and create T bitmap for this purpuse. NBD client would like
to see this CBT under name A I guess thus I used @bitmap-export-name option=
.

But I could start with naming bitmaps delta-A, delta-B, delta-C and then
use name A for merge.

Nikolay

>=20
>>
>>> +#
>>> +# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
>>> +# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to=
 access
>>> +# the exposed bitmap.
>>> +#
>>> +# Since: 3.0
>>> +##
>>> +=C2=A0 { 'command': 'nbd-server-add-bitmap',
>>> +=C2=A0=C2=A0=C2=A0 'data': {'name': 'str', 'bitmap': 'str', '*bitmap-e=
xport-name': 'str'} }
>>> +
>>> +##
>>> =C2=A0 # @nbd-server-stop:
>>> =C2=A0 #
>>> =C2=A0 # Stop QEMU's embedded NBD server, and unregister all devices pr=
eviously
>>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>>> index 65a84739ed..6b0c50732c 100644
>>> --- a/blockdev-nbd.c
>>> +++ b/blockdev-nbd.c
>>> @@ -220,3 +220,26 @@ void qmp_nbd_server_stop(Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server_free(nbd_server);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server =3D NULL;
>>> =C2=A0 }
>>> +
>>> +void qmp_nbd_server_add_bitmap(const char *name, const char *bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_bitmap_export_name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bitmap_export_name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 NBDExport *exp;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!nbd_server) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "NBD serve=
r not running");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 exp =3D nbd_export_find(name);
>>> +=C2=A0=C2=A0=C2=A0 if (exp =3D=3D NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Export '%=
s' is not found", name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 nbd_export_bitmap(exp, bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_bitmap_export=
_name ? bitmap_export_name : bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>>> +}
>>>
>>
>=20
>=20
