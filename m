Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA27A2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d44yHE1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA27A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ixV-0003mh-6B
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0iw0-0002tt-NX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:03:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0ivz-00076T-0M
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596017017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hm2Camwp8Tlp2uEJDqwnqxwlPRZzLfFzDxqmmBqBQLk=;
 b=d44yHE1xslfpRduIUe28qot8WDaCryDlulUciQdte+wR/Gz2PqTT9gPAFZ0q0quJBSXdMb
 rXc/Q/Or41fRM6kxM1aWY36Ak/IFq490SITpUrHOByhxoty7xpHvZx9Td360rgxhiicOO+
 wVKdGHWwjJ2+/t7mhH9myGeqZhcGl28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Hh5lRDAPM3KPJiNUcRLKNg-1; Wed, 29 Jul 2020 06:03:35 -0400
X-MC-Unique: Hh5lRDAPM3KPJiNUcRLKNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C7A106B246;
 Wed, 29 Jul 2020 10:03:34 +0000 (UTC)
Received: from gondolin (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37E3B8A162;
 Wed, 29 Jul 2020 10:03:32 +0000 (UTC)
Date: Wed, 29 Jul 2020 12:03:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 4/6] pc-bios/s390-ccw: Do not bail out early if
 not finding a SCSI disk
Message-ID: <20200729120329.353570c0.cohuck@redhat.com>
In-Reply-To: <20200728183734.7838-5-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-5-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.74; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 20:37:32 +0200
Thomas Huth <thuth@redhat.com> wrote:

> In case the user did not specify a boot device, we want to continue
> looking for other devices if there are no valid SCSI disks on a virtio-
> scsi controller. As a first step, do not panic in this case and let
> the control flow carry the error to the upper functions instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c          | 13 +++++++++----
>  pc-bios/s390-ccw/s390-ccw.h      |  2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c |  7 ++++---
>  pc-bios/s390-ccw/virtio-scsi.c   | 25 ++++++++++++++++++-------
>  pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
>  5 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 9477313188..3cd01cd80f 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -218,7 +218,7 @@ static void find_boot_device(void)
>      IPL_assert(found, "Boot device not found\n");
>  }
>  
> -static void virtio_setup(void)
> +static bool virtio_setup(void)

Hm... I'm always wondering what to make of a function returning bool if
it is not of the "check something" variety. For a function called
virtio_setup(), I'd expect it to setup something, but would be unsure
what it meant if it returned true or false. Maybe better make it return
0 or a negative error?

(also applies to the other setup functions in this patch)

>  {
>      VDev *vdev = virtio_get_device();
>      QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;

(...)

> @@ -288,9 +288,10 @@ void virtio_blk_setup_device(SubChannelId schid)
>              "Config: CDB size mismatch");
>  
>          sclp_print("Using virtio-scsi.\n");
> -        virtio_scsi_setup(vdev);
> -        break;
> +        return virtio_scsi_setup(vdev);

You now have one case with a direct return, one that does not return,
and one that just continues. Can we make that a bit more consistent?

>      default:
>          panic("\n! No IPL device available !\n");
>      }
> +
> +    return true;
>  }
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index eddfb8a7ad..4d05b02ed0 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -194,7 +194,12 @@ static bool scsi_read_capacity(VDev *vdev,
>  
>  /* virtio-scsi routines */
>  
> -static void virtio_scsi_locate_device(VDev *vdev)
> +/*
> + * Tries to locate a SCSI device and adds that information to the
> + * vdev->scsi_device structure.

"and adds the information for the found device" ?

> + * Returns true if SCSI device could be located, false otherwise
> + */
> +static bool virtio_scsi_locate_device(VDev *vdev)

Here, I think a bool is fine. 0/-ENODEV would also make sense.

>  {
>      const uint16_t channel = 0; /* again, it's what QEMU does */
>      uint16_t target;


