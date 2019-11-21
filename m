Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929CB20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZwcu/6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929CB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkb4-0004jG-PM
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iXkZP-0003ry-6p
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iXkZO-0000c7-6G
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:24:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iXkZO-0000bs-2U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574335457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+4mENE7x8ddoBefjU0Xr4bPttBIMV1OGm+5b/sQL90=;
 b=iZwcu/6Y/DF30hyx92vNuk0iZWEravNi4yV72Thu9QALbHwAgkER6Om6gvASLy5YkUips3
 Ae0flS+I2/62x6pXEEwnrMkh/ZAc4vnvdxYQu3iqXTLS+17I0Qgy5Ykm4ghMbu4wzDHxSA
 VfChxrRtdJJ+iir4GwtN4urQNaWHmpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-23_LBElUPDW0pJuOL1btrw-1; Thu, 21 Nov 2019 06:24:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF28610060E5;
 Thu, 21 Nov 2019 11:24:09 +0000 (UTC)
Received: from [10.36.116.214] (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 459BF70936;
 Thu, 21 Nov 2019 11:24:08 +0000 (UTC)
Subject: Re: [PATCH 15/15] s390x: protvirt: Handle SIGP store status correctly
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-16-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <92f11251-6348-0767-b6cf-d6dbed6e6fca@redhat.com>
Date: Thu, 21 Nov 2019 12:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-16-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 23_LBElUPDW0pJuOL1btrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.11.19 12:43, Janosch Frank wrote:
> Status storing is obviously not done by qemu anymore.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   target/s390x/sigp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 2ce22d4dc1..68634d694a 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -144,7 +144,9 @@ static void sigp_stop_and_store_status(CPUState *cs, =
run_on_cpu_data arg)
>       case S390_CPU_STATE_STOPPED:
>           /* already stopped, just store the status */
>           cpu_synchronize_state(cs);
> -        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
> +        if (!cpu->env.pv) {
> +            s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
> +        }

Confused, how is that case handled? The CPU is already stopped, so it=20
won't be run again (consequently, next SIE entry can't store it). Who=20
will store the status?

>           break;
>       }
>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
> @@ -497,7 +499,8 @@ void do_stop_interrupt(CPUS390XState *env)
>       if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) =3D=3D 0) {
>           qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>       }
> -    if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS) {
> +    /* Storing will occur on next SIE entry for fmt 4 */
> +    if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS && !env->pv) {
>           s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>       }
>       env->sigp_order =3D 0;
>=20


--=20

Thanks,

David / dhildenb


