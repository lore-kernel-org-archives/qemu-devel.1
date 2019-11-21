Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA912067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCicoesY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA912067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlQG-0007xa-BL
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlOH-0007Hi-67
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlOF-0006Ku-Bl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:16:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlOF-0006I3-3j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:16:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id 8so3478999wmo.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xEtXjXmv76ln1FAj7Tbw42qQ3LSqnC5XTqwjyD2O4mo=;
 b=oCicoesYWxQvhqOyrfj4OlUQLxEWXHIe6Bruc/d5PBQFGuFMxcEd7QK2eII1g+jFrg
 SVbnRo37BW1KmKX4JX/ojHjILCZL75xLrLHbx+GZ8o9VYE9kdV275lui+dvcU+dwyrHH
 SaQktZYkwHHkZtaACaXcSjKBt209Uvxtpd75wFWPzlKh+hE76yeTDWrYMIAczpdM4OM8
 JrGuEoXqRMi1rOyrPq0Zef5w1M6zzlCfA7FL+Gt6u9moX+5rj2LazuHB8wzDcxHqbpLL
 bRTpsS5XN9X+qcUVbYzYemcajeE7CCzk4bAmjwpUlKi3yTVGIaCUTxHAMDRSMy9Yxens
 gKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xEtXjXmv76ln1FAj7Tbw42qQ3LSqnC5XTqwjyD2O4mo=;
 b=PjGnGnllSxSDyG70OFBZxdJtUseTD/K4vryuXwEiiNKuSOAftWMiZ+Mcug2tkC392u
 dAqv/ECG2wq2xiCKA0DDHYC5M9W6tI6PcSeDbddlnsHwKzpTyOWpppQIaqnJzp20/0CE
 oCukLFI/OvARPTEUXrgooFjacbHyEh0R5AHaJFPyjNMg1IORHCTPSKcinUh0M/LReGsL
 veIzYpzc/BrxASUpNThswkYhads2otR67wRfS0msnntKlWDV6EYPVEi1S+HBepXXSf0n
 AkRLxv2IvjKz1sYW65Kj0Xj3AgcM2eO2GpVlNxny4Euumjrsshu2rcympDbM4ebIX/Vx
 oB2Q==
X-Gm-Message-State: APjAAAXocG3nL/kNMfS+C7LgOvZMO2oMKKdPG4E4JW6zehfgpmbdLBqW
 WxFrWlfDRFnhBTGe9J95rS0=
X-Google-Smtp-Source: APXvYqyZ34gAOpyI/qHrIzhFDwo/6uW8V0V3gVhHaS9V/TsjJqdFEWy17KVk6VAS0quSABc3dOXN8g==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr9178763wmj.106.1574338609025; 
 Thu, 21 Nov 2019 04:16:49 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w19sm2620961wmk.36.2019.11.21.04.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:16:48 -0800 (PST)
Date: Thu, 21 Nov 2019 12:16:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 20/49] multi-process: add qdev_proxy_add to create
 proxy devices
Message-ID: <20191121121647.GO439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <36de8c87e14b6623fd1a570c0c34dd0667ba8aec.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CbqR2XcyIs6OSP+I"
Content-Disposition: inline
In-Reply-To: <36de8c87e14b6623fd1a570c0c34dd0667ba8aec.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


