Received: from eggs.gnu.org ([2001:4830:134:3::10]:32890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dniGs-0007de-TR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dniGo-0003QU-Qz
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dniGo-0003QB-HV
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A72C7EA9A
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 09:29:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
Date: Fri, 01 Sep 2017 11:29:40 +0200
In-Reply-To: <20170831131425.3953-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 31 Aug 2017 14:14:24 +0100")
Message-ID: <878thydawr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] .dir-locals.el: add makefiles to
 auto-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> QEMU uses non-conventional makefile filenames. Ease the life of emacs
> developpers a bit by appending to the auto-mode-alist.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .dir-locals.el      | 7 ++++++-
>  Makefile.target     | 2 --
>  trace/Makefile.objs | 2 --
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> index 3ac0cfc6f0..13ec483765 100644
> --- a/.dir-locals.el
> +++ b/.dir-locals.el
> @@ -1,2 +1,7 @@
>  ((c-mode . ((c-file-style . "stroustrup")
> -	    (indent-tabs-mode . nil))))
> +            (indent-tabs-mode . nil)))
> + (nil . ((eval . (setq auto-mode-alist (append
> +                                        '(("Makefile.*" . makefile-gmake=
-mode)
> +                                          ("\\.mak\\'" . makefile-gmake-=
mode))
> +                                        auto-mode-alist))))
> +      ))

This makes Emacs ask for confirmation like this:

    The local variables list in /home/armbru/work/qemu/
    contains values that may not be safe (*).

    Do you want to apply it?  You can type
    y  -- to apply the local variables list.
    n  -- to ignore the local variables list.
    !  -- to apply the local variables list, and permanently mark these
          values (*) as safe (in the future, they will be set automatically=
.)

      * eval : (setq auto-mode-alist (append (quote (("Makefile.*" . makefi=
le-gmake-mode) ("\\.mak\\'" . makefile-gmake-mode) ("\\.json\\'" . python-m=
ode))) auto-mode-alist))

Not a nice user experience.  For detailed information why and how this
stuff works, see
https://www.gnu.org/software/emacs/manual/html_node/emacs/Safe-File-Variabl=
es.html

Why can't we simply use the usual file name extension like a normal
person?

If that's too much to ask, then I'd recommend adding modelines (like the
ones you delete) to the Makefiles that lack one.

> diff --git a/Makefile.target b/Makefile.target
> index 7f42c45db8..159602c83c 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -1,5 +1,3 @@
> -# -*- Mode: makefile -*-
> -
>  BUILD_DIR?=3D$(CURDIR)/..
>=20=20
>  include ../config-host.mak
> diff --git a/trace/Makefile.objs b/trace/Makefile.objs
> index afd571c3ec..d1f1e646e5 100644
> --- a/trace/Makefile.objs
> +++ b/trace/Makefile.objs
> @@ -1,5 +1,3 @@
> -# -*- mode: makefile -*-
> -
>  $(BUILD_DIR)/trace-events-all: $(trace-events-files)
>  	$(call quiet-command,cat $^ > $@)
