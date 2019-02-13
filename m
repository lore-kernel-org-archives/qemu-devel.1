Received: from eggs.gnu.org ([209.51.188.92]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtqsx-0007pR-Tu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtqsx-000339-1s
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:31:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 13 Feb 2019 09:31:02 +0000
Message-ID: <365fa564-2f73-8fc6-3430-c1222229f5a8@virtuozzo.com>
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-2-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-2-jsnow@redhat.com>
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-ID: <9D7C3493EA97B2438410E84B5A9A8E71@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/5] block/dirty-bitmap: add recording and
 busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <fam@euphon.net>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 12.02.2019 1:02, John Snow wrote:
> The current API allows us to report a single status, which we've defined =
as:
>=20
> Frozen: has a successor, treated as qmp_locked, may or may not be enabled=
.
> Locked: no successor, qmp_locked. may or may not be enabled.
> Disabled: Not frozen or locked, disabled.
> Active: Not frozen, locked, or disabled.
>=20
> The problem is that both "Frozen" and "Locked" mean nearly the same thing=
,
> and that both of them do not intuit whether they are recording guest writ=
es
> or not.
>=20
> This patch deprecates that status field and introduces two orthogonal
> properties instead to replace it.
> ---
>   block/dirty-bitmap.c       |  9 +++++++++
>   qapi/block-core.json       |  9 ++++++++-
>   tests/qemu-iotests/236.out | 28 ++++++++++++++++++++++++++++
>   3 files changed, 45 insertions(+), 1 deletion(-)
>=20

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5a0f5f5a95..275f0d573c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -455,7 +455,13 @@
>   #
>   # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
>   #
> -# @status: current status of the dirty bitmap (since 2.4)
> +# @status: Deprecated in favor of @recording and @locked. (since 4.0)
> +#
> +# @recording: true if the bitmap is recording new writes from the guest.
> +#             Replaces `active` status. (since 4.0)
> +#
> +# @busy: true if the bitmap is in-use by some operation (NBD or jobs)
> +#        and cannot be modified via QMP right now. (since 4.0)

not only modified, but also cannot be used somehow for any other operation.

>   #
>   # @persistent: true if the bitmap will eventually be flushed to persist=
ent
>   #              storage (since 4.0)
> @@ -464,6 +470,7 @@
>   ##
>   { 'struct': 'BlockDirtyInfo',
>     'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
> +           'recording': 'bool', 'busy': 'bool',
>              'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
>  =20
