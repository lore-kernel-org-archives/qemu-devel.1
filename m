Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DDC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D042071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OH8n29jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D042071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkqe-0002pY-Vz
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iXkpy-0002Ep-PP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iXkpw-0003cy-MM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iXkpu-0003ZG-Kn
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574336481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoyXq/0kAMXB0AtsMkumgyfbdard5rYCkmcvpiSTQuE=;
 b=OH8n29jf7ALUbtD6JotTr2flcKWExQN2BMOcnRKMCZi9v2r97gSX4HrvMPEcB+8B/l7sv3
 PB0LPWhq4qm7wgP64W8xvonR5SLgY84DgNcKwCg1FfW8iG+oE733V8hSMkq5zMkkTxN9As
 G9utwhSqBWk96/GNeDRJHy/cZ0wLUjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-TwTp2DfXP0yjRv1NOx3Cyg-1; Thu, 21 Nov 2019 06:41:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8948D7E06;
 Thu, 21 Nov 2019 11:41:16 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-160.ams2.redhat.com
 [10.36.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D0786CE61;
 Thu, 21 Nov 2019 11:41:16 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 8576E3E0527; Thu, 21 Nov 2019 12:41:14 +0100 (CET)
Date: Thu, 21 Nov 2019 12:41:14 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH for-4.2 1/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
Message-ID: <20191121114114.GP7032@paraplu>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-2-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120164912.32384-2-ehabkost@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TwTp2DfXP0yjRv1NOx3Cyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 01:49:11PM -0300, Eduardo Habkost wrote:
> One of the mitigation methods for TAA[1] is to disable TSX
> support on the host system.  Linux added a mechanism to disable
> TSX globally through the kernel command line, and many Linux
> distributions now default to tsx=3Doff.  This makes existing CPU
> models that have HLE and RTM enabled not usable anymore.
>
> Add new versions of all CPU models that have the HLE and RTM
> features enabled, that can be used when TSX is disabled in the
> host system.
>
> References:
>
> [1] TAA, TSX asynchronous Abort:
>     https://software.intel.com/security-software-guidance/insights/deep-d=
ive-intel-transactional-synchronization-extensions-intel-tsx-asynchronous-a=
bort
>     https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_=
abort.html
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

FWIW:

    Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

Here are _all_ the Cascadelake/Icelake/Skylake variants I see with your
patches applied:

    $> ./qemu-system-x86_64 -cpu help | egrep  '(Cascadelake.*|Icelake.*|Sk=
ylake.*)'
    x86 Cascadelake-Server    (alias configured by machine type)
    x86 Cascadelake-Server-noTSX  (alias of Cascadelake-Server-v3)
    x86 Cascadelake-Server-v1  Intel Xeon Processor (Cascadelake)
    x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake)
    x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake)
    x86 Icelake-Client        (alias configured by machine type)
    x86 Icelake-Client-noTSX  (alias of Icelake-Client-v2)
    x86 Icelake-Client-v1     Intel Core Processor (Icelake)
    x86 Icelake-Client-v2     Intel Core Processor (Icelake)
    x86 Icelake-Server        (alias configured by machine type)
    x86 Icelake-Server-noTSX  (alias of Icelake-Server-v2)
    x86 Icelake-Server-v1     Intel Xeon Processor (Icelake)
    x86 Icelake-Server-v2     Intel Xeon Processor (Icelake)
    x86 Skylake-Client        (alias configured by machine type)
    x86 Skylake-Client-IBRS   (alias of Skylake-Client-v2)
    x86 Skylake-Client-noTSX-IBRS  (alias of Skylake-Client-v3)
    x86 Skylake-Client-v1     Intel Core Processor (Skylake)
    x86 Skylake-Client-v2     Intel Core Processor (Skylake, IBRS)
    x86 Skylake-Client-v3     Intel Core Processor (Skylake, IBRS)
    x86 Skylake-Server        (alias configured by machine type)
    x86 Skylake-Server-IBRS   (alias of Skylake-Server-v2)
    x86 Skylake-Server-noTSX-IBRS  (alias of Skylake-Server-v3)
    x86 Skylake-Server-v1     Intel Xeon Processor (Skylake)
    x86 Skylake-Server-v2     Intel Xeon Processor (Skylake, IBRS)
    x86 Skylake-Server-v3     Intel Xeon Processor (Skylake, IBRS)


