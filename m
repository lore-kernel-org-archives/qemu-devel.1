Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9051FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFFA246AF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGJk1snk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFFA246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7nMW-0004Oq-Fh
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7nLt-0003oL-Fu
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7nLq-0002OA-FV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:39:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7nLq-0002My-Bj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582925955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Veux2GeDkcO7vh/hEnLhLhSHAV+dN0NqDmJpDOFAbRk=;
 b=MGJk1snkdRf2rfJ6WGgmaRX7Hmq0FEwOvta0TnEZK+1IoagblJQo/boKYCdnzd060BBefQ
 qZe7Sp194sCFitwYRtQWGgjin9FiOwNPU713kc3Xqf2O+HKiF5o7hrpMifG2sDibYoD5vZ
 OBJhZ0Ac8mtEwSgdpekYlA1WWqb3WXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-evjLFI0lMcqGxf-LgonLpg-1; Fri, 28 Feb 2020 16:39:11 -0500
X-MC-Unique: evjLFI0lMcqGxf-LgonLpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 217018017DF;
 Fri, 28 Feb 2020 21:39:10 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7BEC5D9CA;
 Fri, 28 Feb 2020 21:39:09 +0000 (UTC)
Date: Fri, 28 Feb 2020 16:39:09 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 2/4] target/i386: Remove monitor from some CPU models
Message-ID: <20200228213909.GA481504@habkost.net>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-3-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200212081328.7385-3-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 04:13:26PM +0800, Tao Xu wrote:
> Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
> CPU model to remove MONITOR/MWAIT feature.
>=20
> After QEMU/KVM use "-overcommit cpu-pm=3Don" to expose MONITOR/MWAIT
> (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWAIT
> feature in these CPU model is unused.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

What exactly is the problem you are trying to fix?

No CPU model will ever have monitor=3Don set by default with KVM,
because kvm_default_props has a monitor=3Doff element.

> ---
>  target/i386/cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 848c992cd3..6905e4eabd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3731,6 +3731,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                      { /* end of list */ },
>                  },
>              },
> +            {
> +                .version =3D 3,
> +                .props =3D (PropValue[]) {
> +                    /* mpx was already removed by -v2 above */
> +                    { "monitor", "off" },
> +                    { /* end of list */ },
> +                },
> +            },
>              { /* end of list */ },
>          },
>      },
> @@ -3842,6 +3850,17 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "AMD Opteron 23xx (Gen 3 Class Opteron)",
> +        .versions =3D (X86CPUVersionDefinition[]) {
> +            { .version =3D 1 },
> +            {
> +                .version =3D 2,
> +                .props =3D (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { /* end of list */ },
> +                },
> +            },
> +            { /* end of list */ },
> +        },
>      },
>      {
>          .name =3D "Opteron_G4",
> @@ -3966,6 +3985,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version =3D 3,
> +                .props =3D (PropValue[]) {
> +                    /* ibpb was already enabled by -v2 above */
> +                    { "monitor", "off" },
> +                    { /* end of list */ },
> +                },
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -4018,6 +4045,17 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>          .xlevel =3D 0x8000001E,
>          .model_id =3D "Hygon Dhyana Processor",
>          .cache_info =3D &epyc_cache_info,
> +        .versions =3D (X86CPUVersionDefinition[]) {
> +            { .version =3D 1 },
> +            {
> +                .version =3D 2,
> +                .props =3D (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { /* end of list */ },
> +                },
> +            },
> +            { /* end of list */ },
> +        },
>      },
>  };
> =20
> --=20
> 2.20.1
>=20
>=20

--=20
Eduardo


