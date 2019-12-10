Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19276C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D723F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amMiqEwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D723F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieXuU-0001wO-0X
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieXtr-0001XT-VS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieXto-0000VM-WE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:17:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieXto-0000UY-9l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575955047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0rLMjHQyXZgAzgSQEjl19TI4TtGmHyl5QXEq0zoz84=;
 b=amMiqEwK8gRBL3YkooOoBrfRFbXrQkY0ZthimmCPbYp7wN2znz/GEoKvAu5MmerR6B0aXQ
 n3VD5u8/j+x+eKzRD7Z8xddA3q6Gb0buGaF7W/iyW6BeJkOm5/OqnBbcczpDQrI7ntiDQo
 f0/1Cj/Qhny3/kzh2DPqgG+wbaEk6XI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-6E4eLNyeM4Shz0hubf1xUQ-1; Tue, 10 Dec 2019 00:17:25 -0500
X-MC-Unique: 6E4eLNyeM4Shz0hubf1xUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1B84800D41
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 05:17:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B92045C21B;
 Tue, 10 Dec 2019 05:17:19 +0000 (UTC)
Date: Tue, 10 Dec 2019 00:17:17 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
Message-ID: <20191210051717.GG31990@localhost.localdomain>
References: <20191112135801.854-1-wainersm@redhat.com>
 <20191112135801.854-2-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191112135801.854-2-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 08:58:00AM -0500, Wainer dos Santos Moschetta wrote=
:
> The QEMUMachine VM has a monitor setup on which an QMP
> connection is always attempted on _post_launch() (executed
> by launch()). In case the QEMU process immediatly exits
> then the qmp.accept() (used to establish the connection) stalls
> until it reaches timeout and consequently an exception raises.
>=20
> That behavior is undesirable when, for instance, it needs to
> gather information from the QEMU binary ($ qemu -cpu list) or a
> test which launches the VM expecting its failure.
>=20
> This patch adds the set_qmp_monitor() method to QEMUMachine that
> allows turn off the creation of the monitor machinery on VM launch.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  python/qemu/machine.py | 68 ++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index a4631d6934..04ee86e1ba 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -104,6 +104,7 @@ class QEMUMachine(object):
>          self._events =3D []
>          self._iolog =3D None
>          self._socket_scm_helper =3D socket_scm_helper
> +        self._qmp_set =3D True   # Enable QMP monitor by default.
>          self._qmp =3D None
>          self._qemu_full_args =3D None
>          self._test_dir =3D test_dir
> @@ -228,15 +229,16 @@ class QEMUMachine(object):
>                  self._iolog =3D iolog.read()
> =20
>      def _base_args(self):
> -        if isinstance(self._monitor_address, tuple):
> -            moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
> +        args =3D ['-display', 'none', '-vga', 'none']
> +        if self._qmp_set:
> +            if isinstance(self._monitor_address, tuple):
> +                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
>                  self._monitor_address[0],
>                  self._monitor_address[1])
> -        else:
> -            moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monitor
> -        args =3D ['-chardev', moncdev,
> -                '-mon', 'chardev=3Dmon,mode=3Dcontrol',
> -                '-display', 'none', '-vga', 'none']
> +            else:
> +                moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monit=
or
> +            args.extend(['-chardev', moncdev, '-mon',
> +                         'chardev=3Dmon,mode=3Dcontrol'])
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
>          if self._console_set:
> @@ -255,20 +257,21 @@ class QEMUMachine(object):
> =20
>      def _pre_launch(self):
>          self._temp_dir =3D tempfile.mkdtemp(dir=3Dself._test_dir)
> -        if self._monitor_address is not None:
> -            self._vm_monitor =3D self._monitor_address
> -        else:
> -            self._vm_monitor =3D os.path.join(self._sock_dir,
> -                                            self._name + "-monitor.sock"=
)
> -            self._remove_files.append(self._vm_monitor)
>          self._qemu_log_path =3D os.path.join(self._temp_dir, self._name =
+ ".log")
>          self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
> =20
> -        self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
> -                                            server=3DTrue)
> +        if self._qmp_set:
> +            if self._monitor_address is not None:
> +                self._vm_monitor =3D self._monitor_address
> +            else:
> +                self._vm_monitor =3D os.path.join(self._sock_dir,
> +                                                self._name + "-monitor.s=
ock")
> +                self._remove_files.append(self._vm_monitor)
> +            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, serv=
er=3DTrue)
> =20
>      def _post_launch(self):
> -        self._qmp.accept()
> +        if self._qmp:
> +            self._qmp.accept()
> =20
>      def _post_shutdown(self):
>          if self._qemu_log_file is not None:
> @@ -330,7 +333,8 @@ class QEMUMachine(object):
>          Wait for the VM to power off
>          """
>          self._popen.wait()
> -        self._qmp.close()
> +        if self._qmp:
> +            self._qmp.close()
>          self._load_io_log()
>          self._post_shutdown()
> =20
> @@ -346,12 +350,13 @@ class QEMUMachine(object):
>              self._console_socket =3D None
> =20
>          if self.is_running():
> -            try:
> -                if not has_quit:
> -                    self._qmp.cmd('quit')
> -                self._qmp.close()
> -            except:
> -                self._popen.kill()
> +            if self._qmp:
> +                try:
> +                    if not has_quit:
> +                        self._qmp.cmd('quit')
> +                    self._qmp.close()
> +                except:
> +                    self._popen.kill()
>              self._popen.wait()
> =20
>          self._load_io_log()
> @@ -368,6 +373,23 @@ class QEMUMachine(object):
> =20
>          self._launched =3D False
> =20
> +    def set_qmp_monitor(self, disabled=3DFalse, monitor_address=3DNone):
> +        """
> +        Set the QMP monitor.
> +
> +        @param disabled: if True, qmp monitor options will be removed fr=
om the
> +                         base arguments of the resulting QEMU command li=
ne.

