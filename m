Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6908FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC8B20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2cFfFD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC8B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMqX-0002yx-LR
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kPMoo-0002GD-Nf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kPMol-0007hj-BR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601890202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0swMm/JUHqj2ZF7vtD6A+buWAmQs/pWaJVFCZFFP3vI=;
 b=d2cFfFD9bftd/+GdkygDRgFEok98TwlXqYj+1G5gCUC2Yu9QsFiJ54u/H+EUToCgJqk8i5
 2lLOiMZqoViUxo3td11dV5NgjXKaINdzPijCHQhG+p+2NFD0yWnDpxVPoTPotLo4zCntTw
 +ahGYHNHrfHM3QPx+wfZ9Xb0iIXpf24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-VXkCc_GWNXqeB_k5GtTgNA-1; Mon, 05 Oct 2020 05:29:58 -0400
X-MC-Unique: VXkCc_GWNXqeB_k5GtTgNA-1
Received: by mail-wr1-f71.google.com with SMTP id d13so3741975wrr.23
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0swMm/JUHqj2ZF7vtD6A+buWAmQs/pWaJVFCZFFP3vI=;
 b=L68oIB2dWaY5QgvP+jIcgZoDOdQtDi5SsXAH/K+4PEz1DkD0vaXc5D77zFqSvti9DM
 0QIg3nUTjKXJUyyK8dhPGsaAioVbQeI2Z+QmKTRK5v1ym9L4qQM+iBBM7rwX7V5OrGKv
 ziHcots/pXWD7vczPj8nv1oL2zeNnep3jZIjZ8E6QlP39BM2MpRps315hsIE6TqDcVm/
 qMxB83ZAdTil3qXbYM4R0D4KYheSNsUIHJZYauUExxMabza5IEKOxAc8BcBxHX6XLmHR
 KyNKF0Vay+lXJWvbGrUvLFYPLoQDG8sfEKe2PzNe7mqT5peX+OuKdj81tPXte33Sz0Od
 B8NQ==
X-Gm-Message-State: AOAM531yUiR6A3Sdw9VjVkR8CnVFJdVE7YFhj9wU37lEabYBBj/h9yms
 hm651qEJdJCHikA0zXufZVwhC1g/jbdhKNHcb4bj4f8ynxf1fddpR0l8ImjRuJWqsMNkBaRVrO3
 59RkuOPPbW0To8rY=
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16690445wrs.19.1601890196825; 
 Mon, 05 Oct 2020 02:29:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEQC4DRJp3zkWpIuGXAYYj/DTIrl8/GMb44mGmzfTjxcu3Rfa4cyzIYDc7LqK44dT/Q3vJIA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16690416wrs.19.1601890196466; 
 Mon, 05 Oct 2020 02:29:56 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id v17sm12994343wrc.23.2020.10.05.02.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:29:55 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:29:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: scripts/gdb: issues when loading modules after lx-symbols
Message-ID: <20201005092953.zu7pn2lveo3j2w4s@steredhat>
References: <CAGxU2F7+Tf+hJxxadT_Rw01O43RU9RsasJiVLpukbhvo1w++fA@mail.gmail.com>
 <9e247182-2cc3-9fac-e12e-9743ef24ec43@siemens.com>
 <20201005081451.ajtm6rctimrg5frr@steredhat>
 <0b862e95-c2a7-ad00-5f57-8d958e4af20c@siemens.com>
