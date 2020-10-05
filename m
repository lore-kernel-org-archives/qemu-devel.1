Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390F5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4222068D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esxNWy+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4222068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLPU-0001th-Ck
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPLNK-0000ne-2V
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPLNH-00042T-1v
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601884653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMBMn1g3ajfjio//JMhNgl6rmuGrCIBVU09xjSVhdR0=;
 b=esxNWy+eyoYgReusEblLW4RD08XGuj2IDlhFdq3WbR/cx8o3osBxvkREq3ZYUSY/kpWjVS
 3OlbDJ2w5I4i9FnqPXmZW+pb2A9MWv5L45XrQjJGPYq08lcWRDdO5WkUedom3o2bCfB2SI
 vRHAubfkCAmt7fF4BMkcDGZJ5NdtFuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-lJr9n0uJMyqGtQJGdRMXEg-1; Mon, 05 Oct 2020 03:57:31 -0400
X-MC-Unique: lJr9n0uJMyqGtQJGdRMXEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93575801ABB;
 Mon,  5 Oct 2020 07:57:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0424F757DF;
 Mon,  5 Oct 2020 07:57:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E34810C7796; Mon,  5 Oct 2020 09:57:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH v2] elfload: use g_new/g_malloc and g_autofree
References: <20201001123807.42978-1-eafanasova@gmail.com>
 <87r1qhtdxt.fsf@dusky.pond.sub.org>
 <b4ab229a-0e84-9d0b-1287-846c52a667bb@redhat.com>
 <87eemhm2b9.fsf@dusky.pond.sub.org>
 <17636b91-e111-1b60-4eb2-d526df4a6bb6@redhat.com>
 <d52b5d3655fba86d1b3816115b24997b36952e3b.camel@gmail.com>
Date: Mon, 05 Oct 2020 09:57:27 +0200
In-Reply-To: <d52b5d3655fba86d1b3816115b24997b36952e3b.camel@gmail.com> (Elena
 Afanasova's message of "Sun, 04 Oct 2020 05:20:18 -0700")
Message-ID: <871ridcdg8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, emaste@freebsd.org, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, kamil@netbsd.org, lwhsu@freebsd.org, brad@comstyle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please don't post respins as replies, because our tooling will miss them
there, and even humans may.  Start a new thread instead.  Next time :)

Elena Afanasova <eafanasova@gmail.com> writes:

