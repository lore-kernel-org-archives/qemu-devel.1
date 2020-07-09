Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C914B206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acF1xlMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C914B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTx6-0000uF-4V
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtTwE-0000T2-UQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:37:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtTwD-0000zD-0p
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594291076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+CgbXduTA15o5mvzPDx8NO2U9InVFU+lMnrwJdo5Hg=;
 b=acF1xlMS17rEzlwcqyMMUAzYMZElxM0H+gY6vOafdYWj9GoviMafbratoPMzJcufdXifsw
 H1MXBsot4rPM21fjctoo6MD8sD5XQPbJlKRP2N5Hcp5qsIN837G8BfaVHUTY+kKz38EaJj
 EhIuNt0dxbHysgM4PBK+uqmNvpxp/5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-hWlxK0wQPbCIr18RUgMfjw-1; Thu, 09 Jul 2020 06:37:54 -0400
X-MC-Unique: hWlxK0wQPbCIr18RUgMfjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF67D800C64;
 Thu,  9 Jul 2020 10:37:52 +0000 (UTC)
Received: from gondolin (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8CB60F8D;
 Thu,  9 Jul 2020 10:37:43 +0000 (UTC)
Date: Thu, 9 Jul 2020 12:37:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200709123741.28a1e3b2.cohuck@redhat.com>
In-Reply-To: <20200708185135.46694-3-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-3-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 Jul 2020 20:51:32 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's implement the "storage configuration" part of diag260. This diag
> is found under z/VM, to indicate usable chunks of memory tot he guest OS.
> As I don't have access to documentation, I have no clue what the actual
> error cases are, and which other stuff we could eventually query using th=
is
> interface. Somebody with access to documentation should fix this. This
> implementation seems to work with Linux guests just fine.
>=20
> The Linux kernel supports diag260 to query the available memory since
> v4.20. Older kernels / kvm-unit-tests will later fail to run in such a VM
> (with maxmem being defined and bigger than the memory size, e.g., "-m
>  2G,maxmem=3D4G"), just as if support for SCLP storage information is not
> implemented. They will fail to detect the actual initial memory size.
>=20
> This interface allows us to expose the maximum ramsize via sclp
> and the initial ramsize via diag260 - without having to mess with the
> memory increment size and having to align the initial memory size to it.
>=20
> This is a preparation for memory device support. We'll unlock the
> implementation with a new QEMU machine that supports memory devices.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c        | 57 ++++++++++++++++++++++++++++++++++++++
>  target/s390x/internal.h    |  2 ++
>  target/s390x/kvm.c         | 11 ++++++++
>  target/s390x/misc_helper.c |  6 ++++
>  target/s390x/translate.c   |  4 +++
>  5 files changed, 80 insertions(+)
>=20
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 1a48429564..c3b1e24b2c 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -23,6 +23,63 @@
>  #include "hw/s390x/pv.h"
>  #include "kvm_s390x.h"
> =20
> +void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintp=
tr_t ra)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    const ram_addr_t initial_ram_size =3D ms->ram_size;
> +    const uint64_t subcode =3D env->regs[r3];
> +    S390CPU *cpu =3D env_archcpu(env);
> +    ram_addr_t addr, length;
> +    uint64_t tmp;
> +
> +    /* TODO: Unlock with new QEMU machine. */
> +    if (false) {
> +        s390_program_interrupt(env, PGM_OPERATION, ra);
> +        return;
> +    }
> +
> +    /*
> +     * There also seems to be subcode "0xc", which stores the size of th=
e
> +     * first chunk and the total size to r1/r2. It's only used by very o=
ld
> +     * Linux, so don't implement it.

FWIW,
https://www-01.ibm.com/servers/resourcelink/svc0302a.nsf/pages/zVMV7R1sc246=
272/$file/hcpb4_v7r1.pdf
seems to list the available subcodes. Anything but 0xc and 0x10 is for
24/31 bit only, so we can safely ignore them. Not sure what we want to
do with 0xc: it is supposed to "Return the highest addressable byte of
virtual storage in the host-primary address space, including named
saved systems and saved segments", so returning the end of the address
space should be easy enough, but not very useful.

> +     */
> +    if ((r1 & 1) || subcode !=3D 0x10) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +    addr =3D env->regs[r1];
> +    length =3D env->regs[r1 + 1];
> +
> +    /* FIXME: Somebody with documentation should fix this. */

Doc mentioned above says for specification exception:

"For subcode X'10':
=E2=80=A2 Rx is not an even-numbered register.
=E2=80=A2 The address contained in Rx is not on a quadword boundary.
=E2=80=A2 The length contained in Rx+1 is not a positive multiple of 16."

> +    if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length, 16)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    /* FIXME: Somebody with documentation should fix this. */
> +    if (!length) {

Probably specification exception as well?

> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    /* FIXME: Somebody with documentation should fix this. */

For access exception:

"For subcode X'10', an error occurred trying to store the extent
information into the guest's output area."

> +    if (!address_space_access_valid(&address_space_memory, addr, length,=
 true,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +        return;
> +    }
> +
> +    /* Indicate our initial memory ([0 .. ram_size - 1]) */
> +    tmp =3D cpu_to_be64(0);
> +    cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
> +    tmp =3D cpu_to_be64(initial_ram_size - 1);
> +    cpu_physical_memory_write(addr + sizeof(tmp), &tmp, sizeof(tmp));
> +
> +    /* Exactly one entry was stored. */
> +    env->regs[r3] =3D 1;
> +    setcc(cpu, 0);
> +}
> +
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
>      uint64_t func =3D env->regs[r1];

(...)

> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 58dbc023eb..d7274eb320 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -116,6 +116,12 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, u=
int32_t r3, uint32_t num)
>      uint64_t r;
> =20
>      switch (num) {
> +    case 0x260:
> +        qemu_mutex_lock_iothread();
> +        handle_diag_260(env, r1, r3, GETPC());
> +        qemu_mutex_unlock_iothread();
> +        r =3D 0;
> +        break;
>      case 0x500:
>          /* KVM hypercall */
>          qemu_mutex_lock_iothread();

Looking at the doc referenced above, it seems that we treat every diag
call as privileged under tcg; but it seems that 0x44 isn't? (Unrelated
to your patch; maybe I'm misreading.)

> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4f6f1e31cd..6bb8b6e513 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2398,6 +2398,10 @@ static DisasJumpType op_diag(DisasContext *s, Disa=
sOps *o)
>      TCGv_i32 func_code =3D tcg_const_i32(get_field(s, i2));
> =20
>      gen_helper_diag(cpu_env, r1, r3, func_code);
> +    /* Only some diags modify the CC. */
> +    if (get_field(s, i2) =3D=3D 0x260) {
> +        set_cc_static(s);
> +    }
> =20
>      tcg_temp_free_i32(func_code);
>      tcg_temp_free_i32(r3);


