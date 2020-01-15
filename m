Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE9C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D0B2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeaUCKYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D0B2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irj5f-0004VW-8I
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irj53-00045L-D4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irj51-0006Ra-VD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:51:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irj51-0006R7-RW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579096291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2vIrZyxxxHan2lvnLGXIgfIJSi+6OMjZr78VyPyp8o=;
 b=NeaUCKYhEdSHGpPRsARl7jGOpcrCcU+BzvvTr217a8DN89A/vUFlVzU/DKyAmWSms8Bgzw
 dHfkixK2li3snE0TNCsTPQwRvJ42qlt7ARRu5adt5viHEzTru3csqjNpFurm9NB0aDV5nU
 S5KX4TGGimwfrsg2VE2eq2h7cvD635A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-duEfsIfpMKab-Ez2A6nzTQ-1; Wed, 15 Jan 2020 08:51:30 -0500
Received: by mail-qv1-f69.google.com with SMTP id ce17so11083865qvb.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 05:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TIREAsaTK+BLMbF6Jlnu4RzducR2LDVCc5yv7et84+Q=;
 b=ZvJhFSjpv/Ir4woL0YJNgTPS6DcgNHNgorr90D6u9sB6k+i7iHv4VWhhJm3O1DlLs7
 dXWW+p8XS8CLS5+vC4w2KqAgEHrx2ikT1JY3GwM3wnTFtDTsnnQ5gSJETEo9VKt3MgI+
 A79eD5vaLJdNmbiwbT4W7bW/fFYM1zU7vnul+nrDo6XFxU+51fdjR125JePnL5Y+8gZ6
 RMHOhaBJhtTMSn5EdTcygskAfIO2YMAlwTcZxPVXqhqp6xQWDgokX3zmsGsYV9QGlERr
 9QC3tn74o+bjGLfv+oXzk7rwn7Tb3QggGgXdyMy/kDItfj+qWAmqXEA5TknqKz0Gxx6c
 4+mg==
X-Gm-Message-State: APjAAAUKqf4V2pTcL0SjOgfCNYUXgLkUX1QV2SORIoBRkHsk8GWPqjd+
 uX3yDHBe+zAE0279I+WyI7PlYRkTWV+sRvWGifZb+ZyiD91NzkvV7JPZDeGRmXLlzchr2DZrQI6
 bJwTcqBr55i8PUzo=
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr27863973qkk.190.1579096289616; 
 Wed, 15 Jan 2020 05:51:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTSWaVISBbyl7Oxq7lg3ZBaq3CYqlxGimBB1RixeuSHYDVNiiW8p645/yV6RUNzI5tmMtkXw==
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr27863952qkk.190.1579096289348; 
 Wed, 15 Jan 2020 05:51:29 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 65sm9329540qtf.95.2020.01.15.05.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 05:51:28 -0800 (PST)
Date: Wed, 15 Jan 2020 08:51:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH v1] hw/i386: disable smbus migration for xenpv
Message-ID: <20200115085026-mutt-send-email-mst@kernel.org>
References: <20200113174521.3336-1-olaf@aepfle.de>
MIME-Version: 1.0
In-Reply-To: <20200113174521.3336-1-olaf@aepfle.de>
X-MC-Unique: duEfsIfpMKab-Ez2A6nzTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 06:45:21PM +0100, Olaf Hering wrote:
> With commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea a new member
> smbus_no_migration_support was added, and enabled in two places.
> With commit 4ab2f2a8aabfea95cc53c64e13b3f67960b27fdf the vmstate_acpi
> got new elements, which are conditionally filled. As a result, an
> incoming migration expected smbus related data unless smbus migration
> was disabled for a given MachineClass.
>=20
> Since commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea forgot to handle
> xenpv, live migration to receiving hosts using qemu-4.0 and later is brok=
en.
> Therefore this patch must be applied to stable-4.x as well.
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Thanks!

I think you need to copy Xen maintainers to ack this.
Suggest reposting with a fixed commit message and
cc appropriate maintainers.


> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203079..e19716d0d3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -952,6 +952,7 @@ static void xenfv_machine_options(MachineClass *m)
>      m->desc =3D "Xen Fully-virtualized PC";
>      m->max_cpus =3D HVM_MAX_VCPUS;
>      m->default_machine_opts =3D "accel=3Dxen";
> +    m->smbus_no_migration_support =3D true;
>  }
> =20
>  DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,


