Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F13C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DD52089F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UADLA0e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DD52089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkZL-0003VO-Rw
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXkYZ-0002UM-B0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXkYX-0008W5-R0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:23:27 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXkYX-0008VZ-FC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:23:25 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so3961134wrr.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3PFr5QSS2uj5c56qcvXCX/7Hi9Xdr/bG2+dQofwf+3I=;
 b=UADLA0e0jX8JPxrPU72TDV/+HCTd6ewre8S2v/HMsbZnvGEAQ/UzXlsNKlHt2bQp9u
 D20c78Ki8jbnB043brjmsrSSIV5SGsJfa09La8ygRKMNvxv3CdbtnAmd/GFT+zQkPi1J
 iEeGCWq8dVhv8W6OLoEgGySUyed+8n6ys+E+D76zaUlezYT727xT/k1c+5X/V48NRwNl
 iIFh97aFGC37lTUcT39gjJPkifNIz77vEf7MOsg5uySCcI4SK73JJMS7N2GzNi6ak8LU
 N4djYDJ6g7kgFXtO6y8e8rpz3dhGRU0/CohP6kv9owTFZg5N1vBk0qHXhruL9QAJ8Esx
 Hwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3PFr5QSS2uj5c56qcvXCX/7Hi9Xdr/bG2+dQofwf+3I=;
 b=dtHx8mc+wOF0wJWOX/W0hlzTjQUxEZD+pIJM5rgZ+gBi/ivFupF5OQYu50q1SZnSd2
 7ii2GQTnszZjwMZrWxx3bZd+zCxQ1N/e96iJGVRf88rw1cI1uRFThrV/so8OPQLhmzoX
 Nm+gpz8T6Cjl7uyawFODFx+u81zQUfXWS3vWPA+9I70WaFcjwN+GTMZZgElk+DY0Dhl1
 ahSYZTnXGzH83TkMZjVs/7ZwrqppU7EBByJmoW5RZoyBgbJN7ZGpITxemis2ecsbSWkB
 0jTcXzHaoDJ5QglCx2qDIxIYuVB5RI1XJjR2FNDm66RCVZMFsefM+4Rdnx2psqhj4y1H
 YsEg==
X-Gm-Message-State: APjAAAV+sxhonj2Mf3+vDO0wrWM74k4tB29EmQq7oOOuA2HTXRXAx+gf
 3+msj3rJ9MOsGgbuw13j7VI=
X-Google-Smtp-Source: APXvYqxMzCgtmV0Hr5JVHRLbck7DiXWlvBPnp5ka/K8qEf6tERdkF3Kt+s0istLIVYc2OoJg3IUPsA==
X-Received: by 2002:adf:a1c5:: with SMTP id v5mr10510591wrv.62.1574335404146; 
 Thu, 21 Nov 2019 03:23:24 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a6sm3115649wrh.69.2019.11.21.03.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 03:23:23 -0800 (PST)
Date: Thu, 21 Nov 2019 11:23:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 14/49] mutli-process: build remote command line args
Message-ID: <20191121112322.GI439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <8d1ffc03424e664000eb65186bef0362cd1a5fd6.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
In-Reply-To: <8d1ffc03424e664000eb65186bef0362cd1a5fd6.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:55AM -0400, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  New patch in v3
>=20
>  hw/proxy/qemu-proxy.c         | 80 +++++++++++++++++++++++++++++++++----=
------
>  include/hw/proxy/qemu-proxy.h |  2 +-
>  2 files changed, 62 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index baba4da..ca7dd1a 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -45,47 +45,89 @@
> =20
>  static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> =20
> +static int add_argv(char *command_str, char **argv, int argc)
> +{
> +    int max_args =3D 64;
> +
> +    if (argc < max_args - 1) {
> +        argv[argc++] =3D command_str;
> +        argv[argc] =3D 0;
> +    } else {
> +        return 0;
> +    }
> +
> +    return argc;
> +}
> +
> +static int make_argv(char *command_str, char **argv, int argc)
> +{
> +    int max_args =3D 64;
> +
> +    char *p2 =3D strtok(command_str, " ");
> +    while (p2 && argc < max_args - 1) {
> +        argv[argc++] =3D p2;
> +        p2 =3D strtok(0, " ");
> +    }
> +    argv[argc] =3D 0;
> +
> +    return argc;
> +}

So "command" isn't really the command-line, it's a string of options to
append to the hardcoded qemu-scsi-dev command?

This needs to command-line string construction needs to be cleaned up
and the hardcoded qemu-scsi-dev needs to be replaced with an argument.

> +
>  int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)

Error handling code is currently inconsistent because there is an int
-errno return value and an errp argument.  For example, errp isn't set
when pdev->managed =3D=3D true.

The int -errno return value isn't needed.  It can be just be bool and
errp should be set in every single error code path.