> Subject: [PATCH v2] elfload: use g_new/g_malloc and g_autofree
>
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  bsd-user/elfload.c | 79 ++++++++--------------------------------------
>  1 file changed, 14 insertions(+), 65 deletions(-)
>
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 32378af7b2..bc4be4c874 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -838,7 +838,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>                                   int interpreter_fd,
>                                   abi_ulong *interp_load_addr)
>  {
> -        struct elf_phdr *elf_phdata  =  NULL;
> +        g_autofree struct elf_phdr *elf_phdata = NULL;
>          struct elf_phdr *eppnt;
>          abi_ulong load_addr = 0;
>          int load_addr_set = 0;
> @@ -867,18 +867,13 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>          if (sizeof(struct elf_phdr) * interp_elf_ex->e_phnum > TARGET_PAGE_SIZE)
>              return ~(abi_ulong)0UL;
>  
> -        elf_phdata =  (struct elf_phdr *)
> -                malloc(sizeof(struct elf_phdr) * interp_elf_ex->e_phnum);
> -
> -        if (!elf_phdata)
> -          return ~((abi_ulong)0UL);
> +        elf_phdata = g_new(struct elf_phdr, interp_elf_ex->e_phnum);
>  
>          /*
>           * If the size of this structure has changed, then punt, since
>           * we will be doing the wrong thing.
>           */
>          if (interp_elf_ex->e_phentsize != sizeof(struct elf_phdr)) {
> -            free(elf_phdata);
>              return ~((abi_ulong)0UL);
>          }
>  
> @@ -891,7 +886,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>          if (retval < 0) {
>                  perror("load_elf_interp");
>                  exit(-1);
> -                free (elf_phdata);
>                  return retval;
>          }
>  #ifdef BSWAP_NEEDED
> @@ -940,7 +934,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>              if (error == -1) {
>                /* Real error */
>                close(interpreter_fd);
> -              free(elf_phdata);
>                return ~((abi_ulong)0UL);
>              }
>  
> @@ -983,7 +976,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>                          PROT_READ|PROT_WRITE|PROT_EXEC,
>                          MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
>          }
> -        free(elf_phdata);
>  
>          *interp_load_addr = load_addr;
>          return ((abi_ulong) interp_elf_ex->e_entry) + load_addr;
> @@ -1036,9 +1028,10 @@ static void load_symbols(struct elfhdr *hdr, int fd)
>  {
>      unsigned int i, nsyms;
>      struct elf_shdr sechdr, symtab, strtab;
> -    char *strings;
> -    struct syminfo *s;
> -    struct elf_sym *syms, *new_syms;
> +    g_autofree char *strings = NULL;
> +    g_autofree struct syminfo *s = NULL;
> +    g_autofree struct elf_sym *syms = NULL;
> +    struct elf_sym *new_syms;

Note for later: @strings, @syminfo and @syms are freed on return.

>  
>      lseek(fd, hdr->e_shoff, SEEK_SET);
>      for (i = 0; i < hdr->e_shnum; i++) {
> @@ -1064,24 +1057,12 @@ static void load_symbols(struct elfhdr *hdr, int fd)
>  
>   found:
>      /* Now know where the strtab and symtab are.  Snarf them. */
> -    s = malloc(sizeof(*s));
> -    syms = malloc(symtab.sh_size);
> -    if (!syms) {
> -        free(s);
> -        return;
> -    }
> -    s->disas_strtab = strings = malloc(strtab.sh_size);
> -    if (!s->disas_strtab) {
> -        free(s);
> -        free(syms);
> -        return;
> -    }
> +    s = g_new(struct syminfo, 1);

The smaller change would be

       s = g_malloc(sizeof(*s));

Matter of taste.

> +    syms = g_malloc(symtab.sh_size);
> +    s->disas_strtab = strings = g_new(char, strtab.sh_size);

I'd prefer the simpler

       s->disas_strtab = strings = g_malloc(strtab.sh_size);

Yes, it returns void * whereas g_new() returns char *, but the char * is
vanishingly unlikely to catch actual bugs.

>  
>      lseek(fd, symtab.sh_offset, SEEK_SET);
>      if (read(fd, syms, symtab.sh_size) != symtab.sh_size) {
> -        free(s);
> -        free(syms);
> -        free(strings);
>          return;
>      }
>  
> @@ -1113,22 +1094,13 @@ static void load_symbols(struct elfhdr *hdr, int fd)
>          that we threw away.  Whether or not this has any effect on the
>          memory allocation depends on the malloc implementation and how
>          many symbols we managed to discard. */
> -    new_syms = realloc(syms, nsyms * sizeof(*syms));
> -    if (new_syms == NULL) {
> -        free(s);
> -        free(syms);
> -        free(strings);
> -        return;
> -    }
> +    new_syms = g_realloc(syms, nsyms * sizeof(*syms));
>      syms = new_syms;
>  
>      qsort(syms, nsyms, sizeof(*syms), symcmp);
>  
>      lseek(fd, strtab.sh_offset, SEEK_SET);
>      if (read(fd, strings, strtab.sh_size) != strtab.sh_size) {
> -        free(s);
> -        free(syms);
> -        free(strings);
>          return;
>      }
>      s->disas_num_syms = nsyms;
   #if ELF_CLASS == ELFCLASS32
       s->disas_symtab.elf32 = syms;
       s->lookup_symbol = (lookup_symbol_t)lookup_symbolxx;
   #else
       s->disas_symtab.elf64 = syms;
       s->lookup_symbol = (lookup_symbol_t)lookup_symbolxx;
   #endif
       s->next = syminfos;
       syminfos = s;

@strings, @syminfo and @syms are freed here.  s->disas_strtab,
s->disas_symtab.elf{32,64}, s->next become dangling pointers.
I'd expect this to blow up.  Have you tested?

   }

> @@ -1156,10 +1128,10 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>      unsigned char ibcs2_interpreter;
>      int i;
>      struct elf_phdr * elf_ppnt;
> -    struct elf_phdr *elf_phdata;
> +    g_autofree struct elf_phdr *elf_phdata = NULL;
>      abi_ulong elf_bss, k, elf_brk;
>      int retval;
> -    char * elf_interpreter;
> +    g_autofree char *elf_interpreter = NULL;
>      abi_ulong elf_entry, interp_load_addr = 0;
>      abi_ulong start_code, end_code, start_data, end_data;
>      abi_ulong reloc_func_desc = 0;
> @@ -1190,10 +1162,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>      }
>  
>      /* Now read in all of the header information */
> -    elf_phdata = (struct elf_phdr *)malloc(elf_ex.e_phentsize*elf_ex.e_phnum);
> -    if (elf_phdata == NULL) {
> -        return -ENOMEM;
> -    }
> +    elf_phdata = g_new(struct elf_phdr, elf_ex.e_phnum);

