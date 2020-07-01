Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C993C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ADF206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaesLXJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ADF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZFM-0004tz-5o
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqZEo-0004Ut-Gs
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:41:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqZEm-0007pc-42
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593596462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ZRktC2pp2ziUJZ1/ll+bHHqGCnBnsNQoQITIOdWtmU=;
 b=eaesLXJuimI6J2cdJxZx3AMp4LhYxaNmbU+h4VGwQINCVWUaIXC90rMXZbgGrSFZaFs7Y6
 z4cvPHdbnJwzBIruI/60IM8fd+ShAP8oqvV7GoFdYZu89mGYaLiL/c+tlJBMx+tSwAOTlz
 IYDpcksTLDSfzFKuTL7vdX6vYj3mkvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-7wlO5HFsMAyaJmMimLd5sw-1; Wed, 01 Jul 2020 05:41:01 -0400
X-MC-Unique: 7wlO5HFsMAyaJmMimLd5sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28A681902EA7;
 Wed,  1 Jul 2020 09:40:59 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C529C741A2;
 Wed,  1 Jul 2020 09:40:52 +0000 (UTC)
Date: Wed, 1 Jul 2020 10:40:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 13/21] multi-process: Forward PCI config space acceses
 to the remote process
Message-ID: <20200701094051.GF126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <736d124ffb6c58e8061baba2503981f5e8b3f70b.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <736d124ffb6c58e8061baba2503981f5e8b3f70b.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:35AM -0700, elena.ufimtseva@oracle.com wrote:
> @@ -42,6 +48,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondit=
ion cond,
>      case CONNECT_DEV:
>          process_connect_dev_msg(&msg, ioc, &local_err);
>          break;
> +    case PCI_CONFIG_WRITE:
> +        process_config_write(ioc, pci_dev, &msg);
> +        break;
> +    case PCI_CONFIG_READ:
> +        process_config_read(ioc, pci_dev, &msg);
> +        break;

pci_dev is NULL when mpqemu_process_msg() is called on the main socket.
This is an example of how the N:1 model complicates things.  Now
process_config_read/write() need to check that pci_dev is non-NULL to
avoid crashing.

>      default:
>          error_setg(&local_err, "Unknown command (%d) received from proxy=
 \
>                     in remote process pid=3D%d", msg.cmd, getpid());
> @@ -89,3 +101,45 @@ exit:
> =20
>      mpqemu_msg_send(&ret, com);
>  }
> +
> +static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
> +                                 MPQemuMsg *msg)
> +{
> +    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> +    MPQemuMsg ret =3D { 0 };
> +
> +    if (conf->addr >=3D PCI_CFG_SPACE_EXP_SIZE) {

This check treats all devices as PCIe devices. Traditional PCI devices
have a smaller config space and pci_default_write_config() has an
assertion that fails on out-of-bounds writes:

  assert(addr + l <=3D pci_config_size(d));

Are you sure all devices are PCIe? If yes, please enforce that in the
code. If no, then please fix the size check.

> +struct conf_data_msg {
> +    uint32_t addr;
> +    uint32_t val;
> +    int l;
> +};

QEMU coding style uses typedefs:

  typedef struct {
      uint32_t addr;
      uint32_t val;
      int l;
  } ConfDataMsg;

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78WiMACgkQnKSrs4Gr
c8jYWgf+NeT1ihCS2FskPLXKSGmQah9K8ViTawP8036kDOEatxVp4d8U25JsQpqT
PiP3LoSmlSX9QZkyrQh1i4LXcBblofeSlRWa/o2cN8WNZnWgc6f54EGyQI24SchU
SEM/hvn62OxO2bswhyqSIlmU7PbDO0gN5mPg6bo2KFppCpGxspoOaP2IADJiyzAc
28IyJ22snSM9HLzkMxx2MWfCGPGewT1CLfBcqaXRkplCTNRLhk+/Gg4SzhLzAXPj
AK9dGo+IL1KP/ryKGmYGJBh+t/Pw++k/t0umjnSFYmsmtVMG/eKRmT8XOII3la5E
h94D96cqyNqhZX0slbuh8p2YhFxayQ==
=HBJB
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--


