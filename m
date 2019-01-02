Received: from eggs.gnu.org ([208.118.235.92]:33637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1geeuv-0002tn-0i
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1geeuu-0007hP-4c
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:42:32 -0500
Date: Wed, 2 Jan 2019 11:41:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190102114156.GD2446@work-vm>
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218175122.3229-5-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] migration: Use QEMU_NONSTRING for
 non NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> GCC 8 added a -Wstringop-truncation warning:
>=20
>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>   bug 81117 is specifically intended to highlight likely unintended
>   uses of the strncpy function that truncate the terminating NUL
>   character from the source string.
>=20
> This new warning leads to compilation failures:
>=20
>     CC      migration/global_state.o
>   qemu/migration/global_state.c: In function 'global_state_store_runnin=
g':
>   qemu/migration/global_state.c:45:5: error: 'strncpy' specified bound =
100 equals destination size [-Werror=3Dstringop-truncation]
>        strncpy((char *)global_state.runstate, state, sizeof(global_stat=
e.runstate));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
>=20
> Use the QEMU_NONSTRING attribute, since this array is intended to store
> character arrays that do not necessarily contain a terminating NUL.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  migration/global_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..6e19333422 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -21,7 +21,7 @@
> =20
>  typedef struct {
>      uint32_t size;
> -    uint8_t runstate[100];
> +    uint8_t runstate[100] QEMU_NONSTRING;

Hmm; global_state_post_load needs to be fixed for this;  it
uses s->runsate and ends up passing it to both a trace
and a qapi_enum_parse - so it's really treating it as a string.
That code is unsafe anyway since it's assuming the received
runstate would be terminated.

Dave

>      RunState state;
>      bool received;
>  } GlobalState;
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