Test with system QEMU
---------------------

Where `cat system-qemu.sh` is:

    #!/usr/bin/env bash
    args=3D(
     -display none
     -cpu Skylake-Client-IBRS
     -no-user-config
     -machine q35,accel=3Dkvm
     -nodefaults
     -m 2048
     -serial stdio
     -drive file=3D/export/vm1.qcow2,format=3Dqcow2,if=3Dvirtio
    )
    /usr/bin/qemu-system-x86_64 "${args[@]}"

Run it:

    $> ./system-qemu.sh
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.01H:ECX.aes [bit 25]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.hle [bit 4]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.rtm [bit 11]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.rdseed [bit 18]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.adx [bit 19]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.smap [bit 20]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.80000001H:ECX.3dnowprefetch [bit 8]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.0DH:EAX.xsavec [bit 1]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.0DH:EAX.xgetbv1 [bit 2]
    [...]

Notice that it is (correctly) complaining about about "hle" and "rtm".


Test with patched QEMU
----------------------

Now, with a QEMU built with your both patches, and using the -noTSX-IBRS
model:

Where `cat patched-qemu.sh` is:

    #!/usr/bin/env bash
    args=3D(
     -display none
     -cpu Skylake-Client-noTSX-IBRS
     -no-user-config
     -machine q35,accel=3Dkvm
     -nodefaults
     -m 2048
     -serial stdio
     -drive file=3D/export/vm1.qcow2,format=3Dqcow2,if=3Dvirtio
    )
    ~/build/qemu/x86_64-softmmu/qemu-system-x86_64 "${args[@]}"

Run it:

    $> ./patched-qemu.sh
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.01H:ECX.aes [bit 25]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.rdseed [bit 18]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.adx [bit 19]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.07H:EBX.smap [bit 20]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.80000001H:ECX.3dnowprefetch [bit 8]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.0DH:EAX.xsavec [bit 1]
    qemu-system-x86_64: warning: host doesn't support requested feature: CP=
UID.0DH:EAX.xgetbv1 [bit 2]
    [...]

Here it doesn't complain (also correctly so) about "hle" and "rtm",
because the -noTSX-IBRS model disabled them :-)


>  target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 296b491607..0267e08612 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2474,6 +2474,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version =3D 3,
> +                .props =3D (PropValue[]) {
> +                    { "hle", "off" },
> +                    { "rtm", "off" },
> +                    { /* end of list */ }
> +                }
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -2541,6 +2549,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version =3D 3,
> +                .props =3D (PropValue[]) {
> +                    { "hle", "off" },
> +                    { "rtm", "off" },
> +                    { /* end of list */ }
> +                }
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -2608,6 +2624,13 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                    { /* end of list */ }
>                },
>              },
> +            { .version =3D 3,
> +              .props =3D (PropValue[]) {
> +                  { "hle", "off" },
> +                  { "rtm", "off" },
> +                  { /* end of list */ }
> +              },
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -2665,6 +2688,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_6_EAX_ARAT,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core Processor (Icelake)",
> +        .versions =3D (X86CPUVersionDefinition[]) {
> +            { .version =3D 1 },
> +            {
> +                .version =3D 2,
> +                .props =3D (PropValue[]) {
> +                    { "hle", "off" },
> +                    { "rtm", "off" },
> +                    { /* end of list */ }
> +                },
> +            },
> +            { /* end of list */ }
> +        }
>      },
>      {
>          .name =3D "Icelake-Server",
> @@ -2723,6 +2758,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_6_EAX_ARAT,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon Processor (Icelake)",
> +        .versions =3D (X86CPUVersionDefinition[]) {
> +            { .version =3D 1 },
> +            {
> +                .version =3D 2,
> +                .props =3D (PropValue[]) {
> +                    { "hle", "off" },
> +                    { "rtm", "off" },
> +                    { /* end of list */ }
> +                },
> +            },
> +            { /* end of list */ }
> +        }
>      },
>      {
>          .name =3D "Denverton",
> --
> 2.21.0
>

--
/kashyap


