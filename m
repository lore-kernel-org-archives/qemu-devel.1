Received: from eggs.gnu.org ([2001:4830:134:3::10]:46839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGxj-0003K7-5a
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGxf-000655-U8
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diGxf-00063p-Kk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D58A16B35C
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 09:19:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-20-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 11:19:21 +0200
In-Reply-To: <20170727154126.11339-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 27 Jul 2017
	17:41:19 +0200")
Message-ID: <87efsak0va.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/26] build-sys: move qapi variables in
 qapi.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

We don't move in qapi.mak we move *into* qapi.mak.

While we're talking: use a more common tag, and start the phrase with a
capital letter: "Makefile: Move qapi variables into qapi.mak".

Commit message then still misses the most important part: why?

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile | 43 +++++++++++++++++--------------------------
>  qapi.mak | 14 ++++++++++++++
>  2 files changed, 31 insertions(+), 26 deletions(-)
>  create mode 100644 qapi.mak
>
> diff --git a/Makefile b/Makefile
> index ef721480eb..8cd30fd88e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -50,6 +50,7 @@ endif
>  endif
>=20=20
>  include $(SRC_PATH)/rules.mak
> +include $(SRC_PATH)/qapi.mak
>=20=20
>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
>  GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
> @@ -390,56 +391,46 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC=
_PATH)/scripts/hxtool
>  qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>  qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-generated
>=20=20
> -gen-out-type =3D $(subst .,-,$(suffix $@))
> -
> -qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
> -
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qap=
i-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(qapi-types-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
> -		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +		$(qapi-gen-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
>  qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
:\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qap=
i-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(qapi-visit-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
> -		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +		$(qapi-gen-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
>  qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal=
.c :\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(=
qapi-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(qapi-commands-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
> -		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +		$(qapi-gen-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
>=20=20
> -qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
> -               $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
> -               $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.j=
son \
> -               $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json=
 \
> -               $(SRC_PATH)/qapi/trace.json
> -
>  qapi-types.c qapi-types.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> +$(qapi-modules) $(qapi-types-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
> -		$(gen-out-type) -o "." -b $<, \
> +		$(qapi-gen-type) -o "." -b $<, \
>  		"GEN","$@")
>  qapi-visit.c qapi-visit.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
> +$(qapi-modules) $(qapi-visit-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
> -		$(gen-out-type) -o "." -b $<, \
> +		$(qapi-gen-type) -o "." -b $<, \
>  		"GEN","$@")
>  qapi-event.c qapi-event.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
> +$(qapi-modules) $(qapi-event-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
> -		$(gen-out-type) -o "." $<, \
> +		$(qapi-gen-type) -o "." $<, \
>  		"GEN","$@")
>  qmp-commands.h qmp-marshal.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
> +$(qapi-modules) $(qapi-commands-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
> -		$(gen-out-type) -o "." $<, \
> +		$(qapi-gen-type) -o "." $<, \
>  		"GEN","$@")
>  qmp-introspect.h qmp-introspect.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
> +$(qapi-modules) $(qapi-introspect-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
> -		$(gen-out-type) -o "." $<, \
> +		$(qapi-gen-type) -o "." $<, \
>  		"GEN","$@")
>=20=20
>  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
> diff --git a/qapi.mak b/qapi.mak
> new file mode 100644
> index 0000000000..70196127d9
> --- /dev/null
> +++ b/qapi.mak
> @@ -0,0 +1,14 @@
> +qapi-gen-type =3D $(subst .,-,$(suffix $@))
> +
> +qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
> +       $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
> +       $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
> +       $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
> +       $(SRC_PATH)/qapi/trace.json
> +
> +qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
> +qapi-types-py =3D $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> +qapi-visit-py =3D $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
> +qapi-commands-py =3D $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
> +qapi-introspect-py =3D $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
> +

.git/rebase-apply/patch:111: new blank line at EOF.

I'm not sure separating the variables from the rules using them is a
good idea.  Perhaps I'll understand once you explain *why* you're doing
this.
