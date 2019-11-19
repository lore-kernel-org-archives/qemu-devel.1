Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C49C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D4720679
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avsEUj0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D4720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1mK-0004u7-89
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX1lD-0004Mz-Se
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX1lC-0004uE-LZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:33:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX1lC-0004tf-9t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574163209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCnhXKhZFiTnT1VusziUpymLg2XNpy4bI8EppRoNY1U=;
 b=avsEUj0y+HP38mn8DTC6CjhJUBjhfTM3EeFekMy2I1TrlvYzFaEKKBO/4/rnQw+T+czah7
 kTrexXzoZQZng8pNJQXMNGEw9hFELDzuk/EXrKxbwbEaoAAKfEayvyxD4VAohaAbJACXea
 4c2aQ4p2NvbjjyX7MD0ODuane02mDtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-4JMhxkq8OY6fapkByOuOZg-1; Tue, 19 Nov 2019 06:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E53D41005510
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1681610027B0;
 Tue, 19 Nov 2019 11:33:25 +0000 (UTC)
Subject: Re: [PATCH 14/16] kvm: convert "-machine kvm_shadow_mem" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-15-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <46c12c3f-f159-92d6-668f-f28841dd3b1e@redhat.com>
Date: Tue, 19 Nov 2019 12:33:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-15-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4JMhxkq8OY6fapkByOuOZg-1
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 15.39, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  hw/core/machine.c   | 39 ---------------------------------------
>  include/hw/boards.h |  2 --
>  qemu-options.hx     |  6 +++---
>  target/i386/kvm.c   |  2 +-
>  vl.c                |  4 ++++
>  6 files changed, 51 insertions(+), 45 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 140b0bd..c016319 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -41,6 +41,7 @@
>  #include "hw/irq.h"
>  #include "sysemu/sev.h"
>  #include "sysemu/balloon.h"
> +#include "qapi/visitor.h"
> =20
>  #include "hw/boards.h"
> =20
> @@ -92,6 +93,7 @@ struct KVMState
>      int max_nested_state_len;
>      int many_ioeventfds;
>      int intx_set_mask;
> +    int kvm_shadow_mem;

It's an "int" here...

>      bool sync_mmu;
>      bool manual_dirty_log_protect;
>      /* The man page (and posix) say ioctl numbers are signed int, but
> @@ -2922,6 +2924,40 @@ static bool kvm_accel_has_memory(MachineState *ms,=
 AddressSpace *as,
>      return false;
>  }
> =20
> +static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    int64_t value =3D s->kvm_shadow_mem;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    Error *error =3D NULL;
> +    int64_t value;
> +
> +    visit_type_int(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    s->kvm_shadow_mem =3D value;
> +}

... but the get and set functions are using an int64_t internally? Looks
somewhat weird. Well, it has been like this in the old code already, but
maybe it's now a good point in time to clean this up?

 Thomas


