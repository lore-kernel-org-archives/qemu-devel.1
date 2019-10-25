Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81090CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A3821D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhpgYqE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A3821D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6uJ-00071T-Ec
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iO6sX-0002VJ-6V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iO6sU-0000a6-Pd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:12:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iO6sU-0000Zr-Lv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572037929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0d3yl1MetiIylGaFooMIupwSslUB9qHpUwYR6NnN7k4=;
 b=WhpgYqE22PcoPhUeHVvtXvhM6/FEoJ48Zk4MpFcN3qQ1rvXxWycD51Vyyx/qkKtSDatwW3
 +pYBKXK/iAyDF9TLPmHNOiD+43+caqFUFKqXhhtzqHmQT1U5an6imQealcB4+AQByzmbhw
 C/zc39DFpLbjN7vNkAGdZ9k7WfOxin8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-zT7SCY5QMaePeTKuxtqJkA-1; Fri, 25 Oct 2019 17:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B3347B;
 Fri, 25 Oct 2019 21:12:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8994194B9;
 Fri, 25 Oct 2019 21:12:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 475061138619; Fri, 25 Oct 2019 23:11:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
References: <20191025165706.177653-1-dgilbert@redhat.com>
Date: Fri, 25 Oct 2019 23:11:52 +0200
In-Reply-To: <20191025165706.177653-1-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Fri, 25 Oct 2019 17:57:06 +0100")
Message-ID: <87a79o4jjb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zT7SCY5QMaePeTKuxtqJkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
> to only allow the range 0..65535; however both qemu and libvirt document
> the special value -1  to mean don't reboot.
> Allow it again.
>
> Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error chec=
king")
> RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..1a9ec44232 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
> =20
>      if (reboot_timeout) {
>          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
> +
>          /* validate the input */
> -        if (rt_val < 0 || rt_val > 0xffff) {
> +        if (rt_val < -1 || rt_val > 0xffff) {
>              error_report("reboot timeout is invalid,"
> -                         "it should be a value between 0 and 65535");
> +                         "it should be a value between -1 and 65535");
>              exit(1);
>          }
>      }

Semantic conflict with "PATCH] qemu-options.hx: Update for
reboot-timeout parameter", Message-Id:
<20191015151451.727323-1-hhan@redhat.com>.

I'm too tired right now to risk an opinion on which one we want.


