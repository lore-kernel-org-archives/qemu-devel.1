Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E7C561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6986F22251
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTNnXey+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6986F22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8qU-0004gC-4n
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kV8pi-0004FF-Pl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kV8ph-0000W0-25
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603266412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tF8Juzt5E2okTQleXTs3gZcw7Gm5tpAIOwBk1IB5zxw=;
 b=FTNnXey+pKjPga1EznDpcEMEmMQY/lj/b2VAVE1GlGi0P3R/ASWb4H92dRx2VPWSp9n3P2
 IYH296PfzkshewnTxVkCk8N6Gk9MUKnv3eMsFPrOt3KSC/2g2A5xxt9kJaio7bm27Z4rCu
 4ar07UBAPRWeLJeL+YQFOsgQglckaWA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-J0mIHHOpPJSx5X3HEY8_bw-1; Wed, 21 Oct 2020 03:46:48 -0400
X-MC-Unique: J0mIHHOpPJSx5X3HEY8_bw-1
Received: by mail-io1-f71.google.com with SMTP id u14so946472iof.14
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tF8Juzt5E2okTQleXTs3gZcw7Gm5tpAIOwBk1IB5zxw=;
 b=ZwxZvRcIHMa9G8KzoO5HNF1eXxYn6hBBDtuHK8EGM43ZGQemxrr2mZjX9oOcuAhLEC
 ZtYoBQOAYV4TeYgYFKNKBVUrwemaoK9ZhKmsS5jmx5sInTX1a4XqvsHGI+GnJlZ2Admu
 m8Y6zyu/BnXTMq9ZtVIZKXDKm/f5UF4BY2jKEZN6HeVD03jyHZvHDP0EQgvJX+sSa5j2
 HXA2JKr1h49zJjqHGWj783b70CwSD3KcxtDD4DiGbXnf17gzgoYqttBegS/XzkKsAUSm
 353PffCl5O5qtDZ/JsSOMGjySLGbYSrGehdKYthTzmNtSSut/VPVuTR+YXpDqBhCw2X2
 kreg==
X-Gm-Message-State: AOAM531PhaLm2JW6PVRHRkcns9ZZD/Kyfqwb6S2Z6tkn7woKoRJ6Drgv
 Tqxn58ftb5senBM4Py+Ntax+1Dc0Kh6fDg2t8Zi6g9oRVKmOVoIlDkSRc9WtYyUGIQU5rNCL177
 mGMHmvd2R238jmSgk5MfPt7VKost0zn4=
X-Received: by 2002:a92:d742:: with SMTP id e2mr1419070ilq.11.1603266407796;
 Wed, 21 Oct 2020 00:46:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSrkFnWSbfNQp2UG55JI/GtEX7ndahLv14Slq4OlAa2hnd3R+fE+gIUVAlb6mkkAVoat1HbUPMF99bQEHRBL0=
X-Received: by 2002:a92:d742:: with SMTP id e2mr1419062ilq.11.1603266407590;
 Wed, 21 Oct 2020 00:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-2-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2020 11:46:36 +0400
Message-ID: <CAMxuvayFUCLKJ6bjYAHLiRk-935et+uWeY_zJE0ka8gkY-Xu6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] qga: Rename guest-get-devices return member 'address'
 to 'id'
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Tomas Golembiovsky <tgolembi@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 11:15 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Member 'address' is union GuestDeviceAddress with a single branch
> GuestDeviceAddressPCI, containing PCI vendor ID and device ID.  This
> is not a PCI address.  Type GuestPCIAddress is.  Messed up in recent
> commit 2e4211cee4 "qga: add command guest-get-devices for reporting
> VirtIO devices".
>
> Rename type GuestDeviceAddressPCI to GuestDeviceIdPCI, type
> GuestDeviceAddress to GuestDeviceId, and member 'address' to 'id'.
>
> Document the member properly while there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qga/qapi-schema.json | 17 +++++++++--------
>  qga/commands-win32.c | 16 ++++++++--------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index cec98c7e06..f2c81cda2b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1257,26 +1257,26 @@
>    'returns': 'GuestOSInfo' }
>
>  ##
> -# @GuestDeviceAddressPCI:
> +# @GuestDeviceIdPCI:
>  #
>  # @vendor-id: vendor ID
>  # @device-id: device ID
>  #
>  # Since: 5.2
>  ##
> -{ 'struct': 'GuestDeviceAddressPCI',
> +{ 'struct': 'GuestDeviceIdPCI',
>    'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
>
>  ##
> -# @GuestDeviceAddress:
> +# @GuestDeviceId:
>  #
> -# Address of the device
> -# - @pci: address of PCI device, since: 5.2
> +# Id of the device
> +# - @pci: PCI ID, since: 5.2
>  #
>  # Since: 5.2
>  ##
> -{ 'union': 'GuestDeviceAddress',
> -  'data': { 'pci': 'GuestDeviceAddressPCI' } }
> +{ 'union': 'GuestDeviceId',
> +  'data': { 'pci': 'GuestDeviceIdPCI' } }
>
>  ##
>  # @GuestDeviceInfo:
> @@ -1284,6 +1284,7 @@
>  # @driver-name: name of the associated driver
>  # @driver-date: driver release date in format YYYY-MM-DD
>  # @driver-version: driver version
> +# @id: device ID
>  #
>  # Since: 5.2
>  ##
> @@ -1292,7 +1293,7 @@
>        'driver-name': 'str',
>        '*driver-date': 'str',
>        '*driver-version': 'str',
> -      '*address': 'GuestDeviceAddress'
> +      '*id': 'GuestDeviceId'
>    } }
>
>  ##
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0c3c05484f..879b02b6c3 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2390,22 +2390,22 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error =
**errp)
>          }
>          for (j =3D 0; hw_ids[j] !=3D NULL; j++) {
>              GMatchInfo *match_info;
> -            GuestDeviceAddressPCI *address;
> +            GuestDeviceIdPCI *id;
>              if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)=
) {
>                  continue;
>              }
>              skip =3D false;
>
> -            address =3D g_new0(GuestDeviceAddressPCI, 1);
> +            id =3D g_new0(GuestDeviceIdPCI, 1);
>              vendor_id =3D g_match_info_fetch(match_info, 1);
>              device_id =3D g_match_info_fetch(match_info, 2);
> -            address->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16)=
;
> -            address->device_id =3D g_ascii_strtoull(device_id, NULL, 16)=
;
> +            id->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16);
> +            id->device_id =3D g_ascii_strtoull(device_id, NULL, 16);
>
> -            device->address =3D g_new0(GuestDeviceAddress, 1);
> -            device->has_address =3D true;
> -            device->address->type =3D GUEST_DEVICE_ADDRESS_KIND_PCI;
> -            device->address->u.pci.data =3D address;
> +            device->id =3D g_new0(GuestDeviceId, 1);
> +            device->has_id =3D true;
> +            device->id->type =3D GUEST_DEVICE_ID_KIND_PCI;
> +            device->id->u.pci.data =3D id;
>
>              g_match_info_free(match_info);
>              break;
> --
> 2.26.2
>