I personally tend avoid double negatives as long as I'm aware of them.
Wouldn't "enabled=3DTrue" be more straightforward?  Just my personal
preference though.

> +        @param monitor_address: address for the QMP monitor.

Do you have a use case for passing the monitor address here too, in
addition to also being available as a parameter to __init__()?  In the
next patch, I don't see it being used (or here for that matter).

> +        @note: call this function before launch().
> +        """
> +        if disabled:
> +            self._qmp_set =3D False
> +            self._qmp =3D None
> +        else:
> +            self._qmp_set =3D True
> +            if monitor_address:
> +                self._monitor_address =3D monitor_address
> +
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>          """
>          Invoke a QMP command and return the response dict
> --=20
> 2.18.1
>=20

Other than those comments, it LGTM.

- Cleber.

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3vKloACgkQZX6NM6Xy
CfMGbQ//TczliLO0M8BYDRKl8nVYBFEoKUvnh713rMeXxcPIj55AATJs5VPvSltS
4Nf8PWL8i731VT2R5tm4J2xd+ETeUf3+CvOT/80CdEvo6Gi8+3zEp6rNTYYPjTOO
nnCqQtXB9MpkkPTfb0VDbjIf8O9mTlSYiJl1UMPhc23eAKABVde7OT/xi+CZsaIy
JWazf85E1IRaVLB5CDM9nBzdqaHzTJrd052A8ClnjbET+fSl8CWEWVpcwHp/SWki
xpNpeCEFTI40cKLGFQPPJtRmJgR1GTqb+7tyxEOw8wVZH4VTJFmLCznVX7ga5o+J
EHPIo5Wh6FW+G+vcjO1ThKILPGfWz9d/IeOueN8uyY0LixO+RMg11sIBr6VxT/LW
g+0N1/odOn8aozP+69PNDxDWT1rqulKaKBMHFVWxwsDvSoj5Th98PvG0VjmsreFJ
6nECeC0cxqJsOONtHa/oGSXiEOfsrcJgURadUnHUul9uwwfvOagjZUf8n0AISjhH
3nrgHd4mHZEhvot+WOf0EyEqckkqs13LjLfw+RqZywLz4IIjUjbrVzqHLZ9MdWld
G9K7Ze2LhQM23p3+GY0qabMGOtDOYJ8nItlLl1Px9yNYLBDvXGmS+jPA+pi/ht/Z
9N38nAf38l2dWZeoqmf9+oXT79HwE1NYkp12ttq2MskuL1qw8wk=
=gxdn
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--


