Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B383C35240
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFE924656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxUU5err"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFE924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqNw-00049I-Rw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itqMx-0003C3-RJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itqMt-0001sm-J4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:02:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itqMt-0001sZ-Es
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579600963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AWQiREJxN9rv1oDVmYf/FFgrolMa5xplZG/aoRsi+Ag=;
 b=DxUU5errkyj2Gza1kWXpcIBEFmyRznTCbxrWIj3A5pJFvIcLoHIFmLh6H31mc3sWDA0dDN
 Wb58DE5ie9/p/dtcWKkLrlUwhUgLokYJrvbDbfeYMTnQzh8/p4wMbKZWxXTKDkqMpO2Z0f
 6f0ypz9YUwQr5at6cWZ4FC5rvyjy8Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-u9Rf53nYP_2HUYkTPdtKWQ-1; Tue, 21 Jan 2020 05:02:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F85DB20;
 Tue, 21 Jan 2020 10:02:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DFA28BE28;
 Tue, 21 Jan 2020 10:02:35 +0000 (UTC)
Subject: Re: [PATCH 2/2] aspeed/i2c: Prevent uninitialized warning
To: mrezanin@redhat.com, qemu-devel@nongnu.org
References: <cover.1579598240.git.mrezanin@redhat.com>
 <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c1b01c90-e42c-b65f-c7b8-2a589510a7d0@redhat.com>
Date: Tue, 21 Jan 2020 11:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: u9Rf53nYP_2HUYkTPdtKWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Andrew Jeffery <andrew@aj.id.au>, peter.maydell@linaro.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 10.28, mrezanin@redhat.com wrote:
> From: Miroslav Rezanina <mrezanin@redhat.com>
> 
> Compiler reports uninitialized warning for cmd_flags variable.
> 
> Adding NULL initialization to prevent this warning.
> 
> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
> ---
>  hw/i2c/aspeed_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 2da04a4..445182a 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
>  
>  static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>  {
> -    g_autofree char *cmd_flags;
> +    g_autofree char *cmd_flags = NULL;
>      uint32_t count;
>  
>      if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {

Reviewed-by: Thomas Huth <thuth@redhat.com>

... maybe someone with enough Perl-foo (i.e. not me ;-)) should add a
check to our check_patch.pl script so that it complains when new code is
introduced that uses g_autofree without initializing the variable...


