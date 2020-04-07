Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE64206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI7VjUeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE64206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrvN-0000ib-0X
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLruh-0000BO-3b
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLruf-0000QJ-6g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:21:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLruf-0000Nc-2u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586280081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQiHstZGuwK2PxCk6kKBcF/nQrlvopaAdx39Gwx/kH4=;
 b=QI7VjUegii/GPCJ/6IJb8hVQRMucXPp2E+zbMPTlppI4lcFkaOz6mvjCFYACFvTSd3Funh
 87Qi5zKLBmjozmdI7LgUKXRAjhih4Tow9wrLT60VqtigqeQAgWDqD4olqxvZgYL8IfwBDy
 OvZrwoeYzG8iXrXScyChHoExbzhHUWU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-iTfHKMm8OMGPItRTi-mFAg-1; Tue, 07 Apr 2020 13:21:18 -0400
X-MC-Unique: iTfHKMm8OMGPItRTi-mFAg-1
Received: by mail-vk1-f199.google.com with SMTP id c139so802633vke.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 10:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZOZF9+moBI5CtkogJgYKCk/q3BeUIHtjPMrRQ3ebg0U=;
 b=DcLG5143M+7HCH+svwo9R8JNprNZ5+f5wRY0uev4n9Std1wyhmp+dzWlyUHPxMD5RZ
 iWtehef5e9r3GHUa+W74sfZNQO8m/fC56BTZPUzTw6AhjlpJ7GYeUYeisoOHmOZ7Nykj
 N8cPQo/NewfP0uCS2ozAusxEgDQKO4c97c8uBHuzb1x2W370R7PSXsnbDkw4lzR5POQk
 upNfWYQeT0Ha0/PtrAPIlGGwvZ8zcXzDrpL7K2dF2fSzlI51Mud5ZNT7CB5kXWKQn/Wt
 tqYz65/Iv7VhZlB1lpLXOsG50yp7SwddG61EbwPCfT74a9bWJiPMjZW4XnQB247Ej/Zb
 IWyQ==
X-Gm-Message-State: AGi0PuZ0N4CIYdkKp/gktGDJrlzR6lVSZRBmQgK0xkYIjB+jZ1PjOFVm
 5G3g/SIzOvIH3eUtO0tL0MAq/CEew7uG17IrUpfU205hzHe9hmHOWPSUU91auovCQPNNu1bHKoN
 U7R0x6pX5V70O4v6wpsz6RZ3Kbc0I8Xg=
X-Received: by 2002:a67:1947:: with SMTP id 68mr2855473vsz.145.1586280077662; 
 Tue, 07 Apr 2020 10:21:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLk5tMtxLkYSd1RK8WcDC1sRL+fTba7B9ggB5hMJrL83GUsbmJIXZqNPYOuqlN+L9oCg6wVsCT67ZCvQBAOH4w=
X-Received: by 2002:a67:1947:: with SMTP id 68mr2855451vsz.145.1586280077429; 
 Tue, 07 Apr 2020 10:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155642.10716-1-ovoshcha@redhat.com>
 <20200407155642.10716-2-ovoshcha@redhat.com>
In-Reply-To: <20200407155642.10716-2-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 7 Apr 2020 14:21:06 -0300
Message-ID: <CAKJDGDaX07=qaUuVa=BH3Ue3RbjZec2QvhZ+vWLNd-azp0zm8g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Acceptance test: adds param 'address' in
 _get_free_port
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Philippe Mathieu Daude <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 1:05 PM Oksana Vohchana <ovoshcha@redhat.com> wrote:
>
> In the migration test function _get_free_port works only for localhost,
> but in the case to use migration through an RDMA we need to get a free po=
rt
> on the configured network RDMA-interface.
> This patch is the start for another migration option
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a8367ca023..e4c39b85a1 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -52,8 +52,8 @@ class Migration(Test):
>          source_vm.qmp('migrate', uri=3Dsrc_uri)
>          self.assert_migration(source_vm, dest_vm)
>
> -    def _get_free_port(self):
> -        port =3D network.find_free_port()
> +    def _get_free_port(self, address=3D'localhost'):
> +        port =3D network.find_free_port(address=3Daddress)
>          if port is None:
>              self.cancel('Failed to find a free port')
>          return port
> --
> 2.21.1
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


