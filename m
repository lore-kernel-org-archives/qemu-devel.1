Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20487C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EDE20867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EDE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOPm-0000hW-1T
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHOP4-0000B5-EJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHOP2-0004l7-J7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHOP2-0004k8-8g
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:30:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E09A4300CB25;
 Mon,  7 Oct 2019 08:29:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-11.rdu2.redhat.com
 [10.10.120.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 799DF5D6D0;
 Mon,  7 Oct 2019 08:29:57 +0000 (UTC)
Subject: Re: [PULL 25/30] Fix wrong behavior of cpu_memory_rw_debug() function
 in SMM
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
 <1570035113-56848-26-git-send-email-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5389cd77-f8bc-f4f3-9206-d2f3b47cd533@redhat.com>
Date: Mon, 7 Oct 2019 10:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1570035113-56848-26-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 07 Oct 2019 08:29:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Dmitry Poletaev <poletaev@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

(+Peter)

On 10/02/19 18:51, Paolo Bonzini wrote:
> From: Dmitry Poletaev <poletaev@ispras.ru>
> 
> There is a problem, that you don't have access to the data using cpu_memory_rw_debug() function when in SMM. You can't remotely debug SMM mode program because of that for example.
> Likely attrs version of get_phys_page_debug should be used to get correct asidx at the end to handle access properly.
> Here the patch to fix it.
> 
> Signed-off-by: Dmitry Poletaev <poletaev@ispras.ru>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c    | 2 +-
>  target/i386/cpu.h    | 3 ++-
>  target/i386/helper.c | 5 ++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)

If it's not too late yet -- I've just pulled the master branch and this patch doesn't appear to be on it --, can you please edit the commit message a little?

It would be nice if the commit message included the following two links, to the original issue report from Dmitry (both links point to the same message, just in different archives):

  "Can not read SMI handler code with cpu_memory_rw_debug while in SMM"
  https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg06039.html
  http://mid.mail-archive.com/51deeefdf33168ff11234ffd96ee646d@rainloop.ispras.ru

(Thank you Dmitry for the patch BTW, I'll probably rely quite a bit on it in the future.)

Thank you,
Laszlo

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 313a2ef..8fcb571 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6245,7 +6245,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->asidx_from_attrs = x86_asidx_from_attrs;
>      cc->get_memory_mapping = x86_cpu_get_memory_mapping;
> -    cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
> +    cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
>      cc->write_elf64_note = x86_cpu_write_elf64_note;
>      cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
>      cc->write_elf32_note = x86_cpu_write_elf32_note;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 033991c..eaa5395 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1690,7 +1690,8 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>  
>  void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  
> -hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
> +                                         MemTxAttrs *attrs);
>  
>  int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 0fa51be..c3a6e4f 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -715,7 +715,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> +hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
> +                                         MemTxAttrs *attrs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
> @@ -725,6 +726,8 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      uint32_t page_offset;
>      int page_size;
>  
> +    *attrs = cpu_get_mem_attrs(env);
> +
>      a20_mask = x86_get_a20_mask(env);
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          pte = addr & a20_mask;
> 


