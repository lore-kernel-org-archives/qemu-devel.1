Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1E020707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt21K6WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixA6d-00086h-Uu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ixA64-0007d1-9G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ixA63-0006dk-3v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ixA63-0006db-0I
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580391782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4QEyZJyxaj+bRDqLXZs41gS2Qq/7qO4bL6wlmomS+Q=;
 b=Pt21K6WPhslkeJNCvk9/3CGp5j753Vy3kjnTVnOXXFg42jF6IlXgZru1EctY1iVq1GGBuA
 LwLrAe9qJfqRS9tikLLF83hfs7wNnVpHsA4FUzYrP6OFzcaSDblAhDaa72hBHu29EEGJ3Z
 tUQz8WXeUVTu3tvDUt4SZj5HLxKqg90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-pD-rqosnNfuPL5nPit53lQ-1; Thu, 30 Jan 2020 08:42:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so1719881wrb.21
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FJOtt+7a254d2IQYPN7NICdLcl702BWyBIIGnC4XL40=;
 b=hvS347i4SNrOAYp5iCpHAXT6rtFByI6jz2JCf2Nd1zK9QBU2bUa/m2EwrudI8eYjsX
 V26v2db7Gt8QJfFKZcbasIDplUMyXBXcGDzWS5ZTq3GeATLLUC9ckfsAloJ8DmlYfBLL
 WWPDvGVnLQaaIlMalDARBRdnqksI6+IbftqaAEPerc/ZnTE7yxxDFN3hW1/UtkBaFsh1
 rMAbewv7POIo9RAuP+/IcGrTGDeQPxAkYnMk8AY4GiAM/q7zS9ZSLahJZUYldtvcDkL+
 /TQPHuqiaTwvvMQTE1KHQYwxJpLnsZuzURzALJOWVQfK8xmpQxnrx8TuWn3/5Mnf5p6T
 atug==
X-Gm-Message-State: APjAAAWGHbw+Sk6Nm7wawD7fvQ+QEDmzny7nX9O6U9/idlYmfavhvpMc
 rOBTh3hy7l0VtPjYiW1Ru7oyeoEVxVKmPIxAJcMwWC4DlPQTeC9tSkE5CIYqL086f7PSp51VWK0
 ffgc3FEdNHEBnSX8=
X-Received: by 2002:a5d:4446:: with SMTP id x6mr5696646wrr.312.1580391772578; 
 Thu, 30 Jan 2020 05:42:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZDgIZ65H9bp/LNlI+ua7QrZWwGH4I7254eV0VGuV9KPK83ChYEcvHEPoAawcYZbyidccYQg==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr5696621wrr.312.1580391772354; 
 Thu, 30 Jan 2020 05:42:52 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id y6sm7363553wrl.17.2020.01.30.05.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 05:42:51 -0800 (PST)
Date: Thu, 30 Jan 2020 08:42:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 3/4] tests: add virtuqueue size checking to
 virtio_seg_max_adjust test
Message-ID: <20200130084045-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200129140702.5411-4-dplotnikov@virtuozzo.com>
X-MC-Unique: pD-rqosnNfuPL5nPit53lQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:07:01PM +0300, Denis Plotnikov wrote:
> This is due to the change in the default virtqueue_size in the
> latest machine type to improve guest disks performance.
>

Sorry what is due to the change?
=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  tests/acceptance/virtio_seg_max_adjust.py | 33 ++++++++++++++---------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> index 5458573138..645d69b313 100755
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -27,8 +27,10 @@ from qemu.machine import QEMUMachine
>  from avocado_qemu import Test
> =20
>  #list of machine types and virtqueue properties to test
> -VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
> -VIRTIO_BLK_PROPS =3D {'seg_max_adjust': 'seg-max-adjust'}
> +VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust',
> +                     'queue_size': 'virtqueue_size'}
> +VIRTIO_BLK_PROPS =3D {'seg_max_adjust': 'seg-max-adjust',
> +                    'queue_size': 'queue-size'}
> =20
>  DEV_TYPES =3D {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
>               'virtio-blk-pci': VIRTIO_BLK_PROPS}
> @@ -40,7 +42,7 @@ VM_DEV_PARAMS =3D {'virtio-scsi-pci': ['-device', 'virt=
io-scsi-pci,id=3Dscsi0'],
>                                      'driver=3Dnull-co,id=3Ddrive0,if=3Dn=
one']}
> =20
> =20
> -class VirtioMaxSegSettingsCheck(Test):
> +class VirtioPramsCheck(Test):
>      @staticmethod
>      def make_pattern(props):
>          pattern_items =3D ['{0} =3D \w+'.format(prop) for prop in props]
> @@ -72,20 +74,24 @@ class VirtioMaxSegSettingsCheck(Test):
>                  props[p[0]] =3D p[1]
>          return query_ok, props, error
> =20
> -    def check_mt(self, mt, dev_type_name):
> +    def check_mt(self, mt, expected_props, dev_type_name):
>          with QEMUMachine(self.qemu_bin) as vm:
> -            vm.set_machine(mt["name"])
> +            vm.set_machine(mt)
>              for s in VM_DEV_PARAMS[dev_type_name]:
>                  vm.add_args(s)
>              vm.launch()
>              query_ok, props, error =3D self.query_virtqueue(vm, dev_type=
_name)
> =20
>          if not query_ok:
> -            self.fail('machine type {0}: {1}'.format(mt['name'], error))
> +            self.fail('machine type {0}: {1}'.format(mt, error))
> =20
>          for prop_name, prop_val in props.items():
> -            expected_val =3D mt[prop_name]
> -            self.assertEqual(expected_val, prop_val)
> +            expected_val =3D expected_props[prop_name]
> +            msg =3D 'Property value mismatch for (MT: {0}, '\
> +                  'property name: {1}): expected value: "{2}" '\
> +                  'actual value: "{3}"'\
> +                  .format(mt, prop_name, expected_val, prop_val)
> +            self.assertEqual(expected_val, prop_val, msg)


Looks like an unrelated change, no?

>      @staticmethod
>      def seg_max_adjust_enabled(mt):
> @@ -120,15 +126,18 @@ class VirtioMaxSegSettingsCheck(Test):
> =20
>          for dev_type in DEV_TYPES:
>              # create the list of machine types and their parameters.
> -            mtypes =3D list()
> +            mtypes =3D dict()
>              for m in machines:
>                  if self.seg_max_adjust_enabled(m):
>                      enabled =3D 'true'
> +                    queue_size =3D '256'
>                  else:
>                      enabled =3D 'false'
> -                mtypes.append({'name': m,
> -                               DEV_TYPES[dev_type]['seg_max_adjust']: en=
abled})
> +                    queue_size =3D '128'
> +                mtypes[m] =3D {
> +                    DEV_TYPES[dev_type]['seg_max_adjust']: enabled,
> +                    DEV_TYPES[dev_type]['queue_size']: queue_size }
> =20
>              # test each machine type for a device type
>              for mt in mtypes:
> -                self.check_mt(mt, dev_type)
> +                self.check_mt(mt, mtypes[mt], dev_type)
> --=20
> 2.17.0