MIME-Version: 1.0
In-Reply-To: <0b862e95-c2a7-ad00-5f57-8d958e4af20c@siemens.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Kieran Bingham <kbingham@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 10:33:30AM +0200, Jan Kiszka wrote:
> On 05.10.20 10:14, Stefano Garzarella wrote:
> > On Sun, Oct 04, 2020 at 08:52:37PM +0200, Jan Kiszka wrote:
> >> On 01.10.20 16:31, Stefano Garzarella wrote:
> >>> Hi,
> >>> I had some issues with gdb scripts and kernel modules in Linux 5.9-rc7.
> >>>
> >>> If the modules are already loaded, and I do 'lx-symbols', all work fine.
> >>> But, if I load a kernel module after 'lx-symbols', I had this issue:
> >>>
> >>> [ 5093.393940] invalid opcode: 0000 [#1] SMP PTI
> >>> [ 5093.395134] CPU: 0 PID: 576 Comm: modprobe Not tainted 5.9.0-rc7-ste-00010-gf0b671d9608d-dirty #2
> >>> [ 5093.397566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> >>> [ 5093.400761] RIP: 0010:do_init_module+0x1/0x270
> >>> [ 5093.402553] Code: ff ff e9 cf fe ff ff 0f 0b 49 c7 c4 f2 ff ff ff e9 c1 fe ff ff e8 5f b2 65 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 cc <1f> 44 00 00 55 ba 10 00 00 00 be c0 0c 00 00 48 89 e5 41 56 41 55
> >>> [ 5093.409505] RSP: 0018:ffffc90000563d18 EFLAGS: 00010246
> >>> [ 5093.412056] RAX: 0000000000000000 RBX: ffffffffc010a0c0 RCX: 0000000000004ee3
> >>> [ 5093.414472] RDX: 0000000000004ee2 RSI: ffffea0001efe188 RDI: ffffffffc010a0c0
> >>> [ 5093.416349] RBP: ffffc90000563e50 R08: 0000000000000000 R09: 0000000000000002
> >>> [ 5093.418044] R10: 0000000000000096 R11: 00000000000008a4 R12: ffff88807a0d1280
> >>> [ 5093.424721] R13: ffffffffc010a110 R14: ffff88807a0d1300 R15: ffffc90000563e70
> >>> [ 5093.427138] FS:  00007f018f632740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> >>> [ 5093.430037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [ 5093.432279] CR2: 000055fbe282b239 CR3: 000000007922a006 CR4: 0000000000170ef0
> >>> [ 5093.435096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> [ 5093.436765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> [ 5093.439689] Call Trace:
> >>> [ 5093.440954]  ? load_module+0x24b6/0x27d0
> >>> [ 5093.443212]  ? __kernel_read+0xd6/0x150
> >>> [ 5093.445140]  __do_sys_finit_module+0xd3/0xf0
> >>> [ 5093.446877]  __x64_sys_finit_module+0x1a/0x20
> >>> [ 5093.449098]  do_syscall_64+0x38/0x50
> >>> [ 5093.450877]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> [ 5093.456153] RIP: 0033:0x7f018f75c43d
> >>> [ 5093.457728] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 6a 0c 00 f7 d8 64 89 01 48
> >>> [ 5093.466349] RSP: 002b:00007ffd7f080368 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> >>> [ 5093.470613] RAX: ffffffffffffffda RBX: 0000557e5c96f9c0 RCX: 00007f018f75c43d
> >>> [ 5093.474747] RDX: 0000000000000000 RSI: 0000557e5c964288 RDI: 0000000000000003
> >>> [ 5093.478049] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> >>> [ 5093.481298] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> >>> [ 5093.483725] R13: 0000557e5c964288 R14: 0000557e5c96f950 R15: 0000557e5c9775c0
> >>> [ 5093.485778] Modules linked in: virtio_vdpa(+) vdpa sunrpc kvm_intel kvm irqbypass virtio_blk virtio_rng rng_core [last unloaded: virtio_vdpa]
> >>> [ 5093.488695] ---[ end trace 23712ecebc11f53c ]---
> >>>
> >>> Guest kernel: Linux 5.9-rc7
> >>> gdb: GNU gdb (GDB) Fedora 9.1-6.fc32
> >>> I tried with QEMU 4.2.1 and the latest master branch: same issue.
> >>>
> >>>
> >>> I did some digging, and skipping the gdb 'add-symbol-file' command in symbol.py
> >>> avoid the issue, but of course I don't have the symbols loaded:
> >>>
> >>>     diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> >>>     index 1be9763cf8bb..eadfaa4d4907 100644
> >>>     --- a/scripts/gdb/linux/symbols.py
> >>>     +++ b/scripts/gdb/linux/symbols.py
> >>>     @@ -129,7 +129,7 @@ lx-symbols command."""
> >>>                      filename=module_file,
> >>>                      addr=module_addr,
> >>>                      sections=self._section_arguments(module))
> >>>     -            gdb.execute(cmdline, to_string=True)
> >>>     +            #gdb.execute(cmdline, to_string=True)
> >>>                  if module_name not in self.loaded_modules:
> >>>                      self.loaded_modules.append(module_name)
> >>>              else:
> >>>
> >>> I tried several modules and this happens every time after '(gdb) lx-symbols'.
> >>>
> >>> Do you have any hints?
> >>>
> >> I assume you are debugging a kernel inside QEMU/KVM, right?
> > 
> > Right!
> > 
> >>                                                             Does it work
> >> without -enable-kvm?
> > 
> > Yes, disabling kvm it works.
> > 
> 
> OK, there it is, still...
> What may also "work" is going down to single core.

No, I tried with single core and kvm enabled and I have the same issue.

> 
> >>
> >> Debugging guests in KVM mode at least was unstable for a long time. I
> >> avoided setting soft-BPs - which is what the script does for the sake of
> >> tracking modules loading -, falling back to hw-BPs, as I had no time to
> >> debug that further. /Maybe/ that's the issue here.
> > 
> > Thanks for the suggestion, I'll try to have a look.
> > 
> 
> Would be great if this issue could finally be resolved. And then covered
> by the kvm-unit tests. Those still succeed, I think.

Yeah, I'm a bit busy, but I'll try to find a fix.

Just an update, I tried to follow your suggestion using hw-BPs, but
unfortunately the gdb python module doesn't provide an easy way to set
them, so I hacked a bit gdb forcing hw-BPs and with this patch applied
to gdb I don't see the issue anymore:

diff --git a/gdb/python/py-breakpoint.c b/gdb/python/py-breakpoint.c
index 7369c91ad9..df8ec92049 100644
--- a/gdb/python/py-breakpoint.c
+++ b/gdb/python/py-breakpoint.c
@@ -57,7 +57,7 @@ struct pybp_code
 static struct pybp_code pybp_codes[] =
 {
   { "BP_NONE", bp_none},
-  { "BP_BREAKPOINT", bp_breakpoint},
+  { "BP_BREAKPOINT", bp_hardware_breakpoint},
   { "BP_WATCHPOINT", bp_watchpoint},
   { "BP_HARDWARE_WATCHPOINT", bp_hardware_watchpoint},
   { "BP_READ_WATCHPOINT", bp_read_watchpoint},
@@ -383,7 +383,7 @@ bppy_get_location (PyObject *self, void *closure)

   BPPY_REQUIRE_VALID (obj);

-  if (obj->bp->type != bp_breakpoint)
+  if (obj->bp->type != bp_hardware_breakpoint)
     Py_RETURN_NONE;

   const char *str = event_location_to_string (obj->bp->location.get ());
@@ -730,7 +730,7 @@ bppy_init (PyObject *self, PyObject *args, PyObject *kwargs)
                                    "temporary","source", "function",
                                    "label", "line", "qualified", NULL };
   const char *spec = NULL;
-  enum bptype type = bp_breakpoint;
+  enum bptype type = bp_hardware_breakpoint;
   int access_type = hw_write;
   PyObject *internal = NULL;
   PyObject *temporary = NULL;
@@ -792,7 +792,7 @@ bppy_init (PyObject *self, PyObject *args, PyObject *kwargs)
     {
       switch (type)
        {
-       case bp_breakpoint:
+       case bp_hardware_breakpoint:
          {
            event_location_up location;
            symbol_name_match_type func_name_match_type
@@ -834,7 +834,7 @@ bppy_init (PyObject *self, PyObject *args, PyObject *kwargs)
            create_breakpoint (python_gdbarch,
                               location.get (), NULL, -1, NULL,
                               0,
-                              temporary_bp, bp_breakpoint,
+                              temporary_bp, bp_hardware_breakpoint,
                               0,
                               AUTO_BOOLEAN_TRUE,
                               ops,
@@ -1007,7 +1007,7 @@ gdbpy_breakpoint_created (struct breakpoint *bp)
   if (!user_breakpoint_p (bp) && bppy_pending_object == NULL)
     return;

-  if (bp->type != bp_breakpoint
+  if (bp->type != bp_hardware_breakpoint
       && bp->type != bp_watchpoint
       && bp->type != bp_hardware_watchpoint
       && bp->type != bp_read_watchpoint

Of course it is an hack, but it's a starting point :-)

Thanks,
Stefano