This assumes elf_ex.e_phentsize == sizeof(struct elf_phdr).  Why is that
true?

>  
>      retval = lseek(bprm->fd, elf_ex.e_phoff, SEEK_SET);
>      if(retval > 0) {
> @@ -1204,7 +1173,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>      if (retval < 0) {
>          perror("load_elf_binary");
>          exit(-1);
> -        free (elf_phdata);
>          return -errno;
>      }
>  
> @@ -1220,7 +1188,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>      elf_brk = 0;
>  
>  
> -    elf_interpreter = NULL;
>      start_code = ~((abi_ulong)0UL);
>      end_code = 0;
>      start_data = 0;
> @@ -1231,8 +1198,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>          if (elf_ppnt->p_type == PT_INTERP) {
>              if ( elf_interpreter != NULL )
>              {
> -                free (elf_phdata);
> -                free(elf_interpreter);
>                  close(bprm->fd);
>                  return -EINVAL;
>              }
> @@ -1242,13 +1207,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>               * is an a.out format binary
>               */
>  
> -            elf_interpreter = (char *)malloc(elf_ppnt->p_filesz);
> -
> -            if (elf_interpreter == NULL) {
> -                free (elf_phdata);
> -                close(bprm->fd);
> -                return -ENOMEM;
> -            }
> +            elf_interpreter = g_new(char, elf_ppnt->p_filesz);

Again, I'd prefer the simpler

               elf_interpreter = g_malloc(elf_ppnt->p_filesz);

>  
>              retval = lseek(bprm->fd, elf_ppnt->p_offset, SEEK_SET);
>              if(retval >= 0) {
> @@ -1298,8 +1257,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>              if (retval < 0) {
>                  perror("load_elf_binary3");
>                  exit(-1);
> -                free (elf_phdata);
> -                free(elf_interpreter);
>                  close(bprm->fd);
>                  return retval;
>              }
> @@ -1323,8 +1280,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>          }
>  
>          if (!interpreter_type) {
> -            free(elf_interpreter);
> -            free(elf_phdata);
>              close(bprm->fd);
>              return -ELIBBAD;
>          }
> @@ -1346,8 +1301,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>              }
>          }
>          if (!bprm->p) {
> -            free(elf_interpreter);
> -            free (elf_phdata);
>              close(bprm->fd);
>              return -E2BIG;
>          }
> @@ -1486,18 +1439,14 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
>          reloc_func_desc = interp_load_addr;
>  
>          close(interpreter_fd);
> -        free(elf_interpreter);
>  
>          if (elf_entry == ~((abi_ulong)0UL)) {
>              printf("Unable to load interpreter\n");
> -            free(elf_phdata);
>              exit(-1);
>              return 0;
>          }
>      }
>  
> -    free(elf_phdata);
> -
>      if (qemu_log_enabled())
>          load_symbols(&elf_ex, bprm->fd);


