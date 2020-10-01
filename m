Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DBC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F66208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHBPzZyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F66208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0MV-00020u-5f
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kO05y-0006j8-2t
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kO05t-0005D4-Fs
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601564524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjY980M3j683XwjxRN64oS8USRfLJqvigyVnEBEuKZY=;
 b=cHBPzZyBvudLEhb8zMq6GKmFkLditDM/fw8uGk+Mkd2LXsLY+KW685eMc8prANrexnpd8/
 c1owX4p99FmSS6noeIoqdIGWl5UiOzhELGWAMwfA+AhkNUZM6lptjf7tXZuhNqEnWKeGh/
 Lnqeh+nCMsFKS4/3TmN76cosRq8qdJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-v9Oy-dE7NA6SOSXlyHuh9Q-1; Thu, 01 Oct 2020 11:02:00 -0400
X-MC-Unique: v9Oy-dE7NA6SOSXlyHuh9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA1E1882FA3;
 Thu,  1 Oct 2020 15:01:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18F6773678;
 Thu,  1 Oct 2020 15:01:54 +0000 (UTC)
Subject: Re: [PATCH] elfload: use g_new instead of malloc
To: Elena Afanasova <eafanasova@gmail.com>, qemu-devel@nongnu.org
References: <20201001123807.42978-1-eafanasova@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3acc2481-a3ac-9ec4-9520-10727cc92ef3@redhat.com>
Date: Thu, 1 Oct 2020 17:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201001123807.42978-1-eafanasova@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2020 14.38, Elena Afanasova wrote:
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  bsd-user/elfload.c | 92 +++++++++++++++-------------------------------
>  1 file changed, 30 insertions(+), 62 deletions(-)
> 
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 32378af7b2..e10ca54eb7 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -867,18 +867,14 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
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
> +            g_free(elf_phdata);
>              return ~((abi_ulong)0UL);
>          }
>  
> @@ -890,9 +886,8 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>          }
>          if (retval < 0) {
>                  perror("load_elf_interp");
> +                g_free(elf_phdata);
>                  exit(-1);
> -                free (elf_phdata);
> -                return retval;
>          }
>  #ifdef BSWAP_NEEDED
>          eppnt = elf_phdata;
> @@ -940,7 +935,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>              if (error == -1) {
>                /* Real error */
>                close(interpreter_fd);
> -              free(elf_phdata);
> +              g_free(elf_phdata);
>                return ~((abi_ulong)0UL);
>              }
>  
> @@ -983,7 +978,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>                          PROT_READ|PROT_WRITE|PROT_EXEC,
>                          MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
>          }
> -        free(elf_phdata);
> +        g_free(elf_phdata);
>  
>          *interp_load_addr = load_addr;
>          return ((abi_ulong) interp_elf_ex->e_entry) + load_addr;
> @@ -1064,24 +1059,15 @@ static void load_symbols(struct elfhdr *hdr, int fd)
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
> +    syms = g_new(symtab.sh_size, 1);
> +    s->disas_strtab = strings = g_new(strtab.sh_size, 1);
>  
>      lseek(fd, symtab.sh_offset, SEEK_SET);
>      if (read(fd, syms, symtab.sh_size) != symtab.sh_size) {
> -        free(s);
> -        free(syms);
> -        free(strings);
> +        g_free(s);
> +        g_free(syms);
> +        g_free(strings);
>          return;
>      }
>  
> @@ -1113,22 +1099,16 @@ static void load_symbols(struct elfhdr *hdr, int fd)
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
> +        g_free(s);
> +        g_free(syms);
> +        g_free(strings);
>          return;
>      }
[...]

 Hi!

That clean-up sounds like a very good idea ... but I think this would be
a perfect place to use g_autofree in the declaration of the variables,
then you can get rid of the free() calls completely!

 Thomas


