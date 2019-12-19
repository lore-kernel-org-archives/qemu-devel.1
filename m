Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB01C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4232146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7AZTF4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4232146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihySL-0002Kd-U5
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihyRe-0001t1-Iz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihyRc-00079z-PR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:14:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihyRc-00071k-Au
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:14:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id b19so6012615wmj.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ab/Jk3SSsWeaCBWMLoecVZqoUNqvSUKrPgb7UIjWBP8=;
 b=k7AZTF4wgH17DCfMANQF+oxpl/GD7sMnYlz0uwliXWKCsgyTk2ytP4A1YUQnzAxlBG
 eyvtXtfYV2+XxbntnbvouCcw5SbBuRLwD1WXGgklYr71aQoC2DPAyIDxhXRjkfJe8fnj
 w+i9pZZXTRWIS4lkaTUA8g49ITA1rk6xo8JIrp/edcNIjW5oVPkOrHfbV49b20kCuznI
 qXpYJEt4S/mNUQb2xG5qrCs+D6K5gwLVteabDgfGqSXRiBkH+sVpljO8STM+yJj/03xt
 uES5x7xePDx1y+b64pyv+mRW0TSzswPTzlBRGSiUwcrHqx7eM45xd8fvokmLlh7v+nxY
 M27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ab/Jk3SSsWeaCBWMLoecVZqoUNqvSUKrPgb7UIjWBP8=;
 b=IViZAEtlwEriNXMDcw6koQfFfg7fWzflfrMgMN0E9oxCCaeUBIDpJEnBYBscLe3ZHw
 guN+cd+nBaOzIM8sjpByIfCDIqa4soWeOaaonh5KaK1ZgtfjLongw8MB43xuMu4cfAC0
 70pz/gCRsFShCodxPvN8CaCPzv+W2genN1vdc+O8jXFECkPMYoWrP1GeqLG4CX77sFdL
 0hr5PRGnyDQkhB46QIsVqIRn7wP7hPWMRayE2O1KkvgUtkTlZOW2MWopuK9vaEUZ91vZ
 oM4+YTM+wEBJXcNe/GDd7Tkf0QNNKXTT338Vqa9HvKlbaO9woXNGNx8yybxs5dW4vbpr
 C5VA==
X-Gm-Message-State: APjAAAUVRY03YBvL9u816mLLjBwhI91DGEq/iusMw+dQpNqZ4mAlq7oH
 +rniV8gHu79oQkGlANYISgE=
X-Google-Smtp-Source: APXvYqzr0Z4BOWt7zXNEv2QPcnzBBGbx/uiO/WnpyA5GsGC9Ah6OorPa4YPGOYD+gZyhIzZ6jBmFQg==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr11337379wmc.14.1576772070501; 
 Thu, 19 Dec 2019 08:14:30 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p26sm6437664wmc.24.2019.12.19.08.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:14:28 -0800 (PST)
Date: Thu, 19 Dec 2019 16:14:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191219161426.GH1624084@stefanha-x1.localdomain>
References: <20191209015331.5455-1-chanmickyyun@gmail.com>
 <20191211105916-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <20191211105916-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org,
 "Micky Yun Chan\(michiboo\)" <chanmickyyun@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 10:59:38AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 09, 2019 at 09:53:31AM +0800, Micky Yun Chan(michiboo) wrote:
> > From: Micky Yun Chan <chanmickyyun@gmail.com>
> >=20
> > This patch is to add standard commands defined in docs/interop/vhost-us=
er.rst
> > For vhost-user-* program
> >=20
> > Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
>=20
> Thanks!
> I'll queue it for merge after the release. If possible please ping me
> after the release to help make sure it didn't get dropped.

Ping, just in case :)

