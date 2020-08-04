Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00657C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C380722BED
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqHekWuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C380722BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2w1Q-00048L-1i
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2w0Z-0003jh-AU
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:25:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2w0W-0006ML-JS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596543926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E0rCWwTJciLBwWZNbLwRLuWQY9To+8Bxu8jyBvN/AyY=;
 b=hqHekWuWGGGAdwfc/qr6b9lDf2/ARFeVfsz8Hm+Pm25xLdvzkMPDyVGI/zURmaIBLFlHSh
 5jidzTXQy7m/nDijUDgFkPHY+F/BGR9QalsswvZr9vegsUQHqwE2oLNRAv0WdQ15r4PtgB
 9B4T3Jaq0u/cs/2FyBgJq8PHR+bdcAY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-3rlO-ZlwMJWunEdPos4Pvg-1; Tue, 04 Aug 2020 08:25:24 -0400
X-MC-Unique: 3rlO-ZlwMJWunEdPos4Pvg-1
Received: by mail-ed1-f72.google.com with SMTP id f18so898702edy.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 05:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=E0rCWwTJciLBwWZNbLwRLuWQY9To+8Bxu8jyBvN/AyY=;
 b=Tq8E7Q/zEph2c3nZ+eZppf1NlKxmjZ3fuE95Qfrpsw2wqAbt2sitPLDTaBEPK/2qyf
 MuZ+OFpg2jI3clhys+STI0F6dbYjAQM88mvHMoJVYMRdl/vDuX3xx6nNswr6nn0eYOaU
 MYxct1lsGw/MNrYQ26gOxsQ0/xOmvITJ0IOG5WPkjHN3RIqYzb4AE89hivClRibXA2II
 8NTU0L1nlXNc3QMbvvrC4JIOSnaQOsO3hWDIhO7F+Il1U++zepVjVoowckL5FcvSc1uA
 6d7cJHTvHOSRKMyn+HqmYzIgCQTqjfQd95ZqDnUEGk9q6O+E5EXzDpem/u5BrNhfE05H
 nhCg==
X-Gm-Message-State: AOAM532w3uY0+ueSC5h5NVjoieYc1kCGAhhuFm2rm62ZHn2gkfFx9923
 Z6OgBJe+x/yIANBlgZsLUJ0PrbZTKCIjHsHO8G8mdfGQ/gjZEeKkZr0D57wJ66+wpqaaRxKyqjl
 11ooTu8kx1qaIR+0=
X-Received: by 2002:a17:906:178b:: with SMTP id
 t11mr20754113eje.489.1596543923334; 
 Tue, 04 Aug 2020 05:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8RGcP2J0bt0IOy/zCIVazFuN+viZ4yYjkjTbgkcoMZxd413VEG4HMILFhveugNAV2YZeNQg==
X-Received: by 2002:a17:906:178b:: with SMTP id
 t11mr20754086eje.489.1596543923031; 
 Tue, 04 Aug 2020 05:25:23 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id o16sm18658397ejj.106.2020.08.04.05.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 05:25:22 -0700 (PDT)
Subject: Re: [PATCH 1/3] memory: add readonly support to
 memory_region_init_ram_from_file()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <febc6361-1c62-bc3e-7924-bbd19711b5df@redhat.com>
Date: Tue, 4 Aug 2020 14:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200804101244.1283503-2-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> There is currently no way to open(O_RDONLY) and mmap(PROT_READ) when
> creating a memory region from a file. This functionality is needed since
> the underlying host file may not allow writing.
> 
> Add a bool readonly argument to memory_region_init_ram_from_file() and
> the APIs it calls.
> 
> Extend memory_region_init_ram_from_file() rather than introducing a
> memory_region_init_rom_from_file() API so that callers can easily make a
> choice between read/write and read-only at runtime without calling
> different APIs.

What happens if we call:

 memory_region_init_ram_from_file(mr, ..., readonly=false, ...);
 memory_region_set_readonly(mr, false);

?

> 
> No new RAMBlock flag is introduced for read-only because it's unclear
> whether RAMBlocks need to know that they are read-only. Pass a bool
> readonly argument instead.
> 
> Both of these design decisions can be changed in the future. It just
> seemed like the simplest approach to me.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/exec/memory.h     |  2 ++
>  include/exec/ram_addr.h   |  5 +++--
>  include/qemu/mmap-alloc.h |  2 ++
>  backends/hostmem-file.c   |  2 +-
>  exec.c                    | 18 +++++++++++-------
>  softmmu/memory.c          |  7 +++++--
>  util/mmap-alloc.c         | 10 ++++++----
>  util/oslib-posix.c        |  2 +-
>  8 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 307e527835..1ae7b31e3a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -884,6 +884,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>   *             - RAM_PMEM: the memory is persistent memory
>   *             Other bits are ignored now.
>   * @path: the path in which to allocate the RAM.
> + * @readonly: true to open @path for reading, false for read/write.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
>   * Note that this function does not do anything to cause the data in the
> @@ -896,6 +897,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        uint64_t align,
>                                        uint32_t ram_flags,
>                                        const char *path,
> +                                      bool readonly,
>                                        Error **errp);
>  
[...]
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..d228635bb3 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1553,15 +1553,18 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        uint64_t align,
>                                        uint32_t ram_flags,
>                                        const char *path,
> +                                      bool readonly,
>                                        Error **errp)
>  {
>      Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->readonly = readonly;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
> +    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
> +                                             readonly, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
>          mr->size = int128_zero();
> @@ -1585,7 +1588,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>                                             share ? RAM_SHARED : 0,
> -                                           fd, &err);
> +                                           fd, false, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
>          mr->size = int128_zero();
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..890fda6a35 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -85,9 +85,11 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>  void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
> +                    bool readonly,
>                      bool shared,
>                      bool is_pmem)
>  {
> +    int prot;
>      int flags;
>      int map_sync_flags = 0;
>      int guardfd;
> @@ -146,8 +148,9 @@ void *qemu_ram_mmap(int fd,
>  
>      offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
>  
> -    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -               flags | map_sync_flags, fd, 0);
> +    prot = PROT_READ | (readonly ? 0 : PROT_WRITE);
> +
> +    ptr = mmap(guardptr + offset, size, prot, flags | map_sync_flags, fd, 0);
>  
>      if (ptr == MAP_FAILED && map_sync_flags) {
>          if (errno == ENOTSUP) {
> @@ -171,8 +174,7 @@ void *qemu_ram_mmap(int fd,
>           * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
>           * we will remove these flags to handle compatibility.
>           */
> -        ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -                   flags, fd, 0);
> +        ptr = mmap(guardptr + offset, size, prot, flags, fd, 0);
>      }
>  
>      if (ptr == MAP_FAILED) {
[...]


