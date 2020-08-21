Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F92C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A4D2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro0DeB8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A4D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Ml-00042b-Gy
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94fm-0002yM-UV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94fj-0005F5-I3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598007202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+9F4xNLVAKKsOWtZbOuVT7aIWPj/15or+wQ69QWejEE=;
 b=Ro0DeB8zdZXwf+Brs3wiCC2sp2i7EHdn21qevGdOTaWMSH2P6sgP/snO+kSehrAmdDPJwT
 mvrbqcGdJ5Ez3kIhs7IM1JVqPzMwBS1YTE3tslfwIXddllLBsGkHhkxs2XLwdoOM5taLs0
 aRgL1froOMDZPqWwDUgFl+nHXoyh4Sg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-V1qAGcv1P1Cozwej0xAcUQ-1; Fri, 21 Aug 2020 06:53:20 -0400
X-MC-Unique: V1qAGcv1P1Cozwej0xAcUQ-1
Received: by mail-wr1-f69.google.com with SMTP id r14so438330wrq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+9F4xNLVAKKsOWtZbOuVT7aIWPj/15or+wQ69QWejEE=;
 b=lS2l9zZ48WI1DOzhT5JkBmmfujACgz2mUeNWcm2y4unej8UgwT+HaRn5xxQjOlvFk8
 8BhorUn0FeBxVawzPTG2Tm34hm3qI1zikloMV6T2TLTrKSSA25tyK/wv02Omzg8Q6KmY
 RQIIfvmU8sElB5DUUH9pMJVkL3hP2YSld505lSZ3sCPlLJWUlnE1SKOXkIFBtsuTM0/y
 z6pjsozHSnPbp/PjsoOVWmxiFqxeqrt9OMyIg9ovrg3XIu/iwlNO1RWwKPD/u7vtBh9F
 xA+K/niLcYFRXzmu1BsWKdHQZOpNc6rgZIFNuXWG+pgrgDrGC5hMMEU/BgEn+1xC996C
 F7Lg==
X-Gm-Message-State: AOAM533UqdMawRtj0jbXNxHL6u1TlkJ3yLSvwwgpOw4ZgtuInDBrvGvw
 9TuR67cvh7rRxqzrJNFvpx3vYh0crMDSNk7el6evlp97vpReIxYdVsBRn3SCMJYWFcHPbN33TT0
 EGlyUAuGOfW1Wom8=
X-Received: by 2002:adf:f248:: with SMTP id b8mr2319507wrp.247.1598007199406; 
 Fri, 21 Aug 2020 03:53:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycQmIoVwRkV8VuNBWHYHusppBvEWG3dtREBDiRRn8D42Fe7m1fvXxuHE19ysX0EMDqFucPYQ==
X-Received: by 2002:adf:f248:: with SMTP id b8mr2319494wrp.247.1598007199166; 
 Fri, 21 Aug 2020 03:53:19 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z207sm4930173wmc.2.2020.08.21.03.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:53:18 -0700 (PDT)
Subject: Re: [PATCH] virtiofsd: add -o allow_directio|no_directio option
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
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
Message-ID: <f2f9d81a-29d8-038b-5a1c-d88eb9115a33@redhat.com>
Date: Fri, 21 Aug 2020 12:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Yongji Xie <xieyongji@bytedance.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 5:41 AM, Jiachen Zhang wrote:
> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> open flag of guest applications will be discarded by virtiofsd. While
> this behavior makes it consistent with the virtio-9p scheme when guest
> applications using direct I/O, we no longer have any chance to bypass
> the host page cache.
> 
> Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
> option is added, or none of '-o no_directio' or '-o allow_directio' is
> added, the 'allow_directio' will be set to 0, and virtiofsd discards
> O_DIRECT as before. If '-o allow_directio' is added to the stariting
> command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> flags will be retained and host page cache can be bypassed.
> 
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  tools/virtiofsd/helper.c         |  4 ++++
>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..534ff52c64 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
>             "                               (0 leaves rlimit unchanged)\n"
>             "                               default: min(1000000, fs.file-max - 16384)\n"
>             "                                        if the current rlimit is lower\n"
> +           "    -o allow_directio|no_directio\n"
> +           "                               retain/discard O_DIRECT flags passed down\n"
> +           "                               to virtiofsd from guest applications.\n"
> +           "                               default: no_directio\n"
>             );
>  }
>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 94e0de2d2b..1c5ea27821 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -151,6 +151,7 @@ struct lo_data {
>      int timeout_set;
>      int readdirplus_set;
>      int readdirplus_clear;
> +    int allow_directio;

Can we use 'allow_direct_io'?

>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
> @@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] = {
>      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
>      { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
>      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
> +    { "allow_directio", offsetof(struct lo_data, allow_directio), 1 },
> +    { "no_directio", offsetof(struct lo_data, allow_directio), 0 },

Here too, split 'direct_io'?

>      FUSE_OPT_END
>  };
>  static bool use_syslog = false;
> @@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
>      fuse_reply_err(req, 0);
>  }
>  
> -static void update_open_flags(int writeback, struct fuse_file_info *fi)
> +static void update_open_flags(int writeback, int allow_directio,
> +                              struct fuse_file_info *fi)
>  {
>      /*
>       * With writeback cache, kernel may send read requests even
> @@ -1541,10 +1545,13 @@ static void update_open_flags(int writeback, struct fuse_file_info *fi)
>  
>      /*
>       * O_DIRECT in guest should not necessarily mean bypassing page
> -     * cache on host as well. If somebody needs that behavior, it
> -     * probably should be a configuration knob in daemon.
> +     * cache on host as well. Therefore, we discard it by default
> +     * ('-o no_directio'). If somebody needs that behavior, the
> +     * '-o allow_directio' option should be set.
>       */
> -    fi->flags &= ~O_DIRECT;
> +    if (!allow_directio) {
> +        fi->flags &= ~O_DIRECT;
> +    }
>  }
>  
>  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
> @@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
>          goto out;
>      }
>  
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->allow_directio, fi);
>  
>      fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
>                  mode);
> @@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>      fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
>               fi->flags);
>  
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->allow_directio, fi);
>  
>      sprintf(buf, "%i", lo_fd(req, ino));
>      fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> @@ -2824,6 +2831,7 @@ int main(int argc, char *argv[])
>          .debug = 0,
>          .writeback = 0,
>          .posix_lock = 1,
> +        .allow_directio = 0,
>          .proc_self_fd = -1,
>      };
>      struct lo_map_elem *root_elem;
> 


