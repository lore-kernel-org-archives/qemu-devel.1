Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EACA20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EACA20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJInr-00018x-JU
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jJIki-0004ZN-E2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jJIkh-0000uo-58
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:24:32 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:3621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jJIkd-0000t6-5z; Tue, 31 Mar 2020 11:24:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A485F456DF;
 Tue, 31 Mar 2020 17:24:24 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:24:22 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <713436887.61.1585668262838@webmail.proxmox.com>
In-Reply-To: <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev23
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > How can I see/debug those waiting request?
> 
> Examine bs->tracked_requests list.
> 
> BdrvTrackedRequest has "Coroutine *co" field. It's a pointer of coroutine of this request. You may use qemu-gdb script to print request's coroutine back-trace:

I would, but there are no tracked request at all.

print bs->tracked_requests
$2 = {lh_first = 0x0}


> gdb> source qemu_source/scripts/qemu-gdb.py
> 
> gdb> qemu coroutine CO_POINTER
> 
> - this will show, what exactly the request is doing now/waiting for.

(gdb) up
#1  0x0000555555c60489 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
77	  return __ppoll_alias (__fds, __nfds, __timeout, __ss);
(gdb) up
#2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:335
335	        return ppoll((struct pollfd *)fds, nfds, NULL, NULL);
(gdb) up
#3  0x0000555555c62c71 in fdmon_poll_wait (ctx=0x7fffe8905e80, ready_list=0x7fffffffdce8, timeout=-1) at util/fdmon-poll.c:79
79	    ret = qemu_poll_ns(pollfds, npfd, timeout);
(gdb) up
#4  0x0000555555c62257 in aio_poll (ctx=0x7fffe8905e80, blocking=blocking@entry=true) at util/aio-posix.c:589
589	        ret = ctx->fdmon_ops->wait(ctx, &ready_list, timeout);
(gdb) up
#5  0x0000555555bc25e5 in bdrv_do_drained_begin (poll=<optimized out>, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x7fffe8954bc0)
    at block/io.c:430
430	        BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, recursive, parent));

(gdb) print *bs
$1 = {open_flags = 139426, read_only = false, encrypted = false, sg = false, probed = false, force_share = false, implicit = false, 
  drv = 0x555556115080 <bdrv_raw>, opaque = 0x7fffe8918400, aio_context = 0x7fffe8915180, aio_notifiers = {lh_first = 0x0}, walking_aio_notifiers = false, 
  filename = "/dev/pve/vm-101-disk-0", '\000' <repeats 4073 times>, backing_file = '\000' <repeats 4095 times>, 
  auto_backing_file = '\000' <repeats 4095 times>, backing_format = '\000' <repeats 15 times>, full_open_options = 0x7fffe562c000, 
  exact_filename = "/dev/pve/vm-101-disk-0", '\000' <repeats 4073 times>, backing = 0x0, file = 0x7fffe88e9b60, bl = {request_alignment = 1, 
    max_pdiscard = 0, pdiscard_alignment = 0, max_pwrite_zeroes = 0, pwrite_zeroes_alignment = 0, opt_transfer = 0, max_transfer = 0, 
    min_mem_alignment = 512, opt_mem_alignment = 4096, max_iov = 1024}, supported_write_flags = 64, supported_zero_flags = 324, 
  node_name = "#block163", '\000' <repeats 22 times>, node_list = {tqe_next = 0x7fffe8975180, tqe_circ = {tql_next = 0x7fffe8975180, 
      tql_prev = 0x7fffe8963540}}, bs_list = {tqe_next = 0x7fffe895f480, tqe_circ = {tql_next = 0x7fffe895f480, 
      tql_prev = 0x555556114f10 <all_bdrv_states>}}, monitor_list = {tqe_next = 0x0, tqe_circ = {tql_next = 0x0, tql_prev = 0x0}}, refcnt = 2, op_blockers = {
    {lh_first = 0x0} <repeats 16 times>}, inherits_from = 0x0, children = {lh_first = 0x7fffe88e9b60}, parents = {lh_first = 0x7fffe88ea180}, 
  options = 0x7fffe8933400, explicit_options = 0x7fffe8934800, detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_ON, backing_blocker = 0x0, 
  total_sectors = 67108864, before_write_notifiers = {notifiers = {lh_first = 0x0}}, write_threshold_offset = 0, write_threshold_notifier = {notify = 0x0, 
    node = {le_next = 0x0, le_prev = 0x0}}, dirty_bitmap_mutex = {lock = pthread_mutex_t = {Type = Normal, Status = Not acquired, Robust = No, Shared = No, 
      Protocol = None}, initialized = true}, dirty_bitmaps = {lh_first = 0x0}, wr_highest_offset = {value = 28049412096}, copy_on_read = 0, in_flight = 0, 
  serialising_in_flight = 0, io_plugged = 0, enable_write_cache = 0, quiesce_counter = 1, recursive_quiesce_counter = 0, write_gen = 113581, reqs_lock = {
    locked = 0, ctx = 0x0, from_push = {slh_first = 0x0}, to_pop = {slh_first = 0x0}, handoff = 0, sequence = 0, holder = 0x0}, tracked_requests = {
    lh_first = 0x0}, flush_queue = {entries = {sqh_first = 0x0, sqh_last = 0x7fffe8958e38}}, active_flush_req = false, flushed_gen = 112020, 
  never_freeze = false}


Looks bdrv_parent_drained_poll_single() calls  blk_root_drained_poll(), which return true in my case (in_flight > 5). Looks like I am loosing poll events somewhere?