--CbqR2XcyIs6OSP+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:09:01AM -0400, Jagannathan Raman wrote:
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 3b84055..fc1c731 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -337,7 +337,8 @@ static void init_proxy(PCIDevice *dev, char *command,=
 bool need_spawn, Error **e
> =20
>      if (!pdev->managed) {
>          if (need_spawn) {
> -            if (!remote_spawn(pdev, command, &local_error)) {
> +            if (remote_spawn(pdev, command, &local_error)) {
> +                fprintf(stderr, "remote spawn failed\n");
>                  return;
>              }
>          }

Looks like a fix for a bug in a previous patch.  Please squash it.
Also, please propagate local_err and do not use fprintf in a function
that has an errp argument for reporting errors.

> +#if defined(CONFIG_MPQEMU)

Maybe these functions should be in a separate file that the makefile
includes when CONFIG_MPQEMU is defined.

> +
> +static PCIProxyDev *get_proxy_object_rid(const char *rid)
> +{
> +    PCIProxyDev *entry;
> +    if (!proxy_list_lock.initialized) {
> +        QLIST_INIT(&proxy_dev_list.devices);
> +        qemu_mutex_init(&proxy_list_lock);
> +    }

This locking approach is broken since exactly-once initialization
semantics are required to avoid races during initialization.  Is the
lock needed at all?

> +DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp)
> +{
> +    PCIProxyDev *pdev =3D NULL;
> +    DeviceState *dev;
> +    const char *rid, *rsocket =3D NULL, *command =3D NULL;
> +    QDict *qdict_new;
> +    const char *id =3D NULL;
> +    const char *driver =3D NULL;
> +    const char *bus =3D NULL;
> +
> +    if (!proxy_list_lock.initialized) {
> +        QLIST_INIT(&proxy_dev_list.devices);
> +        qemu_mutex_init(&proxy_list_lock);
> +    }
> +
> +    rid =3D qemu_opt_get(opts, "rid");
> +    if (!rid) {
> +        error_setg(errp, "rdevice option needs rid specified.");
> +        return NULL;
> +    }
> +    if (device) {
> +        driver =3D qemu_opt_get(opts, "driver");
> +        /* TODO: properly identify the device class. */
> +        if (strncmp(driver, "lsi", 3) =3D=3D 0) {
> +            id =3D qemu_opts_id(opts);
> +            if (!id) {
> +                error_setg(errp, "qdev_remote_add option needs id specif=
ied.");
> +                return NULL;
> +            }
> +        }
> +    }
> +
> +    rsocket =3D qemu_opt_get(opts, "socket");
> +    if (rsocket) {
> +        if (strlen(rsocket) > MAX_RID_LENGTH) {
> +            error_setg(errp, "Socket number is incorrect.");
> +            return NULL;
> +        }
> +    }
> +    /*
> +     * TODO: verify command with known commands and on remote end.
> +     * How else can we verify the binary we launch without libvirtd supp=
ort?
> +     */
> +    command =3D qemu_opt_get(opts, "command");
> +    if (!rsocket && !command) {
> +        error_setg(errp, "rdevice option needs socket or command specifi=
ed.");
> +        return NULL;
> +    }
> +
> +    bus =3D qemu_opt_get(opts, "bus");
> +    dev =3D qdev_proxy_add(rid, id, (char *)bus, (char *)command,
> +                         rsocket ? atoi(rsocket) : -1,
> +                         rsocket ? true : false, errp);
> +    if (!dev) {
> +        error_setg(errp, "qdev_proxy_add error.");
> +        return NULL;
> +    }
> +
> +    qdict_new =3D qemu_opts_to_qdict(opts, NULL);
> +
> +    if (!qdict_new) {
> +        error_setg(errp, "Could not parse rdevice options.");
> +        return NULL;
> +    }
> +
> +    pdev =3D PCI_PROXY_DEV(dev);
> +    if (!pdev->set_remote_opts) {
> +        /* TODO: destroy proxy? */
> +        error_setg(errp, "set_remote_opts failed.");
> +        return NULL;
> +    } else {
> +        if (id && !pdev->dev_id) {
> +            pdev->dev_id =3D g_strdup(id);
> +        }
> +        pdev->set_remote_opts(PCI_DEVICE(pdev), qdict_new,
> +                              device ? DEV_OPTS : DRIVE_OPTS);

This function needs to be able to return an error if setting the options
failed.  A response message needs to be defined in the protocol to
support this.

Is DRIVE_OPTS still needed?  I thought the drives would be configured in
the remote process and no proxy objects were needed on the QEMU side?

--CbqR2XcyIs6OSP+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WgC8ACgkQnKSrs4Gr
c8iP7gf+Iozk9KLaeziSqIN6NZhAIvPBLgnlyd+vtpgV0hsD8dtuolshZ6Kmax1H
DlZ4NmVRk3+bwthuv1swLE/UjbD0m6VG56LqrMKtLsL6+jH7jXJF0RKmAxO4URoI
tJ2mfm0UywMOQNdakuu7vD4Umc2lP6uADIvgHX5wCvVWWtSF4l3jQkO4xBx8zK00
J5She/9kUrFzpju5USjrLHKY/r0TG78v+ztLdL555UVGUOL7EhgKzaw33NLTZuA3
AzVx2lIvbkpWhRfSqYOZwr0wKAguA0JtOGaCjJqLn8osyGXreoVpd5jtWpSnuyjB
1PTJUCI4YA2n4wp1V7YPk4h5kscj7w==
=Zsx2
-----END PGP SIGNATURE-----

--CbqR2XcyIs6OSP+I--