> > ---
> >  contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
> >  docs/interop/vhost-user.json            |  31 +++++++
> >  docs/interop/vhost-user.rst             |  17 ++++
> >  3 files changed, 112 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-us=
er-blk/vhost-user-blk.c
> > index ae61034656..6fd91c7e99 100644
> > --- a/contrib/vhost-user-blk/vhost-user-blk.c
> > +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> > @@ -576,70 +576,90 @@ vub_new(char *blk_file)
> >      return vdev_blk;
> >  }
> > =20
> > +static int opt_fdnum =3D -1;
> > +static char *opt_socket_path;
> > +static char *opt_blk_file;
> > +static gboolean opt_print_caps;
> > +static gboolean opt_read_only;
> > +
> > +static GOptionEntry entries[] =3D {
> > +    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
> > +      "Print capabilities", NULL },
> > +    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
> > +      "Use inherited fd socket", "FDNUM" },
> > +    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
> > +      "Use UNIX socket path", "PATH" },
> > +    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
> > +     "block device or file path", "PATH"},
> > +    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
> > +      "Enable read-only", NULL }
> > +};
> > +
> >  int main(int argc, char **argv)
> >  {
> > -    int opt;
> > -    char *unix_socket =3D NULL;
> > -    char *blk_file =3D NULL;
> > -    bool enable_ro =3D false;
> >      int lsock =3D -1, csock =3D -1;
> >      VubDev *vdev_blk =3D NULL;
> > +    GError *error =3D NULL;
> > +    GOptionContext *context;
> > =20
> > -    while ((opt =3D getopt(argc, argv, "b:rs:h")) !=3D -1) {
> > -        switch (opt) {
> > -        case 'b':
> > -            blk_file =3D g_strdup(optarg);
> > -            break;
> > -        case 's':
> > -            unix_socket =3D g_strdup(optarg);
> > -            break;
> > -        case 'r':
> > -            enable_ro =3D true;
> > -            break;
> > -        case 'h':
> > -        default:
> > -            printf("Usage: %s [ -b block device or file, -s UNIX domai=
n socket"
> > -                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> > -            return 0;
> > +    context =3D g_option_context_new(NULL);
> > +    g_option_context_add_main_entries(context, entries, NULL);
> > +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> > +        g_printerr("Option parsing failed: %s\n", error->message);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    if (opt_print_caps) {
> > +        g_print("{\n");
> > +        g_print("  \"type\": \"block\",\n");
> > +        g_print("  \"features\": [\n");
> > +        g_print("    \"read-only\",\n");
> > +        g_print("    \"blk-file\"\n");
> > +        g_print("  ]\n");
> > +        g_print("}\n");
> > +        exit(EXIT_SUCCESS);
> > +    }
> > +
> > +    if (!opt_blk_file) {
> > +        g_print("%s\n", g_option_context_get_help(context, true, NULL)=
);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    if (opt_socket_path) {
> > +        lsock =3D unix_sock_new(opt_socket_path);
> > +        if (lsock < 0) {
> > +            exit(EXIT_FAILURE);
> >          }
> > +    } else if (opt_fdnum < 0) {
> > +        g_print("%s\n", g_option_context_get_help(context, true, NULL)=
);
> > +        exit(EXIT_FAILURE);
> > +    } else {
> > +        lsock =3D opt_fdnum;
> >      }
> > =20
> > -    if (!unix_socket || !blk_file) {
> > -        printf("Usage: %s [ -b block device or file, -s UNIX domain so=
cket"
> > -               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> > -        return -1;
> > -    }
> > -
> > -    lsock =3D unix_sock_new(unix_socket);
> > -    if (lsock < 0) {
> > -        goto err;
> > -    }
> > -
> > -    csock =3D accept(lsock, (void *)0, (void *)0);
> > +    csock =3D accept(lsock, NULL, NULL);
> >      if (csock < 0) {
> > -        fprintf(stderr, "Accept error %s\n", strerror(errno));
> > -        goto err;
> > +        g_printerr("Accept error %s\n", strerror(errno));
> > +        exit(EXIT_FAILURE);
> >      }
> > =20
> > -    vdev_blk =3D vub_new(blk_file);
> > +    vdev_blk =3D vub_new(opt_blk_file);
> >      if (!vdev_blk) {
> > -        goto err;
> > +        exit(EXIT_FAILURE);
> >      }
> > -    if (enable_ro) {
> > +    if (opt_read_only) {
> >          vdev_blk->enable_ro =3D true;
> >      }
> > =20
> >      if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
> >                    vub_panic_cb, &vub_iface)) {
> > -        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> > -        goto err;
> > +        g_printerr("Failed to initialize libvhost-user-glib\n");
> > +        exit(EXIT_FAILURE);
> >      }
> > =20
> >      g_main_loop_run(vdev_blk->loop);
> > -
> > +    g_main_loop_unref(vdev_blk->loop);
> > +    g_option_context_free(context);
> >      vug_deinit(&vdev_blk->parent);
> > -
> > -err:
> >      vub_free(vdev_blk);
> >      if (csock >=3D 0) {
> >          close(csock);
> > @@ -647,8 +667,8 @@ err:
> >      if (lsock >=3D 0) {
> >          close(lsock);
> >      }
> > -    g_free(unix_socket);
> > -    g_free(blk_file);
> > +    g_free(opt_socket_path);
> > +    g_free(opt_blk_file);
> > =20
> >      return 0;
> >  }
> > diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> > index da6aaf51c8..ce0ef74db5 100644
> > --- a/docs/interop/vhost-user.json
> > +++ b/docs/interop/vhost-user.json
> > @@ -54,6 +54,37 @@
> >    ]
> >  }
> > =20
> > +##
> > +# @VHostUserBackendBlockFeature:
> > +#
> > +# List of vhost user "block" features.
> > +#
> > +# @read-only: The --read-only command line option is supported.
> > +# @blk-file: The --blk-file command line option is supported.
> > +#
> > +# Since: 5.0
> > +##
> > +{
> > +  'enum': 'VHostUserBackendBlockFeature',
> > +  'data': [ 'read-only', 'blk-file' ]
> > +}
> > +
> > +##
> > +# @VHostUserBackendCapabilitiesBlock:
> > +#
> > +# Capabilities reported by vhost user "block" backends
> > +#
> > +# @features: list of supported features.
> > +#
> > +# Since: 5.0
> > +##
> > +{
> > +  'struct': 'VHostUserBackendCapabilitiesBlock',
> > +  'data': {
> > +    'features': [ 'VHostUserBackendBlockFeature' ]
> > +  }
> > +}
> > +
> >  ##
> >  # @VHostUserBackendInputFeature:
> >  #
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 7827b710aa..015ac08177 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1376,3 +1376,20 @@ Command line options:
> >    Enable virgl rendering support.
> > =20
> >    (optional)
> > +
> > +vhost-user-blk
> > +--------------
> > +
> > +Command line options:
> > +
> > +--blk-file=3DPATH
> > +
> > +  Specify block device or file path.
> > +
> > +  (optional)
> > +
> > +--read-only
> > +
> > +  Enable read-only.
> > +
> > +  (optional)
> > --=20
> > 2.21.0
>=20
>=20

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37oeIACgkQnKSrs4Gr
c8hUmQf/fOrrOSy5b5q+iFPzpKG4h46JKPDpBirvsJ6RvJfDa9NAm6D9cUpukjRT
ZZjbbuSQAf1UHjd+/Ajpj1WbH8CVEUNr89nQD2mgreaqp+IpiZysf6xxMKMkRn0U
ooJu0ka7eS34DspmSK73O+fKJUL+GlcxcS1NxNz631E0Me0kVGmp+bM9psFbFo/y
5Gw3ljqDrWOculZ/gw4wjSvaE9S+USIpx7tcBVFn+7Nvm4hC8nD7qN0AjgWet+wZ
L93PxPFGRkVAuFPxWaj4hC8D/NN8mNC/MmJ3p3mHU5fexOQOelLFntaon+Nq4678
im065MhkHcSvrA0eoaOeoQqIvNfT4w==
=mBu5
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--