>  {
> -    char *args[3];
>      pid_t rpid;
>      int fd[2] =3D {-1, -1};
>      Error *local_error =3D NULL;
> +    char *argv[64];
> +    int argc =3D 0, _argc;
> +    char *sfd;
> +    char *exec_dir;
> +    int rc =3D -EINVAL;
> =20
>      if (pdev->managed) {
>          /* Child is forked by external program (such as libvirt). */
> -        return -1;
> +        return rc;
>      }
> =20
>      if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
>          error_setg(errp, "Unable to create unix socket.");
> -        return -1;
> +        return rc;
>      }
> +    exec_dir =3D g_strdup_printf("%s/%s", qemu_get_exec_dir(), "qemu-scs=
i-dev");
> +    argc =3D add_argv(exec_dir, argv, argc);
> +    sfd =3D g_strdup_printf("%d", fd[1]);
> +    argc =3D add_argv(sfd, argv, argc);
> +    _argc =3D argc;
> +    argc =3D make_argv((char *)command, argv, argc);
> +
>      /* TODO: Restrict the forked process' permissions and capabilities. =
*/
>      rpid =3D qemu_fork(&local_error);
> =20
>      if (rpid =3D=3D -1) {
>          error_setg(errp, "Unable to spawn emulation program.");
>          close(fd[0]);
> -        close(fd[1]);
> -        return -1;
> +        goto fail;
>      }
> =20
>      if (rpid =3D=3D 0) {
>          close(fd[0]);
> -
> -        args[0] =3D g_strdup(command);
> -        args[1] =3D g_strdup_printf("%d", fd[1]);
> -        args[2] =3D NULL;
> -        execvp(args[0], (char *const *)args);
> +        execvp(argv[0], (char *const *)argv);
>          exit(1);
>      }
>      pdev->remote_pid =3D rpid;
> -    pdev->rsocket =3D fd[0];
> +    pdev->rsocket =3D fd[1];
> +    pdev->socket =3D fd[0];

Please choose meaningful names for these fields.  I'm not sure why both
need to be kept around though...

> =20
> +    rc =3D 0;
> +
> +fail:
>      close(fd[1]);
> =20
> -    return 0;
> +    for (int i =3D 0; i < _argc; i++) {
> +        g_free(argv[i]);
> +    }
> +
> +    return rc;
>  }
> =20
>  static int get_proxy_sock(PCIDevice *dev)
> @@ -94,7 +136,7 @@ static int get_proxy_sock(PCIDevice *dev)
> =20
>      pdev =3D PCI_PROXY_DEV(dev);
> =20
> -    return pdev->rsocket;
> +    return pdev->socket;
>  }
> =20
>  static void set_proxy_sock(PCIDevice *dev, int socket)
> @@ -103,7 +145,7 @@ static void set_proxy_sock(PCIDevice *dev, int socket)
> =20
>      pdev =3D PCI_PROXY_DEV(dev);
> =20
> -    pdev->rsocket =3D socket;
> +    pdev->socket =3D socket;
>      pdev->managed =3D true;
> =20
>  }
> @@ -198,16 +240,16 @@ static void pci_proxy_dev_register_types(void)
> =20
>  type_init(pci_proxy_dev_register_types)
> =20
> -static void init_proxy(PCIDevice *dev, char *command, Error **errp)
> +static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, E=
rror **errp)
>  {
>      PCIProxyDev *pdev =3D PCI_PROXY_DEV(dev);
>      Error *local_error =3D NULL;
> =20
>      if (!pdev->managed) {
> -        if (command) {
> -            remote_spawn(pdev, command, &local_error);
> -        } else {
> -            return;
> +        if (need_spawn) {

pdev->managed, command =3D=3D NULL, need_spawn are all ways of checking
whether the remote process needs to be spawned.  Why are all of them
necessary and can they be simplified?

> +            if (!remote_spawn(pdev, command, &local_error)) {
> +                return;

local_error needs to be propagated.

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Wc6oACgkQnKSrs4Gr
c8hSTAf7BeG9RZqwvBTew1L8VkwJ8gCWyz6iltCRGsZg7sfsUPX2VfW8x1/Rr1pI
a0SWwmLuk1M4nvPJskRs7/EppESsEYvDBuiN2tYc1hM3s4q6jME+zMffsPcd0Rrg
RHz46qqCNzF63/AQOdf2XLXjBOA7xmQHR9oLWxoMQ2cFluh4GnpNi8wY2kvedcOT
HgYUadKbu/iJJqSpuBOwmO5dfcrgXXdB+4WOyrhBce/C98t9DbdefO4GV6/DMStQ
vKU6AImsfqzujZF6Mgy5d/g5HQ8bHeXolbX+bO5hnCMUfL5ruYo3ml4y0dxPK/lV
xWIPQV9qFAJqxkNMxqcLWDz4dyqDVw==
=IeSM
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--

