Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF82C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2632A206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tOVeWstQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2632A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjQ8-00046e-Aw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.j.williams@intel.com>) id 1jLjPJ-0003Nn-O2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.j.williams@intel.com>) id 1jLjPH-0001rK-Mu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:16:28 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
 id 1jLjPH-0001mW-AB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:16:27 -0400
Received: by mail-ed1-x542.google.com with SMTP id i16so2891579edy.11
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DwgMN4zMTMuRr6YHh0JQsVDXTgCDT7kDKvTmnN8+AVI=;
 b=tOVeWstQJVsAur2IRXEkr4pOlE1D1YE5pzgTxBQ2eo4G7CdFmWehit8mV1WcfnuEa9
 mz1/iijYtuzhDhvtDUpUka/UcUmdHeMCw5+U1QCfcEU+QsmpIEErrjd9t1aNXK89DoUC
 2LYyPTdBL9ttQd3BBsekowvoqTkD4FH0dUAO5Z+7IbyBVMX+ZlSlpY+V0O/cGUa4msxp
 0jH4K60UB4ZnYfIZnGdB2U/YA/bDVslAdRgNw8DMWPPhm+URnv1mwki/nSJDYUC1VmZ5
 O64pI5Ve3Cy37rVSojkEkQrGzSaWVgWozBZ3DMVWXUmuznkwVEBOAHUBYriT6ssVkm/G
 VWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DwgMN4zMTMuRr6YHh0JQsVDXTgCDT7kDKvTmnN8+AVI=;
 b=XgGq0nyUac0uMvW90V/zqoLW6BJRMzIhCIBwuzo5xQLfu+HGoQNXCq4Qn8u5nvxM0v
 ZxcNzSam4StIocJtSemdXhvcEZehaET04L+TNrVdFczb6+Rw79YZD2FPJTOLMoyq4YFo
 d8TajXEgZiTP5lK/HwLh0yZlZ9PjE7bYdUXTzDWZ56St9FIMtMc5dvXLtAPXQiMgMTae
 Pz7jz8Y+T+IonLt4p1SqdZt+iQVdlFeFDGY/TCglAXSayt/2oQW51Q7ESK6sDINSJwmf
 9tXN7AH8FBw+GVWl+EnoaKPQDVAns4efzptnJ5UL10bzdeG6vY5aZDDRlz794RL8dha2
 fF4Q==
X-Gm-Message-State: AGi0PuaMhrYsJc6PnbbrEXILeEOHZQ5eS2cACyrkNygSdKXd7i7Wj4Ob
 RqGcQLubr+K3bKCA8qgUJFiBoVKzrl+jGsvdWok8Kg==
X-Google-Smtp-Source: APiQypIPBnq6XBehQmw21+6AIaBvv+uQ5QhJUR7BAOSDl1IMZ9rSunfvUzha+U64TWayY6SYWKDrabw8ZNk3oVGRB4A=
X-Received: by 2002:a05:6402:22b7:: with SMTP id
 cx23mr839909edb.383.1586247378926; 
 Tue, 07 Apr 2020 01:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <2c45ec7c-f3ea-2962-47a6-9330f0a2f146@intel.com>
 <64ba0e18-2fa3-f5bd-7711-1d91f1dc74da@redhat.com>
In-Reply-To: <64ba0e18-2fa3-f5bd-7711-1d91f1dc74da@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Apr 2020 01:16:07 -0700
Message-ID: <CAPcyv4iOi+5RJgkEWuJpn8JjOMrNCh4Uk1Ag=Fo=i+iFf1TkFA@mail.gmail.com>
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 1:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/04/20 09:29, Liu, Jingqi wrote:
> > Ping.
> >
> > Any comments are appreciated.
> >
> > Hi Paolo, Richard,
> >
> > Any comments about this ?
>
> I was hoping to get a review from someone else because I have no way to
> test it.  But I've now queued the patch, thanks.

Does qemu run tests in a nested VM? The difficult aspect of testing
devdax is that you need to boot your kernel with a special option or
have existing memory ranges assigned to the device. Although, Joao had
thoughts about allowing dynamic creation of device-dax instance by hot
unplugging memory.


>
> Paolo
>
> >
> > Thanks,
> >
> > Jingqi
> >
> > On 4/1/2020 11:13 AM, Liu, Jingqi wrote:
> >> If the backend file is devdax pmem character device, the alignment
> >> specified by the option 'align=NUM' in the '-object memory-backend-file'
> >> needs to match the alignment requirement of the devdax pmem character
> >> device.
> >>
> >> This patch fetches the devdax pmem file 'align', so that we can compare
> >> it with the NUM of 'align=NUM'.
> >> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
> >>
> >> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
> >> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
> >>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> >> ---
> >>   exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 45 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index de9d949902..8221abffec 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
> >>       return size;
> >>   }
> >>   +static int64_t get_file_align(int fd)
> >> +{
> >> +    int64_t align = -1;
> >> +#if defined(__linux__)
> >> +    struct stat st;
> >> +
> >> +    if (fstat(fd, &st) < 0) {
> >> +        return -errno;
> >> +    }
> >> +
> >> +    /* Special handling for devdax character devices */
> >> +    if (S_ISCHR(st.st_mode)) {
> >> +        g_autofree char *subsystem_path = NULL;
> >> +        g_autofree char *subsystem = NULL;
> >> +
> >> +        subsystem_path =
> >> g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
> >> +                                         major(st.st_rdev),
> >> minor(st.st_rdev));
> >> +        subsystem = g_file_read_link(subsystem_path, NULL);
> >> +
> >> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
> >> +            g_autofree char *align_path = NULL;
> >> +            g_autofree char *align_str = NULL;
> >> +
> >> +            align_path =
> >> g_strdup_printf("/sys/dev/char/%d:%d/device/align",
> >> +                                    major(st.st_rdev),
> >> minor(st.st_rdev));
> >> +
> >> +            if (g_file_get_contents(align_path, &align_str, NULL,
> >> NULL)) {
> >> +                return g_ascii_strtoll(align_str, NULL, 0);
> >> +            }
> >> +        }
> >> +    }
> >> +#endif /* defined(__linux__) */
> >> +
> >> +    return align;
> >> +}
> >> +
> >>   static int file_ram_open(const char *path,
> >>                            const char *region_name,
> >>                            bool *created,
> >> @@ -2275,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
> >> size, MemoryRegion *mr,
> >>   {
> >>       RAMBlock *new_block;
> >>       Error *local_err = NULL;
> >> -    int64_t file_size;
> >> +    int64_t file_size, file_align;
> >>         /* Just support these ram flags by now. */
> >>       assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
> >> @@ -2311,6 +2347,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
> >> size, MemoryRegion *mr,
> >>           return NULL;
> >>       }
> >>   +    file_align = get_file_align(fd);
> >> +    if (file_align > 0 && mr && file_align > mr->align) {
> >> +        error_setg(errp, "backing store align 0x%" PRIx64
> >> +                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
> >> +                   file_align, mr->align);
> >> +        return NULL;

Is there any downside to just making the alignment value be the max of
the device-dax instance align and the command line option? Why force
someone to debug the option unnecessarily?

