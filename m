Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D4220838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6eSUjpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D4220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFag-00015J-0l
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJFZx-0000dQ-Qz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJFZv-0002Bo-SY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:01:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJFZv-0002BF-PI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585656071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++inZy/usoSfkedC1OxG6X4hFfgNOcRjN23s2NSFVmk=;
 b=Q6eSUjpnW6QuJTPiTPPSWhHtP1RfL3vuJe9x0MWS0A1Wj3t7iL3hr04TqfiEwj0T6ZBhfO
 9l3R5Nz8+0xR5INJH6jFPl4hYmzI3TauISOrQR8s50wX1rW7WyuzP5Jk48rQmpc9E6gbFs
 a7/B2bMOwDxMndyMsdhZ+Jl93NLHvsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-AT6gVHCFOkmKmNDh97zSMw-1; Tue, 31 Mar 2020 08:01:09 -0400
X-MC-Unique: AT6gVHCFOkmKmNDh97zSMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74F721005F76;
 Tue, 31 Mar 2020 12:01:08 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 014F25C1BB;
 Tue, 31 Mar 2020 12:01:06 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:01:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2] s390x: kvm: Fix number of cpu reports for stsi 3.2.2
Message-ID: <20200331140104.179fed21.cohuck@redhat.com>
In-Reply-To: <20200331110123.3774-1-frankja@linux.ibm.com>
References: <f6b26b2c-23c2-6622-2f58-1e74f335842e@redhat.com>
 <20200331110123.3774-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 07:01:23 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The cpu number reporting is handled by KVM and QEMU only fills in the
> VM name, uuid and other values.
> 
> Unfortunately KVM doesn't report reserved cpus and doesn't even know
> they exist until the are created via the ioctl.
> 
> So let's fix up the cpu values after KVM has written its values to the
> 3.2.2 sysib. To be consistent We use the same code to retrieve the cpu

"...consistent, we..." (fixed up while applying)

> numbers as the STSI TCG code in target/s390x/misc_helper.c:HELPER(stsi).
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> 
> * Fixed commit message and add rev-by
> * Calculating total_cpus from configured + reserved
> 
> ---
>  target/s390x/kvm.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 3630c15f45a48864..69881a0da0b31f72 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1819,8 +1819,10 @@ static int handle_tsch(S390CPU *cpu)
>  
>  static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
>  {
> +    const MachineState *ms = MACHINE(qdev_get_machine());
> +    uint16_t conf_cpus = 0, reserved_cpus = 0;
>      SysIB_322 sysib;
> -    int del;
> +    int del, i;
>  
>      if (s390_is_pv()) {
>          s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));

This is against s390-next; rebased and applied to s390-fixes (please
double check).

[I'm holding off rebasing s390-next on top of s390-fixes resp. master;
I'll rather do that once after all pieces including the headers update
are in place.]


