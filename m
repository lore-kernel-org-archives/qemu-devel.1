Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 04:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD5720738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RysXgJNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD5720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbd4N-0004hW-Ju
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 00:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbd3K-0004Di-Dr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 00:43:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbd3H-0006QH-TO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 00:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590036206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=giE285k9sIgJf/ygeiyjVz4uez8ees6tXUNmorLDtdM=;
 b=RysXgJNBIuxzufKp90PgadtY52Ga8F4dNArmLoofVWgZXloiJj+KaiXnXS3W7MBxHcSvqc
 bB70XrmAzA/PKEDCYL474JhN5+kWByb/FEwg05lhjNNaO1ZhC823m4xGqmz0Tnnxfx9GnJ
 Ymr9l7Iq4YefrlNHaJT4D3+oDMAUPmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Vz-JS9wdMmqYZaCpsVDFlg-1; Thu, 21 May 2020 00:43:22 -0400
X-MC-Unique: Vz-JS9wdMmqYZaCpsVDFlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A08C218FE860;
 Thu, 21 May 2020 04:43:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 774055EE0E;
 Thu, 21 May 2020 04:43:18 +0000 (UTC)
Subject: Re: [PATCH v1 04/10] linux-user: completely re-write init_guest_space
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com>
Date: Thu, 21 May 2020 06:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200513175134.19619-5-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 00:43:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/2020 19.51, Alex Bennée wrote:
> First we ensure all guest space initialisation logic comes through
> probe_guest_base once we understand the nature of the binary we are
> loading. The convoluted init_guest_space routine is removed and
> replaced with a number of pgb_* helpers which are called depending on
> what requirements we have when loading the binary.
> 
> We first try to do what is requested by the host. Failing that we try
> and satisfy the guest requested base address. If all those options
> fail we fall back to finding a space in the memory map using our
> recently written read_self_maps() helper.
> 
> There are some additional complications we try and take into account
> when looking for holes in the address space. We try not to go directly
> after the system brk() space so there is space for a little growth. We
> also don't want to have to use negative offsets which would result in
> slightly less efficient code on x86 when it's unable to use the
> segment offset register.
> 
> Less mind-binding gotos and hopefully clearer logic throughout.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Laurent Vivier <laurent@vivier.eu>
[...]
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 619c054cc48..01a9323a637 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -11,6 +11,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
>  #include "qemu/units.h"
> +#include "qemu/selfmap.h"
>  
>  #ifdef _ARCH_PPC64
>  #undef ARCH_DLINFO
> @@ -382,68 +383,30 @@ enum {
>  
>  /* The commpage only exists for 32 bit kernels */
>  
> -/* Return 1 if the proposed guest space is suitable for the guest.
> - * Return 0 if the proposed guest space isn't suitable, but another
> - * address space should be tried.
> - * Return -1 if there is no way the proposed guest space can be
> - * valid regardless of the base.
> - * The guest code may leave a page mapped and populate it if the
> - * address is suitable.
> - */
> -static int init_guest_commpage(unsigned long guest_base,
> -                               unsigned long guest_size)
> -{
> -    unsigned long real_start, test_page_addr;
> -
> -    /* We need to check that we can force a fault on access to the
> -     * commpage at 0xffff0fxx
> -     */
> -    test_page_addr = guest_base + (0xffff0f00 & qemu_host_page_mask);
> -
> -    /* If the commpage lies within the already allocated guest space,
> -     * then there is no way we can allocate it.
> -     *
> -     * You may be thinking that that this check is redundant because
> -     * we already validated the guest size against MAX_RESERVED_VA;
> -     * but if qemu_host_page_mask is unusually large, then
> -     * test_page_addr may be lower.
> -     */
> -    if (test_page_addr >= guest_base
> -        && test_page_addr < (guest_base + guest_size)) {
> -        return -1;
> -    }
> +#define ARM_COMMPAGE (intptr_t)0xffff0f00u
>  
> -    /* Note it needs to be writeable to let us initialise it */
> -    real_start = (unsigned long)
> -                 mmap((void *)test_page_addr, qemu_host_page_size,
> -                     PROT_READ | PROT_WRITE,
> -                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +static bool init_guest_commpage(void)
> +{
> +    void *want = g2h(ARM_COMMPAGE & -qemu_host_page_size);
> +    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
> +                      MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  
> -    /* If we can't map it then try another address */
> -    if (real_start == -1ul) {
> -        return 0;
> +    if (addr == MAP_FAILED) {
> +        perror("Allocating guest commpage");
> +        exit(EXIT_FAILURE);
>      }
> -
> -    if (real_start != test_page_addr) {
> -        /* OS didn't put the page where we asked - unmap and reject */
> -        munmap((void *)real_start, qemu_host_page_size);
> -        return 0;
> +    if (addr != want) {
> +        return false;
>      }
>  
> -    /* Leave the page mapped
> -     * Populate it (mmap should have left it all 0'd)
> -     */
> -
> -    /* Kernel helper versions */
> -    __put_user(5, (uint32_t *)g2h(0xffff0ffcul));
> +    /* Set kernel helper versions; rest of page is 0.  */
> +    __put_user(5, (uint32_t *)g2h(0xffff0ffcu));
>  
> -    /* Now it's populated make it RO */
> -    if (mprotect((void *)test_page_addr, qemu_host_page_size, PROT_READ)) {
> +    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
>          perror("Protecting guest commpage");
> -        exit(-1);
> +        exit(EXIT_FAILURE);
>      }
> -
> -    return 1; /* All good */
> +    return true;
>  }
>  
>  #define ELF_HWCAP get_elf_hwcap()
> @@ -2075,239 +2038,267 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      return sp;
>  }
>  
> -unsigned long init_guest_space(unsigned long host_start,
> -                               unsigned long host_size,
> -                               unsigned long guest_start,
> -                               bool fixed)
> -{
> -    /* In order to use host shmat, we must be able to honor SHMLBA.  */
> -    unsigned long align = MAX(SHMLBA, qemu_host_page_size);
> -    unsigned long current_start, aligned_start;
> -    int flags;
> -
> -    assert(host_start || host_size);
> -
> -    /* If just a starting address is given, then just verify that
> -     * address.  */
> -    if (host_start && !host_size) {
> -#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
> -        if (init_guest_commpage(host_start, host_size) != 1) {
> -            return (unsigned long)-1;
> -        }
> +#ifndef ARM_COMMPAGE
> +#define ARM_COMMPAGE 0
> +#define init_guest_commpage() true
>  #endif
> -        return host_start;
> -    }
>  
> -    /* Setup the initial flags and start address.  */
> -    current_start = host_start & -align;
> -    flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
> -    if (fixed) {
> -        flags |= MAP_FIXED;
> -    }
> +static void pgb_fail_in_use(const char *image_name)
> +{
> +    error_report("%s: requires virtual address space that is in use "
> +                 "(omit the -B option or choose a different value)",
> +                 image_name);
> +    exit(EXIT_FAILURE);
> +}
>  
> -    /* Otherwise, a non-zero size region of memory needs to be mapped
> -     * and validated.  */
> +static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
> +                                abi_ulong guest_hiaddr, long align)
> +{
> +    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
> +    void *addr, *test;
>  
> -#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
> -    /* On 32-bit ARM, we need to map not just the usable memory, but
> -     * also the commpage.  Try to find a suitable place by allocating
> -     * a big chunk for all of it.  If host_start, then the naive
> -     * strategy probably does good enough.
> -     */
> -    if (!host_start) {
> -        unsigned long guest_full_size, host_full_size, real_start;
> -
> -        guest_full_size =
> -            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
> -        host_full_size = guest_full_size - guest_start;
> -        real_start = (unsigned long)
> -            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);
> -        if (real_start == (unsigned long)-1) {
> -            if (host_size < host_full_size - qemu_host_page_size) {
> -                /* We failed to map a continous segment, but we're
> -                 * allowed to have a gap between the usable memory and
> -                 * the commpage where other things can be mapped.
> -                 * This sparseness gives us more flexibility to find
> -                 * an address range.
> -                 */
> -                goto naive;
> -            }
> -            return (unsigned long)-1;
> +    if (!QEMU_IS_ALIGNED(guest_base, align)) {
> +        fprintf(stderr, "Requested guest base 0x%lx does not satisfy "
> +                "host minimum alignment (0x%lx)\n",
> +                guest_base, align);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Sanity check the guest binary. */
> +    if (reserved_va) {
> +        if (guest_hiaddr > reserved_va) {
> +            error_report("%s: requires more than reserved virtual "
> +                         "address space (0x%" PRIx64 " > 0x%lx)",
> +                         image_name, (uint64_t)guest_hiaddr, reserved_va);
> +            exit(EXIT_FAILURE);
>          }
> -        munmap((void *)real_start, host_full_size);
> -        if (real_start & (align - 1)) {
> -            /* The same thing again, but with extra
> -             * so that we can shift around alignment.
> -             */
> -            unsigned long real_size = host_full_size + qemu_host_page_size;
> -            real_start = (unsigned long)
> -                mmap(NULL, real_size, PROT_NONE, flags, -1, 0);
> -            if (real_start == (unsigned long)-1) {
> -                if (host_size < host_full_size - qemu_host_page_size) {
> -                    goto naive;
> -                }
> -                return (unsigned long)-1;
> -            }
> -            munmap((void *)real_start, real_size);
> -            real_start = ROUND_UP(real_start, align);
> +    } else {
> +        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
> +            error_report("%s: requires more virtual address space "
> +                         "than the host can provide (0x%" PRIx64 ")",
> +                         image_name, (uint64_t)guest_hiaddr - guest_base);
> +            exit(EXIT_FAILURE);
>          }

 Hi Alex,

this causes an error with newer versions of Clang:

linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
long' > 18446744073709551615 is always false
[-Werror,-Wtautological-type-limit-compare]
4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
4687 1 error generated.

Any ideas how to fix this?

 Thomas


