Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51646C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5222081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB19Ctix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5222081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8K2-0002ev-Ib
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is8FH-0004Um-Ey
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is8FC-0008CE-8G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:43:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is8FC-0008Bl-4q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579193021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=buRSOiILco/oIeYSzDuxM5jHpqQZMWxy7dVdhOgoewo=;
 b=dB19CtixoMTB22QL/f9dDH3J4uuEbm54eh8lQwShcsYKWhxJ+rO9DUkgEtA8Z92DIABo0g
 0Fnfy8s7+zlBusrjaZNBTuer3oz/Qv7sdEIpd6gB8J2vpjzVNQu2tb9XTWpLPB/baKINQl
 r/Ty6ssuRLh9n4qlJhqeRgTHGFZkgwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-MKQcxyWUPdO4kFesoEcFOA-1; Thu, 16 Jan 2020 11:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2214018FE860;
 Thu, 16 Jan 2020 16:43:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 082C51001281;
 Thu, 16 Jan 2020 16:43:32 +0000 (UTC)
Subject: Re: [PATCH v2 85/86] numa: make exit() usage consistent
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-86-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a4feb8cd-a105-bcfd-b8c3-27ac5bb0f474@redhat.com>
Date: Thu, 16 Jan 2020 17:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-86-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MKQcxyWUPdO4kFesoEcFOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@linaro.org>,
 ehabkost@redhat.com, David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/2020 16.07, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: ehabkost@redhat.com
> ---
>  hw/core/numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 3177066..47d5ea1 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -718,7 +718,7 @@ void numa_complete_configuration(MachineState *ms)
>          /* Report large node IDs first, to make mistakes easier to spot =
*/
>          if (!numa_info[i].present) {
>              error_report("numa: Node ID missing: %d", i);
> -            exit(1);
> +            exit(EXIT_FAILURE);
>          }
>      }
> =20
> @@ -759,7 +759,7 @@ void numa_complete_configuration(MachineState *ms)
>              error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
>                           " should equal RAM size (0x" RAM_ADDR_FMT ")",
>                           numa_total, ram_size);
> -            exit(1);
> +            exit(EXIT_FAILURE);
>          }
> =20
>          if (!numa_uses_legacy_mem()) {

Please don't. We've had exit(1) vs. exit(EXIT_FAILURE) discussions in
the past already, and IIRC there was no clear conclusion which one we
want to use. There are examples of changes to the numeric value in our
git history (see d54e4d7659ebecd0e1fa7ffc3e954197e09f8a1f for example),
and example of the other way round (see 4d1275c24d5d64d22ec4a30ce1b6a0
for example).

Your patch series here is already big enough, so I suggest to drop this
patch from the series. If you want to change this, please suggest an
update to CODING_STYLE.rst first so that we agree upon one style for
exit() ... otherwise somebody else might change this back into numeric
values in a couple of months just because they have a different taste.

 Thomas


