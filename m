Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706EEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9F2214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDHzbuxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9F2214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Jn-0007eF-2V
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS1II-0006O3-Fo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS1IH-000644-9T
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:02:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS1IH-00063D-1a
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:02:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id c22so20758952wmd.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qQXriDAmGVYWmDIQ5Z6gRehd77sJ5yWG2d1HzcVfMzQ=;
 b=IDHzbuxWN6TQMmuxKO0FuR0cGlEVDsvezOKU/RE+Du5P+5KdT3fYFLDNuAB8QpOFfS
 hTUGw8xp+s3CJu7Ye9Dfmhq2FnOyGB4b1rc/z8ZctWzOGRY4/GYgYg4blKkdQJm8hzXU
 ByPIfK06VC6Q6inKj9poEn5ZcwWO6jOiy9dCP+yt0CXspNUtpeVD2qB2dAbjqf3cf4IF
 HXp7DwAZVqGvrYk4ob9TNX9hYENfXHNKDJzBbw3R7pjANBlzW2ZYp6atLuAsRQjZyNvz
 K7Y7s+kcHfn3r+DndoDz7a7oE2j4Cv6PiEle8uvXTX55NfI8NDKWpu+ifWSwzflZOXDr
 6VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qQXriDAmGVYWmDIQ5Z6gRehd77sJ5yWG2d1HzcVfMzQ=;
 b=d2B2OH7XlstDrHuk2JMoprpOdhdtdtM4q8+Ki4cWtJblx0nLcBu6yWkICQs9j5RV7e
 6V0SZ9ZeyNEpcExZZpI9ZzCSAaT4Ii8H4uN2SeGUeob+TGvDwThAG3WiUGheCZcMYzWU
 oFsHO9lqjk3zq6AKpIrsqR0WG4RtLusuF2Avi8Bj5RLVZdhbkJMizEJs0cqTkxJSyDwD
 eaGy7yyrbaYDqT3UKKQvyMspaSUSvd4gv1pkaFAuTtPvApsL6feRCeE0KtC++7Yj1d6o
 dsbC2UrcJALdCWnUFuDfH1HtTMWzB6+Mvlvu22HmPdRZ33hIia65lo6gGmda4lvX2CH0
 D8qw==
X-Gm-Message-State: APjAAAUEdVtFdoaOkrNASpRWPtHdSQZKQKbNDj0AGTC4v26XtVKlJE6U
 7dyTcPhFNHI2+Ztd8RQiOcI=
X-Google-Smtp-Source: APXvYqxiLmAUKF2Hl5V/OmX7t/aXae/gARX8JNcUR4BcfRwGIXQ2zmrKKu+q9Vd+LwyFqCKXy1c+fQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr4755769wmk.85.1572969775413;
 Tue, 05 Nov 2019 08:02:55 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id h205sm22920909wmf.35.2019.11.05.08.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 08:02:54 -0800 (PST)
Date: Tue, 5 Nov 2019 17:02:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC 3/3] tests/vhost-user-fs-test: add vhost-user-fs test case
Message-ID: <20191105160252.GF166646@stefanha-x1.localdomain>
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-4-stefanha@redhat.com>
 <20191029003605.GC2508@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20191029003605.GC2508@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2019 at 12:36:05AM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > +static void after_test(void *arg G_GNUC_UNUSED)
> > +{
> > +    unlink(socket_path);
> > +
> > +    remove_dir_and_children(shared_dir);
>=20
> This scares me. Especially since it's running as root.
> Can we add a bunch of paranoid checks to make sure it doesn't
> end up rm -rf / ?

Yes, we can resolve the path and check it is not "/".

> > +/* Open a file by nodeid using FUSE_OPEN */
> > +static int32_t fuse_open(QVirtioFS *vfs, uint64_t nodeid, uint32_t fla=
gs,
> > +                         uint64_t *fh)
> > +{
> > +    struct fuse_in_header in_hdr =3D {
> > +        .opcode =3D guest32(FUSE_OPEN),
> > +        .unique =3D guest64(virtio_fs_get_unique(vfs)),
> > +        .nodeid =3D guest64(nodeid),
> > +    };
> > +    struct fuse_open_in in =3D {
> > +        .flags =3D guest32(flags),
> > +    };
> > +    struct iovec sg_in[] =3D {
> > +        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
> > +        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
> > +    };
> > +    struct fuse_out_header out_hdr;
> > +    struct fuse_open_out out;
> > +    struct iovec sg_out[] =3D {
> > +        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
> > +        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
> > +    };
>=20
> I wonder if anything can be done to reduce the size of the iovec boiler
> plate?

I'm not aware of a clean way to build the iovec array automatically but
we could do this if you prefer it:

  #define IOVEC(elem) { .iov_base =3D &elem, .iov_len =3D sizeof(elem) }

  struct iovec sg_in[] =3D {
    IOVEC(in_hdr),
    IOVEC(in),
  };

Do you find this nicer?

Stefan

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BnSwACgkQnKSrs4Gr
c8jMdwf/dPuWyPiILgjVQyqoBW4i4LYRi2NqilkJDN5b9Is1n1dmVvfhtTnH748o
Ex2by9FJVrRcaP7cENH6wQEJgN4IlrUfKn28Y+Ge42aDFjkHm3N7/BlgJJojrJmh
89hcnr1n2eEVD/GrLbEfIxLCNZ64379gvlGZCPd3WQJ0nOUD1R4CeaJRRYODg6gK
sXUJqIXAzi62k0OfiSibvSPTnlf5XK1mh9VbSC2K2NNIgW1fmaxt3q2jr1gknt0/
k72CZENM6Jjhyb5GEzykXigCIrrJBAnO5sxNbp0xzdD3z/UxI8WtBkodDDEZjB0S
DxXnVgUawY4sos0uEjaK6Zp8W2i92g==
=wxgU
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

