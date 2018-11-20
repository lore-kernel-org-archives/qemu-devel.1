Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDZY-0002Nn-81
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDZV-0000Pe-3r
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:28:40 -0500
References: <20181120203628.2367003-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb5fbd50-0629-8afb-e1d4-cc3d1a94e057@redhat.com>
Date: Tue, 20 Nov 2018 16:28:26 -0500
MIME-Version: 1.0
In-Reply-To: <20181120203628.2367003-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: Avoid UTF-8 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org



On 11/20/18 3:36 PM, Eric Blake wrote:
> While most developers are now using UTF-8 environments, it's
> harder to guarantee that error messages will be output to
> a multibyte locale. Rather than risking error messages that
> get corrupted into mojibake when the user runs qemu in a
> non-multibyte locale, let's stick to straight ASCII error
> messages, rather than assuming that our use of UTF-8 in source
> code string constants will work unchanged in other locales.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/misc/tmp105.c | 2 +-
>  hw/misc/tmp421.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
> index 0918f3a6ea2..f6d7163273a 100644
> --- a/hw/misc/tmp105.c
> +++ b/hw/misc/tmp105.c
> @@ -79,7 +79,7 @@ static void tmp105_set_temperature(Object *obj, Visit=
or *v, const char *name,
>          return;
>      }
>      if (temp >=3D 128000 || temp < -128000) {
> -        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " =C2=B0C is o=
ut of range",
> +        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of =
range",
>                     temp / 1000, temp % 1000);
>          return;
>      }
> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
> index c234044305d..eeb11000f0f 100644
> --- a/hw/misc/tmp421.c
> +++ b/hw/misc/tmp421.c
> @@ -153,7 +153,7 @@ static void tmp421_set_temperature(Object *obj, Vis=
itor *v, const char *name,
>      }
>=20
>      if (temp >=3D maxs[ext_range] || temp < mins[ext_range]) {
> -        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " =C2=B0C is o=
ut of range",
> +        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of =
range",
>                     temp / 1000, temp % 1000);
>          return;
>      }
>=20

Do we have any policy in place to prohibit this in the future?
(Presumably a policy that is automatic and won't interfere with QEMU
localization efforts which may rightly attempt to use UTF-8 for those
locales.)

Do you have a script or trick to find utf-8 containing strings in our
source?

Only curious, don't hold this patch up on my account. I'm not raising a
challenge.

--js
