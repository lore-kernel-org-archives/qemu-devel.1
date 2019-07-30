Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D3C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB40206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB40206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsO04-0001DR-6d
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hsNzT-0000l4-3A
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hsNzR-0006M8-W7
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1hsNzP-0006Kb-Ch; Tue, 30 Jul 2019 05:00:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 419AC30ADC81;
 Tue, 30 Jul 2019 09:00:10 +0000 (UTC)
Received: from ptitpuce (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A6F5D6D0;
 Tue, 30 Jul 2019 09:00:02 +0000 (UTC)
References: <20190729164234.11573-1-kwolf@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <20190729164234.11573-1-kwolf@redhat.com>
Date: Tue, 30 Jul 2019 11:00:00 +0200
Message-ID: <m1y30foq27.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 30 Jul 2019 09:00:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] scsi-cd: Fix inserting read-only
 media in empty drive
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf writes:

> scsi-disks decides whether it has a read-only device by looking at
> whether the BlockBackend specified as drive=... is read-only. In the
> case of an anonymous BlockBackend (with a node name specified in
> drive=...), this is the read-only flag of the attached node. In the case
> of an empty anonymous BlockBackend, it's always read-write because
> nothing prevented it from being read-write.
>
> This is a problem because scsi-cd would take write permissions on the
> anonymous BlockBackend of an empty drive created without a drive=...
> option. Using blockdev-insert-medium with a read-only node fails then
> with the error message "Block node is read-only".
>
> Fix scsi_realize() so that scsi-cd devices always take read-only
> permissions on their BlockBackend instead.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1733920
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8e95e3e38d..af3e622dc5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2318,6 +2318,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
>  static void scsi_realize(SCSIDevice *dev, Error **errp)
>  {
>      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
> +    bool read_only;
>
>      if (!s->qdev.conf.blk) {
>          error_setg(errp, "drive property not set");
> @@ -2351,8 +2352,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>              return;
>          }
>      }
> -    if (!blkconf_apply_backend_options(&dev->conf,
> -                                       blk_is_read_only(s->qdev.conf.blk),
> +
> +    read_only = blk_is_read_only(s->qdev.conf.blk);
> +    if (dev->type == TYPE_ROM) {
> +        read_only = true;
> +    }

Is there a reason to check blk_is_read_only even for CD-ROM?
If not, why not make it a "else"?

> +
> +    if (!blkconf_apply_backend_options(&dev->conf, read_only,
>                                         dev->type == TYPE_DISK, errp)) {
>          return;
>      }


--
Cheers,
Christophe de Dinechin (IRC c3d)

