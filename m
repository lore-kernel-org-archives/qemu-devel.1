Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E5C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BC62225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AduUQywc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BC62225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbgj-0002Pi-Rw
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kZbdA-0007kq-Uv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kZbd8-0007Rp-CE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604330421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qx+4/jEff/hIlH9YgN56Emxtjt5WQ4fJIXVzrbEC2gw=;
 b=AduUQywcwDX1M4YPY/Gm17PYmYHStkNnSrjeSNKhg12dirnJxF9ToACkx2rXe1Mq1tvPZR
 u15vkJlrBGb9gjrd4aHVcxpe5hMzVTYr5SAg4y5GG1IDKEu1v5dNPfj9RzeVRG9Aj/BPDx
 ZhHbxL65gaHkiy1NkKRl1PWq9fDIA9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-81Eb1GTqPuKcxYvvv3755A-1; Mon, 02 Nov 2020 10:20:18 -0500
X-MC-Unique: 81Eb1GTqPuKcxYvvv3755A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2B5CAF9A0
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 15:20:17 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-126.ams2.redhat.com
 [10.36.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3776C1A8EC;
 Mon,  2 Nov 2020 15:20:13 +0000 (UTC)
Subject: Re: [PATCH-for-5.2] hw/smbios: Fix leaked fd in save_opt_one() error
 path
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201030152742.1553968-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0b82119a-5e99-15f8-bac4-7f86e193706e@redhat.com>
Date: Mon, 2 Nov 2020 16:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201030152742.1553968-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 16:27, Philippe Mathieu-Daudé wrote:
> Fix the following Coverity issue (RESOURCE_LEAK):
> 
>   CID 1432879: Resource leak
> 
>     Handle variable fd going out of scope leaks the handle.
> 
> Replace a close() call by qemu_close() since the handle is
> opened with qemu_open().
> 
> Fixes: bb99f4772f5 ("hw/smbios: support loading OEM strings values from a file")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/smbios/smbios.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 8b30906e50a..6a3d39793bc 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -988,16 +988,18 @@ static int save_opt_one(void *opaque,
>              if (ret < 0) {
>                  error_setg(errp, "Unable to read from %s: %s",
>                             value, strerror(errno));
> +                qemu_close(fd);
>                  return -1;
>              }
>              if (memchr(buf, '\0', ret)) {
>                  error_setg(errp, "NUL in OEM strings value in %s", value);
> +                qemu_close(fd);
>                  return -1;
>              }
>              g_byte_array_append(data, (guint8 *)buf, ret);
>          }
>  
> -        close(fd);
> +        qemu_close(fd);
>  
>          *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
>          (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


